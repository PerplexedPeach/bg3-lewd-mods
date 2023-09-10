-- PersistentVars = {}

-- -- Variable will be restored after the savegame finished loading
-- local function doStuff()
--     PersistentVars['Test'] = 'Something to keep'
-- end

-- local function OnSessionLoaded()
--     -- Persistent variables are only available after SessionLoaded is triggered!
--     Ext.Print(PersistentVars['Test'])
-- end

-- Ext.Events.SessionLoaded:Subscribe("SessionLoaded", OnSessionLoaded)

local loviatar_claws_item_id = "LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685";
local loviatars_love_status_id = "GOB_CALMNESS_IN_PAIN";
local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_";
local remodelled_frame_removed_group = "LI_Claws_RemodelledFrame_removed";
local remodelled_frame_removed_id_prefix = remodelled_frame_removed_group .. "_";
local remodelled_message = {
    "You wake up, feeling that your body has subtly changed. Your muscles feels softer and your flesh feels fuller in certain places.",
    "Your body feels more sensitive to touch. You feel a strange urge to join the frontline of the fiercest battle you can find.",
    "Waking up, your body feels different yet again. You feel sluggish, and soft... Your muscles have shrunk, seemingly turned to fat in other places.",
    "Again, you wake up to a softer body. Your full curves and supple limbs seem more appropriate for a bordella than a life on the road. You have now grown used to the grace of your new body."
};

local function _I(msg)
    _P("[LoviatarClaws] " .. msg);
end

local function getCurrentWearer()
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        local boots = Osi.GetEquippedItem(char, "Boots");
        _I("Character " .. char .. " has boots " .. tostring(boots));
        if boots ~= nil and Osi.GetTemplate(boots) == loviatar_claws_item_id then
            _I("Found wearer: " .. char);
            return char;
        end
    end
    return nil
end

local function hasLoviatarsLove(char)
    return Osi.HasActiveStatus(char, loviatars_love_status_id);
end

local function remodelledFrameLevel(char)
    for level = 1, 4 do
        local passive_key = remodelled_frame_id_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            return level;
        end
    end
    return 0;
end

local function upgradeRemodelledFrame(char)
    -- check level of remodelled body
    local current_level = remodelledFrameLevel(char);
    _I("Upgrading remodelled body to level " .. current_level + 1);
    Osi.AddPassive(char, remodelled_frame_id_prefix .. current_level + 1);
    Osi.OpenMessageBox(char, remodelled_message[current_level + 1]);
end

local function curseLongRestHandler()
    -- loop over characters and check if anyway was wearing the cursed item
    local wearer = getCurrentWearer();
    if wearer ~= nil then
        _I("Loviatar Claws wearer found: " .. wearer);
        -- check that the wearer has Loviatar's blessing
        -- if not, then they can no longer proceed with the transformation
        if not hasLoviatarsLove(wearer) then
            return
        end

        upgradeRemodelledFrame(wearer);
    end
end

local function curseItemUnequipHandler(template, char)
    if template == loviatar_claws_item_id then
        local level = remodelledFrameLevel(char);
        _I("Loviatar Claws wearer unequipped item with level " .. level .. " remodelled body");
        if level > 0 then
            Osi.ApplyStatus(char, remodelled_frame_removed_id_prefix .. level, -1);
        end
    end
end
local function curseItemReequipHandler(template, char)
    if template == loviatar_claws_item_id then
        -- safe to use this level since character cannot progress to next level without wearing the claws
        local level = remodelledFrameLevel(char);
        if level > 0 then
            _I("Loviatar Claws wearer reequipped claws");
            Osi.RemoveStatus(char, remodelled_frame_removed_id_prefix .. level)
        end
    end
end

local function curseItemAcquisitionHandler(char, status, causee, storyActionID)
    -- filter if they're not a player character
    if Osi.IsPlayer(char) == 1 then
        if status == loviatars_love_status_id then
            Osi.OpenMessageBox(char, "Due to your spectacular performance, the priest also gifts you a curious pair of boots. They seem to be made of some kind of leather, but they are so soft and supple that they feel like silk. You feel a strange urge to put them on...");
            Osi.TemplateAddTo(loviatar_claws_item_id, char, 1, 1);
        end
    end
end

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", curseLongRestHandler);

-- handle curse from item unequip
Ext.Osiris.RegisterListener("TemplateUnequipped", 2, "after", curseItemUnequipHandler);
Ext.Osiris.RegisterListener("TemplateEquipped", 2, "after", curseItemReequipHandler);

-- acquire from getting Loviatar's love
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", curseItemAcquisitionHandler);
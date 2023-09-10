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

local WEARER_KEY = "LoviatarClawsWearer";
local loviatar_claws_item_id = "LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685";
local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_"

local function getCurrentWearer()
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        local boots = Osi.GetEquippedItem(char, "Boots");
        _P("Character " .. char .. " has boots " .. tostring(boots));
        if boots ~= nil and Osi.GetTemplate(boots) == loviatar_claws_item_id then
            _P("Found wearer: " .. char);
            return char;
        end
    end
    return nil
end

local function hasLoviatarsLove(char)
    return Osi.HasActiveStatus(char, "GOB_CALMNESS_IN_PAIN");
end

local function upgradeRemodelledFrame(char)
    -- check level of remodelled body
    _P("Checking remodelled body level of " .. char);
    local currentLevel = 0;
    for level = 1, 4 do
        local passive_key = remodelled_frame_id_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            Osi.RemovePassive(char, passive_key);
        end
    end
    _P("Upgrading remodelled body to level " .. currentLevel + 1);
    Osi.AddPassive(char, remodelled_frame_id_prefix .. currentLevel + 1);
end

local function curseLongRestHandler()
    -- loop over characters and check if anyway was wearing the cursed item
    local wearer = getCurrentWearer();
    if wearer ~= nil then
        _P("Loviatar Claws wearer found: " .. wearer);
        -- check that the wearer has Loviatar's blessing
        -- if not, then they can no longer proceed with the transformation
        if not hasLoviatarsLove(wearer) then
            return
        end

        -- no need to add persistent checks since only one character can have Loviatar's Love
        -- only this character can receive the effects from wearing it
        -- if PersistentVars[WEARER_KEY] == nil then
        --     PersistentVars[WEARER_KEY] = wearer;
        -- end

        upgradeRemodelledFrame(wearer);
    end
end

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function()
    _P("Long rest finished");
    curseLongRestHandler();
    --   if quest == "LOW_FindBhaalTemple_FollowMurders" then
    --       Osi.TemplateAddTo("443b2caf-8d36-42cf-b389-d774229ed18c", GetHostCharacter(), 1, 1)
    --   end
end)

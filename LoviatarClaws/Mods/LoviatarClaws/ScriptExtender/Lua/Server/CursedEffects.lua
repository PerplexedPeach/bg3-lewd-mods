PersistentVars = {}

local persistent_dmg_taken = "Total Damage Taken";
local loviatar_claws_item_id = "LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685";
local loviatar_claws_camp_item_id = "LI_LoviatarClaws_Camp_ec34283c-5e38-4bbc-a9cd-01397d55c5ce";
local loviatar_claws_replica_item_id = "LI_LoviatarClaws_Replica_49041dbe-1df1-4b57-a53f-72e291bd291f";
local loviatars_love_status_id = "GOB_CALMNESS_IN_PAIN";
local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_";
local remodelled_frame_removed_group = "LI_Claws_RemodelledFrame_removed";
local remodelled_frame_removed_id_prefix = remodelled_frame_removed_group .. "_";
local remodelled_message = {
    "LI_CLAW_REMODEL_1_MSG",
    "LI_CLAW_REMODEL_2_MSG",
    "LI_CLAW_REMODEL_3_MSG",
    "LI_CLAW_REMODEL_4_MSG",
};
local acquire_message = "LI_CLAW_GIFT_MSG";
local pain_thresholds_for_remodel = {
    99,
    199,
    299,
    499
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

local function totalTakenDamage()
    return PersistentVars[persistent_dmg_taken];
end

local function registerDamage(defender, attackerOwner, attacker2, damageType, damageAmount, damageCause, storyActionID)
    -- only keep track of damage if the defender is the wearer (we're not going to track per-character, there wll just be a total)
    if damageAmount == nil or damageAmount <= 0 then
        return
    end
    local wearer = getCurrentWearer();
    if wearer ~= nil and defender == wearer then
        PersistentVars[persistent_dmg_taken] = PersistentVars[persistent_dmg_taken] + damageAmount;
        _I("Damage taken: " .. damageAmount .. " total: " .. PersistentVars[persistent_dmg_taken]);
    end
end

local function hasLoviatarsLove(char)
    return Osi.HasActiveStatus(char, loviatars_love_status_id) == 1;
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
    if current_level < 4 then
        -- check if we've reached the pain threshold for the next level
        local total_damage = totalTakenDamage();
        local pain_threshold = pain_thresholds_for_remodel[current_level + 1];
        _I("Checking total damage: " .. total_damage .. " pain threshold: " .. pain_threshold);
        if total_damage < pain_threshold then
            _I("Needs more pain for remodelling!")
            return
        end

        _I("Upgrading remodelled body to level " .. current_level + 1);
        if current_level > 0 then
            Osi.RemovePassive(char, remodelled_frame_id_prefix .. current_level);
        end

        Osi.AddPassive(char, remodelled_frame_id_prefix .. current_level + 1);
        Osi.OpenMessageBox(char, remodelled_message[current_level + 1]);
    end
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
            Osi.OpenMessageBox(char, acquire_message);
            Osi.TemplateAddTo(loviatar_claws_item_id, char, 1, 1);
            Osi.TemplateAddTo(loviatar_claws_camp_item_id, char, 1, 1);
            Osi.TemplateAddTo(loviatar_claws_replica_item_id, char, 1, 1);
        end
    end
end

local function OnSessionLoaded()
    -- Persistent variables are only available after SessionLoaded is triggered!
    if PersistentVars[persistent_dmg_taken] == nil then
        PersistentVars[persistent_dmg_taken] = 0
    end
    _I("Total damage taken: " .. PersistentVars[persistent_dmg_taken]);
end


Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", curseLongRestHandler);

-- handle curse from item unequip
Ext.Osiris.RegisterListener("TemplateUnequipped", 2, "after", curseItemUnequipHandler);
Ext.Osiris.RegisterListener("TemplateEquipped", 2, "after", curseItemReequipHandler);

-- acquire from getting Loviatar's love
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", curseItemAcquisitionHandler);

Ext.Events.SessionLoaded:Subscribe("SessionLoaded", OnSessionLoaded)
Ext.Osiris.RegisterListener("AttackedBy", 7, "after", registerDamage);
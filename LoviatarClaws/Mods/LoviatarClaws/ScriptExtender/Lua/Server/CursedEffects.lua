PersistentVars = {};
-- for debugging, can put this in the console to set
-- Mods.LoviatarClaws.PersistentVars["Total Damage Taken"] = 100

local persistent_dmg_taken = "Total Damage Taken";
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
local ready_for_remodel_message = {
    "LI_CLAW_READY_1_MSG",
    "LI_CLAW_READY_2_MSG",
    "LI_CLAW_READY_3_MSG",
    "LI_CLAW_READY_4_MSG",
}
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


function TotalTakenDamageID(char)
    return persistent_dmg_taken .. "_" .. char;
end

function TotalTakenDamage(char)
    local dmg = PersistentVars[TotalTakenDamageID(char)];
    if dmg == nil then
        return 0;
    end
    return dmg;
end

function IncreaseTotalTakenDamage(char, amount)
    local id = TotalTakenDamageID(char);
    PersistentVars[id] = TotalTakenDamage(char) + amount;
    _I("Damage taken: " .. amount .. " total: " .. PersistentVars[id] .. " for ID: " .. id);
end

function HasLoviatarsLove(char)
    return Osi.HasActiveStatus(char, loviatars_love_status_id) == 1;
end

function RemodelledFrameLevel(char)
    for level = 1, 4 do
        local passive_key = remodelled_frame_id_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            return level;
        end
    end
    return 0;
end

function UpgradeRemodelledFrame(char)
    -- check level of remodelled body
    local current_level = RemodelledFrameLevel(char);
    if current_level < 4 then
        -- check if we've reached the pain threshold for the next level
        local total_damage = TotalTakenDamage(char);
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

local function OnSessionLoaded()
end


---@class LiClawsProgression
LiClawsProgression = {};
---Main progression interface for claws
---@param main_shortname string Short name for logging
---@param item_id string full template ID for the armor item e.g. LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685
---@param camp_item_id string full tempate ID for the camp version of the item
---@param replica_item_id string full template ID for the replica version of the item (no gameplay effects)
---@return LiClawsProgression
function LiClawsProgression:new(main_shortname, item_id, camp_item_id, replica_item_id)
    local self = {} ---@class LiClawsProgression
    setmetatable(self, {
        __index = LiClawsProgression
    })

    self.shortname = main_shortname;
    self.item_id = item_id;
    self.camp_item_id = camp_item_id;
    self.replica_item_id = replica_item_id;

    return self;
end

function LiClawsProgression:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function LiClawsProgression:error(message)
    self:log(" [ERROR] " .. message);
end

---Get the current wearer of the item
---@return table list of player character IDs that are wearing some copy of the item
function LiClawsProgression:getCurrentWearers()
    local wearers = {};
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        local boots = Osi.GetEquippedItem(char, "Boots");
        if boots ~= nil and Osi.GetTemplate(boots) == self.item_id then
            _I("Found wearer: " .. char);
            wearers[#wearers + 1] = char;
        end
    end
    return wearers;
end

function LiClawsProgression:registerDamage(defender, attackerOwner, attacker2, damageType, damageAmount, damageCause,
                                           storyActionID)
    -- only keep track of damage if the defender is the wearer (we're not going to track per-character, there wll just be a total)
    if damageAmount == nil or damageAmount <= 0 then
        return
    end
    local wearers = self:getCurrentWearers();
    for _, wearer in pairs(wearers) do
        if defender == wearer then
            -- check if we're passing a threshold, and if so display a message
            local total_damage = TotalTakenDamage(wearer);
            for i = 4, 1, -1 do
                if total_damage < pain_thresholds_for_remodel[i] and total_damage + damageAmount >= pain_thresholds_for_remodel[i] then
                    self:log("Reached pain threshold: " .. pain_thresholds_for_remodel[i]);
                    Osi.OpenMessageBox(wearer, ready_for_remodel_message[i]);
                end
            end
            IncreaseTotalTakenDamage(wearer, damageAmount);
        end
    end
end

function LiClawsProgression:curseLongRestHandler()
    -- loop over characters and check if anyway was wearing the cursed item
    local wearers = self:getCurrentWearers();
    for _, wearer in pairs(wearers) do
        self:log("Loviatar Claws wearer found: " .. wearer);
        -- check that the wearer has Loviatar's blessing
        -- if not, then they can no longer proceed with the transformation
        if not HasLoviatarsLove(wearer) then
            return
        end

        UpgradeRemodelledFrame(wearer);
    end
end

function LiClawsProgression:curseItemUnequipHandler(template, char)
    if template == self.item_id then
        local level = RemodelledFrameLevel(char);
        self:log("Loviatar Claws wearer unequipped item with level " .. level .. " remodelled body");
        if level > 0 then
            Osi.ApplyStatus(char, remodelled_frame_removed_id_prefix .. level, -1);
        end
    end
end

function LiClawsProgression:curseItemReequipHandler(template, char)
    if template == self.item_id then
        -- safe to use this level since character cannot progress to next level without wearing the claws
        local level = RemodelledFrameLevel(char);
        if level > 0 then
            self:log("Loviatar Claws wearer reequipped claws");
            Osi.RemoveStatus(char, remodelled_frame_removed_id_prefix .. level)
        end
    end
end

local cursed_item_acquisition_registered = false;
function LiClawsProgression:curseItemAcquisitionHandler(char, status, causee, storyActionID)
    -- filter if they're not a player character
    if Osi.IsPlayer(char) == 1 then
        if status == loviatars_love_status_id then
            Osi.OpenMessageBox(char, acquire_message);
            Osi.TemplateAddTo(self.item_id, char, 1, 1);
            Osi.TemplateAddTo(self.camp_item_id, char, 1, 1);
            Osi.TemplateAddTo(self.replica_item_id, char, 1, 1);
        end
    end
end

function LiClawsProgression:registerHandlers()
    Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function() self:curseLongRestHandler() end);

    -- handle curse from item unequip
    Ext.Osiris.RegisterListener("TemplateUnequipped", 2, "after", function(...) self:curseItemUnequipHandler(...) end);
    Ext.Osiris.RegisterListener("TemplateEquipped", 2, "after", function(...) self:curseItemReequipHandler(...) end);

    -- acquire from getting Loviatar's love (only 1 version can be registered)
    if not cursed_item_acquisition_registered then
        Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:curseItemAcquisitionHandler(...) end);
        cursed_item_acquisition_registered = true;
    end
    Ext.Osiris.RegisterListener("AttackedBy", 7, "after", function(...) self:registerDamage(...) end);
    self:log("Registered handlers");
end

Claws = LiClawsProgression:new("Claws",
    "LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685",
    "LI_LoviatarClaws_Camp_ec34283c-5e38-4bbc-a9cd-01397d55c5ce",
    "LI_LoviatarClaws_Replica_49041dbe-1df1-4b57-a53f-72e291bd291f");
Claws:registerHandlers();

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded);

local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_";


local sated_status_ids = {
    "LI_SATED",
    "LI_SATED_1",
    "LI_SATED_2"
};
local need_more_sated_stacks_msg = "LI_NEED_MORE_SATED_MSG";


local function _I(msg)
    _P("[SharessHarness] " .. msg);
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

---@class LiHarnessProgression
LiHarnessProgression = {};
---Main progression interface for Sharess's harness
---@param main_shortname string Short name for logging
---@param item_ids table list of full template ID for the armor item e.g. LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685
---@return LiHarnessProgression
function LiHarnessProgression:new(main_shortname, item_ids)
    local self = {} ---@class LiHarnessProgression
    setmetatable(self, {
        __index = LiHarnessProgression
    })

    self.shortname = main_shortname;
    self.item_ids = item_ids;

    return self;
end

function LiHarnessProgression:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function LiHarnessProgression:harnessLevel(char)
    local worn = Osi.GetEquippedItem(char, "Breast");
    -- self:log("Character " .. char .. " wearing breasts " .. tostring(worn));
    if worn == nil then
        return nil;
    end
    for level = 1, 5 do
        local harness_template_id = self.item_ids[level];
        if Osi.GetTemplate(worn) == harness_template_id then
            return level - 1;
        end
    end
    return nil;
end

---return a table of player character IDs that are wearing some copy of the item
---@return table player_id to number of sated stacks
function LiHarnessProgression:getSatedWearers()
    local sated = {};
    -- return the character and the number of sated stacks
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        local found = false;
        for stacks, status_id in pairs(sated_status_ids) do
            if Osi.HasActiveStatus(char, status_id) == 1 then
                self:log("Found sated wearer: " .. char .. " with stacks " .. stacks);
                sated[char] = stacks;
                found = true;
            end
        end
        if found == false then
            -- check if this character is wearing it but has no stacks
            local harness_level = self:harnessLevel(char);
            if harness_level ~= nil then
                sated[char] = 0;
            end
        end
    end
    return sated;
end

local function delayedCall(delayInMs, func)
    local startTime = Ext.Utils.MonotonicTime()
    local handlerId;
    handlerId = Ext.Events.Tick:Subscribe(function()
        local endTime = Ext.Utils.MonotonicTime()
        if (endTime - startTime > delayInMs) then
            Ext.Events.Tick:Unsubscribe(handlerId)
            func()
        end
    end);
end

function LiHarnessProgression:upgradeArmor(char)
    -- check level of remodelled body
    local body_level = RemodelledFrameLevel(char);
    -- can only upgrade to the remodelled body stage
    local armor_level = self:harnessLevel(char);
    -- not wearing the harness
    -- TODO give a message to the player that they need to be wearing the harness
    if armor_level == nil then
        self:log("Character " .. char .. " is not wearing the harness");
        -- Osi.OpenMessageBox(char, acquire_message);
        return
    end

    self:log("Body level " .. body_level .. " armor level " .. tostring(armor_level));
    if body_level > armor_level then
        -- remove the old armor
        local old_armor_template = self.item_ids[armor_level + 1];
        Osi.TemplateRemoveFromUser(old_armor_template, char, 1);

        -- add the new armor
        local new_armor_template = self.item_ids[armor_level + 2];
        Osi.TemplateAddTo(new_armor_template, char, 1, 1);
        -- if new_armor == nil then
        --     _I("Failed to find new armor " .. new_armor_template .. " in inventory");
        --     return
        -- end
        -- create a timed callback to equip it after 1 second
        -- this is because the armor is not available to equip immediately after adding it
        delayedCall(1000, function()
            local new_armor = Osi.GetItemByTemplateInUserInventory(new_armor_template, char);
            self:log("Equipping new armor " .. tostring(new_armor));
            Osi.Equip(char, new_armor);
        end);
    end
end

function LiHarnessProgression:curseLongRestHandler()
    self:log("long rest handler start")
    -- loop over characters and check if anyone has 3 sated stacks
    local wearers = self:getSatedWearers();
    for wearer, stacks in pairs(wearers) do
        -- check that the armor can still be upgraded
        local armor_level = self:harnessLevel(wearer);
        self:log("Wearer found: " .. wearer .. " with " .. stacks .. " stacks with armor level " .. tostring(armor_level));
        -- armor level is from 0 to 4, so if it's 4 then we can't upgrade it anymore
        if armor_level ~= nil and armor_level < 4 then
            -- if we have fewer than 3 stacks, we don't need to do anything
            -- give a message to the player hinting that they need to get more stacks
            if stacks >= 2 then
                self:upgradeArmor(wearer);
            elseif stacks >= 0 then
                self:log("Insufficient stacks: " .. stacks .. " for wearer " .. wearer .. ", giving message")
                Osi.OpenMessageBox(wearer, need_more_sated_stacks_msg);
            end
        end
    end
end

local clear_sated_registered = false;
function LiHarnessProgression:clearSatedHandler()
    delayedCall(3000, function()
        for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
            local char = player[1];
            -- remove sated status (doing it manually so it doesn't get cleared automatically after long rest)
            for _, status_id in pairs(sated_status_ids) do
                Osi.RemoveStatus(char, status_id);
            end
        end
    end);
end

function LiHarnessProgression:registerHandlers()
    Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function() self:curseLongRestHandler() end);
    if not clear_sated_registered then
        Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function() self:clearSatedHandler() end);
        clear_sated_registered = true;
    end
    self:log("Registered handlers");
end

Harness = LiHarnessProgression:new("Harness", {
    "LI_SharessHarness_f84dabb1-f1da-467a-9236-8c6aa474d4a4",
    "LI_SharessHarness_1_62328163-7cb9-49b5-8e76-f4a4ebd345ec",
    "LI_SharessHarness_2_e54bf9e5-38d7-402f-8e6a-2f3d9e6baf9b",
    "LI_SharessHarness_3_72dcd9e5-206b-48ba-83cc-997dc0598a57",
    "LI_SharessHarness_4_2de908cd-285d-4a31-b259-cdec0d3b59c0"
});
Harness:registerHandlers();

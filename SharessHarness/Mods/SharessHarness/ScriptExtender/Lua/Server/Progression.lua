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

local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_";

local harness_template_ids = {
    "LI_SharessHarness_f84dabb1-f1da-467a-9236-8c6aa474d4a4",
    "LI_SharessHarness_1_62328163-7cb9-49b5-8e76-f4a4ebd345ec",
    "LI_SharessHarness_2_e54bf9e5-38d7-402f-8e6a-2f3d9e6baf9b",
    "LI_SharessHarness_3_72dcd9e5-206b-48ba-83cc-997dc0598a57",
    "LI_SharessHarness_4_2de908cd-285d-4a31-b259-cdec0d3b59c0"
};
local sated_status_ids = {
    "LI_SATED",
    "LI_SATED_1",
    "LI_SATED_2"
};
local need_more_sated_stacks_msg = "LI_NEED_MORE_SATED_MSG";


local function _I(msg)
    _P("[SharessHarness] " .. msg);
end

function HarnessLevel(char)
    local worn = Osi.GetEquippedItem(char, "Breast");
    _I("Character " .. char .. " wearing breasts " .. tostring(worn));
    if worn == nil then
        return nil;
    end
    for level = 1, 5 do
        local harness_template_id = harness_template_ids[level];
        if Osi.GetTemplate(worn) == harness_template_id then
            _I("Found armor stage: " .. level - 1);
            return level - 1;
        end
    end
    return nil;
end

local function getSatedWearer()
    -- return the character and the number of sated stacks
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        for stacks, status_id in pairs(sated_status_ids) do
            if Osi.HasActiveStatus(char, status_id) == 1 then
                _I("Found sated wearer: " .. char .. " with stacks " .. stacks);
                return char, stacks
            end
        end
        -- check if this character is wearing it but has no stacks
        local harness_level = HarnessLevel(char);
        if harness_level ~= nil then
            return char, 0
        end
    end
    _I("No sated wearer found");
    return nil, 0
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

local function upgradeArmor(char)
    -- check level of remodelled body
    local body_level = RemodelledFrameLevel(char);
    -- can only upgrade to the remodelled body stage
    local armor_level = HarnessLevel(char);
    -- not wearing the harness
    -- TODO give a message to the player that they need to be wearing the harness
    if armor_level == nil then
        _I("Character " .. char .. " is not wearing the harness");
        -- Osi.OpenMessageBox(char, acquire_message);
        return
    end

    if body_level > armor_level then
        _I("Body level " .. body_level .. " is higher than armor level " .. armor_level .. ", upgrading armor");
        -- remove the old armor
        local old_armor_template = harness_template_ids[armor_level + 1];
        Osi.TemplateRemoveFromUser(old_armor_template, char, 1);

        -- add the new armor
        local new_armor_template = harness_template_ids[armor_level + 2];
        Osi.TemplateAddTo(new_armor_template, char, 1, 1);
        -- if new_armor == nil then
        --     _I("Failed to find new armor " .. new_armor_template .. " in inventory");
        --     return
        -- end
        -- create a timed callback to equip it after 1 second
        -- this is because the armor is not available to equip immediately after adding it
        delayedCall(1000, function()
            local new_armor = Osi.GetItemByTemplateInUserInventory(new_armor_template, char);
            _I("Equipping new armor " .. tostring(new_armor));
            Osi.Equip(char, new_armor);
        end);
    end
end

local function curseLongRestHandler()
    -- loop over characters and check if anyone has 3 sated stacks
    local wearer, stacks = getSatedWearer();
    if wearer ~= nil then
        _I("Sharess Harness wearer found: " .. wearer .. " with " .. stacks .. " stacks");

        -- check that the armor can still be upgraded
        local armor_level = HarnessLevel(wearer);
        -- armor level is from 0 to 4, so if it's 4 then we can't upgrade it anymore
        if armor_level ~= nil and armor_level < 4 then
            -- if we have fewer than 3 stacks, we don't need to do anything
            -- give a message to the player hinting that they need to get more stacks
            if stacks >= 2 then
                upgradeArmor(wearer);
            elseif stacks >= 0 then
                Osi.OpenMessageBox(wearer, need_more_sated_stacks_msg);
            end
        end

        -- remove sated status (doing it manually so it doesn't get cleared automatically after long rest)
        for _, status_id in pairs(sated_status_ids) do
            Osi.RemoveStatus(wearer, status_id);
        end
    end
end

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", curseLongRestHandler);

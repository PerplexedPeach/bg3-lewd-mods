local body_slot = "Breast";
local body_ids = {
    "LI_RemodelledFrameBody_1_f3b9c69e-e1df-4db7-8d94-d1372240df7a",
    "LI_RemodelledFrameBody_2_06bd8d1f-dcb9-451f-bb85-901f5fa79023",
    "LI_RemodelledFrameBody_3_fc55ef7a-6e74-4537-8e3f-231ba3a1fc5b",
    "LI_RemodelledFrameBody_4_faa19a15-0f48-4a9e-b2dd-c6e6bd7160fb",
};
local body_slot_camp = "VanityBody";
local body_camp_ids = {
    "LI_RemodelledFrameBody_Camp_1_9e0b66b1-c701-4df2-b115-28c8cc3b1493",
    "LI_RemodelledFrameBody_Camp_2_b1c133cb-c644-44f7-8be3-0b75903fcfb5",
    "LI_RemodelledFrameBody_Camp_3_39e11814-fef7-44ed-b2f2-36780e6537a9",
    "LI_RemodelledFrameBody_Camp_4_d2f1b595-7a38-4c2f-af2b-ddcb429d62c2",
};
local remodelled_frame_id_prefix = "LI_Claws_RemodelledFrame_";

function RemodelledFrameLevel(char)
    for level = 1, 4 do
        local passive_key = remodelled_frame_id_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            return level;
        end
    end
    return 0;
end

local function _I(msg)
    _P("[RFB] " .. msg);
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

---Get whether an item UUID belongs to a temporary ID
---@param item string UUID
---@return boolean whether it is an armor slot ID
---@return boolean whether it is a camp armor slot ID
local function isTempBody(item)
    local template = Osi.GetTemplate(item);
    for _, id in pairs(body_ids) do
        if template == id then
            return true, false;
        end
    end
    for _, id in pairs(body_camp_ids) do
        if template == id then
            return false, true;
        end
    end
    return false, false;
end

-- avoid triggering unequip handler after replacing an existing equipped boots
local do_not_trigger_unequip = false;
-- only care about this if the character has remodelled frame 
function UnequipHandler(item, char)
    if do_not_trigger_unequip == true then
        return;
    end
    local frame_level = RemodelledFrameLevel(char);
    if frame_level == 0 then
        return;
    end
    local slot = Ext.Entity.Get(item).Equipable.Slot;
    if slot ~= body_slot and slot ~= body_slot_camp then
        return;
    end
    -- ignore if it's temp body to avoid infinte loop
    local is_temp, is_temp_camp = isTempBody(item);
    if is_temp == true or is_temp_camp == true then
        return;
    end

    if slot == body_slot then
        -- create and equip camp feet later
        local id = body_ids[frame_level];
        Osi.TemplateAddTo(id, char, 1, 0);
        delayedCall(400, function()
            local to_equip = Osi.GetItemByTemplateInUserInventory(id, char);
            _I("Equipping remodelled frame body " .. frame_level);
            Osi.Equip(char, to_equip);
        end);
    elseif slot == body_slot_camp then
        local id = body_camp_ids[frame_level];
        Osi.TemplateAddTo(id, char, 1, 0);
        delayedCall(400, function()
            local to_equip = Osi.GetItemByTemplateInUserInventory(id, char);
            _I("Equipping remodelled frame body (camp) " .. frame_level);
            Osi.Equip(char, to_equip);
        end);
    end
end

function ReequipHandler(item, char)
    local slot = Ext.Entity.Get(item).Equipable.Slot;
    if slot ~= body_slot and slot ~= body_slot_camp then
        return;
    end
    local frame_level = RemodelledFrameLevel(char);
    if frame_level == 0 then
        return;
    end
    -- ignore if it's temp body to avoid infinte loop
    local is_temp, is_temp_camp = isTempBody(item);
    if is_temp == true or is_temp_camp == true then
        return;
    end

    if slot == body_slot then
        -- remove all up to what we have now since the frame level could've increased since last
        _I("Removing body");
        for level = 1, frame_level do
            local id = body_ids[level];
            Osi.TemplateRemoveFromUser(id, char, 1);
        end
        do_not_trigger_unequip = true;
        delayedCall(1000, function()
            do_not_trigger_unequip = false;
        end);
    elseif slot == body_slot_camp then
        _I("Removing body (camp)");
        for level = 1, frame_level do
            local id = body_camp_ids[level];
            Osi.TemplateRemoveFromUser(id, char, 1);
        end
        do_not_trigger_unequip = true;
        delayedCall(1000, function()
            do_not_trigger_unequip = false;
        end);
    end
end

Ext.Osiris.RegisterListener("Unequipped", 2, "after", function(...) UnequipHandler(...) end);
Ext.Osiris.RegisterListener("Equipped", 2, "after", function(...) ReequipHandler(...) end);
 
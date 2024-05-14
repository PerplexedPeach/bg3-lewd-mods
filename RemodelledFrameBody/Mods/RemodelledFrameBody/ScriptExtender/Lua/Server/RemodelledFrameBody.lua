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

local function _I(msg)
    _P("[RFB] " .. msg);
end


---Get whether an item UUID belongs to a temporary ID
---@param item string UUID
---@return integer armorlevel an armor slot ID stage
---@return integer camplevel camp armor slot ID stage
local function tempBodyItemLevel(item)
    local template = Osi.GetTemplate(item);
    for level = 1, 4 do
        if template == body_ids[level] then
            return level, 0;
        end
        if template == body_camp_ids[level] then
            return 0, level;
        end
    end
    return 0,0;
end

-- avoid triggering unequip handler after replacing an existing equipped boots
local do_not_trigger_unequip = false;
-- only care about this if the character has remodelled frame 
function UnequipHandler(item, char)
    local slot = Ext.Entity.Get(item).Equipable.Slot;
    if slot ~= body_slot and slot ~= body_slot_camp then
        return;
    end

    -- remove if it's temp body 
    local temp_level, temp_camp_level = tempBodyItemLevel(item);
    if temp_level > 0 or temp_camp_level > 0 then
        if temp_level > 0 then
            local id = body_ids[temp_level];
            Osi.TemplateRemoveFromUser(id, char, 1);
        else
            local id = body_camp_ids[temp_camp_level];
            Osi.TemplateRemoveFromUser(id, char, 1);
        end
        _I("Removing temp body");
        return;
    end
    
    if do_not_trigger_unequip == true then
        return;
    end

    -- local frame_level = Mods.DivineCurse.ForcedExposedBodyLevel(char);
    -- _I("Nude with frame level " .. frame_level);
    -- if frame_level == 0 then
    --     return;
    -- end

    -- if slot == body_slot then
    --     -- create and equip camp feet later
    --     local id = body_ids[frame_level];
    --     local item = Osi.CreateAtObject(id, char, 0, 0, "", 0);
    --     _I("Equipping remodelled frame body " .. frame_level);
    --     Osi.Equip(char, item);
    -- elseif slot == body_slot_camp then
    --     local id = body_camp_ids[frame_level];
    --     local item = Osi.CreateAtObject(id, char, 0, 0, "", 0);
    --     _I("Equipping remodelled frame body (camp) " .. frame_level);
    --     Osi.Equip(char, item);
    -- end
end

function ReequipHandler(item, char)
    local entity = Ext.Entity.Get(item);
    if entity == nil then
        return;
    end
    local slot = entity.Equipable.Slot;
    if slot ~= body_slot and slot ~= body_slot_camp then
        return;
    end
    do_not_trigger_unequip = true;
    Mods.DivineCurse.DelayedCall(1000, function()
        do_not_trigger_unequip = false;
    end);
end

-- function ShouldReplaceBody(char, slot)
--     -- we add body if there's nothing worn, or if it's one of our body items
--     local item = Osi.GetEquippedItem(char, slot);
--     if item == nil then
--         return true;
--     end
--     local temp_level, temp_camp_level = tempBodyItemLevel(item);
--     if slot == body_slot then
--         return temp_level > 0;
--     elseif slot == body_slot_camp then
--         return temp_camp_level > 0;
--     end
--     return false;
-- end

-- function EnforceBodyConsistency(char)
--     local frame_level = Mods.DivineCurse.ForcedExposedBodyLevel(char);
--     if frame_level > 0 then
--         if Osi.GetArmourSet(char) == Mods.DivineCurse.ARMOR_SET then
--             if ShouldReplaceBody(char, body_slot) then
--                 local id = body_ids[frame_level];
--                 local item = Osi.CreateAtObject(id, char, 0, 0, "", 0);
--                 _I("Equipping remodelled frame body " .. frame_level);
--                 Osi.Equip(char, item);
--             end
--         else
--             if ShouldReplaceBody(char, body_slot_camp) then
--                 local id = body_camp_ids[frame_level];
--                 local item = Osi.CreateAtObject(id, char, 0, 0, "", 0);
--                 _I("Equipping remodelled frame body (camp) " .. frame_level);
--                 Osi.Equip(char, item);
--             end
--         end
--     end
-- end

-- -- after loading, check if the body or body camp slot is unequipped, and if so equip it
-- function SaveGameLoadedHandler()
--     for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
--         local char = player[1];
--         -- check if they have remodelled frame
--         EnforceBodyConsistency(char);
--     end
-- end
-- -- also enforce after switching armor sets
-- function ArmorSetChangedHandler(character, eArmorSet)
--     EnforceBodyConsistency(character);
-- end

-- no longer need these due to remodelled frame being a character creation body override
Ext.Osiris.RegisterListener("Unequipped", 2, "after", function(...) UnequipHandler(...) end);
Ext.Osiris.RegisterListener("Equipped", 2, "after", function(...) ReequipHandler(...) end);
-- Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function(...) SaveGameLoadedHandler(...) end);
-- Ext.Osiris.RegisterListener("ArmorSetChanged", 2, "after", function(...) ArmorSetChangedHandler(...) end);
 
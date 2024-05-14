local feet_slot = "Boots";
local feet_id = "LI_HighHeelFeet_131135a6-7488-4b2f-9bab-731e6776c6fd";
local feet_slot_camp = "VanityBoots";
local feet_camp_id = "LI_HighHeelFeet_Camp_26aefb82-c28a-4f77-a573-a5835fd28a3b";
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
    _P("[HHF] " .. msg);
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

-- avoid triggering unequip handler after replacing an existing equipped boots
local do_not_trigger_unequip = false;
-- only care about this if the character has remodelled frame 
function UnequipHandler(item, char)
    if do_not_trigger_unequip == true then
        return;
    end
    -- ignore if it's one of the feets to avoid infinte loop
    if Osi.GetTemplate(item) == feet_id or Osi.GetTemplate(item) == feet_camp_id then
        return;
    end
    local frame = RemodelledFrameLevel(char);
    if frame == 0 then
        return;
    end
    local slot = Ext.Entity.Get(item).Equipable.Slot;
    -- only care about feet or camp feet
    if slot == feet_slot then
        -- create and equip camp feet later
        local item = Osi.CreateAtObject(feet_id, char, 0, 0, "", 0);
        _I("Equipping high heel feet");
        Osi.Equip(char, item);
    elseif slot == feet_slot_camp then
        local item = Osi.CreateAtObject(feet_camp_id, char, 0, 0, "", 0);
        _I("Equipping high heel feet (camp)");
        Osi.Equip(char, item);
    end
end

function ReequipHandler(item, char)
    -- ignore if it's one of the feets to avoid infinte loop
    if Osi.GetTemplate(item) == feet_id or Osi.GetTemplate(item) == feet_camp_id then
        return;
    end
    local entity = Ext.Entity.Get(item);
    if entity == nil then
        return;
    end
    local slot = entity.Equipable.Slot;
    if slot == feet_slot then
        -- create and equip camp feet later
        Osi.TemplateRemoveFromUser(feet_id, char, 1);
        _I("Removing high heel feet");
        do_not_trigger_unequip = true;
        delayedCall(1000, function()
            do_not_trigger_unequip = false;
        end);
    elseif slot == feet_slot_camp then
        Osi.TemplateRemoveFromUser(feet_camp_id, char, 1);
        _I("Removing high heel feet (camp)");
        do_not_trigger_unequip = true;
        delayedCall(1000, function()
            do_not_trigger_unequip = false;
        end);
    end
end

Ext.Osiris.RegisterListener("Unequipped", 2, "after", function(...) UnequipHandler(...) end);
Ext.Osiris.RegisterListener("Equipped", 2, "after", function(...) ReequipHandler(...) end);

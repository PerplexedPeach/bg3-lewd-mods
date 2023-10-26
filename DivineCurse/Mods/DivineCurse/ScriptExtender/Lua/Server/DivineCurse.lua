function DelayedCall(delayInMs, func)
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

-- need to track both the remodelled frame level as well as any worn harness level (since that overrides the body)
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

local body_passive_prefix = "LI_Body_";
function ExposedBodyLevel(char)
    for level = 1, 4 do
        local passive_key = body_passive_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            return level;
        end
    end
    return 0;
end

local clothes_passive_prefix = "LI_Clothes_";
function WornClothesLevel(char)
    for level = 0, 4 do
        local passive_key = clothes_passive_prefix .. level;
        if Osi.HasPassive(char, passive_key) == 1 then
            return level;
        end
    end
    return nil;
end

---What level (0 to 4) equipped body equipment should be, taking into account remodelled frame level and any worn clothing
---@param char any
---@return integer
function BodyEquipmentLevel(char)
    local body_level = ExposedBodyLevel(char);
    local clothes_level = WornClothesLevel(char);
    -- if clothes is worn, report that, else report the body level
    if clothes_level == nil then
        -- note that if character is wearing some other clothing, the body level will be 0
        return body_level;
    else
        return clothes_level;
    end
end

---@class BodyEquipment
BodyEquipment = {};
---Main progression interface for claws
---@param main_shortname string Short name for logging
---@param equipment_slot string equipment slot e.g. "Breast"
---@param item_ids_per_stage string full template IDs for the item e.g. LI_LoviatarClaws_07ea67e5-344b-4de6-91d3-449cce27a685 ordered by remodelled body stage
---@return BodyEquipment
function BodyEquipment:new(main_shortname, equipment_slot, item_ids_per_stage)
    local self = {} ---@class BodyEquipment
    setmetatable(self, {
        __index = BodyEquipment
    })

    self.shortname = main_shortname;
    self.slot = equipment_slot;
    self.item_ids_per_stage = item_ids_per_stage;
    if #self.item_ids_per_stage ~= 5 then
        self:error("Must have 5 stages of equipment (body stages 0 to 4)");
    end

    return self;
end

function BodyEquipment:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function BodyEquipment:error(message)
    self:log(" [ERROR] " .. message);
end

function BodyEquipment:itemLevel(item)
    if item == nil then
        return nil;
    end
    local template = Osi.GetTemplate(item);
    for level = 0, 4 do
        local id = self.item_ids_per_stage[level + 1];
        if template == id then
            return level;
        end
    end
    return nil;
end

function BodyEquipment:enforceBodyEquipmentConsistency(item, char)
    -- check if the equipped item is one of ours
    local item_level = self:itemLevel(item);
    if item_level == nil then
        return;
    end

    DelayedCall(100, function()
        -- check if there's an incompatibility between item level and Body Equipment level
        local body_level = BodyEquipmentLevel(char);

        self:log("item level " .. tostring(item_level) .. " body level " .. body_level .. " for " .. char);
        if item_level ~= body_level then
            self:log("Transforming " .. self.slot .. " from level " .. item_level .. " to " .. body_level);
            Osi.TemplateRemoveFromUser(self.item_ids_per_stage[item_level + 1], char, 1);
            local template_id = self.item_ids_per_stage[body_level + 1];

            local item = Osi.CreateAtObject(template_id, char, 0, 0, "", 0);
            Osi.Equip(char, item);
        end
    end);
end

function BodyEquipment:equipHandler(equipped_item, char)
    -- we also need to care about equipping things other than our item since they could change the body level
    local item = Osi.GetEquippedItem(char, self.slot);
    self:enforceBodyEquipmentConsistency(item, char);
end
-- also check after a delay after long rest (since the body level may have changed)
function BodyEquipment:longRestHandler()
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        local item = Osi.GetEquippedItem(char, self.slot);

        self:enforceBodyEquipmentConsistency(item, char);
    end
end

function BodyEquipment:registerHandlers()
    Ext.Osiris.RegisterListener("Equipped", 2, "after", function(...) self:equipHandler(...) end);
    Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function()
        DelayedCall(1000, function() self:longRestHandler() end);
    end);

    self:log("Registered handlers");
end

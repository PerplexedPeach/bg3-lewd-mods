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

local forced_status_prefix = "LI_FORCED_BODY_";
function ForcedBodyLevel(char)
    for level = 0, 4 do
        local status_key = forced_status_prefix .. level;
        if Osi.HasActiveStatus(char, status_key) == 1 then
            return level;
        end
    end
end

---What level (0 to 4) the character's body should be, taking into account remodelled frame level and overrides (no clothing considered)
---@param char any
---@return integer
function ForcedExposedBodyLevel(char)
    local forced_level = ForcedBodyLevel(char);
    if forced_level ~= nil then
        return forced_level;
    end
    return RemodelledFrameLevel(char);
end

---What level (0 to 4) equipped body accessories should be, taking into account remodelled frame level and any worn clothing
---@param char any
---@return integer
function BodyEquipmentLevel(char)
    local forced_level = ForcedBodyLevel(char);
    if forced_level ~= nil then
        return forced_level;
    end
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

-- TODO separate code into modules
local function _I(message)
    _P("[DivineCurse] " .. message);
end

local bliss_status = "LI_BLISS";
local pleasure_status = "LI_PLEASURE";
function Modifier(character, attribute)
    return math.floor((Osi.GetAbility(character, attribute) - 10) / 2);
end

function MaxPleasure(character)
    -- consider modifiers / perks for raising max pleasure
    local max_pleasure = 10;
    local modifier = Modifier(character, "Wisdom") + Modifier(character, "Constitution");
    local frame_level = RemodelledFrameLevel(character);
    local level = math.floor(Osi.GetLevel(character) / 2);
    max_pleasure = max_pleasure + level + modifier * 2 + frame_level * 3;
    if max_pleasure < 5 then
        max_pleasure = 5;
    end
    return max_pleasure;
end

function HandlePleasure(character, status, causee, storyActionID)
    if status ~= pleasure_status then
        return;
    end
    _I("Pleasure status applied to " .. character .. " by " .. causee .. " with story action " .. storyActionID);
    -- check character max HP against stacks of pleasure
    local max_pleasure = MaxPleasure(character);
    local cur_pleasure = Osi.GetStatusTurns(character, pleasure_status);
    _I("Pleasure " .. cur_pleasure .. " / " .. max_pleasure .. " for " .. character);
    if cur_pleasure > max_pleasure then
        _I("Bliss for " .. character);
        Osi.ApplyStatus(character, bliss_status, 2, 1, character);
        Osi.RemoveStatus(character, pleasure_status);
    end
end


-- get body override debug item
PersistentVars = {};
local debug_item_id = "LI_Body_Debugger_5c4ace59-3a59-4dc0-b6dc-b6049b119a02";
local function addDebugItem()
    if PersistentVars[debug_item_id] == nil then
        local char = Osi.GetHostCharacter();
        _P("Added body debug item to " .. tostring(char));
        Osi.TemplateAddTo(debug_item_id, char, 1, 1)
        PersistentVars[debug_item_id] = true;
    end
end

Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "after", function() addDebugItem() end);
Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() addDebugItem() end);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) HandlePleasure(...) end);
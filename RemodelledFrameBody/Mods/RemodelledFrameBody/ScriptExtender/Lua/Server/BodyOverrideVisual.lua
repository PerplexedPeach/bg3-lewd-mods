RaceMap = {
    ["b6dccbed-30f3-424b-a181-c4540cf38197"] = "TIF",
    ["bdf9b779-002c-4077-b377-8ea7c1faa795"] = "GTY",
};
function GetAssetForBodyShapeAndType(asset_map, entity)
    -- asset map will have keys in the form of <race>_<body_type> e.g. HUM_F, HUM_FS, HUM_M, GTY_F
    local cs = entity.CharacterCreationStats;
    local race = RaceMap[cs.Race] or "HUM";

    local body_type = "F";
    if cs.BodyType == 0 then
        body_type = "M";
    end
    local body_shape = "";
    if cs.BodyShape == 1 then
        body_shape = "S";
    end

    local query = race .. "_" .. body_type .. body_shape;
    local res = asset_map[query];
    if res == nil then
        query = "HUM_" .. body_type .. body_shape;
        res = asset_map[query];
    end
    return res;
end

---@class BodyOverrideVisual
BodyOverrideVisual = {};
---Framework for syncing passives (vai technical status ID) and their character visuals, as well as optionally gating it behind characters.
---we introduce a hidden status effect to listen for when the passive gets added or removed since there's no way to do that with passives themselves.
---@param main_shortname string Short name for logging
---@param status_id string technical status ID associated with having this visual
---@param hide_status_id string technical status ID associated with temporarily hiding this visual
---@param ccsv_ids table CharacterCreationSharedVisual IDs for the visual body per body shape
---@param character_lock_id string|nil optional character ID that restricts the check to just this character
---@param override_ccsv_id_fn function|nil optional function that takes the character GUID and returns the CCSV ID to use
---@return BodyOverrideVisual
function BodyOverrideVisual:new(main_shortname, status_id, hide_status_id, ccsv_ids, character_lock_id,
                                override_ccsv_id_fn)
    local self = {} ---@class BodyOverrideVisual
    setmetatable(self, {
        __index = BodyOverrideVisual
    })

    self.shortname = main_shortname;
    self.status_id = status_id;
    self.hide_status_id = hide_status_id;
    self.character_id = character_lock_id;

    self.ids = ccsv_ids;
    self.override_ccsv_id_fn = override_ccsv_id_fn;
    -- iterate over the keys and values of ccsv_ids_per_stage

    return self;
end

function BodyOverrideVisual:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function BodyOverrideVisual:error(message)
    self:log(" [ERROR] " .. message);
end

function BodyOverrideVisual:enforceVisualConsistency(char)
    char = Mods.DivineCurse.GetGUID(char);
    -- care about if self.character is specified
    if self.character_id ~= nil and self.character_id ~= char then
        return;
    end
    local entity = Ext.Entity.Get(char);

    local id = GetAssetForBodyShapeAndType(self.ids, entity);
    if self.override_ccsv_id_fn ~= nil then
        id = self.override_ccsv_id_fn(char);
        self:log("Overriding CCSV ID for " .. char .. " to " .. id);
    end
    if Osi.HasActiveStatus(char, self.status_id) == 1 and (self.hide_status_id == nil or Osi.HasActiveStatus(char, self.hide_status_id) == 0) then
        -- only add if we don't already have it (avoid spamming log)
        if not Mods.DivineCurse.FindCharacterCreationVisual(entity, id) then
            self:log("Applying lust brand visual to " .. char .. " with ID " .. tostring(id));
            Osi.AddCustomVisualOverride(char, id);
        end
    else
        self:log("Removing lust brand visual from " .. char .. " with ID " .. tostring(id));
        Osi.RemoveCustomVisualOvirride(char, id);
    end
end

function BodyOverrideVisual:statusAppliedHandler(char, status, causee, storyActionID)
    if status == self.status_id or status == self.hide_status_id then
        self:enforceVisualConsistency(char);
    end
end

function BodyOverrideVisual:statusRemovedHandler(char, status, causee, applyStoryActionID)
    if status == self.status_id or status == self.hide_status_id then
        self:enforceVisualConsistency(char);
    end
end

function BodyOverrideVisual:registerHandlers()
    Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:statusAppliedHandler(...) end);
    Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) self:statusRemovedHandler(...) end);
end

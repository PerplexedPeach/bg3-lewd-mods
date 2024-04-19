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
    -- sometimes valid to not have a valid asset (e.g. HUM_M for remodelled body)
    if id == nil then
        -- self:error("No CCSV ID found for " .. char);
        return;
    end
    if self:shouldHaveVisual(char) then
        -- only add if we don't already have it (avoid spamming log)
        if not Mods.DivineCurse.FindCharacterCreationVisual(entity, id) then
            self:log("Applying visual to " .. char .. " with ID " .. tostring(id));
            Osi.AddCustomVisualOverride(char, id);
        end
    else
        self:log("Removing visual from " .. char .. " with ID " .. tostring(id));
        Osi.RemoveCustomVisualOvirride(char, id);
    end
end

function BodyOverrideVisual:shouldHaveVisual(char)
    return Osi.HasActiveStatus(char, self.status_id) == 1 and (self.hide_status_id == nil or Osi.HasActiveStatus(char, self.hide_status_id) == 0);
end

function BodyOverrideVisual:shouldEnforceConsistency(status)
    return status == self.status_id or status == self.hide_status_id;
end

function BodyOverrideVisual:statusAppliedHandler(char, status, causee, storyActionID)
    if self:shouldEnforceConsistency(status) then
        self:enforceVisualConsistency(char);
    end
end

function BodyOverrideVisual:statusRemovedHandler(char, status, causee, applyStoryActionID)
    if self:shouldEnforceConsistency(status) then
        self:enforceVisualConsistency(char);
    end
end

function BodyOverrideVisual:registerHandlers()
    Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:statusAppliedHandler(...) end);
    Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) self:statusRemovedHandler(...) end);
end


-- body levels with overrides from debugger
---@class LevelledBodyOverrideVisual : BodyOverrideVisual
LevelledBodyOverrideVisual = {};
setmetatable(LevelledBodyOverrideVisual, {
    __index = BodyOverrideVisual
});


-- create the new function (constructor) with different arguments
---@param main_shortname string Short name for logging
---@param status_id string technical status ID associated with having this visual
---@param hide_status_id string technical status ID associated with temporarily hiding this visual
---@param ccsv_ids table CharacterCreationSharedVisual IDs for the visual body per body shape
---@param character_lock_id string|nil optional character ID that restricts the check to just this character
---@param override_ccsv_id_fn function|nil optional function that takes the character GUID and returns the CCSV ID to use
---@param level integer the level of the body
---@return LevelledBodyOverrideVisual
function LevelledBodyOverrideVisual:new(main_shortname, status_id, hide_status_id, ccsv_ids, character_lock_id,
                                        override_ccsv_id_fn, level)

    ---@class LevelledBodyOverrideVisual
    local self = BodyOverrideVisual:new(main_shortname, status_id, hide_status_id, ccsv_ids, character_lock_id,
                                       override_ccsv_id_fn); 
    setmetatable(self, {
        __index = LevelledBodyOverrideVisual
    });

    self.level = level;

    return self;
end


function LevelledBodyOverrideVisual:shouldHaveVisual(char)
    -- if body is hidden then no body visual should be shown
    if self.hide_status_id ~= nil and Osi.HasActiveStatus(char, self.hide_status_id) == 1 then
        return false;
    end
    -- if an override is active, then only show the one the override one
    local override_level = Mods.DivineCurse.BodyOverrideLevel(char);
    if override_level ~= nil then
        return override_level == self.level;
    end

    -- otherwise shows if the technical status is active
    return Osi.HasActiveStatus(char, self.status_id) == 1;
end

function LevelledBodyOverrideVisual:shouldEnforceConsistency(status)
    return status == self.status_id or status == self.hide_status_id or string.find(status, Mods.DivineCurse.LI_FORCED_BODY) ~= nil;
end

B1 = LevelledBodyOverrideVisual:new("B1", "LI_REMODELLED_FRAME_1_TECHNICAL", "LI_HIDE_REMODELLED_FRAME", {
    HUM_F = "79594cfb-25f0-4211-bb98-72b20d6e538c",
    HUM_FS = "8fb02f86-16af-457e-b0d2-d4be7d6aa3bb",
    GTY_F = "9a2724a5-adc6-45e2-a6fe-6abea6a87167",
    TIF_F = "ddca8a95-5ad3-4c8b-98db-766a468df0e9",
    TIF_FS = "6e5e1e23-9d51-4865-9f6c-8e8eb41320af",
}, nil, nil, 1);
B1:registerHandlers();

B2 = LevelledBodyOverrideVisual:new("B2", "LI_REMODELLED_FRAME_2_TECHNICAL", "LI_HIDE_REMODELLED_FRAME", {
    HUM_F = "eaac61a3-df92-4389-b117-ea165c10419c",
    HUM_FS = "6bc8843d-4b62-4638-ab7d-3e0450845130",
    GTY_F = "2556794d-630a-4145-9445-5ca965f4c010",
    TIF_F = "ff41da85-dc4e-47b7-bda7-76896293073f",
    TIF_FS = "c7f6c320-733e-45aa-8ef2-ba35ef3d4885",
}, nil, nil, 2);
B2:registerHandlers();

B3 = LevelledBodyOverrideVisual:new("B3", "LI_REMODELLED_FRAME_3_TECHNICAL", "LI_HIDE_REMODELLED_FRAME", {
    HUM_F = "4bc0e332-adbc-43fb-8eee-5e011c743dcd",
    HUM_FS = "0cfb0980-36a7-4348-bd73-cceae0492e16",
    GTY_F = "c1fffa55-3ea8-43f5-a43e-0d670db6bb80",
    TIF_F = "d6a21029-798d-405e-a791-e416b41510bc",
    TIF_FS = "4826e99b-033b-4f4c-883a-bcf5d4cb6cb5",
}, nil, nil, 3);
B3:registerHandlers();

B4 = LevelledBodyOverrideVisual:new("B4", "LI_REMODELLED_FRAME_4_TECHNICAL", "LI_HIDE_REMODELLED_FRAME", {
    HUM_F = "884dfef1-f8a2-48de-9d45-55555bdb463c",
    HUM_FS = "4198a9eb-6d94-46d2-a3d2-6c0ca46ea481",
    GTY_F = "ea1e8f96-f288-4801-85e4-5d84ff8bc18b",
    TIF_F = "d4d705ba-584a-4042-9e0c-04079b5d1da8",
    TIF_FS = "b372fc3f-9813-4c89-8ac6-6267fad31b74",
}, nil, nil, 4);
B4:registerHandlers();
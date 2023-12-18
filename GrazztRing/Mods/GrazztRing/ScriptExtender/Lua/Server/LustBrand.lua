HIDE_BRAND_STATUS = "LI_HIDE_BRAND";

---@class LustBrand
LustBrand = {};
---Framework for syncing lust brand passives and their character visuals, as well as optionally gating it behind characters.
---note that it's a passive that actually provides stat changes, but we introduce a hidden status effect to listen for when the
---passive gets added or removed since there's no way to do that with passives themselves.
---@param main_shortname string Short name for logging
---@param status_id string status ID associated with this lust brand that should decide whether to apply the visual
---@param ccsv_ids table CharacterCreationSharedVisual IDs for the visual brand per body shape
---@param character_lock_id string|nil optional character ID that restricts the check to just this character
---@param override_ccsv_id_fn function|nil optional function that takes the character GUID and returns the CCSV ID to use
---@return LustBrand
function LustBrand:new(main_shortname, status_id, ccsv_ids, character_lock_id, override_ccsv_id_fn)
    local self = {} ---@class LustBrand
    setmetatable(self, {
        __index = LustBrand
    })

    self.shortname = main_shortname;
    self.status_id = status_id;
    self.character_id = character_lock_id;

    self.ids = { { {}, {} }, { {}, {} } };
    self.override_ccsv_id_fn = override_ccsv_id_fn;
    -- iterate over the keys and values of ccsv_ids_per_stage

    for body_type, body_type_ids in pairs(ccsv_ids) do
        for body_shape, body_shape_id in pairs(body_type_ids) do
            local body_type_index = BodyTypeIndexMap[body_type];
            local body_shape_index = BodyShapeIndexMap[body_shape];
            if body_type_index == nil then
                self:error("Unknown body type " .. body_type);
            end
            if body_shape_index == nil then
                self:error("Unknown body shape " .. body_shape);
            end
            self.ids[body_type_index][body_shape_index] = body_shape_id;
        end
    end

    return self;
end

function LustBrand:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function LustBrand:error(message)
    self:log(" [ERROR] " .. message);
end


function LustBrand:handleLustBrandConsistency(char)
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
    if Osi.HasActiveStatus(char, self.status_id) == 1 and Osi.HasActiveStatus(char, HIDE_BRAND_STATUS) == 0 then
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

function LustBrand:statusAppliedHandler(char, status, causee, storyActionID)
    if status == self.status_id or status == HIDE_BRAND_STATUS then
        self:handleLustBrandConsistency(char);
    end
end

function LustBrand:statusRemovedHandler(char, status, causee, applyStoryActionID)
    if status == self.status_id or status == HIDE_BRAND_STATUS then
        self:handleLustBrandConsistency(char);
    end
end

function LustBrand:registerHandlers()
    Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:statusAppliedHandler(...) end);
    Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) self:statusRemovedHandler(...) end);

    self:log("Registered handlers");
end

L1 = LustBrand:new("L1", "LI_LUST_BRAND_TECHNICAL", {
    female = {
        normal = "0ed6e187-2232-4bec-a524-f983e175df55",
        strong = "58a88b95-eb78-4c00-9207-52c3f76df89b"
    },
    male = {
        normal = "7bfece7a-9142-409f-b276-1227bb037169"
    }
}, nil, nil);
L1:registerHandlers();
HIDE_BRAND_STATUS = "LI_HIDE_BRAND";
BRAND_PROGRESSION_EVENT_FLAGS = {
    -- sleeping with Haarlep
    ["LOW_HouseOfHope_State_GaveBodyToIncubus_54fb1ca4-b259-c4d8-7f9b-47b3dd889020"] = true,
    -- going into the wall crack / void
    ["MOO_WallTentacle_Tentacle_EnteredVoid_49d4bd06-580e-1a06-8b7b-a96e17193deb"] = true,
    -- sleeping with the twins
    ["WYR_DapperDrow_Event_IntimacyDone_10cfd95c-876e-cce9-9138-5593b5b5a33e"] = true,
    -- eating juiced spider
    ["SHA_SpiderMeatHunk_HasLickedAgain_3ca12346-8d7e-3c3f-6340-f1b0de361094"] = true,
    -- sleeping with Mizora
    ["NIGHT_Mizora_Romance_fbc49818-3d0a-43be-915b-b6d0f507d162"] = true,
};

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

    self.ids = ccsv_ids;
    self.override_ccsv_id_fn = override_ccsv_id_fn;
    -- iterate over the keys and values of ccsv_ids_per_stage

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

function ProgressLustBrand(char)
    local current_stage = LustBrandStage(char);
    -- _P("Brand progression triggered for " .. char .. " at stage " .. current_stage);
    -- TODO give a message about you reaching the limits of the powers of a brand
    if current_stage >= 3 then
        return;
    end
    -- TODO advance up a stage, remove the previous passive and add new passive in
    -- TODO give lore message about the brand advancing
end

local function handleFlagSet(flag, speaker, dialogueInstance)
    _P("FlagSet: " .. flag .. " by " .. speaker .. " in " .. dialogueInstance);
    if BRAND_PROGRESSION_EVENT_FLAGS[flag] then
        local char = Mods.DivineCurse.GetGUID(speaker);
        -- if the speaker has the brand, then progress it; otherwise we treat it like a global event and progress the brand of all
        if LustBrandStage(char) > 0 then
            ProgressLustBrand(char);
        else
            for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
                local char = player[1];
                if LustBrandStage(char) > 0 then
                    ProgressLustBrand(char);
                end
            end
        end
    end
end

local function registerProgressionEventListeners()
    Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(...) handleFlagSet(...) end);
end

L1 = LustBrand:new("L1", "LI_LUST_BRAND_TECHNICAL", {
    HUM_F = "0ed6e187-2232-4bec-a524-f983e175df55",
    HUM_FS = "58a88b95-eb78-4c00-9207-52c3f76df89b",
    GTY_F = "52cea3e5-2115-4374-8071-9eed0761c995",
    HUM_M = "7bfece7a-9142-409f-b276-1227bb037169",
}, nil, nil);
L1:registerHandlers();

registerProgressionEventListeners();

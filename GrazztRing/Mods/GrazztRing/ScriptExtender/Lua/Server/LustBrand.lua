local hide_brand_status = "LI_HIDE_BRAND";

---@class LustBrand
LustBrand = {};
---Framework for syncing lust brand passives and their character visuals, as well as optionally gating it behind characters.
---note that it's a passive that actually provides stat changes, but we introduce a hidden status effect to listen for when the
---passive gets added or removed since there's no way to do that with passives themselves.
---@param main_shortname string Short name for logging
---@param status_id string status ID associated with this lust brand that should decide whether to apply the visual
---@param ccsv_id string CharacterCreationSharedVisual ID for the visual brand
---@param character_lock_id string|nil optional character ID that restricts the check to just this character
---@return LustBrand
function LustBrand:new(main_shortname, status_id, ccsv_id, character_lock_id)
    local self = {} ---@class LustBrand
    setmetatable(self, {
        __index = LustBrand
    })

    self.shortname = main_shortname;
    self.ccsv_id = ccsv_id;
    self.status_id = status_id;
    self.character_id = character_lock_id;

    return self;
end

function LustBrand:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function LustBrand:error(message)
    self:log(" [ERROR] " .. message);
end

function LustBrand:handleLustBrandConsistency(char)
    -- care about if self.character is specified
    if self.character_id ~= nil and self.character_id ~= char then
        return;
    end
    if Osi.HasActiveStatus(char, self.status_id) == 1 and Osi.HasActiveStatus(char, hide_brand_status) == 0 then
        self:log("Applying lust brand visual to " .. char);
        Osi.AddCustomVisualOverride(char, self.ccsv_id);
    else
        self:log("Removing lust brand visual from " .. char);
        Osi.RemoveCustomVisualOvirride(char, self.ccsv_id);
    end
end

function LustBrand:statusAppliedHandler(char, status, causee, storyActionID)
    if status == self.status_id or status == hide_brand_status then
        self:handleLustBrandConsistency(char);
    end
end

function LustBrand:statusRemovedHandler(char, status, causee, applyStoryActionID)
    if status == self.status_id or status == hide_brand_status then
        self:handleLustBrandConsistency(char);
    end
end

function LustBrand:registerHandlers()
    Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:statusAppliedHandler(...) end);
    Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) self:statusRemovedHandler(...) end);

    self:log("Registered handlers");
end

L1 = LustBrand:new("L1", "LI_LUST_BRAND_TECHNICAL", "0ed6e187-2232-4bec-a524-f983e175df55", nil);
L1:registerHandlers();
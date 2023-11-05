local hide_piercing_status = "LI_HIDE_PIERCINGS";

---@class BodyPiercing
BodyPiercing = {};
---Visual framework for piercings
---@param main_shortname string Short name for logging
---@param template_id string Template ID for the item
---@param equipment_slot string equipment slot e.g. "Breast"
---@param ccsv_ids_per_stage table list of CharacterCreationSharedVisual IDs for the item ordered by remodelled body stage
---@return BodyPiercing
function BodyPiercing:new(main_shortname, template_id, equipment_slot, ccsv_ids_per_stage)
    local self = {} ---@class BodyPiercing
    setmetatable(self, {
        __index = BodyPiercing
    })

    self.shortname = main_shortname;
    self.slot = equipment_slot;
    self.template_id = template_id;
    self.ids_per_stage = ccsv_ids_per_stage;
    if #self.ids_per_stage ~= 5 then
        self:error("Must have 5 stages of equipment (body stages 0 to 4)");
    end
    self.all_ids = {};
    for _, ids in ipairs(self.ids_per_stage) do
        for _, id in ipairs(ids) do
            self.all_ids[id] = true;
        end
    end
    self:log("new");
    _D(self.all_ids);

    return self;
end

function BodyPiercing:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function BodyPiercing:error(message)
    self:log(" [ERROR] " .. message);
end

function BodyPiercing:itemLevel(char)
    -- forced to not show piercing
    if Osi.HasActiveStatus(char, hide_piercing_status) == 1 then
        return nil;
    end
    local item = Osi.GetEquippedItem(char, self.slot);
    if item == nil then
        return nil;
    end
    local template = Osi.GetTemplate(item);
    if template ~= self.template_id then
        return nil;
    end
    -- else return the forced body level
    return Mods.DivineCurse.BodyEquipmentLevel(char);
end

function BodyPiercing:enforceBodyPiercingConsistency(char)
    -- check what level of the equipment the character is wearing
    -- get the item template at slot
    local itemLevel = self:itemLevel(char);
    self:log("enforcing consistency for " .. char .. " with item level " .. tostring(itemLevel));

    local char_entity = Ext.Entity.Get(char);
    local char_visuals = char_entity.CharacterCreationAppearance.Visuals;

    local keep_vis_ids = {};
    if itemLevel ~= nil then
        -- add visuals that belong to the item level
        for _, vis_id in ipairs(self.ids_per_stage[itemLevel + 1]) do
            keep_vis_ids[vis_id] = true;
        end
    end

    -- remove all visuals that we manage and are not in the keep list
    for _, vis_id in ipairs(char_visuals) do
        if self.all_ids[vis_id] ~= nil then
            self:log("found managed visual " .. vis_id);
            if keep_vis_ids[vis_id] == nil then
                Osi.RemoveCustomVisualOvirride(char, vis_id);
            else
                keep_vis_ids[vis_id] = false;
            end
        end
    end

    self:log("to add visual visuals");
    _D(keep_vis_ids);

    for vis_id, add in pairs(keep_vis_ids) do
        if add then
            Osi.AddCustomVisualOverride(char, vis_id);
        end
    end
end

function BodyPiercing:equipHandler(equipped_item, char)
    -- we also need to care about equipping things other than our item since they could change the body level
    self:enforceBodyPiercingConsistency(char);
end

function BodyPiercing:unequipHandler(unequipped_item, char)
    -- we also need to care about equipping things other than our item since they could change the body level
    self:enforceBodyPiercingConsistency(char);
end

function BodyPiercing:statusAppliedHandler(object, status, causee, storyActionID)
    if status == hide_piercing_status then
        self:log("Hiding piercing for " .. object);
        self:enforceBodyPiercingConsistency(object);
    end
end

function BodyPiercing:statusRemovedHandler(object, status, causee, applyStoryActionID)
    if status == hide_piercing_status then
        self:log("Stop hiding piercing for " .. object);
        self:enforceBodyPiercingConsistency(object);
    end
end

function BodyPiercing:registerHandlers()
    self:log("Registering");
    Ext.Osiris.RegisterListener("Equipped", 2, "after", function(...) self:equipHandler(...) end);
    Ext.Osiris.RegisterListener("Unequipped", 2, "after", function(...) self:unequipHandler(...) end);
    Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) self:statusAppliedHandler(...) end);
    Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) self:statusRemovedHandler(...) end);

    self:log("Registered handlers");
end


Piercing1 = BodyPiercing:new("P1", "LI_GrazztRing_1_a372e826-3eb0-4eb5-be1d-92e0953957d5", "Cloak", {
    {"a15bbb01-7edd-4a17-a0fd-b8286a68d96e", "219eefaa-7614-4a1e-a82a-a9957e170b5c"},
    {"e07bbed8-242d-4a17-8669-de00059030e5", "437972aa-2221-4522-8bda-0d12e5bd9db7"},
    {"8f509b81-962e-40dc-8e29-b2f49ef03e66", "afc9f644-fa89-4dbf-a5a6-b8e71b67a060"},
    {"88ba0085-bfda-4e49-a5fa-cd0c7075268d", "fe39df5a-f76f-40df-a48a-51a358e0e3ee"},
    {"3e371491-034b-4fc4-8b19-d1ed67b9ee66", "ebb3ee9c-4d29-484c-8ea0-dc577ba6a092"},
});
Piercing1:registerHandlers();
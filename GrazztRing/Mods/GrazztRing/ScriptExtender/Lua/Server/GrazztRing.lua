local hide_piercing_status = "LI_HIDE_PIERCINGS";
local remove_piercing_damage = 15;
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

---@class BodyPiercing
BodyPiercing = {};
---Visual framework for piercings
---@param main_shortname string Short name for logging
---@param template_id string Template ID for the item
---@param equipment_slot string equipment slot e.g. "Breast"
---@param ccsv_ids_per_stage table list of CharacterCreationSharedVisual IDs for the item ordered by remodelled body stage.
--- Note BodyType 0 is male, BodyType 1 is female; BodyShape 0 is normal, BodyShape 1 is strong
---@return BodyPiercing
function BodyPiercing:new(main_shortname, template_id, equipment_slot, ccsv_ids_per_stage)
    local self = {} ---@class BodyPiercing
    setmetatable(self, {
        __index = BodyPiercing
    })

    self.shortname = main_shortname;
    self.slot = equipment_slot;
    self.template_id = template_id;
    -- indexed by body type then body shape
    self.ids_per_stage = ccsv_ids_per_stage;
    -- iterate over the keys and values of ccsv_ids_per_stage

    self.all_ids = {};
    for key, stage_ids in pairs(self.ids_per_stage) do
        if #stage_ids ~= 5 then
            self:error("Must have 5 stages of equipment (body stages 0 to 4) for key " .. key);
        end

        for _, ids in ipairs(stage_ids) do
            for _, id in ipairs(ids) do
                self.all_ids[id] = true;
            end
        end
    end
    -- self:log("new");
    -- _D(self.ids_per_stage);

    return self;
end

function BodyPiercing:log(message)
    _P("[" .. self.shortname .. "] " .. message);
end

function BodyPiercing:error(message)
    self:log(" [ERROR] " .. message);
end

function BodyPiercing:getIdsPerStageForEntity(entity)
    return GetAssetForBodyShapeAndType(self.ids_per_stage, entity);
end

function BodyPiercing:isWearingItem(char)
    local item = Osi.GetEquippedItem(char, self.slot);
    if item == nil then
        return false;
    end
    local template = Osi.GetTemplate(item);
    return template == self.template_id;
end

function BodyPiercing:itemLevel(char)
    -- forced to not show piercing
    if Osi.HasActiveStatus(char, hide_piercing_status) == 1 then
        return nil;
    end
    if self:isWearingItem(char) == false then
        return nil;
    end
    -- else return the forced body level
    return Mods.DivineCurse.BodyEquipmentLevel(char);
end

function BodyPiercing:applyVisuals(char, itemLevel)
    local char_entity = Ext.Entity.Get(char);
    local char_visuals = char_entity.CharacterCreationAppearance.Visuals;

    local keep_vis_ids = {};
    if itemLevel ~= nil then
        -- add visuals that belong to the item level
        local ids_per_stage = self:getIdsPerStageForEntity(char_entity);
        -- self:log("ids per stage for entity " .. char);
        -- _D(ids_per_stage);
        for _, vis_id in ipairs(ids_per_stage[itemLevel + 1]) do
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

function BodyPiercing:enforceBodyPiercingConsistency(char)
    -- check what level of the equipment the character is wearing
    -- get the item template at slot
    local itemLevel = self:itemLevel(char);
    self:log("enforcing consistency for " .. char .. " with item level " .. tostring(itemLevel));
    self:applyVisuals(char, itemLevel);
end

function BodyPiercing:equipHandler(equipped_item, char)
    -- only care about ourselves since there are potentially many piercings with shared ccsv ids
    local template = Osi.GetTemplate(equipped_item);
    if template == self.template_id then
        self:enforceBodyPiercingConsistency(char);
    end
end

function BodyPiercing:unequipHandler(unequipped_item, char)
    -- only care about ourselves
    local template = Osi.GetTemplate(unequipped_item);
    if template == self.template_id then
        self:enforceBodyPiercingConsistency(char);
        Osi.ApplyDamage(char, remove_piercing_damage, "Piercing", unequipped_item);
    end
end

function BodyPiercing:statusAppliedHandler(object, status, causee, storyActionID)
    if status == hide_piercing_status then
        if self:isWearingItem(object) == true then
            self:log("Hiding piercing for " .. object);
            self:enforceBodyPiercingConsistency(object);
        end
    end
end

function BodyPiercing:statusRemovedHandler(object, status, causee, applyStoryActionID)
    if status == hide_piercing_status then
        if self:isWearingItem(object) == true then
            self:log("Stop hiding piercing for " .. object);
            self:enforceBodyPiercingConsistency(object);
        end
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
    HUM_F = {
        { "219eefaa-7614-4a1e-a82a-a9957e170b5c" },
        { "437972aa-2221-4522-8bda-0d12e5bd9db7" },
        { "afc9f644-fa89-4dbf-a5a6-b8e71b67a060" },
        { "fe39df5a-f76f-40df-a48a-51a358e0e3ee" },
        { "ebb3ee9c-4d29-484c-8ea0-dc577ba6a092" },
    },
    HUM_FS = {
        { "4813dae1-cb97-481e-b9e1-5a60d22ce7fa" },
        { "166a81f6-1e14-46fa-aac5-b5c4cce00068" },
        { "142659d1-7d5e-4180-bce1-9ee510b1f8cd" },
        { "facbf4f6-e288-48a6-87db-2433bcfc60a5" },
        { "a20f45db-c11f-4c0a-a46d-2a2ff789e07b" },
    },
    HUM_M = {
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd" },
    }
});
Piercing1:registerHandlers();

Piercing2 = BodyPiercing:new("P2", "LI_GrazztRing_2_3325e465-daed-4daf-b6d3-1a2d8c0ff338", "Cloak", {
    HUM_F = {
        { "a15bbb01-7edd-4a17-a0fd-b8286a68d96e", "219eefaa-7614-4a1e-a82a-a9957e170b5c" },
        { "e07bbed8-242d-4a17-8669-de00059030e5", "437972aa-2221-4522-8bda-0d12e5bd9db7" },
        { "8f509b81-962e-40dc-8e29-b2f49ef03e66", "afc9f644-fa89-4dbf-a5a6-b8e71b67a060" },
        { "88ba0085-bfda-4e49-a5fa-cd0c7075268d", "fe39df5a-f76f-40df-a48a-51a358e0e3ee" },
        { "3e371491-034b-4fc4-8b19-d1ed67b9ee66", "ebb3ee9c-4d29-484c-8ea0-dc577ba6a092" },
    },
    HUM_FS = {
        { "c698fab1-43a2-4c7d-9d59-38d94a986ec4", "4813dae1-cb97-481e-b9e1-5a60d22ce7fa" },
        { "fc60aa34-b2b0-4bc7-be37-38bba9fae88c", "166a81f6-1e14-46fa-aac5-b5c4cce00068" },
        { "4011dbf5-a4a1-44cf-9d42-b8b346420b80", "142659d1-7d5e-4180-bce1-9ee510b1f8cd" },
        { "5da94a8e-4e4c-4573-a3a3-5e8c5f42fd5e", "facbf4f6-e288-48a6-87db-2433bcfc60a5" },
        { "410c7436-61d0-4b5e-b5c3-1b4898c581f6", "a20f45db-c11f-4c0a-a46d-2a2ff789e07b" },
    },
    HUM_M = {
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd", "af7cb44c-ef4a-4b3b-82fd-444cdedeef9a" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd", "af7cb44c-ef4a-4b3b-82fd-444cdedeef9a" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd", "af7cb44c-ef4a-4b3b-82fd-444cdedeef9a" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd", "af7cb44c-ef4a-4b3b-82fd-444cdedeef9a" },
        { "122bdd78-cfa0-4911-8ea8-2c4dfbfb82dd", "af7cb44c-ef4a-4b3b-82fd-444cdedeef9a" },
    }
});
Piercing2:registerHandlers();

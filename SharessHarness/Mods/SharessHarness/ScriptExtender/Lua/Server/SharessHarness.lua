local stimulation_passive = "LI_Sharess_Stimulation_Passive";

local sated_status_ids = {
    "LI_SATED",
    "LI_SATED_1",
    "LI_SATED_2"
};


---@class LiHarnessProgression : BodyEquipment
LiHarnessProgression = {};
setmetatable(LiHarnessProgression, {
    __index = Mods.DivineCurse.BodyEquipment
});


-- create the new function (constructor) with different arguments
---@param main_shortname string Short name for logging
---@param item_ids_per_stage table VisualBank IDs for each item per body stage
---@return LiHarnessProgression
function LiHarnessProgression:new(main_shortname, item_ids_per_stage)
    ---@class LiHarnessProgression
    local self = Mods.DivineCurse.BodyEquipment:new(main_shortname, "Breast", item_ids_per_stage);
    setmetatable(self, {
        __index = LiHarnessProgression
    });

    return self;
end

function ClearSatedHandler()
    Mods.DivineCurse.DelayedCall(3000, function()
        for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
            local char = player[1];
            -- remove sated status (doing it manually so it doesn't get cleared automatically after long rest)
            for _, status_id in pairs(sated_status_ids) do
                Osi.RemoveStatus(char, status_id);
            end
        end
    end);
end

function HandleSatedFromBliss(char, status, causee, storyActionID)
    if status ~= Mods.DivineCurse.BLISS_STATUS then
        return;
    end
    -- sate armor if wearing it - first check if we're wearing any by presence of passive
    if Osi.HasPassive(char, stimulation_passive) == 1 then
        -- check what sated level we're at
        for i, status in ipairs(sated_status_ids) do
            if Osi.HasActiveStatus(char, status) == 1 then
                if i == #sated_status_ids then
                    -- already at max level
                    return;
                end
                -- remove the status
                Osi.RemoveStatus(char, status);
                -- add the next one
                local next_status = sated_status_ids[i + 1];
                if next_status ~= nil then
                    Osi.ApplyStatus(char, next_status, -1, 1, char);
                end
                return;
            end
        end
        -- haven't found any, so we need to add the first one
        Osi.ApplyStatus(char, sated_status_ids[1], -1, 1, char);
    end
end

Ext.Osiris.RegisterListener("LongRestFinished", 0, "after", function() ClearSatedHandler() end);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", HandleSatedFromBliss);

Harness = LiHarnessProgression:new("Harness", {
    "LI_SharessHarness_f84dabb1-f1da-467a-9236-8c6aa474d4a4",
    "LI_SharessHarness_1_62328163-7cb9-49b5-8e76-f4a4ebd345ec",
    "LI_SharessHarness_2_e54bf9e5-38d7-402f-8e6a-2f3d9e6baf9b",
    "LI_SharessHarness_3_72dcd9e5-206b-48ba-83cc-997dc0598a57",
    "LI_SharessHarness_4_2de908cd-285d-4a31-b259-cdec0d3b59c0"
});
Harness:registerHandlers();

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

L1 = Mods.RemodelledFrameBody.BodyOverrideVisual:new("L1", "LI_LUST_BRAND_TECHNICAL", HIDE_BRAND_STATUS, {
    HUM_F = "0ed6e187-2232-4bec-a524-f983e175df55",
    HUM_FS = "58a88b95-eb78-4c00-9207-52c3f76df89b",
    GTY_F = "52cea3e5-2115-4374-8071-9eed0761c995",
    HUM_M = "7bfece7a-9142-409f-b276-1227bb037169",
}, nil, nil);
L1:registerHandlers();

registerProgressionEventListeners();

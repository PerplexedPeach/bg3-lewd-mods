HIDE_BRAND_STATUS = "LI_HIDE_BRAND";
EVENTS = {
    -- sleeping with Haarlep
    HAARLEP = "LOW_HouseOfHope_State_GaveBodyToIncubus_54fb1ca4-b259-c4d8-7f9b-47b3dd889020",
    -- going into the wall crack / void
    WALL_CRACK = "MOO_WallTentacle_Tentacle_EnteredVoid_49d4bd06-580e-1a06-8b7b-a96e17193deb",
    -- sleeping with the twins
    DROW_TWINS = "WYR_DapperDrow_Event_IntimacyDone_10cfd95c-876e-cce9-9138-5593b5b5a33e",
    -- eating juiced spider
    SPIDER_MEAT = "SHA_SpiderMeatHunk_HasLickedAgain_3ca12346-8d7e-3c3f-6340-f1b0de361094",
    -- sleeping with Mizora
    -- MIZORA = "NIGHT_Mizora_Romance_fbc49818-3d0a-43be-915b-b6d0f507d162",
    MIZORA = "CAMP_Mizora_Event_RomancedMizora_b5bb0f61-64ac-255e-a7c7-9d3b6f84ea31",
};
BRAND_PROGRESSION_EVENT_FLAGS = {
    [EVENTS.HAARLEP] = true,
    [EVENTS.WALL_CRACK] = true,
    [EVENTS.DROW_TWINS] = true,
    [EVENTS.SPIDER_MEAT] = true,
    [EVENTS.MIZORA] = true,
};
-- narrative messages for each event
BRAND_PROGRESSION_EVENT_MSGS = {
    [EVENTS.HAARLEP] = "LI_LUST_BRAND_HAARLEP_MSG",
    [EVENTS.WALL_CRACK] = "LI_LUST_BRAND_WALL_CRACK_MSG",
    [EVENTS.DROW_TWINS] = "LI_LUST_BRAND_DROW_TWINS_MSG",
    [EVENTS.SPIDER_MEAT] = "LI_LUST_BRAND_SPIDER_MEAT_MSG",
    [EVENTS.MIZORA] = "LI_LUST_BRAND_MIZORA_MSG",
};
BRAND_PROGRESSION_MSGS = {
    -- 1 to 2
    "LI_LUST_BRAND_1_MSG",
    -- 2 to 3
    "LI_LUST_BRAND_2_MSG",
};
BRAND_COMPLETED_MSG = "LI_LUST_BRAND_COMPLETED_MSG";


function ProgressLustBrand(char)
    local current_stage = LustBrandStage(char);
    _P("Brand progression triggered for " .. char .. " at stage " .. current_stage);
    if current_stage >= 3 then
        -- give a message about you reaching the limits of the powers of a brand
        Osi.OpenMessageBox(char, BRAND_COMPLETED_MSG);
        return;
    end
    if current_stage > 0 then
        -- advance up a stage, remove the previous passive and add new passive in
        Osi.RemovePassive(char, PLAYER_LUST_BRAND_PASSIVES_IDS[current_stage]);
        -- also remove the hiding status if it exists
        Osi.RemoveStatus(char, HIDE_BRAND_STATUS);
        -- give lore message about the brand advancing
        Osi.OpenMessageBox(char, BRAND_PROGRESSION_MSGS[current_stage]);
    end
    Osi.AddPassive(char, PLAYER_LUST_BRAND_PASSIVES_IDS[current_stage + 1]);
end

local function handleFlagSet(flag, speaker, dialogueInstance)
    -- _P("FlagSet: " .. flag .. " by " .. speaker .. " in " .. dialogueInstance);
    if BRAND_PROGRESSION_EVENT_FLAGS[flag] then
        -- local char = Mods.DivineCurse.GetGUID(speaker);
        local consort = GrazztConsort();
        if consort ~= nil then
            -- display message if it exists
            local event_msg = BRAND_PROGRESSION_EVENT_MSGS[flag];
            if event_msg ~= nil then
                Osi.OpenMessageBox(consort, event_msg);
            end
            Mods.DivineCurse.DelayedCall(20000, function() ProgressLustBrand(consort); end);
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
L2 = Mods.RemodelledFrameBody.BodyOverrideVisual:new("L2", "LI_LUST_BRAND_UPGRADED_TECHNICAL", "LI_HIDE_BRAND_2", {
    HUM_F = "7d2b1b00-b709-43ec-ac06-f02ecf845319",
    HUM_FS = "64eb8f98-7f32-4ba9-98c6-15c570a0da36",
    GTY_F = "7cc045f7-54e7-490e-874b-feea51b96e19",
    HUM_M = "03da298d-aa8a-426a-ba83-7fdfa01df22a",
}, nil, nil);
L2:registerHandlers();
L3 = Mods.RemodelledFrameBody.BodyOverrideVisual:new("L3", "LI_LUST_BRAND_COMPLETE_TECHNICAL", "LI_HIDE_BRAND_3", {
    HUM_F = "314c5eb1-549b-43a0-a0fe-f0c1528f6170",
    HUM_FS = "60fba90d-11b1-4904-9f37-9155c86d11bd",
    GTY_F = "12b8ce89-7d21-4962-a605-045eeb1e52ba",
    HUM_M = "ee91297e-b638-4513-86ca-788ee68326b7",
}, nil, nil);
L3:registerHandlers();

registerProgressionEventListeners();

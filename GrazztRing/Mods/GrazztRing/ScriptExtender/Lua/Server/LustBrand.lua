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
    MIZORA = "NIGHT_Mizora_Romance_fbc49818-3d0a-43be-915b-b6d0f507d162",
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
    -- TODO advance up a stage, remove the previous passive and add new passive in
    -- give lore message about the brand advancing
    Osi.OpenMessageBox(char, BRAND_PROGRESSION_MSGS[current_stage]);
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

registerProgressionEventListeners();

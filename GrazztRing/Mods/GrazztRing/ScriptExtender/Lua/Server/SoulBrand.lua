local soul_brand_unlock_limit = 5;
local soul_brand_approval_bonus = 50;
SOUL_BRAND_PASSIVE = "LI_Lust_Brand_Soul_Brand";
local soul_brand_acquire_message = "LI_SOUL_BRAND_ACQUIRE";

SOUL_BRAND_STATUS = "LI_SOUL_BRAND_TECHNICAL";
DRAIN_TARGET_STATUS = "LI_SOUL_BRAND_GARROTE_TARGET";
-- special NPC guids that have special crests
KARLACH = "2c76687d-93a2-477b-8b18-8a14b549304c";
SHADOWHEART = "3ed74f06-3c60-42dc-83f6-f034cb47c679";
MINTHARA = "25721313-0c15-4935-8176-9f134385451b";
TAV = "97c99688-6b7f-3b3e-5cb2-fea9647b6275";
LAEZEL = "58a69333-40bf-8358-1d17-fff240d7fb12";
AYLIN = "6c55edb0-901b-4ba4-b9e8-3475a8392d9b";

local soul_brand_mapping = {
    [KARLACH] = {
        passive = "LI_Soul_Brand_Karlach",
        consort_passive = "LI_Soul_Brand_Karlach_Consort",
        technical_status = "LI_SOUL_BRAND_KARLACH_TECHNICAL",
        message_id = "LI_SOUL_BRAND_KARLACH",
        visual_id = "3ebbe8d8-d509-479d-8c44-69b3343ae1dd"
    },
    [SHADOWHEART] = {
        passive = "LI_Soul_Brand_Shadowheart",
        consort_passive = "LI_Soul_Brand_Shadowheart_Consort",
        technical_status = "LI_SOUL_BRAND_SHADOWHEART_TECHNICAL",
        message_id = "LI_SOUL_BRAND_SHADOWHEART",
        visual_id = "bc3f8ad4-d8f4-47b2-9bb0-aaeedc901b86"
    },
    [MINTHARA] = {
        passive = "LI_Soul_Brand_Minthara",
        consort_passive = "LI_Soul_Brand_Minthara_Consort",
        technical_status = "LI_SOUL_BRAND_MINTHARA_TECHNICAL",
        message_id = "LI_SOUL_BRAND_MINTHARA",
        visual_id = "3c02f49f-2fb0-4776-bad5-7fe5f9ee159f"
    },
    [AYLIN] = {
        passive = "LI_Soul_Brand_Aylin",
        consort_passive = "LI_Soul_Brand_Aylin_Consort",
        technical_status = "LI_SOUL_BRAND_AYLIN_TECHNICAL",
        message_id = "LI_SOUL_BRAND_AYLIN",
        visual_id = "61218b50-c4ea-410b-9db4-aa884f318fca"
    },
    [LAEZEL] = {
        passive = "LI_Soul_Brand_Laezel",
        consort_passive = "LI_Soul_Brand_Laezel_Consort",
        technical_status = "LI_SOUL_BRAND_LAEZEL_TECHNICAL",
        message_id = "LI_SOUL_BRAND_LAEZEL",
        visual_id = "a59314d4-9dda-4ca0-a090-3117a6630cc5"
    },
};
local soul_brand_profane_succor_passives = {
    [1] = "LI_Profane_Succor_1",
    [3] = "LI_Profane_Succor_2",
    [5] = "LI_Profane_Succor_3",
};

local function _I(message)
    _P("[Soul Brand] " .. message);
end

--- To switch the appearance of the tattoo from outside this mod (such as through the console)
--- e.g. Mods.GrazztRing.SetSoulBrandVisual(Mods.GrazztRing.KARLACH, "3ebbe8d8-d509-479d-8c44-69b3343ae1dd")
function SetSoulBrandVisual(npc_guid, ccvid)
    soul_brand_mapping[npc_guid].visual_id = ccvid;
end

---Number of soul brands applied by the consort
---@param char string GUID of the consort
---@return integer
function NumberOfSoulBrandsApplied(char)
    -- loop over special_uuids_to_passive_and_message and count how many of them are applied
    local count = 0;
    for _, res in pairs(soul_brand_mapping) do
        if Osi.HasPassive(char, res.consort_passive) == 1 then
            count = count + 1;
        end
    end
    return count;
end

function SoulBrandAppliedHandler(char, status, causee, storyActionID)
    if status ~= SOUL_BRAND_STATUS then
        return;
    end
    DoApplySoulBrand(causee, char);
end

function DoApplySoulBrand(brander, brandee)
    brander = Mods.DivineCurse.GetGUID(brander);
    brandee = Mods.DivineCurse.GetGUID(brandee);
    _I("Soul brand applied to " .. brandee .. " by " .. brander);

    local res = soul_brand_mapping[brandee];
    if res ~= nil then
        local passive = res.passive;
        local passive_consort = res.consort_passive;
        local message_id = res.message_id;
        _I("Branding special NPC " ..
            brandee .. " with passive " .. passive .. " and adding passive " .. passive_consort .. " to " .. brander);
        Osi.AddPassive(brandee, passive);
        Osi.AddPassive(brander, passive_consort);
        Mods.DivineCurse.DelayedCall(3000, function()
            Osi.OpenMessageBox(brander, message_id);
            SoulBrandGiveConsortProfaneSuccor(brander, NumberOfSoulBrandsApplied(brander));
            Osi.ChangeApprovalRating(brandee, brander, 0, soul_brand_approval_bonus);
        end);
    end
end

function SoulBrandGiveConsortProfaneSuccor(char, have_num_soul_brands)
    _I("Giving profane succor to " .. char .. " with " .. have_num_soul_brands .. " soul brands");
    for num_required, passive in pairs(soul_brand_profane_succor_passives) do
        if have_num_soul_brands >= num_required and Osi.HasPassive(char, passive) == 0 then
            _I("Adding profane succor " .. passive .. " to " .. char);
            Osi.AddPassive(char, passive);
        end
    end
end

function SoulBrandAcquireHandler(char, status, causee, storyActionID)
    if status ~= Mods.DivineCurse.BLISS_STATUS then
        return;
    end
    -- not the consort, ignore
    -- already have the passive, ignore
    if not IsGrazztConsort(causee) or Osi.HasPassive(causee, SOUL_BRAND_PASSIVE) == 1 then
        return;
    end
    -- when we have given others at least some Bliss, we unlock ability to give Soul Brands
    local caused_bliss = Mods.DivineCurse.BlissCauseCountAll(causee);
    if caused_bliss < soul_brand_unlock_limit then
        return;
    end

    Osi.OpenMessageBox(causee, soul_brand_acquire_message);
    Osi.AddPassive(causee, SOUL_BRAND_PASSIVE);
end

local function registerSoulBrandVisuals(human_name, guid)
    local data = soul_brand_mapping[guid];
    local sb = Mods.RemodelledFrameBody.BodyOverrideVisual:new(human_name, data.technical_status, HIDE_BRAND_STATUS, {}, guid,
        function(char) return soul_brand_mapping[guid].visual_id end);
    sb:registerHandlers();
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after",
    function(...)
        SoulBrandAppliedHandler(...); SoulBrandAcquireHandler(...)
    end);

registerSoulBrandVisuals("Karlach", KARLACH);
registerSoulBrandVisuals("Shadowheart", SHADOWHEART);
registerSoulBrandVisuals("Minthara", MINTHARA);
registerSoulBrandVisuals("Aylin", AYLIN);
registerSoulBrandVisuals("Laezel", LAEZEL);

local soul_brand_unlock_limit = 5;
SOUL_BRAND_PASSIVE = "LI_Lust_Brand_Soul_Brand";
local soul_brand_acquire_message = "LI_SOUL_BRAND_ACQUIRE";

SOUL_BRAND_STATUS = "LI_SOUL_BRAND_TECHNICAL";
DRAIN_TARGET_STATUS = "LI_SOUL_BRAND_GARROTE_TARGET";
-- special NPC guids that have special crests
KARLACH = "2c76687d-93a2-477b-8b18-8a14b549304c";

local special_uuids_to_passive_and_message = {
    [KARLACH] = {"LI_Soul_Brand_Karlach", "LI_Soul_Brand_Karlach_Consort", "LI_SOUL_BRAND_KARLACH"},
};
local soul_brand_for_consort_passives = {
    special_uuids_to_passive_and_message[KARLACH][2]
};


local function _I(message)
    _P("[Soul Brand] " .. message);
end

function SoulBrandAppliedHandler(char, status, causee, storyActionID)
    if status ~= SOUL_BRAND_STATUS then
        return;
    end
    causee = Mods.DivineCurse.GetGUID(causee);
    char = Mods.DivineCurse.GetGUID(char);
    _I("Soul brand status applied to " .. char .. " by " .. causee .. " with story action " .. storyActionID);
    local res = special_uuids_to_passive_and_message[char];
    if res ~= nil then
        local passive = res[1];
        local passive_consort = res[2];
        local message_id = res[3];
        _I("Branding special NPC " .. char .. " with passive " .. passive .. " and adding passive " .. passive_consort .. " to " .. causee);
        Osi.AddPassive(char, passive);
        Osi.AddPassive(causee, passive_consort);
        Mods.DivineCurse.DelayedCall(3000, function()
            Osi.OpenMessageBox(char, message_id);
        end);
    end
end

function SoulBrandAcquireHandler(char, status, causee, storyActionID)
    if status ~= Mods.DivineCurse.BLISS_STATUS then
        return;
    end
    -- not the consort, ignore
    -- already have the passive, ignore
    if not IsGrazztConsort(char) or Osi.HasPassive(char, SOUL_BRAND_PASSIVE) == 1 then
        return;
    end
    -- when we have given others at least some Bliss, we unlock ability to give Soul Brands
    local caused_bliss = Mods.DivineCurse.BlissCauseCountAll(causee);
    if caused_bliss < soul_brand_unlock_limit then
        return;
    end

    Osi.OpenMessageBox(char, soul_brand_acquire_message);
    Osi.AddPassive(char, SOUL_BRAND_PASSIVE);
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) SoulBrandAppliedHandler(...); SoulBrandAcquireHandler(...) end);
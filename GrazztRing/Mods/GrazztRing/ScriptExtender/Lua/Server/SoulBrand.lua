local soul_brand_unlock_limit = 5;
SOUL_BRAND_PASSIVE = "LI_Lust_Brand_Soul_Brand";
local soul_brand_acquire_message = "ha709ac40g498bg4b91g9f8egf03100a9d2e4";

SOUL_BRAND_STATUS = "LI_SOUL_BRAND_TECHNICAL";
DRAIN_TARGET_STATUS = "LI_SOUL_BRAND_GARROTE_TARGET";
-- special NPC guids that have special crests
KARLACH = "2c76687d-93a2-477b-8b18-8a14b549304c";


local function _I(message)
    _P("[Soul Brand] " .. message);
end

function SoulBrandAppliedHandler(char, status, causee, storyActionID)
    if status ~= SOUL_BRAND_STATUS then
        return;
    end
    causee = Mods.DivineCurse.GetGUID(causee);
    _I("Soul brand status applied to " .. char .. " by " .. causee .. " with story action " .. storyActionID);
end

function SoulBrandAcquireHandler(char, status, causee, storyActionID)
    if status ~= Mods.DivineCurse.BLISS_STATUS then
        return;
    end
    -- already have the passive, ignore
    if Osi.HasPassive(char, SOUL_BRAND_PASSIVE) == 1 then
        return;
    end
    -- when we have given others at least some Bliss, we unlock ability to give Soul Brands
    local caused_bliss = Mods.DivineCurse.BlissCauseCountAll(causee);
    if caused_bliss < soul_brand_unlock_limit then
        return;
    end

    Osi.OpenMessageBox(char, Ext.Loca.GetTranslatedString(soul_brand_acquire_message));
    Osi.AddPassive(char, SOUL_BRAND_PASSIVE);
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) SoulBrandAppliedHandler(...); SoulBrandAcquireHandler(...) end);
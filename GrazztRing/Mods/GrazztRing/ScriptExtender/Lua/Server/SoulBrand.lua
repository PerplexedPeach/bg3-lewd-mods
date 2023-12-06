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

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) SoulBrandAppliedHandler(...) end);
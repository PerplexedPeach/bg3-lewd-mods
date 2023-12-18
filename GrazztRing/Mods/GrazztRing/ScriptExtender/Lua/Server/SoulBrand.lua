local soul_brand_unlock_limit = 5;
SOUL_BRAND_PASSIVE = "LI_Lust_Brand_Soul_Brand";
local soul_brand_acquire_message = "LI_SOUL_BRAND_ACQUIRE";

SOUL_BRAND_STATUS = "LI_SOUL_BRAND_TECHNICAL";
DRAIN_TARGET_STATUS = "LI_SOUL_BRAND_GARROTE_TARGET";
-- special NPC guids that have special crests
KARLACH = "2c76687d-93a2-477b-8b18-8a14b549304c";

local soul_brand_mapping = {
    [KARLACH] = {
        passive = "LI_Soul_Brand_Karlach",
        consort_passive = "LI_Soul_Brand_Karlach_Consort",
        technical_status = "LI_SOUL_BRAND_KARLACH_TECHNICAL",
        message_id = "LI_SOUL_BRAND_KARLACH",
        visual_id = "3ebbe8d8-d509-479d-8c44-69b3343ae1dd"
    },
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
    causee = Mods.DivineCurse.GetGUID(causee);
    char = Mods.DivineCurse.GetGUID(char);
    _I("Soul brand status applied to " .. char .. " by " .. causee .. " with story action " .. storyActionID);
    local res = soul_brand_mapping[char];
    if res ~= nil then
        local passive = res.passive;
        local passive_consort = res.consort_passive;
        local message_id = res.message_id;
        _I("Branding special NPC " ..
            char .. " with passive " .. passive .. " and adding passive " .. passive_consort .. " to " .. causee);
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

local function registerSoulBrandVisuals(human_name, guid)
    local data = soul_brand_mapping[guid];
    local sb = LustBrand:new(human_name, data.technical_status, {}, guid,
        function(char) return soul_brand_mapping[guid].visual_id end);
    sb:registerHandlers();
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after",
    function(...)
        SoulBrandAppliedHandler(...); SoulBrandAcquireHandler(...)
    end);

registerSoulBrandVisuals("Karlach", KARLACH);

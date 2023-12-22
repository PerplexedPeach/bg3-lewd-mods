PersistentVars = {};
-- listen for long rest for when you have enough orgasms and sleeps with the ring on
local player_lust_brand_passive_ids = {
    "LI_Lust_Brand"
};
local grazzt_consort_key = "grazzt_consort";
local grazzt_consort_title = "hb3436a69g5fe9g47d8g8bdcg1f6c577d38a5";

local function _I(message)
    _P("[Consort] " .. message);
end

function LustBrandStage(char)
    for i, passive_id in ipairs(player_lust_brand_passive_ids) do
        if Osi.HasPassive(char, passive_id) == 1 then
            return i;
        end
    end
    return 0;
end

function GrazztConsort()
    return PersistentVars[grazzt_consort_key];
end

function SetGrazztConsort(char)
    _I("Setting " .. char .. " as Grazzt's consort");
    PersistentVars[grazzt_consort_key] = Mods.DivineCurse.GetGUID(char);
    NameConsort(char);
end

function IsGrazztConsort(char)
    if PersistentVars[grazzt_consort_key] == nil then
        return false;
    end
    char = Mods.DivineCurse.GetGUID(char);
    return PersistentVars[grazzt_consort_key] == char;
end

function NameConsort(consort)
    local name_handle = Osi.GetDisplayName(consort);
    local name = Ext.Loca.GetTranslatedString(name_handle);
    -- TODO different titles with stages and choices rather than just a single selection here
    local title = Ext.Loca.GetTranslatedString(grazzt_consort_title);
    -- if the name already has the title, don't add it again
    _I("checking if " .. name .. " has title " .. title .. " find result " .. tostring(string.find(name, title)));
    if string.find(name, title) ~= nil then
        return;
    end
    _I("found consort " ..
    consort .. " name handle " .. name_handle .. " translated name " .. name .. " translated title " .. title);
    -- Osi.SetStoryDisplayName(consort, name .. title);
    Ext.Loca.UpdateTranslatedString(name_handle, name .. title);
end

function NameConsortAfterLoad()
    local consort = GrazztConsort();
    if consort ~= nil then
        NameConsort(consort);
    end
end

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() NameConsortAfterLoad() end);

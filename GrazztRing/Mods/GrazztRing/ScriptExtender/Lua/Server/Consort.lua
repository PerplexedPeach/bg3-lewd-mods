PersistentVars = {};
-- listen for long rest for when you have enough orgasms and sleeps with the ring on
local player_lust_brand_passive_ids = {
    "LI_Lust_Brand"
};
local grazzt_consort_key = "grazzt_consort";
local grazzt_consort_title = "hb3436a69g5fe9g47d8g8bdcg1f6c577d38a5";
local consort_passive = "LI_CONSORT_TECHNICAL";
local title_hiding_status = "LI_HIDE_TITLE";

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

    -- depending on if you have the hide title status or not, we will add or remove the title
    local should_have_title = Osi.HasActiveStatus(consort, title_hiding_status) == 0;
    local res = string.find(name, title);
    _I("Should have title? " .. tostring(should_have_title));

    if should_have_title then
        if res ~= nil then
            return;
        end
        _I("found consort " ..
        consort .. " name handle " .. name_handle .. " translated name " .. name .. " translated title " .. title);
        -- Osi.SetStoryDisplayName(consort, name .. title);
        Ext.Loca.UpdateTranslatedString(name_handle, name .. title);
    else
        if res == nil then
            return;
        end
        _I("Hiding title");
        -- Osi.SetStoryDisplayName(consort, name:gsub(title, ""));
        Ext.Loca.UpdateTranslatedString(name_handle, name:gsub(title, ""));
    end
end

function NameConsortAfterLoad()
    local consort = GrazztConsort();
    if consort ~= nil then
        NameConsort(consort);
        -- ensure they have passive
        Osi.AddPassive(consort, consort_passive);
    end
end

function TitleHidingHandler(char, status, causee, storyActionID)
    if status ~= title_hiding_status then
        return;
    end
    -- needs to be delayed because the status is not applied immediately
    Mods.DivineCurse.DelayedCall(1000, function() NameConsort(char) end);
end

Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() NameConsortAfterLoad() end);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) TitleHidingHandler(...) end);
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) TitleHidingHandler(...) end);

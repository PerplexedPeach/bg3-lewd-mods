PersistentVars = {};
-- listen for long rest for when you have enough orgasms and sleeps with the ring on
local base_ring_template = "LI_GrazztRing_2a33b13e-adb2-4d52-9303-14ca982cef99";
local possible_ring_slots = { "Ring", "Ring2" };
local base_piercing_template = "LI_GrazztRing_1_a372e826-3eb0-4eb5-be1d-92e0953957d5";
local bliss_threshold_ring_to_piercing = 1;
local bliss_threshold_lust_brand = 3;
local ring_to_piercing_msg = "LI_RING_PROGRESSION_MSG";
local lust_brand_msg = "LI_LUST_BRAND_MSG";
local player_lust_brand_passive_ids = {
    "LI_Lust_Brand"
};
local grazzt_consort_key = "grazzt_consort";
local grazzt_consort_title = "hb3436a69g5fe9g47d8g8bdcg1f6c577d38a5";
local grazzt_ignore_msg = "LI_GRAZZT_IGNORE_MSG";

local function _I(message)
    _P("[Grazzt Piercings] " .. message);
end

function IsWearingBaseRing(char)
    for _, slot in ipairs(possible_ring_slots) do
        local item = Osi.GetEquippedItem(char, slot);
        if item ~= nil and Osi.GetTemplate(item) == base_ring_template then
            return true;
        end
    end
    return false;
end

function LustBrandStage(char)
    for i, passive_id in ipairs(player_lust_brand_passive_ids) do
        if Osi.HasPassive(char, passive_id) == 1 then
            return i;
        end
    end
    return 0;
end

function DoRingToPiercings(char)
    _I("Upgrade ring conditions met for " .. char);
    Osi.OpenMessageBox(char, ring_to_piercing_msg);

    -- evolve ring by removing it and adding the next one
    Osi.TemplateRemoveFromUser(base_ring_template, char, 1);
    local piercings = Osi.CreateAtObject(base_piercing_template, char, 0, 0, "", 0);
    Osi.Equip(char, piercings);
end

function HandleLongRest()
    _I("Long rest handler start");
    -- loop through player characters
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        if IsWearingBaseRing(char) and Mods.DivineCurse.BlissCount(char) >= bliss_threshold_ring_to_piercing then
            -- grazzt will only have 1 consort (first one to use it)
            if PersistentVars[grazzt_consort_key] == nil then
                _I("Setting " .. char .. " as Grazzt's consort");
                PersistentVars[grazzt_consort_key] = Mods.DivineCurse.GetGUID(char);
                NameConsort(char);
                DoRingToPiercings(char);
            elseif IsGrazztConsort(char) then
                -- allow you to evolve ring to piercing even if you already have it
                DoRingToPiercings(char);
            else
                _I("Grazzt already has a consort " .. GrazztConsort() .. " ignoring " .. char);
                Osi.OpenMessageBox(char, grazzt_ignore_msg);
            end
        end
    end
end

function GrazztConsort()
    return PersistentVars[grazzt_consort_key];
end

function IsGrazztConsort(char)
    if PersistentVars[grazzt_consort_key] == nil then
        return false;
    end
    char = Mods.DivineCurse.GetGUID(char);
    return PersistentVars[grazzt_consort_key] == char;
end

function HandleBliss(char, status, causee, storyActionID)
    if status ~= Mods.DivineCurse.BLISS_STATUS then
        return;
    end
    if Mods.DivineCurse.BlissCount(char) >= bliss_threshold_lust_brand and LustBrandStage(char) == 0 and IsGrazztConsort(char) then
        _I("Applying lust brand to " .. char);
        Osi.OpenMessageBox(char, lust_brand_msg);
        Osi.AddPassive(char, player_lust_brand_passive_ids[1]);
    end
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
    _I("found consort " .. consort .. " name handle " .. name_handle .. " translated name " .. name .. " translated title " .. title);
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
Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function() HandleLongRest() end);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) HandleBliss(...) end);
-- listen for long rest for when you have enough orgasms and sleeps with the ring on
local base_ring_template = "LI_GrazztRing_2a33b13e-adb2-4d52-9303-14ca982cef99";
local possible_ring_slots = { "Ring", "Ring2" };
local base_piercing_template = "LI_GrazztRing_1_a372e826-3eb0-4eb5-be1d-92e0953957d5";
local bliss_threshold = 1;
local ring_to_piercing_msg = "LI_RING_PROGRESSION_MSG";

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

function DoRingToPiercings(char)
    _I("Upgrade ring conditions met for " .. char);
    Osi.OpenMessageBox(char, ring_to_piercing_msg);

    -- evolve ring by removing it and adding the next one
    Osi.TemplateRemoveFromUser(base_ring_template, char, 1);
    local piercings = Osi.CreateAtObject(base_piercing_template, char, 0, 0, "", 0);
    Osi.Equip(char, piercings);

    -- TODO add lust brand passive
    -- TODO add lust brand passive framework (listen for passive added and passive removed)
end

function HandleLongRest()
    _I("Long rest handler start");
    -- loop through player characters
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        if IsWearingBaseRing(char) and Mods.DivineCurse.BlissCount(char) >= bliss_threshold then
            DoRingToPiercings(char);
        end
    end
end

Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function() HandleLongRest() end);

-- listen for long rest for when you have enough orgasms and sleeps with the ring on
local possible_ring_slots = { "Ring", "Ring2" };
local piercing_slot = "Cloak";

local piercing_templates = {
    "LI_GrazztRing_2a33b13e-adb2-4d52-9303-14ca982cef99",   -- stage 0 base ring
    "LI_GrazztRing_1_a372e826-3eb0-4eb5-be1d-92e0953957d5", -- stage 1 ring
    "LI_GrazztRing_2_3325e465-daed-4daf-b6d3-1a2d8c0ff338", -- stage 2 chain
}
local bliss_threshold_ring_to_piercing = 1;
local bliss_threshold_lust_brand = 3;
local piercing_upgrade_msgs = {
    "LI_RING_PROGRESSION_MSG",
    "LI_PIERCINGS_PROGRESSION_MSG",
};
local lust_brand_msg = "LI_LUST_BRAND_MSG";
local player_lust_brand_passive_ids = {
    "LI_Lust_Brand"
};
local grazzt_ignore_msg = "LI_GRAZZT_IGNORE_MSG";

local function _I(message)
    _P("[Grazzt Piercings] " .. message);
end

function IsWearingBaseRing(char)
    for _, slot in ipairs(possible_ring_slots) do
        local item = Osi.GetEquippedItem(char, slot);
        if item ~= nil and Osi.GetTemplate(item) == piercing_templates[1] then
            return true;
        end
    end
    return false;
end

---Piercing stage 0 is ring, 1 is piercing, 2 is chain
---@param char any
---@param stage any
---@return boolean
function IsWearingPiercingStage(char, stage)
    if stage == 0 then
        return IsWearingBaseRing(char);
    end

    local item = Osi.GetEquippedItem(char, piercing_slot);
    if item ~= nil and Osi.GetTemplate(item) == piercing_templates[stage + 1] then
        return true;
    end
    return false;
end

function UpgradePiercings(char, current_stage)
    _I("Upgrade piercings conditions met for " .. char .. " current stage " .. current_stage);
    Osi.OpenMessageBox(char, piercing_upgrade_msgs[current_stage + 1]);

    -- evolve ring by removing it and adding the next one
    Osi.TemplateRemoveFromUser(piercing_templates[current_stage + 1], char, 1);
    local piercings = Osi.CreateAtObject(piercing_templates[current_stage + 2], char, 0, 0, "", 0);
    Osi.Equip(char, piercings);
end

function HandleLongRest()
    _I("Long rest handler start");
    -- loop through player characters
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        if IsWearingPiercingStage(char, 0) and Mods.DivineCurse.BlissCount(char) >= bliss_threshold_ring_to_piercing then
            -- grazzt will only have 1 consort (first one to use it)
            if GrazztConsort() == nil then
                SetGrazztConsort(char);
                UpgradePiercings(char, 0);
            elseif IsGrazztConsort(char) then
                -- allow you to evolve ring to piercing even if you already have it
                UpgradePiercings(char, 0);
            else
                _I("Grazzt already has a consort " .. GrazztConsort() .. " ignoring " .. char);
                Osi.OpenMessageBox(char, grazzt_ignore_msg);
            end
        end
        -- check stage 1 to 2
        if IsGrazztConsort(char) and IsWearingPiercingStage(char, 1) and NumberOfSoulBrandsApplied(char) >= 3 then
            _I("Upgrading piercings for " .. char .. " from stage 1 to 2");
            UpgradePiercings(char, 1);
        end
    end
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

Ext.Osiris.RegisterListener("LongRestStarted", 0, "after", function() HandleLongRest() end);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) HandleBliss(...) end);

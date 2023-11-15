local function _I(message)
    _P("[Dark Inspection] " .. message);
end

-- check for bliss counts with spell
local dark_inspection_spell = "Target_DarkInspection";
function ReportBlissCounts(caster, target, spell, spellType, spellElement, storyActionID)
    if spell ~= dark_inspection_spell then
        return;
    end

    local bliss_count = Mods.DivineCurse.BlissCount(target);
    local bliss_cause_counts = Mods.DivineCurse.BlissCauseCountAll(target);
    _I("Bliss count for " .. target .. ": " .. bliss_count);
    _I("Bliss cause counts for " .. target .. ":");
    _D(bliss_cause_counts);

    -- also report this to the caster in a string that we pass onto OpenMessageBox
    local name_handle = Osi.GetDisplayName(caster);
    local report = "You channel your dark inspection on " .. Ext.Loca.GetTranslatedString(name_handle) .. "...\n";
    report = report .. "Max pleasure: " .. Mods.DivineCurse.MaxPleasure(target) .. "\n";
    report = report .. "Bliss count: " .. bliss_count .. "\n";
    report = report .. "Bliss cause counts:\n";
    for ability, count in pairs(bliss_cause_counts) do
        report = report .. ability .. ": " .. count .. "\n";
    end
    Osi.OpenMessageBox(caster, report);
end
Ext.Osiris.RegisterListener("UsingSpellOnTarget", 6, "after", ReportBlissCounts);
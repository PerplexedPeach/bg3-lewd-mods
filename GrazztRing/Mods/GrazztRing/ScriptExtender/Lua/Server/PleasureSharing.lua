PLEASURE_SHARING_SOURCE = "LI_PLEASURE_SHARING_SOURCE";
PLEASURE_SHARING_TARGET = "LI_PLEASURE_SHARING_TARGET";

-- share pleasure when taking pleasure
function SharePleasureModifier(character, causee, props)
    local is_source = Osi.HasActiveStatus(character, PLEASURE_SHARING_SOURCE) == 1;
    local is_target = Osi.HasActiveStatus(character, PLEASURE_SHARING_TARGET) == 1;
    if is_source or is_target then
        local target = SHARING_CHARS[PLEASURE_SHARING_TARGET];
        local source = SHARING_CHARS[PLEASURE_SHARING_SOURCE];
        -- check distance
        local distance = Osi.GetDistanceTo(target, source);
        if distance <= 9.0 then
            local reduction = math.ceil(props.pleasure * 0.5);
            props.pleasure = props.pleasure - reduction;
            _P("Sharing pleasure " .. character .. " is_source " .. tostring(is_source) .. " is_target " .. tostring(is_target) .. " reduction " .. reduction .. " new pleasure " .. props.pleasure .. " distance " .. distance);
            -- find the target to share with
            if is_source then
                Osi.ApplyStatus(target, Mods.DivineCurse.PLEASURE_STATUS, 6 * reduction, 1, character);
                Mods.DivineCurse.DisplayPleasure(target, reduction);
            else
                Osi.ApplyStatus(source, Mods.DivineCurse.PLEASURE_STATUS, 6 * reduction, 1, character);
                Mods.DivineCurse.DisplayPleasure(source, reduction);
            end
        end
    end
end

SHARING_CHARS = {};
local function saveSharePleasureCharacters(character, status, causee, storyActionID)
    if status == PLEASURE_SHARING_SOURCE then
        SHARING_CHARS[PLEASURE_SHARING_SOURCE] = character;
    elseif status == PLEASURE_SHARING_TARGET then
        SHARING_CHARS[PLEASURE_SHARING_TARGET] = character;
    end
end

local function clearPleasureSharing(character, status, causee, storyActionID)
    if status ~= PLEASURE_SHARING_SOURCE and status ~= PLEASURE_SHARING_TARGET then
        return;
    end
    if SHARING_CHARS[PLEASURE_SHARING_TARGET] ~= nil then
        Osi.RemoveStatus(SHARING_CHARS[PLEASURE_SHARING_TARGET], PLEASURE_SHARING_TARGET);
    end
    if SHARING_CHARS[PLEASURE_SHARING_SOURCE] ~= nil then
        Osi.RemoveStatus(SHARING_CHARS[PLEASURE_SHARING_SOURCE], PLEASURE_SHARING_SOURCE);
    end
    SHARING_CHARS[PLEASURE_SHARING_SOURCE] = nil;
    SHARING_CHARS[PLEASURE_SHARING_TARGET] = nil;
end

Mods.DivineCurse.RegisterPleasureModifier(SharePleasureModifier);
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) saveSharePleasureCharacters(...); end);
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) clearPleasureSharing(...); end);

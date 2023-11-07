local function _I(message)
    _P("[DC Pleasure] " .. message);
end

local bliss_status = "LI_BLISS";
local pleasure_status = "LI_PLEASURE";
function Modifier(character, attribute)
    return math.floor((Osi.GetAbility(character, attribute) - 10) / 2);
end

function MaxPleasure(character)
    -- consider modifiers / perks for raising max pleasure
    local max_pleasure = 10;
    local modifier = Modifier(character, "Wisdom") + Modifier(character, "Constitution");
    local frame_level = RemodelledFrameLevel(character);
    local level = math.floor(Osi.GetLevel(character) / 2);
    max_pleasure = max_pleasure + level + modifier * 2 + frame_level * 3;
    if max_pleasure < 5 then
        max_pleasure = 5;
    end
    return max_pleasure;
end

function HandlePleasure(character, status, causee, storyActionID)
    if status ~= pleasure_status then
        return;
    end
    _I("Pleasure status applied to " .. character .. " by " .. causee .. " with story action " .. storyActionID);
    -- check character max HP against stacks of pleasure
    local max_pleasure = MaxPleasure(character);
    local cur_pleasure = Osi.GetStatusTurns(character, pleasure_status);
    _I("Pleasure " .. cur_pleasure .. " / " .. max_pleasure .. " for " .. character);

    -- TODO remove after debugging
    -- RegisterBlissCausee(character, causee);

    if cur_pleasure > max_pleasure then
        RegisterBlissCausee(character, causee);
        Osi.ApplyStatus(character, bliss_status, 2, 1, character);
        Osi.RemoveStatus(character, pleasure_status);
        IncreaseBlissCount(character, 1);
    end
end

function RegisterBlissCausee(char_in_bliss, char_causing_bliss)
    -- read about what pleasure ability this character last used and assume that's what caused the 
    -- look at status of the character in bliss
    local char_entity = Ext.Entity.Get(char_in_bliss);
    local statuses = char_entity.ServerCharacter.Character.StatusManager.Statuses;
    -- iterate in reverse since it's very likely to be at the end
    for i = #statuses, 1, -1 do
        local status = statuses[i];
        if status.StatusId == pleasure_status then
            local ability = "";
            -- find the ability that caused this status
            if status.SourceSpell.OriginatorPrototype ~= "" then
                ability = status.SourceSpell.OriginatorPrototype;
            elseif status.Originator.PassiveId ~= "" then
                ability = status.Originator.PassiveId;
            else
                _I("ERROR: cannot find cause of bliss by " .. char_causing_bliss .. " for " .. char_in_bliss);
                _D(status);
            end
            _I("Bliss caused by " .. char_causing_bliss .. " with ability " .. ability .. " for " .. char_in_bliss);
            local id = BlissCauseID(char_causing_bliss, ability);
            local count = PersistentVars[id] or 0;
            PersistentVars[id] = count + 1;
            break
        end
    end
end

function BlissCauseID(char, ability)
    return bliss_status .. "_" .. char .. "_" .. ability;
end

---How many times this character has caused bliss via this ability
---@param character string
---@param ability string
function BlissCauseCount(character, ability)
    return PersistentVars[BlissCauseID(character, ability)] or 0;
end

function BlissID(char)
    return bliss_status .. "_" .. char;
end

function IncreaseBlissCount(char, amount)
    local id = BlissID(char);
    PersistentVars[id] = BlissCount(char) + amount;
    _I("Increase bliss: " .. amount .. " total: " .. PersistentVars[id] .. " for: " .. char);
end

---How many times this character has experienced bliss
---@param char string
---@return table
function BlissCount(char)
    local bliss_count = PersistentVars[BlissID(char)] or 0;
    return bliss_count;
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) HandlePleasure(...) end);
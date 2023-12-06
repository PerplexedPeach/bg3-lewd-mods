local function _I(message)
    _P("[DC Pleasure] " .. message);
end

BLISS_STATUS = "LI_BLISS";
PLEASURE_STATUS = "LI_PLEASURE";
MAX_PLEASURE_STATUS = "LI_PLEASURE_MAX";
BLISS_OVERLOAD_STATUSES = {
    "LI_BLISS_OVERLOAD_1",
    "LI_BLISS_OVERLOAD_2",
    "LI_BLISS_OVERLOAD_3",
    "LI_BLISS_OVERLOAD_4",
    "LI_BLISS_OVERLOAD_5",
};

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
    if status ~= PLEASURE_STATUS then
        return;
    end
    _I("Pleasure status applied to " .. character .. " by " .. causee .. " with story action " .. storyActionID);
    -- check character max HP against stacks of pleasure
    local max_pleasure = MaxPleasure(character);
    local cur_pleasure = Osi.GetStatusTurns(character, PLEASURE_STATUS);
    _I("Pleasure " .. cur_pleasure .. " / " .. max_pleasure .. " for " .. character);

    if cur_pleasure > max_pleasure then
        Osi.ApplyStatus(character, BLISS_STATUS, 2, 1, causee);
    end
end

function HandleBliss(character, status, causee, storyActionID)
    if status ~= BLISS_STATUS then
        return;
    end
    RegisterBlissCausee(character, causee);
    if GetGUID(character) ~= GetGUID(causee) then
        IncreaseBlissCauseCount(causee, 1);
    end
    -- also try registering bliss cause here
    IncreaseBlissCount(character, 1);
    -- also apply bliss overload depending on the number of bliss
    AdvanceBlissOverload(character);
    Osi.RemoveStatus(character, PLEASURE_STATUS);
end

function AdvanceBlissOverload(character)
    local overload_stage = 1;
    for i = 1, #BLISS_OVERLOAD_STATUSES do
        local bliss_overload_status = BLISS_OVERLOAD_STATUSES[i];
        if Osi.HasActiveStatus(character, bliss_overload_status) == 1 then
            if i < #BLISS_OVERLOAD_STATUSES then
                overload_stage = i + 1;
            else
                overload_stage = i;
            end
        end
    end
    _I("Advance bliss overload for " .. character .. " to stage " .. overload_stage);
    Osi.ApplyStatus(character, BLISS_OVERLOAD_STATUSES[overload_stage], overload_stage * 6, 1);
end

function RegisterBlissCausee(char_in_bliss, char_causing_bliss)
    -- read about what pleasure ability this character last used and assume that's what caused the 
    -- look at status of the character in bliss
    local char_entity = Ext.Entity.Get(char_in_bliss);
    local statuses = char_entity.ServerCharacter.Character.StatusManager.Statuses;
    -- iterate in reverse since it's very likely to be at the end
    for i = #statuses, 1, -1 do
        local status = statuses[i];
        if status.StatusId == PLEASURE_STATUS then
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
            _I("Bliss cause count: " .. PersistentVars[id] .. " for " .. char_causing_bliss .. " with ability " .. ability);
            break
        end
    end
end

function BlissCauseID(char, ability)
    return BLISS_STATUS .. "_" .. GetGUID(char) .. "_" .. ability;
end

---How many times this character has caused bliss via this ability
---@param character string
---@param ability string
function BlissCauseCount(character, ability)
    return PersistentVars[BlissCauseID(character, ability)] or 0;
end

---How many times this character has caused bliss to others via any ability
function BlissCauseCountAll(character)
    return PersistentVars[BlissCauseID(character, "")] or 0;
end

---Get table mapping ability to count of bliss caused by this character using that ability
---@param character string
---@return table
function BlissCauseCountAllDetailed(character)
    local ret = {};
    -- character name can have race prefixes that we want to remove (ends with Player_)
    character = GetGUID(character);

    local char_bliss_cause_prefix = BLISS_STATUS .. "_" .. character .. "_";
    local len_prefix = string.len(char_bliss_cause_prefix);

    _I("Looking for bliss cause counts for " .. character .. " with prefix " .. char_bliss_cause_prefix .. " and length " .. len_prefix);

    for k, v in pairs(PersistentVars) do
        _I("Check key " .. k .. " is prefix of " .. char_bliss_cause_prefix .. " ? " .. tostring(string.sub(k, 1, len_prefix) == char_bliss_cause_prefix));
        -- check if k starts with char_bliss_cause_prefix
        if string.sub(k, 1, len_prefix) == char_bliss_cause_prefix then
            -- extract ability from k
            local ability = string.sub(k, len_prefix + 1);
            ret[ability] = v;
        end
    end
    return ret;
end

function BlissID(char)
    return BLISS_STATUS .. "_" .. GetGUID(char);
end

function IncreaseBlissCount(char, amount)
    local id = BlissID(char);
    PersistentVars[id] = BlissCount(char) + amount;
    _I("Increase bliss: " .. amount .. " total: " .. PersistentVars[id] .. " for: " .. char);
end

---Increase the number of times this character has caused bliss
function IncreaseBlissCauseCount(char, amount)
    local id = BlissCauseID(char, "");
    PersistentVars[id] = BlissCauseCount(char, "") + amount;
end

---How many times this character has experienced bliss
---@param char string
---@return table
function BlissCount(char)
    local bliss_count = PersistentVars[BlissID(char)] or 0;
    return bliss_count;
end

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(...) HandlePleasure(...); HandleBliss(...) end);
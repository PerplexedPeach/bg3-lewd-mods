---Calculate the attribute ability modifier for a character
---@param character string GUID of the character
---@param attribute string Attribute to get the modifier for, e.g. Wisdom, Constitution
---@return integer
function Modifier(character, attribute)
    return math.floor((Osi.GetAbility(character, attribute) - 10) / 2);
end

---Get the GUID without any extraneous prefixes
---@param str string GUID with potential prefixes
---@return string
function GetGUID(str)
    if str ~= nil then
        return string.sub(str, -36);
        -- return str:match("_?([^_]*)$");
    end
    return "";
end

---Find if a character entity has a specific visual
---@param char_entity any
---@param id string id of the visual to test
---@return boolean
function FindCharacterCreationVisual(char_entity, id)
    local char_visuals = char_entity.CharacterCreationAppearance.Visuals;
    for _, vis_id in ipairs(char_visuals) do
        if vis_id == id then
            return true;
        end
    end
    return false;
end

---Call a function after a delay
---@param delayInMs any
---@param func any
function DelayedCall(delayInMs, func)
    local startTime = Ext.Utils.MonotonicTime()
    local handlerId;
    handlerId = Ext.Events.Tick:Subscribe(function()
        local endTime = Ext.Utils.MonotonicTime()
        if (endTime - startTime > delayInMs) then
            Ext.Events.Tick:Unsubscribe(handlerId)
            func()
        end
    end);
end

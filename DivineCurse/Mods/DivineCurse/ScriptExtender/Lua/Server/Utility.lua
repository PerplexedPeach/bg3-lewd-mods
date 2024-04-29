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

local tick_status = "LI_TICK_TECHNICAL";
TICK_LISTENERS = {};
function RegisterTickListener(name, listener)
    TICK_LISTENERS[name] = listener;
end

local function handleTick(character, status, causee, storyActionID)
    if status ~= tick_status then
        return;
    end
    for _, listener in pairs(TICK_LISTENERS) do
        listener();
    end
    -- refresh the tick
    Osi.ApplyStatus(character, tick_status, 6, 1, character);
end

local function startTick()
    -- loop over all player characters and check if any of them have the tick status
    local tick_char = nil;
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        -- someone's already ticking, don't start another
        if Osi.HasActiveStatus(char, tick_status) == 1 then
            return;
        end
        if tick_char == nil then
            tick_char = char;
        end
    end
    Osi.ApplyStatus(tick_char, tick_status, 6, 1, tick_char);
end


Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "after", function() startTick() end);
Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() startTick() end);
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) handleTick(...); end);

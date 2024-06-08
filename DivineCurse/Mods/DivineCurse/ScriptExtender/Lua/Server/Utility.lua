-- get body override debug item
PersistentVars = {};
local debug_item_id = "LI_Body_Debugger_5c4ace59-3a59-4dc0-b6dc-b6049b119a02";
local function addDebugItem()

    local item_id = PersistentVars[debug_item_id];
    if item_id == nil or item_id == true then
        local char = Osi.GetHostCharacter();
        -- backwards compatible for the item being added without retrieving its item ID
        if item_id == true then
            -- find the item in the character inventory if we can 
            item_id = Osi.GetItemByTemplateInPartyInventory(debug_item_id, char);
        end
        if item_id == nil then
            _P("Added body debug item to " .. tostring(char));
            item_id = Osi.CreateAtObject(debug_item_id, char, 0, 0, "", 0);
        end

        PersistentVars[debug_item_id] = item_id;
    end
end

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
local suppress_status_read = false;
TICK_LISTENERS = {};
function RegisterTickListener(name, listener)
    TICK_LISTENERS[name] = listener;
end

local function handleTick(character, status, causee, storyActionID)
    if status ~= tick_status or suppress_status_read then
        return;
    end
    for _, listener in pairs(TICK_LISTENERS) do
        listener();
    end
    -- refresh the tick
    Osi.ApplyStatus(character, tick_status, 6, 1, character);
end

local function startTick()
    -- for backwards compatibility, remove the status on the character
    suppress_status_read = true;
    for _, player in pairs(Osi["DB_Players"]:Get(nil)) do
        local char = player[1];
        if Osi.HasActiveStatus(char, tick_status) == 1 then
            Osi.RemoveStatus(char, tick_status);
        end
    end
    DelayedCall(1000, function()
        suppress_status_read = false;
    end);

    local tick_item = PersistentVars[debug_item_id];
    if Osi.HasActiveStatus(tick_item, tick_status) == 1 then
        return;
    end

    Osi.ApplyStatus(tick_item, tick_status, 6, 1, tick_item);
end


Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "after", function() addDebugItem() end);
Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() addDebugItem() end);

Ext.Osiris.RegisterListener("CharacterCreationFinished", 0, "after", function() startTick() end);
Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", function() startTick() end);
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(...) handleTick(...); end);

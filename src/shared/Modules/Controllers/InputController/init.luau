--!strict

-- Services
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");

-- Dependencies
local Inputs = require(script["Inputs"]);

-- Constants
local LOCAL_PLAYER = Players.LocalPlayer;

-- Class:
local InputController = {};
InputController.__index = InputController;

function InputController.new()
    local self = setmetatable({}, InputController)


    self:bindInputs()
    return self;
end

function InputController:bindInputs()
    local function bind(typeInput: string)
        for i, v in Inputs[typeInput] do
        ContextActionService:BindAction(i, v.fn, false, Enum[typeInput][i])
        end
    end

    bind("KeyCode");
    bind("UserInputType");
    return;
end

function InputController:unbindAction(name: string)
    ContextActionService:UnbindAction(name);
    return;
end

return InputController;
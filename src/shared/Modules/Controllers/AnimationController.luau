--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"))

-- Constants


-- Class:
local AnimationController = {};
AnimationController.__index = AnimationController;

function AnimationController.new()

    -- init remotes

end

function AnimationController:_getCharacter()

end

function AnimationController:_getHumanoid()

end
--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));
local CreateHitbox = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("CreateHitbox"));

-- Constants
local MousePosition = Remote.New("MousePosition");

local Attacks = {
    [1] = function()

    end,
    [2] = function()

    end,
    [3] = function()

    end,
}

-- Setup:
local Magik = {};

function Magik.attack(character: Model, attackCount: number)
    -- local enemy
    -- local distance
    -- local headshot
    

end

function Magik.firstAbility()

end

function Magik.secondAbility()

end

function Magik.thirdAbility()

end

function Magik.ultimate()

end

return Magik;
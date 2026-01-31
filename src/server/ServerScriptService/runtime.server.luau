--!strict

-- Services
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");

-- Setup:
Players.CharacterAutoLoads = false;
local Player = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Player"));



local CombatComponent = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Components"):FindFirstChild("CombatComponent"));

local target = workspace:FindFirstChild("Target");
local targetClass = CombatComponent.new(target, "BasicSword");
targetClass:onBlock();
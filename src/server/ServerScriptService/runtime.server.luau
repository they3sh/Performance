--!strict

-- Services
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");

-- Setup:
Players.CharacterAutoLoads = false;
local Player = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Player"));



local CombatComponent = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Components"):FindFirstChild("CombatComponent"));

local AttackTarget = workspace:FindFirstChild("AttackTarget");
local AttackTargetClass = CombatComponent.new(AttackTarget, "Magik");
while true do
    AttackTargetClass:attack();
    task.wait(1);
end
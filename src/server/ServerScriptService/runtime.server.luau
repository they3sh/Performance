--!strict

-- Services
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");

-- Setup:
Players.CharacterAutoLoads = false;
local Player = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Player"));
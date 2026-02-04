--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));

-- Constants
local MousePosition = Remote.New("MousePosition");

-- Setup:
local InputController = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Controllers"):FindFirstChild("InputController"));
InputController.new();

local MouseController = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Controllers"):FindFirstChild("MouseController"));

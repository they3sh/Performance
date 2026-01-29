--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Setup:
local Replica = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Replica"):FindFirstChild("ReplicaClient"));
local token = `user_{Players.LocalPlayer.UserId}`
Replica.RequestData();
Replica.OnNew(token, function(replica)
    print(replica.Data);

    replica:OnChange(function(action, path, oldValue, newValue)
    
        print(replica.Data);

    end)
end);

local InputController = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Controllers"):FindFirstChild("InputController"));
InputController.new();
--!strict

-- Types
export type PlayerStruct = {

}

-- Services
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local PlayerData = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("PlayerData"));
local Replica = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Replica"):FindFirstChild("ReplicaServer"));
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));
local CombatComponent = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Components"):FindFirstChild("CombatComponent"));

-- Constansts
local AttackEvent = Remote.New("CombatAttack");
local AbilityEvent = Remote.New("CombatAbility");

-- Private variables
local Structs: {[Player]: any} = {}; -- structs cache

-- Class:
local PlayerStruct = {};
PlayerStruct.__index = PlayerStruct;

function PlayerStruct.new(player: Player)
    local self = setmetatable({}, PlayerStruct);

    self.data = PlayerData.new(player)
    self.combat = CombatComponent.new(player, "Magik");

    -- setup:
    do
        local function bindConnection(humanoid: Humanoid)
            local connection
            connection = humanoid.Died:Connect(function()
                connection:Disconnect()
                player:LoadCharacterAsync();
                task.wait(.2)

                local character = player.Character or player.CharacterAdded:Wait();
                local hum = character:FindFirstChild("Humanoid") :: Humanoid;
                bindConnection(hum)
            end)
        end
        player:LoadCharacterAsync();

        local character = player.Character or player.CharacterAdded:Wait();
        local humanoid = character:FindFirstChild("Humanoid") :: Humanoid;
        bindConnection(humanoid);

        task.wait(.2)
        humanoid.Health = 0;
    end

    Structs[player] = self;
    return self;
end

function PlayerStruct.remove(player: Player): ()
    Structs[player] = nil;
end

function PlayerStruct.Get(player: Player)
    return Structs[player];
end

-- Setup:
Players.PlayerAdded:Connect(function(player) PlayerStruct.new(player); end);
Players.PlayerRemoving:Connect(function(player) PlayerStruct.remove(player); end);

AttackEvent.OnServerEvent:Connect(function(player)
    PlayerStruct.Get(player).combat:attack();
end)

return PlayerStruct;
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

local AttackEvent = Remote.New("AttackEvent");
local BlockEvent = Remote.New("BlockEvent");

-- Private variables
local Structs: {[Player]: any} = {}; -- structs cache
local Replicas: {[Player]: Replica.Replica} = {}; -- replica cache

-- Class:
local PlayerStruct = {};
PlayerStruct.__index = PlayerStruct;

function PlayerStruct.new(player: Player)
    local self = setmetatable({}, PlayerStruct);

    -- struct setup:
    -- self.data = PlayerData.new(player);
    self.combat = CombatComponent.new(player, "BasicSword");


    -- Replica setup:
    local token = Replica.Token(`user_{player.UserId}`); -- <- user can be changed for replica, inventory_{player.UserId}, leaderstats_{player_UserId}
    local replicaData = {{ id = 2, amount = 5 }}
    local replica = Replica.New({
        Token = token,
        Data = replicaData,
    });

    Replicas[player] = replica;

    if Replica.ReadyPlayers[player] then
        replica:Subscribe(player);
    end

    -- -- replica:Replicate(); / or replica:Subscribe(player) -- works only for ReadyPlayers
    -- -- replica:Set({ id/key, "property"}, value);
    -- replica:Set({ 1, "cash"}, `{player.UserId}` );
    -- -- replica:TableInsert({}, {value});
    -- replica:TableInsert({}, { id = 5 });

    -- task.delay(3, function()
    --     replica:TableInsert({}, { id = 5 })
    -- end)

    -- setup:
    do -- die connection
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

    local replica = Replicas[player];
    replica:Destroy();
    replica = nil;
    return;
end

function PlayerStruct.Get(player: Player)
    return Structs[player];
end

-- Setup:
Players.PlayerAdded:Connect(function(player) PlayerStruct.new(player); end);
Players.PlayerRemoving:Connect(function(player) PlayerStruct.remove(player); end);
Replica.NewReadyPlayer:Connect(function(player)
    if Replicas[player] then
        Replicas[player]:Subscribe(player);
    end
end)

AttackEvent.OnServerEvent:Connect(function(player)
    local playerStruct =  PlayerStruct.Get(player);
    playerStruct.combat:onAttack();
end)
BlockEvent.OnServerEvent:Connect(function(player)
    local playerStruct =  PlayerStruct.Get(player);
    playerStruct.combat:onBlock();
end)


return PlayerStruct;
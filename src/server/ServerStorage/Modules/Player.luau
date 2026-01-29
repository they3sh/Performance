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

-- Private variables
local Structs: {[Player]: any} = {}; -- players cache
local Replicas: {[Player]: Replica.Replica} = {}; -- replica cache

-- Class:
local PlayerStruct = {};
PlayerStruct.__index = PlayerStruct;

function PlayerStruct.new(player: Player)
    local self = setmetatable({}, PlayerStruct);

    -- struct setup:
    -- self.data = PlayerData.new(player);

    -- Replica setup:
    local token = Replica.Token(`user_{player.UserId}`);
    local replicaData = {{ id = 2, amount = 5 }}
    local replica = Replica.New({
        Token = token,
        Data = replicaData,
    });

    Replicas[player] = replica;

    if Replica.ReadyPlayers[player] then
        print("Subscribe in new function");
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
    player:LoadCharacterAsync();

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

Players.PlayerAdded:Connect(function(player) PlayerStruct.new(player); end);
Players.PlayerRemoving:Connect(function(player) PlayerStruct.remove(player); end);
Replica.NewReadyPlayer:Connect(function(player)
    if Replicas[player] then
        Replicas[player]:Subscribe(player);
        print("SUBSCRIBING IN NewReadyPlayer function");
    end
end)


return PlayerStruct;
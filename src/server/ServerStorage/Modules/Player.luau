--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local PlayerData = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("PlayerData"))

-- Class:
local PlayerStruct = {};
PlayerStruct.__index = PlayerStruct;

function PlayerStruct.new(player: Player)
    local self = setmetatable({}, PlayerStruct);

    self.data = PlayerData.new(player);


    player:LoadCharacterAsync();
    return self;
end

function PlayerStruct.remove(player: Player)

end

return PlayerStruct;
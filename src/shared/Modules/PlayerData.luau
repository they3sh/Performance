--!strict

-- Types
export type ProfileData = {
    Data: {
        
    }
}

-- Services
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local ProfileStore = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("ProfileStore"));

-- Constants
local DATA_NAME = "test";
local DATA_TEMPLATE = {

}

local PlayerStore = ProfileStore.New(DATA_NAME, DATA_TEMPLATE);
local Profiles: {[Player]: typeof(PlayerStore:StartSessionAsync())} = {};

-- Private functions
local function startSessionForPlayer(player: Player): typeof(PlayerStore:StartSessionAsync())

    local profile = PlayerStore:StartSessionAsync(`user_{player.UserId}`, {
        Cancel = function()
            return player.Parent ~= Players;
        end,
    })

    if profile ~= nil then

        profile:AddUserId(player.UserId); -- GDPR compliance
        profile:Reconcile();

        profile.OnSessionEnd:Connect(function()
            Profiles[player] = nil;
            player:Kick(`Profile session end - Please rejoin`);
        end)

        if player.Parent == Players then
            Profiles[player] = profile;
        else
            profile:EndSession();
        end

    else
        player:Kick(`Profile load fail - Please rejoin`);
    end

    return profile;
end

-- Setup:
local PlayerData = {};

function PlayerData.new(player: Player)
    startSessionForPlayer(player)

end

function PlayerData.Get(player: Player)
    return Profiles[player];
end

return PlayerData;
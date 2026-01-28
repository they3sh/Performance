--!strict


-- Services

-- Dependencies

-- Constants
local DATA_NAME = "";
local DATA_TEMPLATE = {

}


-- Private functions
local function startSessionForPlayer()

end

-- Setup:
local PlayerData = {
    _all_Players = {};
};

function PlayerData.new(player: Player)

end


function PlayerData.Get(player: Player)
    return PlayerData._all_Players[player];
end

return PlayerData;
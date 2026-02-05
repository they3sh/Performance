--!strict

-- Services
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Constants
local LOCAL_PLAYER = Players.LocalPlayer;
local PLAYER_CAMERA = workspace.CurrentCamera;


-- Setup:
local MouseController = {};

function MouseController._raycast(): RaycastResult | nil
    local location = MouseController.getMouseLocation();
    local cameraRay = PLAYER_CAMERA:ViewportPointToRay(location.X, location.Y);

    local origin = cameraRay.Origin;
    local direction = cameraRay.Direction * 999;

    local result = workspace:Raycast(origin, direction);
    if not result then return end

    return result;
end

function MouseController.getMouseLocation()
    return UserInputService:GetMouseLocation();
end

function MouseController.getPositionInWorld()
    local result = MouseController._raycast();
    return result.Position;
end

function MouseController.getMouseHit()
    local result = MouseController._raycast();
    return result.Instance;
end

return MouseController;
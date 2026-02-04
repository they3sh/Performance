--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));
local CreateHitbox = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("CreateHitbox"));

-- Constants
local MousePosition = Remote.New("MousePosition");

local Attacks = {
    [1] = function()
        local hitbox = CreateHitbox(CFrame.new(Vector3.zero, Vector3.zero), Vector3.one)

        local partInHitbox = workspace:GetPartsInPart(hitbox);
        return;
    end,
    [2] = function()

        return;
    end,
    [3] = function()

        return;
    end,
}

-- Setup:
local Magik = {};

function Magik.attack(character: Model, attackCount: number)
    local ownerHRP = character:FindFirstChild("HumanoidRootPart") :: BasePart;

    local attackNum = if attackCount > #Attacks then 1 else attackCount;
    local attackResult = Attacks[attackNum]();

    local hits = {}
    for _, v in attackResult do
        local enemyCharacter = v.Parent;
        local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid") :: Humanoid;
        local enemyHRP = enemyCharacter:FindFirstChild("HumanoidRootPart") :: BasePart;
        if enemyHumanoid and hits[enemyCharacter] == nil then

            hits[enemyCharacter] = {
                character = enemyCharacter,
                distance = (ownerHRP.CFrame.Position - enemyHRP.CFrame.Position).Magnitude,
                headshot = if v.Name == "Head" then true else false,
            }
        end
    end

    return hits;
end

function Magik.firstAbility()

end

function Magik.secondAbility()

end

function Magik.thirdAbility()

end

function Magik.ultimate()

end

return Magik;
--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Remote = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Libs"):FindFirstChild("Remote"));
local CreateHitbox = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("CreateHitbox"));

-- Constants


local Attacks = {
    [1] = function(cf: CFrame)
        local startCf = cf * CFrame.new(0, 0, -7.7);
        local AnglesCf = CFrame.Angles(math.rad(-1.684), math.rad(-1.257), math.rad(-51.783));
        local finishCf = startCf * AnglesCf;

        local hitbox = CreateHitbox(finishCf, Vector3.new(1, 13, 15));

        -- Animation

        task.delay(1.5, function()
            hitbox:Destroy();
        end);

        return workspace:GetPartsInPart(hitbox);
    end,
    [2] = function(cf: CFrame)
        local startCf = CFrame.new((cf.LookVector * 3) + cf.Position, Vector3.new(0, 0, -45));
        local finishCf = startCf * AnglesCf;

        local hitbox = CreateHitbox(finishCf, Vector3.new(1, 11, 15));

        -- Animation

        task.delay(1.5, function()
            hitbox:Destroy();
        end);

        return workspace:GetPartsInPart(hitbox);
    end,
    [3] = function(cf: CFrame)
        local startCf = CFrame.new((cf.LookVector * 3) + cf.Position, Vector3.new(0, 0, -45));
        local AnglesCf = CFrame.Angles(0, 0, math.rad(-45));
        local finishCf = startCf * AnglesCf;

        local hitbox = CreateHitbox(finishCf, Vector3.new(1, 11, 15));

        -- Animation

        task.delay(1.5, function()
            hitbox:Destroy();
        end);

        return workspace:GetPartsInPart(hitbox);
    end,
}

-- Setup:
local Magik = {};

function Magik.attack(character: Model, comboIndex: number): {}
    local ownerHRP = character:FindFirstChild("HumanoidRootPart") :: BasePart;
    local ownerCframe = ownerHRP.CFrame;

    local attackNum = if comboIndex > #Attacks then 1 else comboIndex;
    local attackResult = Attacks[attackNum](ownerCframe);
    if attackResult[1] == nil then return {} end

    local hits: {} = {}
    for _, v in attackResult do
        local enemyCharacter = v.Parent;
        local enemyHumanoid = enemyCharacter:FindFirstChild("Humanoid") :: Humanoid;
        local enemyHRP = enemyCharacter:FindFirstChild("HumanoidRootPart") :: BasePart;
        if enemyHumanoid and enemyCharacter ~= character then
            if hits[enemyCharacter] == nil or v.Name == "Head" then

                hits[enemyCharacter] = {
                    character = enemyCharacter,
                    distance = (ownerHRP.CFrame.Position - enemyHRP.CFrame.Position).Magnitude,
                    headshot = if v.Name == "Head" then true else false,
                }
            end
        end
    end

    return hits;
end

function Magik.ability1()

end

function Magik.ability2()

end

function Magik.ability3()

end

function Magik.ultimate()

end

return Magik;
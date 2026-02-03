--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local CreateHibox = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("CreateHitbox"));

-- Constants
local HiboxSize = Vector3.new(3, 5, 3);
local HitboxOffsetPosition = 3;

-- Module:
local BasicSword = {};

function BasicSword.attack(ownerModel: Model): {Model}

    local ownerCF = (ownerModel:FindFirstChild("HumanoidRootPart"):: BasePart).CFrame;

    local HitboxPosition = (ownerCF.Position + (ownerCF.LookVector * HitboxOffsetPosition))
    local hitbox = CreateHibox(HitboxPosition, HiboxSize);
    task.delay(2, function()
        hitbox:Destroy();
    end)

    local targets: {Model} = {};

    local function checkIsHas(model: Model): boolean
        for _, v in targets do
            if v == model then
                return true;
            end
        end
        return false;
    end

    local partsInPart = workspace:GetPartsInPart(hitbox);
    for _, v in partsInPart do
        local parent = v.Parent;
        local humanoid = parent:FindFirstChild("Humanoid");
        if humanoid then
            local hasModel = checkIsHas(parent);
            if not hasModel and parent ~= ownerModel then
                table.insert(targets, parent);
            end -- TODO: add check RAYCAST
        end
    end

    return targets;
end

return BasicSword;
--!strict

-- Services
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Weapons = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection"):FindFirstChild("Weapons"));
local DamageRegister = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("DamageRegister"));

-- Constants
local WeaponsModule = ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection"):FindFirstChild("Weapons")
local Assets = ReplicatedStorage:FindFirstChild("Assets");
local WeaponsAssets = Assets:FindFirstChild("Weapons");

local Classes: {[Player | string]: any} = {};

-- Class:
local CombatComponent = {};
CombatComponent.__index = CombatComponent;

function CombatComponent.new(owner: Player | Model, weapon: string)
    local self = setmetatable({}, CombatComponent);

    local cooldownT: number;
    if weapon then
        cooldownT = Weapons[weapon].cooldown;
    else
        cooldownT = Weapons["BasicSword"].cooldown;
    end

    -- TODO: equip to character weapon

    -- Parameters:
    self.owner = owner;
    self.weapon = weapon;
    self.cooldownT = cooldownT;
    self.walkSpeed = 16;
    self.jumpHeight = 7.2;

    -- States:
    self.cooldownState = false;
    self.blockState = false;
    self.attackState = false;
    self.ragdolState = false;

    Classes[self.owner] = self;
    return self;
end

function CombatComponent.Get(owner: Player | Model)
    return Classes[owner];
end

function CombatComponent:_cooldown()
    self.cooldownState = true;
    task.delay(self.cooldownT, function()
        self.cooldownState = false;
    end)
    return;
end

function CombatComponent:_hitVisual(model: Model, color: Color3, t: number): ()
    local highlight = Instance.new("Highlight");
    highlight.FillColor = color;
    highlight.FillTransparency = 0.6
    highlight.Parent = model;

    task.delay(t, function()
        highlight:Destroy();
    end)
end

function CombatComponent:onAttack()
    if self.cooldownState == true or self.ragdolState == true then return end
    self:_cooldown();
    self.attackState = true;

    local weaponConfig = if Weapons[self.weapon] then Weapons[self.weapon] else Weapons["BasicSword"]
    local weapon = require(WeaponsModule:FindFirstChild(weaponConfig.family):FindFirstChild(weaponConfig.name));

    local ownerModel: Model = if self.owner:IsA("Model") then self.owner else self.owner.Character or self.owner.CharacterAdded:Wait();
    local ownerHumanoid = ownerModel:FindFirstChild("Humanoid") :: Humanoid;
    if ownerHumanoid.Health == 0 then return end

    local targets = weapon.attack(ownerModel);
    if targets[1] == nil then return end

    for _, v in targets do
        local key = if Players:GetPlayerFromCharacter(v) then Players:GetPlayerFromCharacter(v) else v
        local class = Classes[key];

        local damage: number;
        local blockState = class.blockState;
        if blockState then
            damage = weaponConfig.damage * 0.2;
            CombatComponent:_hitVisual(v, Color3.fromRGB(27, 27, 27), 0.2);
        else
            damage = weaponConfig.damage;
            class:ragdol();
            CombatComponent:_hitVisual(v, Color3.fromRGB(200, 0, 0), 0.4);
        end

        local humanoid = v:FindFirstChild("Humanoid") :: Humanoid;
        DamageRegister(damage, humanoid)
    end

    return;
end

function CombatComponent:onBlock()

    local ownerModel: Model = if self.owner:IsA("Model") then self.owner else self.owner.Character or self.owner.CharacterAdded:Wait();
    local ownerHumanoid = ownerModel:FindFirstChild("Humanoid") :: Humanoid;

    self.blockState = not self.blockState;

    if self.blockState then
        self.walkSpeed = ownerHumanoid.WalkSpeed
        self.jumpHeight = ownerHumanoid.JumpHeight

        ownerHumanoid.WalkSpeed = 5;
        ownerHumanoid.JumpHeight = 0;
    else
        ownerHumanoid.WalkSpeed = self.walkSpeed;
        ownerHumanoid.JumpHeight = self.jumpHeight;
    end

    return
end

function CombatComponent:ragdol()
    self.ragdolState = true;

    local ownerModel: Model = if self.owner:IsA("Model") then self.owner else self.owner.Character or self.owner.CharacterAdded:Wait();
    local ownerHumanoid = ownerModel:FindFirstChild("Humanoid") :: Humanoid;

    -- save stats:
    local walkSpeed = ownerHumanoid.WalkSpeed;
    local jumpPower = ownerHumanoid.JumpPower;

    ownerHumanoid.WalkSpeed = 0;
    ownerHumanoid.JumpPower = 0;

    task.delay(0.5, function()
        self.ragdolState = false;
        ownerHumanoid.WalkSpeed = walkSpeed;
        ownerHumanoid.JumpPower = jumpPower;
    end)
end

function CombatComponent:changeWeapon(newWeapon: string)
    if not newWeapon then return end
    self.weapon = newWeapon;
    return;
end

return CombatComponent;
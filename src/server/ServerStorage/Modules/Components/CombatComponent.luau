--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local Heroes = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection"):FindFirstChild("Heroes"))

-- Constants
local Collection = ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection");

local Classes = {};

-- Class:
local CombatComponent = {};
CombatComponent.__index = CombatComponent;

function CombatComponent.new(owner: Player | Model, hero: string)
    -- ** owner - player or character model for npc-bots

    local self = setmetatable({}, CombatComponent);
    -- mark for find this object


    self.owner = owner;
    self._heroName = hero;

    -- states:
    self._ragdolState = false;

    self._attackCooldown = false;
    self._firstAbilityCooldown = false;
    self._secondAbilityCooldown = false;
    self._thirdAbilityCooldown = false;
    self._ultimateCooldown = false;

    Classes[self.owner] = self;
    return self;
end

function CombatComponent._ragdol(): ()

    -- got humanoid??? and set ragdol


end

function CombatComponent:attack(): ()
    if self._attackCooldown == true then return end
    self:_cooldown("_attackCooldown", 2); -- <- Change take from config

    -- todo: start animation

    local character = if self.owner:IsA("Player") then
        self.owner.Character or self.owner.CharacterAdded:Wait() 
    else self.owner;

    local heroConfig = Heroes[self.heroName];
    local hero = require(Collection
        :FindFirstChild("Heroes")
        :FindFirstChild(heroConfig.heroClass)
        :FindFirstChild(heroConfig.heroName)) :: Heroes.Hero;

    hero.attack();

    -- maybe DAMAGE REGISTER here???
    return;
end

function CombatComponent:ability(): ()

end

function CombatComponent:_cooldown(name: string, duration: number): ()
    self[name] = true;
    task.delay(duration, function()
        self[name] = false;
    end)
    return;
end

function CombatComponent:setHero(heroName: string): ()
    self.heroName = heroName;
    return;
end

return CombatComponent;
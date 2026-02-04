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

    self.owner = owner;
    self.heroName = hero;

    self.lastAttack = 0;
    self.attackCount = 1;

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

function CombatComponent.Get(owner: Player | Model)
    return Classes[owner];
end

function CombatComponent._ragdol(): ()

    -- got humanoid??? and set ragdol


end

function CombatComponent:attack(): ()
    if self._attackCooldown == true then return end

    local heroConfig = Heroes[self.heroName];
    local hero = require(Collection
        :FindFirstChild("Heroes")
        :FindFirstChild(heroConfig.heroClass)
        :FindFirstChild(heroConfig.heroName)) :: Heroes.Hero;

    self:_cooldown("_attackCooldown", heroConfig.attackCooldown);

    local t = workspace:GetServerTimeNow();

    -- attack count
    if t - self.lastAttack < 3 then
        if self.attackCount >= 3 then
            self.attackCount = 1;
        else
            self.attackCount += 1;
        end
    end
    self.lastAttack = t;

    local character = if self.owner:IsA("Player") then
        self.owner.Character or self.owner.CharacterAdded:Wait()
    else self.owner;

    local attackResult = hero.attack(character, self.attackCount);




    -- maybe DAMAGE REGISTER here???
    return;
end

function CombatComponent:ability(a: number): ()

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
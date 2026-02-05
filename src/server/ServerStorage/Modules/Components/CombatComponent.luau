--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local HeroesConfig = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection"):FindFirstChild("Heroes"))

-- Constants
local Collection = ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection") :: Folder;
local HeroesFolder = Collection:FindFirstChild("Heroes");
local Duelist = HeroesFolder:FindFirstChild("Duelist");

local HeroesModules= {
    Duelist = {
        Magik = require(Duelist:FindFirstChild("Magik")) :: HeroesConfig.Hero,
    },
    Tank = {

    },
}

local Combats = {};

-- Class:
local CombatComponent = {};
CombatComponent.__index = CombatComponent;

function CombatComponent.new(owner: Player | Model, heroId: string)
    -- ** owner - player or character model for npc-bots

    local self = setmetatable({}, CombatComponent);

    self.owner = owner;
    self.heroId = heroId;

    self.lastAttackTime = 0;
    self.comboIndex = 1;

    -- states:
    self._ragdolled = false;

    self.cooldowns = {
        attack = false,
        ability1 = false,
        ability2 = false,
        ability3 = false,
        ultimate = false,
    }

    Combats[self.owner] = self;
    return self;
end

function CombatComponent.Get(owner: Player | Model)
    return Combats[owner];
end

function CombatComponent._setRagdol(): ()

    -- got humanoid??? and set ragdol


end

function CombatComponent:attack(): ()
    if self.cooldowns.attack == true or self._ragdolled == true then return end

    local heroConfig = HeroesConfig[self.heroId];
    local hero = HeroesModules[heroConfig.heroClass][heroConfig.heroName];

    self:_setCooldown("attack", heroConfig.attackCooldown);

    local t = workspace:GetServerTimeNow();

    -- attack count
    if t - self.lastAttackTime < 3 then
        if self.comboIndex >= 3 then
            self.comboIndex = 1;
        else
            self.comboIndex += 1;
        end
    end
    self.lastAttackTime = t;

    local character = if self.owner:IsA("Player") then
        self.owner.Character or self.owner.CharacterAdded:Wait()
    else self.owner;

    local attackResult = hero.attack(character, self.comboIndex);




    -- maybe DAMAGE REGISTER here???
    return;
end

function CombatComponent:ability(a: number): ()

end

function CombatComponent:_setCooldown(action: string, duration: number): ()
    self.cooldowns[action] = true;
    task.delay(duration, function()
        self.cooldowns[action] = false;
    end)
    return;
end

function CombatComponent:setHero(heroId: string): ()
    self.heroId = heroId;
    return;
end

return CombatComponent;
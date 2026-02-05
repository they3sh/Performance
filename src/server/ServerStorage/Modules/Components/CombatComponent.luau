--!strict

-- Services
local ServerStorage = game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Dependencies
local HeroesConfig = require(ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Collection"):FindFirstChild("Heroes"));
local DamageRegister = require(ServerStorage:FindFirstChild("Modules"):FindFirstChild("Utility"):FindFirstChild("DamageRegister"));

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
    Support = {

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

    local character = if self.owner:IsA("Player") then
        self.owner.Character or self.owner.CharacterAdded:Wait()
    else self.owner;

    local t = workspace:GetServerTimeNow();

    self:_setCooldown("attack", heroConfig.attackCooldown);

    -- combo attacks
    if t - self.lastAttackTime < 3 then
        if self.comboIndex >= 3 then
            self.comboIndex = 1;
        else
            self.comboIndex += 1;
        end
    else
        self.comboIndex = 1;
    end

    self.lastAttackTime = t;

    local attackResult: {HeroesConfig.AttackData} = hero.attack(character, self.comboIndex);
    if attackResult == nil then return end

    -- hit
    for i, v in attackResult do

        -- i think i will rework this
        DamageRegister(
            self.owner,
            v.character,
            v.distance,
            v.headshot,
            heroConfig.attackHeadshotMulti,
            heroConfig.attackDamage
        )

        -- visual hit
        CombatComponent:_setVisualHit(v.character);
    end

    return;
end

function CombatComponent:ability(abilityKey: string): ()
    print(abilityKey);


    return;
end

function CombatComponent:_setCooldown(action: string, duration: number): ()
    self.cooldowns[action] = true;
    task.delay(duration, function()
        self.cooldowns[action] = false;
    end)
    return;
end

function CombatComponent:_setVisualHit(character: Model)
    local highlight = Instance.new("Highlight");
    highlight.Parent = character;

    task.delay(.4, function()
        highlight:Destroy();
    end)
    return;
end

function CombatComponent:setHero(heroId: string): ()
    self.heroId = heroId;
    return;
end

return CombatComponent;
--!strict

-- Types
type RangeDamage = {
    [number]: {
        distance: number,
        damage: number,
    }
}

export type AttackData = {
    character: Model,
    distance: number,
    headshot: boolean,
}

export type Hero = {
    attack: (Model, number) -> {AttackData},
    ability1: () -> (),
    ability2: () -> (),
    ability3: () -> (),
    ultimate: () -> (),
}

export type HeroConfig = {
    heroName: string,
    heroClass: string,
    heroModel: BasePart | MeshPart,
    heroUltimateModel: BasePart | MeshPart,
    attackDamage: RangeDamage,
    attackHeadshotMulti: number,
    attackCooldown: number,
    attackAnimation: string,
    ability1Damage: number,
    ability1Cooldown: number,
    ability1Animation: string,
    ability2Damage: number,
    ability2Cooldown: number,
    ability2Animation: string,
    ability3Damage: number,
    ability3Cooldown: number,
    ability3Animation: string,
    ultimateDamage: number,
    ultimateCooldown: number,
    ultimateAnimation: string,
}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage");

-- Constants
local Assets = ReplicatedStorage:FindFirstChild("Assets");

return {


    ["Magik"] = {
        heroName = "Magik",
        heroClass = "Duelist",
        heroModel = nil;
        heroUltimateModel = nil;

        attackDamage = {
            [1] = {
                distance = 5,
                damage = 40,
            },
            [2] = {
                distance = 10,
                damage = 30,
            },
            [3] = {
                distance = 15,
                damage = 25,
            },
        },
        attackHeadshotMulti = 1.2,
        attackCooldown = 1.2,
        attackAnimation = "",

        ability1Damage = 70, -- maxDamage
        ability1Cooldown = 7,
        ability1Animation = "",

        ability2Damage = 30,
        ability2Cooldown = 4.5,
        ability2Animation = "",

        ability3Damage = 60,
        ability3Cooldown = 7,
        ability3Animation = "",

        ultimateDamage = 30,
        ultimateCooldown = 70,
        ultimateAnimation = "",
    },


}
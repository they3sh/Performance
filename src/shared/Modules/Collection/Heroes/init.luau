--!strict

-- Types
export type Hero = {
    attack: () -> (),
    ultimate: () -> (),

}

export type HeroConfig = {
    heroName: string,
    heroClass: string,
    heroModel: BasePart | MeshPart,
    heroUltimateModel: BasePart | MeshPart,
    attackDamage: number,
    attackCooldown: number,
    attackAnimation: string,
    firstAbilityDamage: number,
    firstAbilitCooldown: number,
    firsyAbilityAnimation: string,
    secondAbilityDamage: number,
    secondAbilityCooldown: number,
    secondAbilityAnimation: string,
    thirdAbilityDamage: number,
    thirdAbilityCooldown: number,
    thirdAbilityAnimation: string,
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

        attackDamage = 40, -- maxDamage
        attackCooldown = 1.2,
        attackAnimation = "",

        firstAbilityDamage = 70, -- maxDamage
        firstAbilitCooldown = 7,
        firsyAbilityAnimation = "",

        secondAbilityDamage = 30,
        secondAbilityCooldown = 4.5,
        secondAbilityAnimation = "",

        thirdAbilityDamage = 60,
        thirdAbilityCooldown = 7,
        thirdAbilityAnimation = "",

        ultimateDamage = 30,
        ultimateCooldown = 70,
        ultimateAnimation = "",
    },


}
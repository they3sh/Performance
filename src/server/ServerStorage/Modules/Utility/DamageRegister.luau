return function(damage: number, humanoid: Humanoid)

    -- damage
    local newHealth = math.max(humanoid.Health - damage, 0);
    humanoid.Health = newHealth;

end
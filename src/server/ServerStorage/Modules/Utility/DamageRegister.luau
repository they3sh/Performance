--!strict

-- Types
type RangeDamage = {
    [number]: {
        distance: number,
        damage: number,
    }
}

-- Private functions
local function getDamageByDistance(distance: number, ranges)

    if distance <= ranges[1].distance then
        return ranges[1].damage
    end

    for i = 1, #ranges - 1 do
        local a = ranges[i]
        local b = ranges[i + 1]

        if distance >= a.distance and distance <= b.distance then
            local alpha = (distance - a.distance) / (b.distance - a.distance)
            return a.damage + (b.damage - a.damage) * alpha
        end
    end

    return ranges[#ranges].damage
end

return function(
    owner: Player | Model,
    enemy: Model,
    distance: number,
    headshot: boolean,
    headshotMulti: number,
    ranges: RangeDamage
): ()

    local damageByDistance = getDamageByDistance(distance, ranges);
    local damage = if headshot then damageByDistance * headshotMulti else damageByDistance;

    local enemyHumanoid = enemy:FindFirstChild("Humanoid") :: Humanoid;
    local enemyHealth = enemyHumanoid.Health;
    local newHealthForEnemy = math.max(enemyHealth - damage, 0);

    enemyHumanoid.Health = newHealthForEnemy;
    return;
end

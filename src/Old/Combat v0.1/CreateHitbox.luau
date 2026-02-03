return function(pos: Vector3, size: Vector3): BasePart
    local part = Instance.new("Part");
    part.Name = "Hitbox";
    part.Parent = workspace;
    part.Anchored = true;
    part.CanCollide = false;
    part.CanTouch = false;
    part.CanQuery = false;
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Transparency = 0.82;
    part.Position = pos;
    part.Size = size;
    return part;
end
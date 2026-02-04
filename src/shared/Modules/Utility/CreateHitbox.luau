return function(cf: CFrame, size: Vector3): BasePart
    local part = Instance.new("Part");
    part.Parent = workspace;
    part.Name = "Hitbox";
    part.Position = cf.Position;
    part.Rotation = cf.Rotation;
    part.Size = size;
    part.Color = Color3.fromRGB(255, 0, 0);
    part.Transparency = 0.82;
    part.Anchored = true;
    part.CanCollide = false;
    part.CanTouch = false;
    part.CanQuery = false;
    return part;
end
script.Parent.OnServerEvent:Connect(function(Player, position)
	local XD = Instance.new("Part")
	XD.Name = "Paint"
	XD.Size = Vector3.new(.08,0.08,.08)
	XD.BrickColor = BrickColor.new("White")
	XD.Anchored = true
	XD.CanCollide = false
	XD.TopSurface = "Smooth"
	XD.BottomSurface = "Smooth"
	XD.CFrame = CFrame.new(position)
	XD.Parent = Player.Character
	game.Debris:AddItem(XD, 10)
end)
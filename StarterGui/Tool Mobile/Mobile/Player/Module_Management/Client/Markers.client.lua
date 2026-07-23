local Event = game.ReplicatedStorage.Marker

Event.OnClientEvent:Connect(function(Player, Position)
	if Player == game.Players.LocalPlayer then
		return
	end
	
	if (Player.TeamColor == BrickColor.new("Really blue") or Player.TeamColor == BrickColor.new("Bright blue")) and (game.Players.LocalPlayer.TeamColor == BrickColor.new("Really blue") or game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue")) then
		for i, v in pairs(workspace.Markers:GetChildren()) do
			if v.Name == Player.Name then
			v:Destroy()
			end
		end
	
		local FakeColor = Instance.new("Part", game.ReplicatedStorage)
		FakeColor.BrickColor = Player.TeamColor
	
		local Color = FakeColor.Color
		local Marker = game.Lighting.Marker:Clone()
	
		Marker.Parent = workspace.Markers
		Marker.Marker.Icon.ImageColor3 = Color
		Marker.Marker.Label.Text = Player.Name
		Marker.Marker.Label.TextColor3 = Color
		Marker.Name = Player.Name
		Marker.Position = Position
	
		game.Debris:AddItem(Marker, 3)
		game.Debris:AddItem(FakeColor, 0)
	end
	
	if (Player.TeamColor == BrickColor.new("Camo") or Player.TeamColor == BrickColor.new("Bright green")) and (game.Players.LocalPlayer.TeamColor == BrickColor.new("Camo") or game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright green")) then
		for i, v in pairs(workspace.Markers:GetChildren()) do
			if v.Name == Player.Name then
			v:Destroy()
			end
		end
	
		local FakeColor = Instance.new("Part", game.ReplicatedStorage)
		FakeColor.BrickColor = Player.TeamColor
	
		local Color = FakeColor.Color
		local Marker = game.Lighting.Marker:Clone()
	
		Marker.Parent = workspace.Markers
		Marker.Marker.Icon.ImageColor3 = Color
		Marker.Marker.Label.Text = Player.Name
		Marker.Marker.Label.TextColor3 = Color
		Marker.Name = Player.Name
		Marker.Position = Position
	
		game.Debris:AddItem(Marker, 3)
		game.Debris:AddItem(FakeColor, 0)
	end
end)
game.ReplicatedStorage.CreatePingStats.OnServerEvent:Connect(function(player)
	local stats = Instance.new("IntValue")
	stats.Name = "leaderstats"
	
	local p2 = Instance.new("StringValue")
	p2.Name = "Ping"
	p2.Parent = stats
	
	local p3 = Instance.new("IntValue")
	p3.Name = "Ping"
	p3.Parent = player
	
	stats.Parent = player
end)
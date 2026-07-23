game.Players.PlayerAdded:Connect(function(player)
	-- Verifica se o leaderstats já foi criado
	if not player:FindFirstChild("leaderstats") then
		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player

		-- Cria ping dentro do leaderstats
		local ping = Instance.new("StringValue")
		ping.Name = "Ping"
		ping.Parent = leaderstats
	end
end)

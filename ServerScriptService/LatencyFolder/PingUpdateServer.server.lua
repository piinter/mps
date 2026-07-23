game.ReplicatedStorage.UpdatePing.OnServerEvent:connect(function(player, ttick)
	if ttick > 500 then
		player:WaitForChild("leaderstats"):WaitForChild("Ping").Value = ttick .. " ms"
		player:WaitForChild("Ping").Value = ttick
	else
		player:WaitForChild("leaderstats"):WaitForChild("Ping").Value = ttick .. " ms"
		player:WaitForChild("Ping").Value = ttick
	end
end)



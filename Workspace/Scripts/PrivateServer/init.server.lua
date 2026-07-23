local VIPMenu = script.PrivateServer

game.Players.PlayerAdded:connect(function(player)
	if player.UserId == game.PrivateServerOwnerId then
		VIPMenu:Clone().Parent = player.PlayerGui
	end
end)
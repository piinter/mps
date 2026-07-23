-- Paste the tools inside the Team, and anyone who spawns with that TeamColor will get it

function onPlayerAdded(player)
	player.CharacterAdded:connect(function()
		for _, team in pairs(game:GetService("Teams"):GetChildren()) do
			if team.TeamColor == player.TeamColor then
				for _, instance in pairs(team:GetChildren()) do
					instance:Clone().Parent = player.Backpack
				end
			end
		end
	end)
end

for _, player in pairs(game.Players:GetPlayers()) do
	onPlayerAdded(player)
end

game.Players.PlayerAdded:connect(onPlayerAdded)

local Team = game.Teams

function onTouch(hit)
	if hit.Name == "Right Leg" or hit.Name == "Left Leg" then
		local player=game.Players:FindFirstChild(hit.Parent.Name)
		if player==nil then return end
		if player.TeamColor == game.Teams.Arbitro.TeamColor then return end
		if player.TeamColor == game.Teams.Tecnico.TeamColor then return end
		hit.Parent.Humanoid.WalkSpeed = 20
	end
end
script.Parent.Touched:connect(onTouch)
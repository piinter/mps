local RS = game:GetService("ReplicatedStorage")
local Event = RS:WaitForChild("PB")

Event.OnServerEvent:connect(function(player)
	for i, v in pairs(workspace:GetDescendants()) do
		if v:FindFirstChild("PB") then
			if v.PB.Value == player.Name then
				v:Destroy()
			end
		end
	end
	local ball = game.Lighting.TPS:Clone()
	local offset = Vector3.new(0,-1.6,-5)
	ball.PB.Value = player.Name
	ball.CFrame = player.Character.Torso.CFrame * CFrame.new(offset)
	ball.Parent = game.Workspace.Balls
end)
local player = script.Parent.Parent.Parent.Parent

function leftClick(mouse)
	if workspace.Configuration.SpawnPublicBall.Value == true then
		for i, v in pairs(workspace.Balls:GetDescendants()) do
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
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

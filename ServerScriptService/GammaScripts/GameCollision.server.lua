local CollInject = game.ServerStorage.Coll

game:GetService("Players").PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		if game.Workspace.Configuration.CollMode.Value == false then return end
		local TorsoC = CollInject.AntiCollideHuman:clone()
		TorsoC.Parent = c.Torso
		local HeadC = CollInject.AntiCollideHuman:clone()
		HeadC.Parent = c.Head
	end)
end)
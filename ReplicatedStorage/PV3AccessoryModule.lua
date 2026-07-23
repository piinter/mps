local PV3Managment = {}
PV3Managment.AddLegs = function (child)
	if child:FindFirstChild("Humanoid") then
		local g = game.ServerStorage.Collisions.Legs:Clone()
		g.Parent = child["HumanoidRootPart"]

		local C = g:GetChildren()
		for i=1, #C do
			if C[i].className == "Part" or C[i].className == "UnionOperation" or C[i].className == "MeshPart" then
				local W = Instance.new("Weld")
				W.Name = "PV3Weld"
				W.Part0 = g.Middle
				W.Part1 = C[i]
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = C[i].CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = g.Middle
				g.Middle.Transparency = 1
			end
			local Y = Instance.new("Weld")
			Y.Name = "PV3Weld"
			Y.Part0 = child["HumanoidRootPart"]
			Y.Part1 = g.Middle
			Y.C0 = CFrame.new(0, 0, 0)
			Y.Parent = Y.Part0
		end

		local h = g:GetChildren()
		for i = 1, # h do
			h[i].Anchored = false
			h[i].CanCollide = false
		end
	end
end
return PV3Managment
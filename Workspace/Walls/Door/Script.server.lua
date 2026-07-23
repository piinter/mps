script.Parent.Touched:Connect(function(hit)
	if hit.Name == "TPS" then
		local V = Instance.new("BodyVelocity")
		V.Velocity = Vector3.new(0, 0, 0)
		V.MaxForce = Vector3.new(math.huge, 0, math.huge)
		V.Parent = hit
		game.Debris:AddItem(V, 0.1)

		local G = Instance.new("BodyGyro")
		G.D = 1
		G.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		G.P = 0
		G.Parent = hit
		game.Debris:AddItem(G, 0.1)
	end
end)
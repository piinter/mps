local debris = game:GetService("Debris")

while true do
	wait()
	if script.Parent.Velocity.Magnitude > 0 then
		wait()
		item = script.Parent
		local F = Instance.new("BodyForce")
		F.Force = Vector3.new(-item.Velocity.X * 0.3, 0, -item.Velocity.Z * 0.3)
		F.Parent = item
		debris:AddItem(F, 0.3)
	end
end
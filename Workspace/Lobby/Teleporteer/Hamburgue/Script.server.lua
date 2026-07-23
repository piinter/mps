local z = script.Parent.Parent:FindFirstChild('Hamburgue')
local x = script.Parent.Parent:FindFirstChild('Local')

z.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild('Humanoid') then
		hit.Parent.HumanoidRootPart.CFrame = x.CFrame + Vector3.new(0,3,0)
	end
end)





local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
	if Player.Character:FindFirstChild("HumanoidRootPart") then
		local cameraDirection = Player.Character["HumanoidRootPart"].CFrame:toObjectSpace(workspace.CurrentCamera.CFrame).LookVector
		cameraDirection = (math.asin(cameraDirection.Y) * 40) + 40
		
		if cameraDirection > 40 then
			cameraDirection = 40
		elseif cameraDirection < 0 then
			cameraDirection = 0
		end
	
		script.Parent.Size = UDim2.new(-1, 0, cameraDirection / 40, 0)
	end
end)

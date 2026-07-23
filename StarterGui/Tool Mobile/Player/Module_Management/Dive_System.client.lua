wait(2)
local Player = game.Players.LocalPlayer
local InputService = game:GetService("UserInputService")

InputService.InputBegan:Connect(function(Input, Processed)
	if workspace.Configuration.Diving.Value == false then return end
	if script.Parent.Parent.Shoot.Equipped == true then return end
	if not Processed then
		if Input.UserInputType == Enum.UserInputType.MouseButton3 then
			Player.Character:WaitForChild("Humanoid").PlatformStand = true
			workspace.Foul:Play()
			Player.Character.Torso.RotVelocity = Vector3.new()
			Player.Character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			wait(1)
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			Player.Character.Humanoid.PlatformStand = false
			Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
end)
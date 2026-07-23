-----------------------------GLOBAL CODE--------------------------------

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local actualBall = 0
local buttonFrame = script.Parent
local ballCamButton = buttonFrame.BallCam
local playerCamButton = buttonFrame.PlayerCam
local freeCamButton = buttonFrame.FreeCam
local module = require(script.Parent.Parent.Parent.MainCamera)
local ballFolder = workspace.Balls

----------------------------BALL CAM CODE------------------------------

ballCamButton.MouseButton1Click:Connect(function()
	module.BallCamToggle()
end)

playerCamButton.MouseButton1Click:Connect(function()
	module.PlayerCamToggle()
end)

freeCamButton.MouseButton1Click:Connect(function()
	module.FreecamToggle()
end)

buttonFrame.Parent.BottomBar.Next.MouseButton1Click:Connect(function()
	if module.UsingCamera == "ball" then
		module.NextBall()
	elseif module.UsingCamera == "player" then
		module.NextPlayer()
	end
end)

buttonFrame.Parent.BottomBar.Previous.MouseButton1Click:Connect(function()
	if module.UsingCamera == "ball" then
		module.PrevBall()
	elseif module.UsingCamera == "player" then
		module.PrevPlayer()
	end
end)

UIS.InputBegan:Connect(function(input, process)
	if not process then
		if input.KeyCode == Enum.KeyCode.X and module.UsingCamera == "free" then
			module.StopFreecam()
		end
	end
end)
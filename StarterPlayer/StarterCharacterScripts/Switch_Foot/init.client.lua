task.wait(2)
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")

-- PROCURANDO O MÓDULO CORRETAMENTE
local TM_Module = Backpack:FindFirstChild("ToolManagment") 
if not TM_Module then
	TM_Module = Backpack:WaitForChild("ToolManagment")
end
local TM = require(TM_Module)

local InputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-- Interface
local FootScreen = PlayerGui:WaitForChild("SwitchFoot") 
local FootFrame = FootScreen:WaitForChild("SwitchFoot")
local Button = FootFrame:WaitForChild("SwitchLabel")

-- Configuração do Tween
local Info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.3)
local Goals = { TextTransparency = 1 }

local Sound = script:FindFirstChild("Success") or script:FindFirstChild("Sound")

InputService.InputBegan:Connect(function(Input, Processed)
	if Processed then return end 

	if Input.KeyCode == Enum.KeyCode.LeftControl or Input.KeyCode == Enum.KeyCode.LeftAlt then

		local currentLeg = TM.check()

		if currentLeg == "R" then
			TM.Set("L")

			Button.Text = "L"
			Button.TextColor3 = Color3.fromRGB(255, 105, 105) 

			local leftLabel = FootFrame:FindFirstChild("Left")
			if leftLabel then
				leftLabel.TextTransparency = 0
				TweenService:Create(leftLabel, Info, Goals):Play()
			end

			if Sound then Sound:Play() end

		elseif currentLeg == "L" then
			TM.Set("R")

			Button.Text = "R"
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)

			local rightLabel = FootFrame:FindFirstChild("Right")
			if rightLabel then
				rightLabel.TextTransparency = 0
				TweenService:Create(rightLabel, Info, Goals):Play()
			end

			if Sound then Sound:Play() end
		end

		if Player.Character then
			local targetLegName = (Button.Text == "R") and "Right Leg" or "Left Leg"
			local legPart = Player.Character:FindFirstChild(targetLegName)

			if legPart then
				local highlight = Instance.new("Highlight")
				highlight.Parent = legPart
				highlight.OutlineTransparency = 0
				highlight.FillColor = Color3.new(1,1,1)

				-- animacao do Highlight sumindo
				TweenService:Create(highlight, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {FillTransparency = 1, OutlineTransparency = 1}):Play()

				Debris:AddItem(highlight, 4)
			end
		end
	end
end)
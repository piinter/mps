wait(2)

local Player = game.Players.LocalPlayer
local InputService = game:GetService("UserInputService")
local playerGui = Player:WaitForChild("PlayerGui")

local TM = require(script.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Button = playerGui.MainHud.MainFrame:WaitForChild("Foot")

local switchFootR = playerGui.Start.SwitchLeg.Right
local switchFootL = playerGui.Start.SwitchLeg.Left

local Active = false

local function ShowSwitchIndicator(indicator)
	indicator.Visible = true
	task.wait(0.25)
	indicator.Visible = false
end

local function ToggleFoot()
	if workspace.Configuration.LeftFoot.Value == false then return end
	if Active then return end
	Active = true

	local toFoot = TM.check() == "R" and "L" or "R"
	TM.Set(toFoot)
	script.Success:Play()

	if toFoot == "L" then
		Button.Text = "L"
		Button.TextColor3 = Color3.fromRGB(255, 0, 0)
		task.spawn(function()
			ShowSwitchIndicator(switchFootL)
		end)
	else
		Button.Text = "R"
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		task.spawn(function()
			ShowSwitchIndicator(switchFootR)
		end)
	end

	Active = false
end

InputService.InputBegan:Connect(function(Input, Processed)
	if Processed then return end
	if Input.KeyCode == Enum.KeyCode.LeftAlt or Input.KeyCode == Enum.KeyCode.LeftControl then
		ToggleFoot()
	end
end)

Button.MouseButton1Click:Connect(function()
	ToggleFoot()
end)

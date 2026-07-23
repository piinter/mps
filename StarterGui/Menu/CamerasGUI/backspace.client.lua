local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local gui = script.Parent
local main = gui:WaitForChild("Main")

local aberto = false

local posAberta = UDim2.fromScale(0.5, 0.75)
local posFechada = UDim2.fromScale(0.5, 1.2)

local tweenInfo = TweenInfo.new(
	0.35,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out
)

local function toggleGUI()
	aberto = not aberto

	local target = aberto and posAberta or posFechada
	TweenService:Create(main, tweenInfo, {
		Position = target
	}):Play()
end

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.Backspace then
		toggleGUI()
	end
end)

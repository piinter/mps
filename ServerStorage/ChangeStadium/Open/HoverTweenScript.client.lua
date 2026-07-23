local button = script.Parent
local textBox = button.Display.Description

local TweenService = game:GetService("TweenService")

local function createTween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    return TweenService:Create(instance, tweenInfo, properties)
end

local function onHover()
	local targetPosition = UDim2.new(0.265, 0, 0.252)
    local tween = createTween(textBox, {Position = targetPosition}, 0.5)
    tween:Play()
end

local function onLeave()
	local offscreenPosition = UDim2.new(-1, 0, 0.252)
    local tween = createTween(textBox, {Position = offscreenPosition}, 0.5)
    tween:Play()
end

button.MouseEnter:Connect(onHover)
button.MouseLeave:Connect(onLeave)

-- Initialize the textBox position offscreen
textBox.Position = UDim2.new(-1, 0, 0.252)
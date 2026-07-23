
-- Load the tween service
local TweenService = game:GetService("TweenService")

-- Define the start and end positions of the parent
local startPos = {x = -0.1, y = 0}
local endPos = {x = 1, y = 0}

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local reverseTweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local reverseTween = TweenService:Create(script.Parent, reverseTweenInfo, {Position = UDim2.new(startPos.x, 0, startPos.y, 0)})
-- Create a new forward tween
local forwardTween = TweenService:Create(script.Parent, tweenInfo, {Position = UDim2.new(endPos.x, 0, endPos.y, 0)})
forwardTween.Completed:Connect(function()
	reverseTween:Play()
end)
reverseTween.Completed:Connect(function()
forwardTween:Play()
end)
-- Start the forward tween
forwardTween:Play()
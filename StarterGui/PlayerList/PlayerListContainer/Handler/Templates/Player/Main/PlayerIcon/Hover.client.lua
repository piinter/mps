local TweenService = game:GetService("TweenService")
local Button = script.Parent

Button.MouseEnter:Connect(function()
	TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = 0.2
	}):Play()
end)

Button.MouseLeave:Connect(function()
	TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = 0.6
	}):Play()
end)
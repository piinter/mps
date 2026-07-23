local module = require(script.Parent.Parent.Parent.Parent.MainCamera)

script.Parent.MouseButton1Click:Connect(function()
	if module.UsingCamera == "free" then
		script.Parent.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5,0,-1.25,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
		return
	end
	module.UsingCamera = "ball"
	module.BallCamToggle()
	script.Parent.Parent.Parent.Parent:TweenPosition(UDim2.new(0.5,0,-1.25,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
end)
local button = script.Parent
local animationload

button.MouseEnter:Connect(function()
	local animation = script.Parent.ViewportFrame.WorldModel.Strong.PlayAnimation.Default2
	animationload = script.Parent.ViewportFrame.WorldModel.Strong.Humanoid:LoadAnimation(animation)
	
	animationload:Play()
end)


button.MouseLeave:Connect(function()
	if animationload then
		animationload:Stop()
		animationload = nil
	end
end)
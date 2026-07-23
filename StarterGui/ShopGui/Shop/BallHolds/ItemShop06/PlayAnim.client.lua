local button = script.Parent
local animationload

button.MouseEnter:Connect(function()
	local animation = script.Parent.ViewportFrame.WorldModel.Salute.PlayAnimation.Salute
	animationload = script.Parent.ViewportFrame.WorldModel.Salute.Humanoid:LoadAnimation(animation)
	
	animationload:Play()
end)


button.MouseLeave:Connect(function()
	if animationload then
		animationload:Stop()
		animationload = nil
	end
end)
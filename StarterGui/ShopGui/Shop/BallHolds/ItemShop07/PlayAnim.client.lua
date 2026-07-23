local button = script.Parent
local animationload

button.MouseEnter:Connect(function()
	local animation = script.Parent.ViewportFrame.WorldModel.Arrounds.PlayAnimation.Arround
	animationload = script.Parent.ViewportFrame.WorldModel.Arrounds.Humanoid:LoadAnimation(animation)
	
	animationload:Play()
end)


button.MouseLeave:Connect(function()
	if animationload then
		animationload:Stop()
		animationload = nil
	end
end)
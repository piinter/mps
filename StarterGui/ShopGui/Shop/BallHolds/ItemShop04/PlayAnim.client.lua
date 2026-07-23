local button = script.Parent
local animationload

button.MouseEnter:Connect(function()
	local animation = script.Parent.ViewportFrame.WorldModel.OneHand.PlayAnimation.OneHand
	animationload = script.Parent.ViewportFrame.WorldModel.OneHand.Humanoid:LoadAnimation(animation)

	animationload:Play()
end)


button.MouseLeave:Connect(function()
	if animationload then
		animationload:Stop()
		animationload = nil
	end
end)
local button = script.Parent
local animationload

button.MouseEnter:Connect(function()
	local animation = script.Parent.ViewportFrame.WorldModel.Default.PlayAnimation.Default
	animationload = script.Parent.ViewportFrame.WorldModel.Default.Humanoid:LoadAnimation(animation)
	
	animationload:Play()
end)


button.MouseLeave:Connect(function()
	--local animation = script.Parent.ViewportFrame.WorldModel.ClubPenguin.PlayAnimation.ClubPenguin
	--local animationload = script.Parent.ViewportFrame.WorldModel.ClubPenguin.Humanoid:GetPlayingAnimationTracks()
	if animationload then
		animationload:Stop()
		animationload = nil
	end
end)
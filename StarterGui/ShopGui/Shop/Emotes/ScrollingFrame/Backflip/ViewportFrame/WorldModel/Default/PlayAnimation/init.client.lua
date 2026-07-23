local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local tela = PlayerGui:WaitForChild("ShopGui"):WaitForChild("Shop"):WaitForChild("Emotes")
local humanoid = script.Parent:WaitForChild("Humanoid")
local animation = script:FindFirstChildOfClass("Animation")

local animationTrack = humanoid:LoadAnimation(animation)
animationTrack.Looped = true

local function updateAnimation()
	if tela.Visible == true then
		if not animationTrack.IsPlaying then
			animationTrack:Play()
		end
	else
		if animationTrack.IsPlaying then
			animationTrack:Stop()
		end
	end
end

tela:GetPropertyChangedSignal("Visible"):Connect(updateAnimation)
updateAnimation()
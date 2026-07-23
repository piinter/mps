--[[
	@author TwinPlayzDev_YT
	@since 6/27/2021
	This script will make players body's FORCEFIELD MATERIAL! On Afk.
--]]


--[ LOCALS ]--

local AFKStatus = {}
local AFKAnimations = {}
local AFKEvent = game.ReplicatedStorage:FindFirstChild("AFK")
local AFKAnimationId = "rbxassetid://136765768692857"

--[ FUNCTIONS ]--

if not AFKEvent then
	AFKEvent = Instance.new("RemoteEvent")
	AFKEvent.Parent = game.ReplicatedStorage
	AFKEvent.Name = "AFK"
end

local updateAFK = function(player,enable)

	local char = player.Character -- character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if enable then -- if afk
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if animator then
			local animation = Instance.new("Animation")
			animation.AnimationId = AFKAnimationId
			animation.Parent = humanoid

			local track = animator:LoadAnimation(animation)
			track.Priority = Enum.AnimationPriority.Idle
			track.Looped = true
			track:Play()

			AFKAnimations[player] = track
		end
	else -- if not afk
		local track = AFKAnimations[player]
		if track then
			track:Stop()
			track:Destroy()
			AFKAnimations[player] = nil
		end
	end

end


AFKEvent.OnServerEvent:Connect(function(player,enable) -- on server event (enable)
	AFKStatus[player] = enable
	updateAFK(player,enable)
end)


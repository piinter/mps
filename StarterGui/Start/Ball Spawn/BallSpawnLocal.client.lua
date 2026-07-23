local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local debounce = false
local debounceTime = 1 -- fração de segundo só para travar spam

Mouse.KeyDown:Connect(function(key)
	if key ~= "p" then return end
	if debounce then return end -- ignora se ainda estiver no cooldown rápido

	if workspace.Configuration.SpawnPublicBall.Value == true then
		game.ReplicatedStorage.PB:FireServer(Player)

		-- ativa o debounce curtinho
		debounce = true
		task.delay(debounceTime, function()
			debounce = false
		end)
	end
end)

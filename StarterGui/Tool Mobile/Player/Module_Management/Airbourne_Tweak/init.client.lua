local player = game.Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
    character = player.CharacterAdded:wait()
end
local Humanoid = character:WaitForChild("Humanoid")

Humanoid.Jumping:Connect(function()
	script.Airbourne.Value = true
	wait(0.5)
	script.Airbourne.Value = false
end)
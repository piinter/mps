local gui = script:WaitForChild("WhistleGUI"):Clone()
local tool = script.Parent

tool.Equipped:Connect(function()
	gui.Parent = game.Players.LocalPlayer.PlayerGui
end)

tool.Unequipped:Connect(function()
	gui.Parent = nil
end)
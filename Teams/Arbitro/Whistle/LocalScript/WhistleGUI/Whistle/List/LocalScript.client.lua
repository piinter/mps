script.Parent:WaitForChild("Default").MouseButton1Click:Connect(function()
	game.ReplicatedStorage.WhistleEvent:FireServer("Whistle1")
end)

script.Parent:WaitForChild("Double").MouseButton1Click:Connect(function()
	game.ReplicatedStorage.WhistleEvent:FireServer("Whistle2")
end)

script.Parent:WaitForChild("FreeKick").MouseButton1Click:Connect(function()
	game.ReplicatedStorage.WhistleEvent:FireServer("Whistle3")
end)

script.Parent:WaitForChild("FullTime").MouseButton1Click:Connect(function()
	game.ReplicatedStorage.WhistleEvent:FireServer("Whistle4")
end)
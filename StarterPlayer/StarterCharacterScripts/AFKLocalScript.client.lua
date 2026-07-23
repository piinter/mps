local ReplicatedStorageEvent = game.ReplicatedStorage:WaitForChild("AFK")

game:GetService("UserInputService").WindowFocusReleased:Connect(function()
	ReplicatedStorageEvent:FireServer(true)
end)

game:GetService("UserInputService").WindowFocused:Connect(function()
	ReplicatedStorageEvent:FireServer(false)
end)
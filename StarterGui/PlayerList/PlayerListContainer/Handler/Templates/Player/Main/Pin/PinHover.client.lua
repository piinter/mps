local TweenService = game:GetService("TweenService")
local Main = game.Players.LocalPlayer.PlayerGui:WaitForChild("PlayerList")
local PinHover = Main:WaitForChild("PlayerListContainer"):WaitForChild("PinCheck")

local Hovering = false

script.Parent.MouseEnter:Connect(function(X, Y)
	if not Hovering and script.Parent.Image ~= "" and script.Parent.Image ~= "rbxassetid://0" then
		Hovering = true
		
		PinHover.Pin.Image = script.Parent.Image

		TweenService:Create(PinHover, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(0, -100, 0, 100),
			Position = UDim2.new(0, 0, 0, script.Parent.Parent.Parent.AbsolutePosition.Y + 15)
		}):Play()
	end
end)

script.Parent.MouseLeave:Connect(function()
	if Hovering then
		TweenService:Create(PinHover, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 100)
		}):Play()
		
		Hovering = false
	end
end)
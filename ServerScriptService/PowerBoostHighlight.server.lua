local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FXEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("FX")

FXEvent.OnServerEvent:Connect(function(player, action, targetCharacter)
	if action == "PowerBoost" and targetCharacter then
		
		local highlight = Instance.new("Highlight")
		highlight.Name = "PowerBoostHighlight"
		highlight.FillColor = Color3.fromRGB(255, 255, 255)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = targetCharacter
		highlight.Parent = targetCharacter
		
		
		local TweenService = game:GetService("TweenService")
		local tween = TweenService:Create(
			highlight,
			TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
			{
				FillTransparency = 1,
				OutlineTransparency = 1
			}
		)
		
		tween:Play()
		tween.Completed:Wait()
		highlight:Destroy()
	end
end)
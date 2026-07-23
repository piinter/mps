local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local sign = script.Parent
local updateEvent = sign:WaitForChild("UpdateSignText")

updateEvent.OnServerEvent:Connect(function(player, newText)
	if player.Character == sign.Parent then
		local holder = sign:FindFirstChild("Holder")

		if holder then
			local finalText = newText

			if not RunService:IsStudio() then
				local success, err = pcall(function()
					local filterResult = TextService:FilterStringAsync(newText, player.UserId)
					finalText = filterResult:GetNonChatStringForBroadcastAsync()
				end)

				if not success then
					finalText = "..."
				end
			end

			for _, descendant in pairs(holder:GetDescendants()) do
				if descendant:IsA("TextLabel") then
					descendant.Text = finalText
					break
				end
			end
		end
	end
end)
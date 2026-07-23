local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")

Players.PlayerAdded:Connect(function(player)
	local success, countryCode = pcall(function()
		return LocalizationService:GetCountryRegionForPlayerAsync(player)
	end)

	if success and countryCode then
		player:SetAttribute("Country", countryCode)
	else
		player:SetAttribute("Country", "Desconhecido")
	end
end)
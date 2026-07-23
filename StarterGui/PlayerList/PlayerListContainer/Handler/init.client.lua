if game:GetService("UserInputService").TouchEnabled or game:GetService("GuiService"):IsTenFootInterface() then
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
	script.Parent:Destroy()
	return
end

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Leaderboard = script.Parent
local Scroll = Leaderboard:WaitForChild("Scroll")
local PinCheck = Leaderboard:WaitForChild("PinCheck")
local TeamTemplate = script:WaitForChild("Templates"):WaitForChild("Team")
local PlayerTemplate = script:WaitForChild("Templates"):WaitForChild("Player")

local CountryModule = require(script:WaitForChild("CountryModule"))

local function updateTeamSize(teamFrame)
	local playerCount = #teamFrame.Players:GetChildren() - 1
	if playerCount <= 0 then
		playerCount = 0
	end
	if playerCount == 0 then
		teamFrame.Size = UDim2.new(1, 0, 0, 22)
		teamFrame.Players.Size = UDim2.new(1, 0, 0, 22)
		Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.UIListLayout.AbsoluteContentSize.Y)
	else
		teamFrame.Size = UDim2.new(1, 0, 0, PlayerTemplate.Size.Y.Offset + TeamTemplate.Players.Position.Y.Offset * playerCount)
		teamFrame.Players.Size = UDim2.new(1, 0, 0, PlayerTemplate.Size.Y.Offset + TeamTemplate.Players.Position.Y.Offset * playerCount)
		Scroll.CanvasSize = UDim2.new(0, 0, 0, Scroll.UIListLayout.AbsoluteContentSize.Y)
	end
end

local function removePlayerFromTeam(teamFrame, playerData, player)
	local playerFrame = teamFrame.Players:FindFirstChild(player.UserId)
	if playerFrame then
		playerFrame:Destroy()
		updateTeamSize(teamFrame, playerData)
	end
end

local pinVisible = false
local currentPinnedFrame
local Pin = PinCheck:WaitForChild("Pin")

local function addPlayersToTeam(team, teamFrame)
	for _, player in pairs(team:GetPlayers()) do
		if not teamFrame.Players:FindFirstChild(player.UserId) then
			pcall(function()
				local playerClone = PlayerTemplate:Clone()
				playerClone.Parent = teamFrame.Players
				playerClone.Name = player.UserId
				playerClone.Main.PlayerName.Text = player.Name
				playerClone.Visible = true

				if player == LocalPlayer then
					playerClone.Main.PlayerName.TextStrokeTransparency = 0.9
				end

				local inventoryConnection
				local pingConnection

				local function cleanupConnections()
					if inventoryConnection then
						inventoryConnection:Disconnect()
						inventoryConnection = nil
					end
					if pingConnection then
						pingConnection:Disconnect()
						pingConnection = nil
					end
				end

				updateTeamSize(teamFrame, team)

				if playerClone.Parent == teamFrame.Players then
					local CountryConnection = nil

					local forcedCountry = if player.UserId == 179439914 then "ZA" else player:GetAttribute("Country")

					if CountryModule.countries[forcedCountry] ~= nil then
						playerClone.Ping.Flag.Image = CountryModule.countries[forcedCountry].decal
					else
						CountryConnection = player:GetAttributeChangedSignal("Country"):Connect(function()
							local newCountry = if player.UserId == 179439914 then "ZA" else player:GetAttribute("Country")
							if CountryModule.countries[newCountry] ~= nil then
								playerClone.Ping.Flag.Image = CountryModule.countries[newCountry].decal
								CountryConnection:Disconnect()
								CountryConnection = nil
							end
						end)
					end

					local plrData = player:FindFirstChild("plrData")
					if plrData then
						local misc = plrData:FindFirstChild("Misc")
						if misc then
							local pinValue = misc:FindFirstChild("Pin")
							if pinValue then
								local function updatePinImage(newImageId)
									if typeof(newImageId) == "string" and newImageId ~= "none" and newImageId ~= "" then
										playerClone.Main.Pin.Image = newImageId
										playerClone.Main.Pin.Visible = true
									else
										playerClone.Main.Pin.Visible = false
									end
								end

								updatePinImage(pinValue.Value)
								pinValue:GetPropertyChangedSignal("Value"):Connect(function()
									updatePinImage(pinValue.Value)
								end)
							end
						end
					end

					local pingStat = player:WaitForChild("Ping", 3)

					if pingStat then
						playerClone.Ping.Ping.Text = tostring(pingStat.Value)
						pingStat:GetPropertyChangedSignal("Value"):Connect(function()
							pcall(function()
								playerClone.Ping.Ping.Text = tostring(pingStat.Value)
							end)
						end)
					end

					playerClone.Main.PlayerIcon.Image = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

					playerClone.Main.MouseEnter:Connect(function()
						local PlayerHovered = game.Players:FindFirstChild(playerClone.Main.PlayerName.Text)

						if PlayerHovered and PlayerHovered:GetAttribute("Device") then
							playerClone.Main.PlayerName.Text = PlayerHovered:GetAttribute("Device")
						end

						playerClone.Main.PlayerName.Font = Enum.Font.MontserratBold
					end)

					playerClone.Main.MouseLeave:Connect(function()
						playerClone.Main.PlayerName.Text = player.Name
						playerClone.Main.PlayerName.Font = Enum.Font.MontserratMedium
					end)
				end
			end)
		end
	end
end

local OrdemDosTimes = {
	["-Home GK"] = 1,
	["-Away GK"] = 2, 
	["Home"] = 3,
	["Away"] = 4,
	["Arbitro"] = 5,
	["Midia"] = 6,
	["Fans"] = 7,
	["Tecnico"] = 8,
	["sHome"] = 9,
	["sAway"] = 10
}

local function refreshLeaderboard()
	for _, child in pairs(Scroll:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	for _, team in pairs(Teams:GetChildren()) do
		local teamClone = TeamTemplate:Clone()
		teamClone.Name = team.Name
		teamClone.BGFrame.BackgroundColor3 = team.TeamColor.Color
		teamClone.BGFrame.TeamName.Text = team.Name

		teamClone.LayoutOrder = OrdemDosTimes[team.Name] or 99

		teamClone.Parent = Scroll
		teamClone.Visible = true

		local playerAddedConnection
		local playerRemovedConnection

		playerAddedConnection = team.PlayerAdded:Connect(function()
			addPlayersToTeam(team, teamClone)
		end)

		playerRemovedConnection = team.PlayerRemoved:Connect(function(player)
			removePlayerFromTeam(teamClone, team, player)
		end)

		addPlayersToTeam(team, teamClone)
		updateTeamSize(teamClone, team)
	end
end

refreshLeaderboard()

local tabVisible = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Tab then
		if tabVisible then
			tabVisible = false
			TweenService:Create(Scroll, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 0, 0, 0)
			}):Play()
			return
		end
		tabVisible = true
		TweenService:Create(Scroll, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
	end
end)
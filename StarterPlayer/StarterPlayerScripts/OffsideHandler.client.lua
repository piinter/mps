--// Loading
if not game:IsLoaded() then
	game.Loaded:Wait()
end

--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

--// Variables
local LocalPlayer = Players.LocalPlayer
local BallsFolder = workspace.Balls
local Pitch = workspace.Campo
local OS_Tracker = Pitch.OS_Tracker
local HomeLine = OS_Tracker.HLine
local AwayLine = OS_Tracker.ALine

--// Offside Handler
RunService.RenderStepped:Connect(function()
	if not OS_Tracker then return end
	local HomePlayers = 0
	local HomeGKDetected = false
	local AwayPlayers = 0
	local AwayGKDetected = false
	local BallDetected = false
	
	for Index, Player in ipairs(Players:GetPlayers()) do
		if Player.Team == Teams["-Home GK"] then
			HomeGKDetected = true
		elseif Player.Team == Teams["-Away GK"] then
			AwayGKDetected = true
		elseif Player.Team == Teams.Home then
			HomePlayers += 1
		elseif Player.Team == Teams.Away then
			AwayPlayers += 1
		end
	end
	
	if BallsFolder:FindFirstChild("TPS") then
		BallDetected = true
	end
	
	if HomePlayers >= 2 and HomeGKDetected and AwayPlayers >= 2 and AwayGKDetected and BallDetected and LocalPlayer.Team == Teams.Arbitro then
		HomeLine.Transparency = 0
		AwayLine.Transparency = 0
		
		local hlm = -1000
		local hfm = 1000
		local alm = 1000
		local afm = -1000
		
		for Index, Player in ipairs(Players:GetPlayers()) do
			if Player.Team == Teams.Home and Player.Character and Player.Character.PrimaryPart then
				if Player.Character.HumanoidRootPart.Position.Z < hlm then
					hlm = Player.Character.HumanoidRootPart.Position.Z
				elseif Player.Character.HumanoidRootPart.Position.Z > hfm then
					hfm = Player.Character.HumanoidRootPart.Position.Z
				end
			end
		end
		
		if BallsFolder:FindFirstChild("TPS").Position.Z - 1.25 < hlm then
			hlm = BallsFolder.TPS.Position.Z - 1.25
		end		
		
		HomeLine.Position = Vector3.new(HomeLine.Position.X, HomeLine.Position.Y, hlm)
		
		for Index, Player in ipairs(Players:GetPlayers()) do
			if Player.Team == Teams.Away and Player.Character and Player.Character.PrimaryPart then
				if Player.Character.HumanoidRootPart.Position.Z > alm then
					alm = Player.Character.HumanoidRootPart.Position.Z
				elseif Player.Character.HumanoidRootPart.Position.Z < afm then
					afm = Player.Character.HumanoidRootPart.Position.Z
				end
			end
		end

		if BallsFolder:FindFirstChild("TPS").Position.Z + 1.25 > alm then
			alm = BallsFolder.TPS.Position.Z + 1.25
		end		
		
		AwayLine.Position = Vector3.new(AwayLine.Position.X, AwayLine.Position.Y, alm)
		
		if hfm > AwayLine.Position.Z then
			AwayLine.Color = Color3.new(1, 0, 0)
		else
			AwayLine.Color = Color3.new(1, 1, 0)
		end
		
		if afm < HomeLine.Position.Z then
			HomeLine.Color = Color3.new(1, 0, 0)
		else
			HomeLine.Color = Color3.new(1, 1, 0)
		end
	else
		HomeLine.Transparency = 1
		AwayLine.Transparency = 1
	end
end)
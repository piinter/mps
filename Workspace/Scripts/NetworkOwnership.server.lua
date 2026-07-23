local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local RS = game:GetService("ReplicatedStorage")

local Event = RS:WaitForChild("ChangeOwner")
local Event2 = RS:WaitForChild("ChangeValue")

local PassEvent = RS:FindFirstChild("PassFired") or Instance.new("RemoteEvent")
PassEvent.Name = "PassFired"
PassEvent.Parent = RS

local cooldown = 0.8

local OffsideSnapshot = {
	Active = false,
	Team = nil,
	OffsidePlayers = {}
}

local function TriggerOffside()
	for index, child in pairs(workspace.Balls:GetChildren()) do
		if child.Name == "TPS" then
			child.Anchored = true
			child.Velocity = Vector3.new(0,0,0)
			child.RotVelocity = Vector3.new(0,0,0)

			if child:FindFirstChild("Highlight") then
				child.Highlight.Enabled = true
			end
			if child:FindFirstChild("BillboardGui") then
				child.BillboardGui.Enabled = true
			end
		end
	end

	OffsideSnapshot.Active = false
	task.wait(3)

	for index, child in pairs(workspace.Balls:GetChildren()) do
		if child.Name == "TPS" then
			child.Anchored = false
			if child:FindFirstChild("Highlight") then
				child.Highlight.Enabled = false
			end
			if child:FindFirstChild("BillboardGui") then
				child.BillboardGui.Enabled = false
			end
		end
	end
end

local function getOpponentsZ(team)
	local oppZ = {}
	local targetTeams = {}

	if team == Teams.Home then
		targetTeams = {Teams.Away, Teams["-Away GK"]}
	elseif team == Teams.Away then
		targetTeams = {Teams.Home, Teams["-Home GK"]}
	end

	for _, p in ipairs(Players:GetPlayers()) do
		if table.find(targetTeams, p.Team) then
			local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			if root then
				table.insert(oppZ, root.Position.Z)
			end
		end
	end
	return oppZ
end

PassEvent.OnServerEvent:Connect(function(player)
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local ball = workspace.Balls:FindFirstChild("TPS")

	if not root or not ball then return end

	if OffsideSnapshot.Active then
		if player.Team == OffsideSnapshot.Team then
			if OffsideSnapshot.OffsidePlayers[player.Name] then
				TriggerOffside()
				return
			end
		else
			OffsideSnapshot.Active = false
		end
	end

	local team = player.Team
	local oppZ = getOpponentsZ(team)
	local offsideLine = 0

	if team == Teams.Home then
		table.sort(oppZ, function(a, b) return a < b end)
		offsideLine = oppZ[2] or oppZ[1] or -1000
		if ball.Position.Z < offsideLine then offsideLine = ball.Position.Z end
	elseif team == Teams.Away then
		table.sort(oppZ, function(a, b) return a > b end)
		offsideLine = oppZ[2] or oppZ[1] or 1000
		if ball.Position.Z > offsideLine then offsideLine = ball.Position.Z end
	else
		return
	end

	local flaggedPlayers = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Team == team and p ~= player then
			local pRoot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			if pRoot then
				if team == Teams.Home and pRoot.Position.Z < offsideLine and pRoot.Position.Z < 0 then
					flaggedPlayers[p.Name] = true
				elseif team == Teams.Away and pRoot.Position.Z > offsideLine and pRoot.Position.Z > 0 then
					flaggedPlayers[p.Name] = true
				end
			end
		end
	end

	OffsideSnapshot.Active = true
	OffsideSnapshot.Team = team
	OffsideSnapshot.OffsidePlayers = flaggedPlayers
end)

Event.OnServerEvent:Connect(function(player, ball)
	local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end

	local Distance = (rootPart.Position - ball.Position).Magnitude
	local torsos = player.Character:FindFirstChild("Torso")
	local header = player.Character:FindFirstChild("Head")

	if ball.Name ~= "TPS" then return end
	if Distance > 12 then return end 
	if ball.Anchored then return end

	if OffsideSnapshot.Active then
		if player.Team == OffsideSnapshot.Team then
			if OffsideSnapshot.OffsidePlayers[player.Name] then
				TriggerOffside()
				return
			end
		else
			OffsideSnapshot.Active = false
		end
	end

	if ball.Owner.Value ~= player then
		if torsos then torsos.CollisionGroup = "Humans" end
		if header then header.CollisionGroup = "Humans" end

		ball:SetNetworkOwner(player)
		ball.Owner.Value = ball:GetNetworkOwner()
		ball.ReactDecline.Value = true

		task.wait(cooldown)

		if torsos then torsos.CollisionGroup = "Colls" end
		if header then header.CollisionGroup = "Colls" end
		ball.ReactDecline.Value = false
	end
end)

Event2.OnServerEvent:Connect(function(player, ball)
	ball.Ankle.Value = true
	task.wait(cooldown)
	ball.Ankle.Value = false
end)
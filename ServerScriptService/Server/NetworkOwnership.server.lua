-- ODEIO ESSE SCRIPT 

local PhysicsService = game:GetService("PhysicsService")
local RS = game:GetService("ReplicatedStorage")
local Event = RS:WaitForChild("ChangeOwner")
local Event2 = RS:WaitForChild("ChangeValue")
local cooldown = .8

Event.OnServerEvent:connect(function(player, ball)
	local Distance = player.Character.HumanoidRootPart.Position.Magnitude - ball.Position.Magnitude
	local torsos = player.Character:FindFirstChild("Torso")
	local header = player.Character:FindFirstChild("Head")
	if ball.Name ~= "TPS" then return end
	if Distance > 10 then return end
	if ball.Owner.Value ~= player then
		torsos.CollisionGroup = "Humans"
		header.CollisionGroup = "Humans"
		ball:SetNetworkOwner(player)
		ball.Owner.Value = ball:GetNetworkOwner()
		ball.ReactDecline.Value = true
		wait(cooldown)
		torsos.CollisionGroup = "Colls"
		header.CollisionGroup = "Colls"
		ball.ReactDecline.Value = false
	end
end)

Event2.OnServerEvent:connect(function(player, ball)
	ball.Ankle.Value = true
	wait(cooldown)
	ball.Ankle.Value = false
end)

local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local anim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(script.Parent.RIGHTHEADER)

Tool.MouseButton1Click:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	anim:Play()
	Kick = true
	wait(0.8)
	TM.ResetWelds()
	anim:Stop()
	Kick = false
	wait(0.2)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.RightVector * 60
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

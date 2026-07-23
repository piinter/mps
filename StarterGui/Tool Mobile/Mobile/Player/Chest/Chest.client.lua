local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local deb = true


Tool.MouseButton1Click:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
	TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
	TM.EditWeld("Head", CFrame.new(0,1.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/-8,0,0))
	Kick = true
	wait(0.2)
	TM.ResetWelds()
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
end)

Player.Character["Head"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
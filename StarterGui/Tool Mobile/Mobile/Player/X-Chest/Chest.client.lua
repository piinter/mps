local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
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
	TM.EditWeld("Right Arm", CFrame.new(0.7,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/2,3,-4.25))
	TM.EditWeld("Torso", CFrame.new(0.7,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/2,3,-4.25))
	TM.EditWeld("Left Arm", CFrame.new(-0.7,-0.3,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-3,3.9))
	TM.EditWeld("Head", CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/16,0.75,0))
	Kick = true
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		local force = Player.Character["Torso"].CFrame.lookVector * 60
		local angle = Vector3.new(4e+006,4e+006,4e+006)
		TM.ApplyForce(Ball, angle, force, "Right Leg")
	end
	wait(0.3)
	TM.ResetWelds()
	Kick = false
	wait(0.3)
	TM.SetUsing(false)
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Right Arm"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Arm"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Right Leg"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Leg"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Head"].TouchEnded:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 60
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
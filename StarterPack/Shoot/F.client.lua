local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false

local power
local maxF

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local SClick = script.Parent.Parent.Module_Management.ShootClick

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

local T = false
local R = false
local Combo = false

Mouse.KeyDown:connect(function(key)
	if key ~= "f" then return end
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.setWindUp(true)
	SClick.Value = true
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
		Combo = true
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-0.785,0.5,0))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
		Combo = true
	end
end)

Mouse.KeyUp:connect(function(key)
	if key ~= "f" then return end
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		TM.setWindUp(false)
		Kick = true
		Combo = false
		if TM.check() == "R" then
			if R == false and T == false then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			elseif T == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			elseif R == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,1,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			end
		else
			if R == false and T == false then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			elseif T == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,-1,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			elseif R == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			end
		end
		wait(0.2)
		Kick = false
		SClick.Value = false
		T = false
		R = false
		TM.ResetWelds()
		TM.resetPowerBar()
		wait()
		TM.SetUsing(false)
		TM.setWindUp(false)
	end
end)


Mouse.KeyDown:connect(function(key)
	if Combo == false then
		return
	end
	if key == "r" then
		R = true
	elseif key == "t" then
		T = true
	end
end)







Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	if hit.Owner.Value ~= Player then
		ChangeOwner(hit)
	end
	if R == false and T == false then
		local force = Player.Character["Torso"].CFrame.lookVector * 0
		local angle = Vector3.new(10e+006,10e+006,10e+006)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Right Leg")
	elseif T == true then
		local force = Player.Character["Torso"].CFrame.rightVector * 70 + Player.Character["Torso"].CFrame.upVector * 45
		local angle = Vector3.new(9000000000,30000,9000000000)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Right Leg")
	elseif R == true then
		local force = Player.Character["Torso"].CFrame.rightVector * -70 + Player.Character["Torso"].CFrame.upVector * 45
		local angle = Vector3.new(9000000000,30000,9000000000)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Right Leg")
	end
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	if hit.Owner.Value ~= Player then
		ChangeOwner(hit)
	end
	if R == false and T == false then
		local force = Player.Character["Torso"].CFrame.lookVector * 0
		local angle = Vector3.new(10e+006,10e+006,10e+006)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Left Leg")
	elseif T == true then
		local force = Player.Character["Torso"].CFrame.rightVector * 70 + Player.Character["Torso"].CFrame.upVector * 45
		local angle = Vector3.new(4e+006,2e+003,4e+006)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Left Leg")
	elseif R == true then
		local force = Player.Character["Torso"].CFrame.rightVector * -70 + Player.Character["Torso"].CFrame.upVector * 45
		local angle = Vector3.new(4e+006,2e+003,4e+006)
		Kick = false
	 
		TM.ApplyForce(hit, angle, force, "Left Leg")
	end
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
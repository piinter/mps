local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

local E = false
local Q = false
local T = false
local R = false

local Combo = false

Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "f" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	if TM.check() == "R" then
		
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
	Combo = true
	wait(0.3)
	Combo = false
	
	if E == false and Q == false and T == false and R == false then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	elseif E == true then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	elseif Q == true then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-0.7) *  CFrame.fromEulerAnglesXYZ(0.64,0,0))
	elseif T == true then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
	elseif R == true then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,1,0))
		end
		
		
	else
		
		
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-0.785,0.5,0))
	Combo = true
	wait(0.3)
	Combo = false
	
	if E == false and Q == false and T == false and R == false then
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	elseif E == true then
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	elseif Q == true then
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-0.7) *  CFrame.fromEulerAnglesXYZ(0.64,0,0))
	elseif T == true then
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,-1,0))
	elseif R == true then
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
	end
		
	end
	
	Kick = true
	wait(0.1)
	TM.ResetWelds()
	Kick = false
	E = false
	Q = false
	T = false
	R = false
	wait(0.05)
	TM.SetUsing(false)
end)

Mouse.KeyDown:connect(function(key)
	if Combo == false then
		return
	end
	if key == "e" then
		E = true
	elseif key == "q" then
		Q = true
	elseif key == "t" then
		T = true
	elseif key == "r" then
		R = true
	end
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	if E == false and Q == false and T == false and R == false then
		local force = Player.Character["Right Leg"].CFrame.lookVector * 0
		local angle = Vector3.new(400000,400000,400000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Right Leg")
	elseif R == true or T == true then
		local force = Player.Character["Right Leg"].CFrame.lookVector * 25
		local angle = Vector3.new(9000000000,30000,9000000000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Right Leg")
	elseif E == true then
		local force = Player.Character["Right Leg"].CFrame.lookVector * -23.5
		local angle = Vector3.new(6e+006,1e+003,6e+006)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Right Leg")
	elseif Q == true then
		local force = Player.Character["Right Leg"].CFrame.lookVector * 25
		local angle = Vector3.new(9000000000,1000000000,9000000000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Right Leg")
	end
	
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	if E == false and Q == false and T == false and R == false then
		local force = Player.Character["Left Leg"].CFrame.lookVector * 0
		local angle = Vector3.new(400000,400000,400000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Left Leg")
	elseif R == true or T == true then
		local force = Player.Character["Left Leg"].CFrame.lookVector * 25
		local angle = Vector3.new(9000000000,30000,9000000000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Left Leg")
	elseif E == true then
		local force = Player.Character["Left Leg"].CFrame.lookVector * -23.5
		local angle = Vector3.new(6e+006,1e+003,6e+006)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Left Leg")
	elseif Q == true then
		local force = Player.Character["Left Leg"].CFrame.lookVector * 25
		local angle = Vector3.new(9000000000,1000000000,9000000000)
		Kick = false
		TM.ApplyForce(hit, angle, force, "Left Leg")
	end
	
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
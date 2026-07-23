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


Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "r" then return end
	if SClick.Value == true then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,0))
	end
	power = 60
	Angle = 50
	maxF = Vector3.new(10e+006, 20, 10e+006)
	for i=1,25 do
		if TM.getWindUp() then
			power = power + 2
			Angle = Angle + 250
			TM.powerUp(i/25)
			wait()
		else 
			break
		end
	end
end)

Mouse.KeyUp:connect(function(key)
	if key ~= "r" then return end
	if SClick.Value == true then return end
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		TM.setWindUp(false)
		Kick = true
		if TM.check() == "R" then
			TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,1,0))
		else
			TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
		end
		wait(0.7)
		Kick = false
		TM.ResetWelds()
		TM.resetPowerBar()
		wait(0.2)
		TM.SetUsing(false)
		TM.setWindUp(false)
	end
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "L" then return end
	if not Equipped then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * power
	local angle = Vector3.new(10e+006, Angle, 10e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "R" then return end
	if not Equipped then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * power
	local angle = Vector3.new(10e+006, Angle, 10e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
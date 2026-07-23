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


Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "x" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Arm", CFrame.new(0.7,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/2,3,-4.25))
	TM.EditWeld("Torso", CFrame.new(0.7,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/2,3,-4.25))
	TM.EditWeld("Left Arm", CFrame.new(-0.7,-0.3,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-3,3.9))
	TM.EditWeld("Head", CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/16,0.75,0))
	Kick = true
	wait(0.5)
	TM.ResetWelds()
	Kick = false
	wait(0.2)
	TM.SetUsing(false)
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Arm"].CFrame.lookVector * math.random(1,20)
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Arm"].CFrame.lookVector * math.random(1,20)
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * math.random(1,20)
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * math.random(1,20)
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
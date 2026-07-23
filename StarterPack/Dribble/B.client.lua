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
	if key ~= "b" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Left Leg", CFrame.new(-0.6,-1.8,-0.8) *  CFrame.fromEulerAnglesXYZ(math.pi/10,0,0))
	wait(0.1)
	TM.EditWeld("Left Leg", CFrame.new(-0.9,-1.8,-0.6) *  CFrame.fromEulerAnglesXYZ(math.pi/7,0.2,-0.3))
	wait(0.1)
	TM.EditWeld("Left Leg", CFrame.new(-1.1,-1.8,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0.3,-0.5))
	wait(0.05)
	TM.EditWeld("Left Leg", CFrame.new(-0.7,-1.8,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/6,-math.pi/2,0))
	TM.EditWeld("Right Leg", CFrame.new(0.7,-1.8,-0.7) *  CFrame.fromEulerAnglesXYZ(math.pi/6,-0.5,0.2))
	Kick = true
	wait(0.2)
	TM.ResetWelds()
	Kick = false
	wait(0.05)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 22
	local angle = Vector3.new(9000000000,30000,9000000000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 24
	local angle = Vector3.new(150000,1000,150000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

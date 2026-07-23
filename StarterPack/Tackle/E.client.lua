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
	if key ~= "e" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Leg", CFrame.new(0.8,-1.3,-1.5) *  CFrame.fromEulerAnglesXYZ(math.pi/2.5,-0.3,0.2))
	TM.EditWeld("Left Leg", CFrame.new(-0.8,-1.8,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/5,0.5,-0.3))
	wait(0.05)
	TM.EditWeld("Right Leg", CFrame.new(0.8,-1.5,-1.3) *  CFrame.fromEulerAnglesXYZ(math.pi/3,-0.5,0.2))
	wait(0.05)
	TM.EditWeld("Left Leg", CFrame.new(-0.9,-1.8,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,-0.3))
	Kick = true
	wait(0.25)
	TM.ResetWelds()
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 50
	local angle = Vector3.new(4e+006,0,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
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
	if key ~= "f" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
	TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
	TM.EditWeld("Head", CFrame.new(0,1.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/-8,0,0))
	Kick = true
	wait(0.3)
	TM.ResetWelds()
	Kick = false
	wait(0.45)
	TM.SetUsing(false)
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 21
	local angle = Vector3.new(4e+006,4e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
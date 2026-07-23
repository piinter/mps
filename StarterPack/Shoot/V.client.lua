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
	if key ~= "v" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	Player.Character.Torso.RotVelocity = Vector3.new()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	local BV = Instance.new("BodyVelocity", Player.Character.HumanoidRootPart)
	BV.Velocity = Vector3.new(0, -5, 0)
	BV.MaxForce = Vector3.new(0, 1500, 0)

	game.Debris:AddItem(BV, 1)
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.8,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0.3))
		TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0, 1.5, 0)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-0.5,1)
		Player.Character.Humanoid.PlatformStand = true
		wait(0.15)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0.5,0,0)
		TM.EditWeld("Right Leg", CFrame.new(0.7,-1,-0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/4,0,0.3))
		TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
	else

		TM.EditWeld("Left Leg", CFrame.new(-0.8,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,-0.3))
		TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0, 1.5, 0)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,0.5,-1)
		Player.Character.Humanoid.PlatformStand = true
		wait(0.15)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0.5,0,0)
		TM.EditWeld("Left Leg", CFrame.new(-0.7,-1,-0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/4,0,-0.3))
		TM.EditWeld("Right Arm", CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))

	end
	Kick = true
	wait(0.3)
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	TM.ResetWelds()
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	Kick = false
	wait(1)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)


Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character.Torso.CFrame.lookVector * 100
	local angle = Vector3.new(2e+003,2e+003,2e+003)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

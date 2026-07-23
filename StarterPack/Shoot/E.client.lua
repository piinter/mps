local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

local power
local maxF
local windingUp = false

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
	windingUp = false
end)

Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "e" then return end
	if windingUp then return end

	-- Iniciar powerbar
	windingUp = true
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)

	-- Animação de preparação
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(1.3,-1.2,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0.8))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
	else
		TM.EditWeld("Left Leg", CFrame.new(-1.3,-1.2,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,-0.8))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
	end

	-- Carregar power
	power = 40
	maxF = Vector3.new(math.huge, math.huge, math.huge)
	for i=1,25 do
		if TM.getWindUp() and windingUp then
			power = power + 1.2
			TM.powerUp(i/25)
			wait()
		else 
			break
		end
	end
end)

Mouse.KeyUp:connect(function(key)
	if key ~= "e" then return end
	if not windingUp then return end
	if not TM.getWindUp() then return end
	if not TM.GetUsing() then return end
	if not Equipped then return end

	-- Finalizar powerbar e executar chute
	windingUp = false
	TM.setWindUp(false)

	-- Animação de chute
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(1.3,-1.2,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/12,0.5,0.8))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
	else
		TM.EditWeld("Left Leg", CFrame.new(-1.3,-1.2,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/12,-0.5,-0.8))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
	end

	Kick = true
	wait(0.6)
	TM.ResetWelds()
	TM.resetPowerBar()
	Kick = false
	wait(0.1)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then 
		Kick = false 
		TM.SlowPlayer(17,0.7,20) 
		return 
	end
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	local force = Player.Character["Right Leg"].CFrame.lookVector * power
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Right Leg")
	Player.Character.Humanoid.PlatformStand = true
	Kick = false
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then 
		Kick = false 
		TM.SlowPlayer(17,0.7,20) 
		return 
	end
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	local force = Player.Character["Left Leg"].CFrame.lookVector * power
	local angle = Vector3.new(4e+006,2e+003,4e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Left Leg")
	Player.Character.Humanoid.PlatformStand = true
	Kick = false
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
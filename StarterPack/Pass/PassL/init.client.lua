local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false

local power
local maxF
local Angle 
local Q = false
local E = false
local UserInputService = game:GetService("UserInputService")
local IsMobile = UserInputService.TouchEnabled
local OldMobile = script.Parent.Parent.Module_Management.OldMobile
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

Tool.Equipped:Connect(function(m)
	Equipped = true
end)

Tool.Unequipped:Connect(function(m)
	Equipped = false
	Combo = false
end)

local function StartKick()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)
	Combo = true
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,0.5,0))
	end
	power = 60
	Angle = 60
	maxF = Vector3.new(10e+006, Angle, 10e+006)
	for i=1,25 do
		if TM.getWindUp() then
			power = power + 1
			Angle = Angle + 0
			TM.powerUp(i/25)
			wait()
		else 
			break
		end
	end
end

local function EndKick()
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		TM.setWindUp(false)
		Kick = true
		if TM.check() == "R" then
			if Q == false and E == false then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(math.pi/9,0,0))
			elseif Q == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(0.78,1,0))
			elseif E == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
			end
		else
			if Q == false and E == false then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(math.pi/9,0,0))
			elseif Q == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1) * CFrame.fromEulerAnglesXYZ(0.78,-1,0))
			elseif E == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
			end
		end
		wait(0.7)
		Combo = false
		Kick = false
		Q = false
		E = false
		TM.ResetWelds()
		TM.resetPowerBar()
		wait(0.2)
		TM.SetUsing(false)
		TM.setWindUp(false)
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if not Equipped then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		StartKick()
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if not Equipped then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		EndKick()
	end
end)

Mouse.KeyDown:Connect(function(key)
	if Equipped == false then return end
	if Combo == false then return end
	if key == "r" then
		Q = true
		E = false
		script.Success:Play()
	elseif key == "t" then
		E = true
		Q = false
		script.Success:Play()
	end
end)

Player.Character["Right Leg"].Touched:Connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == false then return end

	if hit.Owner.Value == Player then

		game.ReplicatedStorage.ChangeValue:FireServer(hit)
		hit.Sound:Play()

		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30

		local curve = Instance.new("BodyThrust")
		local F = Instance.new("BodyVelocity")
		if not Q and not E then
			F.Velocity = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		elseif Q then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		elseif E then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		end
		AddPowers(hit, F, Backspin, .8, 2100, curve, (power))

		local Spin

	elseif hit.Owner.Value ~= Player then

		local MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)

		local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
		if not Q and not E then
			force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
		elseif Q then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
		elseif E then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
		end
		Kick = false
		game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
		TM.ApplyForce(hit, MaxForce, force, "Right Leg", true)

		hit.Sound:Play()
		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30

		local curve = Instance.new("BodyThrust")
		AddPowers(hit, nil, Backspin, .8, 2100, curve, (power))


	end
end)

Player.Character["Right Leg"].Touched:Connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == true then return end

	local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
	if not Q and not E then
		force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
	elseif Q then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
	elseif E then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
	end
	local angle = Vector3.new(10e+006, Angle, 10e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Right Leg", true)

	if power >= 90 then

		if hit.ReactDecline.Value == true and hit.Owner.Value ~= Player and workspace.Configuration.FirstTouch.Value == true then return end

		local Spin = Instance.new("BodyAngularVelocity", hit)
		Spin.AngularVelocity = Player.Character["Torso"].CFrame.rightVector * 25
		Spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

		game.Debris:AddItem(Spin, 0.5)

	end
end)

Player.Character["Left Leg"].Touched:Connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == false then return end

	if hit.Owner.Value == Player then

		game.ReplicatedStorage.ChangeValue:FireServer(hit)
		hit.Sound:Play()

		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 0

		local curve = Instance.new("BodyThrust")
		local F = Instance.new("BodyVelocity")
		if not Q and not E then
			F.Velocity = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		elseif Q then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		elseif E then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
			F.MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)
		end
		AddPowers(hit, F, Backspin, .8, 2100, curve, (power))

		local Spin

	elseif hit.Owner.Value ~= Player then

		local MaxForce = Vector3.new(15e+006, Angle * 2,15e+006)

		local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
		if not Q and not E then
			force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
		elseif Q then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
		elseif E then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
		end
		Kick = false
		game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
		TM.ApplyForce(hit, MaxForce, force, "Left Leg", true)

		hit.Sound:Play()
		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 0

		local curve = Instance.new("BodyThrust")
		AddPowers(hit, nil, Backspin, .8, 2100, curve, (power))


	end
end)

Player.Character["Left Leg"].Touched:Connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == true then return end

	local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
	if not Q and not E then
		force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power)
	elseif Q then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power)
	elseif E then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power)
	end
	local angle = Vector3.new(10e+006, Angle, 10e+006)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Left Leg", true)

	if power >= 90 then

		if hit.ReactDecline.Value == true and hit.Owner.Value ~= Player and workspace.Configuration.FirstTouch.Value == true then return end

		local Spin = Instance.new("BodyAngularVelocity", hit)
		Spin.AngularVelocity = Player.Character["Torso"].CFrame.rightVector * 25
		Spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

		game.Debris:AddItem(Spin, 0.5)

	end
end)

function AddPowers(ball, Power, backspin, backspinTime, bspinAmount, curve, power)
	if Power ~= nil then
		Power.Parent = ball
		game.Debris:AddItem(Power, .3)
	end
	for i, v in pairs(ball:GetChildren()) do
		if v.Name == "Curve" then
			v:Remove()
		end
		if v:IsA("BodyAngularVelocity") then
			v:Remove()
		end
	end
	if curve ~= nil then
		if TM.check() == "R" then
			local Backspin = Instance.new("BodyAngularVelocity")
			local bPos = ball.Position + Vector3.new(0, Player.Character.Torso.Position.Y - ball.Position.Y, 0)
			local dotProduct = Player.Character.Torso.CFrame.lookVector:Dot(bPos - Player.Character.Torso.Position)
			local torsoAngle = math.acos(dotProduct / (bPos - Player.Character.Torso.Position).magnitude)
			if torsoAngle > math.rad(18) and (ball.Position - Player.Character["Left Arm"].Position).magnitude < (ball.Position - Player.Character["Right Arm"].Position).magnitude then
				Backspin.AngularVelocity = Vector3.new(0, -45, 0) + -Player.Character.Torso.CFrame.rightVector
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
				local Curve = Instance.new("BodyForce")
				Curve.Name = "Curve"
				Curve.Parent = ball
				while wait() do
					if ball.Velocity.magnitude > 0.1 then
						Curve.Force = (CFrame.new(Vector3.new(0, 0, 0), ball.Velocity) * CFrame.Angles(0, math.rad(-90), 0)).lookVector * power * -1 * 3
						if power > 2 then
							power = power - 2
						else
							power = 0
						end
					end
				end
				Curve:Destroy()
			elseif torsoAngle > math.rad(30) and (ball.Position - Player.Character["Left Arm"].Position).magnitude > (ball.Position - Player.Character["Right Arm"].Position).magnitude then
				Backspin.AngularVelocity = Vector3.new(0, 45, 0) + -Player.Character.Torso.CFrame.rightVector
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
				local Curve = Instance.new("BodyForce")
				Curve.Name = "Curve"
				Curve.Parent = ball
				while wait() do
					if ball.Velocity.magnitude > 0.1 then
						Curve.Force = (CFrame.new(Vector3.new(0, 0, 0), ball.Velocity) * CFrame.Angles(0, math.rad(-90), 0)).lookVector * power * 2.5
						if power > 2 then
							power = power - 2
						else
							power = 0
						end
					end
				end
				Curve:Destroy()
			elseif backspin ~= nil then
				local Backspin = Instance.new("BodyAngularVelocity")
				Backspin.AngularVelocity = (Player.Character.HumanoidRootPart.CFrame.RightVector) * math.rad(bspinAmount)
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
			end
		elseif TM.check() == "L" then
			local bPos = ball.Position + Vector3.new(0, Player.Character.Torso.Position.Y - ball.Position.Y, 0)
			local dotProduct = Player.Character.Torso.CFrame.lookVector:Dot(bPos - Player.Character.Torso.Position)
			local torsoAngle = math.acos(dotProduct / (bPos - Player.Character.Torso.Position).magnitude)
			if torsoAngle > math.rad(30) and (ball.Position - Player.Character["Left Arm"].Position).magnitude > (ball.Position - Player.Character["Right Arm"].Position).magnitude then
				local Backspin = Instance.new("BodyAngularVelocity")
				Backspin.AngularVelocity = Vector3.new(0, 45, 0) + -Player.Character.Torso.CFrame.rightVector
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
				local Curve = Instance.new("BodyForce")
				Curve.Name = "Curve"
				Curve.Parent = ball
				while wait() do
					if ball.Velocity.magnitude > 0.1 then
						Curve.Force = (CFrame.new(Vector3.new(0, 0, 0), ball.Velocity) * CFrame.Angles(0, math.rad(-90), 0)).lookVector * power * 2.5
						if power > 2 then
							power = power - 2
						else
							power = 0
						end
					end
				end
				Curve:Destroy()
			elseif torsoAngle > math.rad(18) and (ball.Position - Player.Character["Left Arm"].Position).magnitude < (ball.Position - Player.Character["Right Arm"].Position).magnitude then
				local Backspin = Instance.new("BodyAngularVelocity")
				Backspin.AngularVelocity = Vector3.new(0, -45, 0) + -Player.Character.Torso.CFrame.rightVector
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
				local Curve = Instance.new("BodyForce")
				Curve.Name = "Curve"
				Curve.Parent = ball
				while wait() do
					if ball.Velocity.magnitude > 0.1 then
						Curve.Force = (CFrame.new(Vector3.new(0, 0, 0), ball.Velocity) * CFrame.Angles(0, math.rad(-90), 0)).lookVector * power * -1 * 3
						if power > 2 then
							power = power - 2
						else
							power = 0
						end
					end
				end
				Curve:Destroy()
			elseif backspin ~= nil then
				local Backspin = Instance.new("BodyAngularVelocity")
				Backspin.AngularVelocity = (Player.Character.HumanoidRootPart.CFrame.RightVector) * math.rad(bspinAmount)
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
			end
		end
	end
	if backspin ~= nil and curve == nil then
		local Backspin = Instance.new("BodyAngularVelocity")
		Backspin.AngularVelocity = backspin * math.rad(bspinAmount)
		Backspin.Parent = ball
		game.Debris:AddItem(Backspin, backspinTime)
	end
end

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
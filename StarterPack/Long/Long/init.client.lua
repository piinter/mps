local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false

local AngleBar = game.Workspace.Configuration.AngleBar
local power
local maxF
local CamAngle
local QVal = script.Parent.Parent.Module_Management.QValue
local EVal = script.Parent.Parent.Module_Management.EValue
local Bspin = false
local curving = false
local ComboV = script.Parent.Parent.Module_Management.Combo
local SClick = script.Parent.Parent.Module_Management.ShootClick
local AntiR = script.Parent.Parent.Module_Management.AntiR
local UserInputService = game:GetService("UserInputService")
local IsMobile = UserInputService.TouchEnabled
local OldMobile = script.Parent.Parent.Module_Management.OldMobile
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

Tool.Equipped:Connect(function(m)
	Equipped = true
	AngleBar.Value = true
end)

Tool.Unequipped:Connect(function(m)
	if TM.GetUsing() then
		Equipped = false
		AngleBar.Value = false
	else
		Equipped = false
		AngleBar.Value = false
		ComboV.Value = false
		Bspin = false
		QVal.Value = false
		EVal.Value = false
		AntiR.Value = false
	end
end)

local function StartKick()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)
	SClick.Value = true
	ComboV.Value = true
	AntiR.Value = true
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,0.5,0))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
	end
	power = 60
	maxF = Vector3.new(math.huge, math.huge, math.huge)
	for i=1,30 do
		if TM.getWindUp() then
			power = power + (2.4)
			TM.powerUp(i/30)
			wait()
		else 
			break
		end
	end
end

local function EndKick()
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		TM.setWindUp(false)
		SClick.Value = false
		AntiR.Value = false
		Kick = true
		if TM.check() == "R" then
			if QVal.Value == false and EVal.Value == false then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(math.pi/9,0,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			elseif QVal.Value == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(0.78,1,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			elseif EVal.Value == true then
				TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
			end
		else
			if QVal.Value == false and EVal.Value == false then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-1) * CFrame.fromEulerAnglesXYZ(math.pi/9,0,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			elseif QVal.Value == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1) * CFrame.fromEulerAnglesXYZ(0.78,-1,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			elseif EVal.Value == true then
				TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
				TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
				TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
			end
		end
		wait(0.7)
		ComboV.Value = false
		Kick = false
		QVal.Value = false
		EVal.Value = false
		TM.ResetWelds()
		TM.resetPowerBar()
		wait(0.2)
		Bspin = false
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
	if SClick.Value == false then return end
	if ComboV.Value == false then return end
	if AntiR.Value == true then
		if key == "r" then
			QVal.Value = true
			EVal.Value = false
			script.Success:Play()
		elseif key == "t" then
			EVal.Value = true
			QVal.Value = false
			script.Success:Play()
		elseif key == "q" then
			Bspin = true
			script.Success:Play()
		end
	end
end)

Player.Character["Right Leg"].Touched:Connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == false then return end

	local cameraDirection = Player.Character["HumanoidRootPart"].CFrame:toObjectSpace(workspace.CurrentCamera.CFrame).LookVector
	cameraDirection = (math.asin(cameraDirection.Y) * 55) + 200

	if cameraDirection > 55 then
		cameraDirection = 55
	elseif cameraDirection < 1 then
		cameraDirection = 1
	end

	if hit.Owner.Value == Player then

		game.ReplicatedStorage.ChangeValue:FireServer(hit)
		hit.Sound:Play()

		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30

		local curve = Instance.new("BodyThrust")
		local F = Instance.new("BodyVelocity")
		if QVal.Value == false and EVal.Value == false then
			F.Velocity = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		elseif QVal.Value == true then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		elseif EVal.Value == true then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		end
		AddPowers(hit, F, Backspin, 0.3, -500, curve, (power))

		local Spin

	elseif hit.Owner.Value ~= Player then

		local MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		if QVal.Value == false and EVal.Value == false then
			force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		elseif QVal.Value == true then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		elseif EVal.Value == true then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		end
		Kick = false
		game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
		TM.ApplyForce(hit, MaxForce, force, "Right Leg", true)

		hit.Sound:Play()
		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30

		local curve = Instance.new("BodyThrust")
		AddPowers(hit, nil, Backspin, 0.3, -500, curve, (power))
	end
end)

Player.Character["Right Leg"].Touched:Connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == true then return end

	local cameraDirection = Player.Character["HumanoidRootPart"].CFrame:toObjectSpace(workspace.CurrentCamera.CFrame).LookVector
	cameraDirection = (math.asin(cameraDirection.Y) * 55) + 200

	if cameraDirection > 55 then
		cameraDirection = 55
	elseif cameraDirection < 1 then
		cameraDirection = 1
	end

	local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	if QVal.Value == false and EVal.Value == false then
		force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	elseif QVal.Value == true then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	elseif EVal.Value == true then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	end
	local angle = Vector3.new(math.huge, math.huge, math.huge)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Right Leg", true)

	if power >= 90 then

		if hit.ReactDecline.Value == true and hit.Owner.Value ~= Player and workspace.Configuration.FirstTouch.Value == true then return end

		local Spin = Instance.new("BodyAngularVelocity", hit)
		Spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		Spin.AngularVelocity = Player.Character["Torso"].CFrame.rightVector * 25

		game.Debris:AddItem(Spin, 0.5)

	end
end)

Player.Character["Left Leg"].Touched:Connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == false then return end

	local cameraDirection = Player.Character["HumanoidRootPart"].CFrame:toObjectSpace(workspace.CurrentCamera.CFrame).LookVector
	cameraDirection = (math.asin(cameraDirection.Y) * 55) + 200

	if cameraDirection > 55 then
		cameraDirection = 55
	elseif cameraDirection < 1 then
		cameraDirection = 1
	end

	if hit.Owner.Value == Player then

		game.ReplicatedStorage.ChangeValue:FireServer(hit)
		hit.Sound:Play()

		local Backspin = Instance.new("BodyAngularVelocity", hit)
		Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30

		local curve = Instance.new("BodyThrust")
		local F = Instance.new("BodyVelocity")
		if QVal.Value == false and EVal.Value == false then
			F.Velocity = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		elseif QVal.Value == true then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		elseif EVal.Value == true then
			F.Velocity = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
			F.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		end
		AddPowers(hit, F, Backspin, 0.3, -500, curve, (power))

		local Spin

	elseif hit.Owner.Value ~= Player then

		local MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		if QVal.Value == false and EVal.Value == false then
			force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		elseif QVal.Value == true then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		elseif EVal.Value == true then
			force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
		end
		Kick = false
		game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
		TM.ApplyForce(hit, MaxForce, force, "Left Leg", true)

		hit.Sound:Play()
		local Backspin = Instance.new("BodyAngularVelocity", hit)
		if not Bspin then
			Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 30
		else
			Backspin.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.RightVector * 0
		end

		local curve = Instance.new("BodyThrust")
		AddPowers(hit, nil, Backspin, 0.3, -500, curve, (power))
	end
end)

Player.Character["Left Leg"].Touched:Connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end

	if workspace.Configuration.Curve.Value == true then return end

	local cameraDirection = Player.Character["HumanoidRootPart"].CFrame:toObjectSpace(workspace.CurrentCamera.CFrame).LookVector
	cameraDirection = (math.asin(cameraDirection.Y) * 55) + 200

	if cameraDirection > 55 then
		cameraDirection = 55
	elseif cameraDirection < 1 then
		cameraDirection = 1
	end

	local force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	if QVal.Value == false and EVal.Value == false then
		force = (Player.Character["HumanoidRootPart"].CFrame.lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	elseif QVal.Value == true then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	elseif EVal.Value == true then
		force = ((Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(0,-1,0)).lookVector * power) + (Player.Character["HumanoidRootPart"].CFrame.upVector * cameraDirection)
	end
	local angle = Vector3.new(math.huge, math.huge, math.huge)
	Kick = false
	game.ReplicatedStorage:WaitForChild("PassFired"):FireServer()
	TM.ApplyForce(hit, angle, force, "Left Leg", true)

	if power >= 90 then

		if hit.ReactDecline.Value == true and hit.Owner.Value ~= Player and workspace.Configuration.FirstTouch.Value == true then return end

		local Spin = Instance.new("BodyAngularVelocity", hit)
		Spin.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		Spin.AngularVelocity = Player.Character["Torso"].CFrame.rightVector * 25

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
				if Bspin == true then return end
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
			elseif Bspin ~= nil then
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
				if Bspin == true then return end
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
			elseif Bspin ~= nil then
				local Backspin = Instance.new("BodyAngularVelocity")
				Backspin.AngularVelocity = (Player.Character.HumanoidRootPart.CFrame.RightVector) * math.rad(bspinAmount)
				Backspin.Parent = ball
				game.Debris:AddItem(Backspin, .2)
			end
		end
	end
	if Bspin ~= nil and curve == nil then
		local Backspin = Instance.new("BodyAngularVelocity")
		Backspin.AngularVelocity = backspin * math.rad(bspinAmount)
		Backspin.Parent = ball
		game.Debris:AddItem(Backspin, backspinTime)
	end
end

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
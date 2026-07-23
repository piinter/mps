local ToolManagement = {}

local player = game.Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
	character = player.CharacterAdded:wait()
end
local Torso = character:WaitForChild("Torso")
local Head = character:WaitForChild("Head")
local RA = character:WaitForChild("Right Arm")
local LA = character:WaitForChild("Left Arm")
local RL = character:WaitForChild("Right Leg")
local LL = character:WaitForChild("Left Leg")
local Using = false
local powerBar = player.PlayerGui.Start.PowerBar.PowerFrame
local windUp = false
local hasPass = false
local holdingBall = false
local heldBall = nil
local clicked = false
local canclick = false
local SF = "R"

local Offsets = {
	["Torso"] = Vector3.new(),
	["Head"] = Vector3.new(0,1.5,0),

	["Right Arm"] = Vector3.new(1,1,0),
	["Right Leg"] = Vector3.new(0.5,-1,0),

	["Left Arm"] = Vector3.new(-1,1,0),
	["Left Leg"] = Vector3.new(-0.5,-1,0),
}

local R, Rays, E = require, RaycastParams, Enum

local ShieldParams = Rays.new()
ShieldParams.FilterType = E.RaycastFilterType.Exclude
ShieldParams.CollisionGroup = "ShieldRaycast"

local function Shielded(Ball)

	local HumanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
	local filterTable = { Ball }

	for _, part in ipairs(player.Character:GetDescendants()) do
		table.insert(filterTable, part)
	end

	ShieldParams.FilterDescendantsInstances = filterTable

	local PartPos = HumanoidRootPart.Position
	if Offsets[player.Character.Torso.Name] then
		PartPos = HumanoidRootPart.CFrame * Offsets[player.Character.Torso.Name]
	end

	local Origin = PartPos * Vector3.new(1,0,1) + Vector3.new(0, Ball.Position.Y, 0)
	local Destination = Ball.Position

	local Direction = (Destination - Origin) * 1
	local RaycastResult:RaycastResult = workspace:Raycast(Origin, Direction, ShieldParams)
	if RaycastResult then
		return RaycastResult.Instance ~= Ball
	end

	return false
end

local function LocalBodyVelocity(Ball, Angle, Power)
	local Velocity = Instance.new("BodyVelocity", Ball)
	Velocity.Name = player.Name
	Velocity.Velocity = Power
	Velocity.MaxForce = Angle

	game.Debris:AddItem(Velocity, 0.3)
end

--[[local function AnkleCheck()
	local Chance = math.random(1, 2)
	if Chance == 1 then
		ToolManagement.Ankle()
	else
		return
	end
end
--[[
local function VARCheck(Ball)
	if workspace.VAR.Side.Value == false then
		game.ReplicatedStorage.VAR.VAR:FireServer(Ball, Ball.CFrame, workspace.VAR.GLT.Value, workspace.VAR.Side.Value, workspace.VAR.Home.Camera.CFrame)
	else
		game.ReplicatedStorage.VAR.VAR:FireServer(Ball, Ball.CFrame, workspace.VAR.GLT.Value, workspace.VAR.Side.Value, workspace.VAR.Away.Camera.CFrame)
	end
end]]

local function AnkleCheck()
	if workspace.Configuration.Ankles.Value == false then return end
	local Chance = math.random(1, 2)
	if Chance == 1 then
		ToolManagement.Ankle()
	else
		return
	end
end

function ToolManagement.check()
	return SF
end

function ToolManagement.Set(F)
	SF = F
end

function ToolManagement.ApplyForce(hit, angle, power, limb, ankle)
	if Shielded(hit) then
		return
	end


	if hit.Ankle.Value == true and hit.Owner.Value ~= player and workspace.Configuration.FirstTouch.Value == true and ankle == true then 
		AnkleCheck()
		return
	end
	if hit.ReactDecline.Value == true and hit.Owner.Value ~= player and workspace.Configuration.FirstTouch.Value == true then return end

	hit.Sound:Play()

	for i, v in pairs(hit:GetChildren()) do
		if v:IsA("BodyVelocity") then
			v:Remove ()
		end
	end

	game.ReplicatedStorage.ChangeValue:FireServer(hit)

	local React = Instance.new("BodyVelocity", hit)
	React.Name = player.Name
	React.Velocity = power
	React.MaxForce = angle

	game.Debris:AddItem(React, 0.3)

	if hit.Owner.Value ~= player then

		React:Remove()

		if player.Ping.Value >= 300 then

			game.ReplicatedStorage.ChangeOwner:FireServer(hit)
			game.ReplicatedStorage.React:FireServer(hit, angle, power)

		else

			game.ReplicatedStorage.ChangeOwner:FireServer(hit)
			LocalBodyVelocity(hit, angle, power)

		end

	end

end

function ToolManagement.SombreroForce(hit, foot, power, force, ankle)
	if hit.ReactDecline.Value == true and hit.Owner.Value ~= player then return end

	hit.Sound:Play()

	if hit:FindFirstChild("ReactDecline") then
		hit.ReactDecline.Value = true
	end

	for i, v in pairs(hit:GetChildren()) do
		if v:IsA("BodyVelocity") then
			v:Destroy()
		end
	end

	game.ReplicatedStorage.ChangeValue:FireServer(hit)

	local F = Instance.new("BodyVelocity")
	F.Name = "ReactVelocity"
	F.Velocity = foot * power
	F.MaxForce = force
	F.Parent = hit
	game.Debris:AddItem(F,0.3)

	if hit.Owner.Value ~= player then

		F:Remove()

		game.ReplicatedStorage.ChangeOwner:FireServer(hit)

		game.ReplicatedStorage.React:FireServer(hit, force, foot*power)
	end
end

function ToolManagement.ApplyGKForce(hit)

	for i, v in pairs(hit:GetChildren()) do
		if v:IsA("BodyVelocity") then
			v:Remove ()
		end
	end

	hit.Sound:Play()
	--VARCheck(hit)

	if hit.Owner.Value ~= player then
		game.ReplicatedStorage.ChangeOwner:FireServer(hit)
		game.ReplicatedStorage.ApplyGKReact:FireServer ({hit, hit.CFrame})
	else
		LocalBodyVelocity(hit, Vector3.new(math.huge, math.huge, math.huge), player.Character["Torso"].CFrame.lookVector * 40 + Vector3.new(math.random(-50, 50), math.random(0, 40), 0))
	end

end

function ToolManagement.SetUsing(b)
	Using = b
end

function ToolManagement.GetUsing()
	return Using
end

function ToolManagement.powerUp(percent)
	powerBar:TweenSize(UDim2.new(1-percent,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true)
end

powerBar:GetPropertyChangedSignal("Size"):Connect(function()
	local percent = powerBar.Size.X.Scale + 1
	powerBar.Parent.Percentage.Text = tostring(math.ceil((1 - powerBar.Size.X.Scale) * 100)) .. "%"
end)

function ToolManagement.getWindUp()
	return windUp
end

function ToolManagement.setWindUp(b)
	windUp = b
end

function ToolManagement.resetPowerBar()
	local TweenService = game:GetService("TweenService")
	local targetSize = UDim2.new(1, 0, 1, 0)
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(powerBar, tweenInfo, { Size = targetSize })
	tween:Play()

	tween.Completed:Connect(function()
		powerBar.Parent.Info.Text = ""
		powerBar.Parent.Percentage.Text = "0%"
		powerBar.Parent.Visible = false
	end)
end

function ToolManagement.Ankle()
	game.ReplicatedStorage.Ankle:FireServer()
	ToolManagement.SetUsing(true)
	ToolManagement.setWindUp(false)
	ToolManagement.resetPowerBar()
	workspace.CurrentCamera.CameraSubject = Head
	character:WaitForChild("Humanoid").PlatformStand = true
	character.Torso.RotVelocity = Vector3.new()
	character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	character.Humanoid.AutoRotate = false
	ToolManagement.ResetWelds()
	wait(1)
	workspace.CurrentCamera.CameraSubject = character.Humanoid
	ToolManagement.SetUsing(false)
	character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	character.Humanoid.PlatformStand = false
	character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	character.Humanoid.AutoRotate = true
end

function ToolManagement.getHoldingBall()
	return holdingBall
end

local function fetchClosestBall()
	local cball = nil
	local cdist = nil
	for _, ball in pairs(workspace:GetDescendants()) do
		if ball.name ~= "TPS" then continue end
		local dist = (character.Torso.Position - ball.Position).Magnitude
		if cdist == nil or dist < cdist then
			cdist = dist
			cball = ball
		end
	end
	--	print(cball)
	return cball
end

function ToolManagement.showPowerBar()
	powerBar.Parent.Visible = true
end

function ToolManagement.getHoldingBall()
	return holdingBall
end

function ToolManagement.getHeldBall()
	return heldBall
end

function ToolManagement.ClickingAllowed()
	return canclick
end

function ToolManagement.ClickedAlready()
	return clicked
end

function ToolManagement.Click(c)
	clicked = c
end

function ToolManagement.AllowClick(c)
	canclick = c
end

function ToolManagement.attachBall(b, t)
	if RA:FindFirstChild("handsOn") == nil then
		game.ReplicatedStorage.CatchBall:FireServer(b, t)
		b.Sound:Play()
		local clientWeld = Instance.new("Weld")
		clientWeld.Name = "clientWeld"
		clientWeld.Parent = RA
		clientWeld.Part0 = RA
		clientWeld.Part1 = b
		clientWeld.C0 = CFrame.new(0, -0.5, -1.2)
		--VARCheck(b)
		if t ~= "ti" then
			spawn(function()
				wait(3)
				if holdingBall then
					player.PlayerGui.Start.Six_Second.Visible = true
				end
				wait(3)
				if holdingBall then
					player.PlayerGui.Start.Six_Second.Visible = false
					ToolManagement.resetPowerBar()
					ToolManagement.SetUsing(false)
					ToolManagement.dropBall()
					ToolManagement.ResetWelds()
				end
			end)
		end
		holdingBall = true
		heldBall = b
		wait(.5)
		clientWeld:Destroy()
	end
end

function ToolManagement.attachBall(b, t)
	if RA:FindFirstChild("handsOn") == nil then
		game.ReplicatedStorage.CatchBall:FireServer(b, t)
		b.Catch:Play()
		local clientWeld = Instance.new("Weld")
		clientWeld.Name = "clientWeld"
		clientWeld.Parent = RA
		clientWeld.Part0 = RA
		clientWeld.Part1 = b
		clientWeld.C0 = CFrame.new(0, -0.5, -1.2)
		--VARCheck(b)
		if t ~= "ti" then
			spawn(function()
				wait(3)
				if holdingBall then
					player.PlayerGui.Start.Six_Second.Visible = true
				end
				wait(3)
				if holdingBall then
					player.PlayerGui.Start.Six_Second.Visible = false
					ToolManagement.resetPowerBar()
					ToolManagement.SetUsing(false)
					ToolManagement.dropBall()
					ToolManagement.ResetWelds()
				end
			end)
		end
		holdingBall = true
		heldBall = b
		wait(.5)
		clientWeld:Destroy()
	end
end

function ToolManagement.dropBall()
	player.PlayerGui.Start.Six_Second.Visible = false
	game.ReplicatedStorage.DropBall:FireServer()
	holdingBall = false
	heldBall = nil
	for _,v in pairs(RA:GetChildren()) do
		if v.Name == "handsOn" then
			v:Destroy()
		end
		if v.Name == "clientWeld" then
			v:Destroy()
		end
	end
end

function ToolManagement.Throw(ball, properties)
	local power = properties[1]

	player.PlayerGui.Start.Six_Second.Visible = false
	game.ReplicatedStorage.ThrowBall:FireServer(ball, power)
end
















































---Ignore this messy stuff lol

function ToolManagement.EditWeld(TargetLimb, CFrame0, CFrame1)
	game.ReplicatedStorage.EditLimb:FireServer(TargetLimb, CFrame0, CFrame1)	
	local weldExists = false
	local weld = nil
	local appendiges = {RA, LA, RL, LL, Head}
	local correspondingJoints = {Torso:FindFirstChild("Right Shoulder"), Torso:FindFirstChild("Left Shoulder"), Torso:FindFirstChild("Right Hip"), Torso:FindFirstChild("Left Hip"), Torso:FindFirstChild("Neck")}

	for _,v in pairs(Torso:GetChildren()) do
		if v.Name == "Weld" and v.Part1.Name == TargetLimb then
			weldExists = true
			weld = v
		end
	end

	if not weldExists then
		weld = Instance.new("Weld")
	end 

	for i,v in pairs(appendiges) do
		if TargetLimb == v.Name then
			if correspondingJoints[i] == nil then repeat wait() until correspondingJoints[i] end
			correspondingJoints[i].Part1 = nil

			weld.Parent = Torso
			weld.Part0 = Torso
			weld.Part1 = v
			weld.C0 = CFrame0
			if CFrame1 ~= nil then
				weld.C1 = CFrame1
			end
		end
	end
end

function ToolManagement.ResetWelds()
	game.ReplicatedStorage.ResetWelds:FireServer()
	for _,v in pairs(Torso:GetChildren()) do
		if v:IsA("Weld") and v.Name ~= "TDragger" then
			v:Destroy()
		end
	end

	local LS = Torso:FindFirstChild("Left Shoulder")
	local RS = Torso:FindFirstChild("Right Shoulder")
	local LH = Torso:FindFirstChild("Left Hip")
	local RH = Torso:FindFirstChild("Right Hip")
	local NE = Torso:FindFirstChild("Neck")

	local joints = {LS, RS, LH, RH, NE}
	local correspondingLimbs = {LA, RA, LL, RL, Head}

	for i,v in pairs(joints) do
		if v == nil then repeat wait() until v end
		v.Part1 = correspondingLimbs[i]
	end		
end

return ToolManagement

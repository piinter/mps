local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local PhysicsService = game:GetService("PhysicsService")
local torsos = Player.Character:FindFirstChild("Torso")
local header = Player.Character:FindFirstChild("Head")

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

local Tween = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))

local Direction = Enum.EasingDirection.Out
local Style = Enum.EasingStyle.Back
local Duration = 0.45

local ra1 = CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4)

local ra2 = CFrame.new(1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4)

local la1 = CFrame.new(-1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4)

local la2 = CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4)

local rl1 = CFrame.new(0.8,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0.3)

local rl12 = CFrame.new(0.5,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0)

local rl2 = CFrame.new(0.5,-1,-1.5) *  CFrame.fromEulerAnglesXYZ(math.pi/2.3,0,0)

local rl3 = CFrame.new(0.5,-1,-1.5) *  CFrame.fromEulerAnglesXYZ(math.pi/2.3,0,0)

local ll1 = CFrame.new(-0.8,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,-0.3)

local ll12 = CFrame.new(-0.5,-1.5,0.8) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0.5,0)

local ll2 = CFrame.new(-0.5,-1,-1.5) *  CFrame.fromEulerAnglesXYZ(math.pi/2.3,0,0)

local ll3 = CFrame.new(-0.5,-1,-1.5) *  CFrame.fromEulerAnglesXYZ(math.pi/2.3,0,0)

Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "x" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	PhysicsService:SetPartCollisionGroup(torsos, "Humans")
	PhysicsService:SetPartCollisionGroup(header, "Humans")
	Player.Character.Torso.RotVelocity = Vector3.new()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	local BV = Instance.new("BodyVelocity", Player.Character.HumanoidRootPart)
	BV.Velocity = Vector3.new(0, 0, 0)
	BV.MaxForce = Vector3.new(0, 15500, 0)

	game.Debris:AddItem(BV, 0.4)

	if TM.check() == "R" then
		Tween.TweenWeld("Left Leg", CFrame.new(-0.5,-2,0), ll3, Direction, Style, Duration)
		Tween.TweenWeld("Right Leg", CFrame.new(0.5,-2,0), rl1, Direction, Style, Duration)
		Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), ra1, Direction, Style, Duration)
		Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), la1, Direction, Style, Duration)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0, 2.2, 0)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(1.5,0,0)
		Player.Character.Humanoid.PlatformStand = true
		wait(0.19)
		Tween.TweenWeld("Left Leg", ll3, ll12, Direction, Style, 0.1)
		Tween.TweenWeld("Right Leg", rl1, rl2, Direction, Style, 0.1)
		Tween.TweenWeld("Right Arm", ra1, ra2, Direction, Style, 0.1)
		Tween.TweenWeld("Left Arm", la1, la2, Direction, Style, 0.1)
	else
		Tween.TweenWeld("Right Leg", CFrame.new(0.5,-2,0), rl3, Direction, Style, Duration)
		Tween.TweenWeld("Left Leg", CFrame.new(-0.5,-2,0), ll1, Direction, Style, Duration)
		Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), ra2, Direction, Style, Duration)
		Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), la2, Direction, Style, Duration)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0, 2.2, 0)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(1.5,0,0)
		Player.Character.Humanoid.PlatformStand = true
		wait(0.19)
		Tween.TweenWeld("Right Leg", rl3, rl12, Direction, Style, 0.1)
		Tween.TweenWeld("Left Leg", ll1, ll2, Direction, Style, 0.1)
		Tween.TweenWeld("Right Arm", ra2, ra1, Direction, Style, 0.1)
		Tween.TweenWeld("Left Arm", la2, la1, Direction, Style, 0.1)
	end
	Kick = true
	wait(0.3)
	if TM.check() == "R" then
		Tween.TweenWeld("Left Leg", ll12, CFrame.new(-0.5,-2,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Right Leg", rl2, CFrame.new(0.5,-2,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Right Arm", ra2, CFrame.new(1.5,0,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Left Arm", la2, CFrame.new(-1.5,0,0), Direction, Enum.EasingStyle.Linear, 0.1)
	else
		Tween.TweenWeld("Right Leg", rl12, CFrame.new(0.5,-2,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Left Leg", ll2, CFrame.new(-0.5,-2,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Right Arm", ra1, CFrame.new(1.5,0,0), Direction, Enum.EasingStyle.Linear, 0.1)
		Tween.TweenWeld("Left Arm", la1, CFrame.new(-1.5,0,0), Direction, Enum.EasingStyle.Linear, 0.1)
	end
	wait(0.1)
	TM.ResetWelds()
	Kick = false
	wait(0.56)
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	PhysicsService:SetPartCollisionGroup(torsos, "Colls")
	PhysicsService:SetPartCollisionGroup(header, "Colls")
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = (Player.Character.Torso.CFrame.UpVector * 100)
	force = force * Vector3.new(1, 0, 1)
	force = force + Vector3.new(0, 8, 0)
	local angle = Vector3.new(math.huge, math.huge, math.huge)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character.Torso.Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = (Player.Character.Torso.CFrame.UpVector * 100)
	force = force * Vector3.new(1, 0, 1)
	force = force + Vector3.new(0, 8, 0)
	local angle = Vector3.new(math.huge, math.huge, math.huge)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = (Player.Character.Torso.CFrame.UpVector * 100)
	force = force * Vector3.new(1, 0, 1)
	force = force + Vector3.new(0, 8, 0)
	local angle = Vector3.new(math.huge, math.huge, math.huge)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

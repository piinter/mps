local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PhysicsService = game:GetService("PhysicsService")

Kick = false
Equipped = true
Tool = script.Parent
Player = Players.LocalPlayer

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:FindFirstChild("Torso")
local Head = Character:FindFirstChild("Head")
local AnimateScript = Character:FindFirstChild("Animate")


local RIGHT_KICK_ID = "rbxassetid://133820026045082"
local LEFT_KICK_ID  = "rbxassetid://111873393433337"

local function PlayKickAnimation(leg)
	local animator = Humanoid:FindFirstChildOfClass("Animator")
	if not animator then return end

	local anim = Instance.new("Animation")
	anim.AnimationId = (leg == "R") and RIGHT_KICK_ID or LEFT_KICK_ID

	local track = animator:LoadAnimation(anim)
	track.Priority = Enum.AnimationPriority.Action4
	track.Looped = false
	track:Play()

	return track
end

Tool.MouseButton1Click:Connect(function()
	if not Equipped then return end
	if TM.GetUsing() then return end

	TM.SetUsing(true)
	Kick = true

	local oldSpeed = Humanoid.WalkSpeed
	local oldJump = Humanoid.JumpPower

	Humanoid.WalkSpeed = 20
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	
	if AnimateScript then
		AnimateScript.Disabled = true
	end

	
	Humanoid.AutoRotate = false

	local gyro = Instance.new("BodyGyro")
	gyro.MaxTorque = Vector3.new(0, 400000, 0)
	gyro.CFrame = HRP.CFrame
	gyro.Parent = HRP
	game.Debris:AddItem(gyro, 0.6)

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, -5, 0)
	bv.MaxForce = Vector3.new(0, 1500, 0)
	bv.Parent = HRP
	game.Debris:AddItem(bv, 0.45)

	local leg = TM.check()
	local kickTrack = PlayKickAnimation(leg)

	task.wait(0.5)

	if kickTrack then
		kickTrack:Stop()
	end

	-- 🔄 RESTORE
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Humanoid.AutoRotate = true
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

	if AnimateScript then
		AnimateScript.Disabled = false
	end

	Humanoid.WalkSpeed = oldSpeed
	Humanoid.JumpPower = oldJump

	Kick = false
	task.wait(1)
	TM.SetUsing(false)
end)



local function ApplyKick(hit, limb)
	if not Kick then return end
	if hit.Name ~= "TPS" then return end

	Kick = false
	local force = Head.CFrame.LookVector * 110
	local angle = Vector3.new(4e6, 2e3, 4e6)

	TM.ApplyForce(hit, angle, force, limb)
end

Character["Right Leg"].Touched:Connect(function(hit)
	if TM.check() == "L" then return end
	ApplyKick(hit, "Right Leg")
end)

Character["Left Leg"].Touched:Connect(function(hit)
	if TM.check() == "R" then return end
	ApplyKick(hit, "Left Leg")
end)

Character.Head.Touched:Connect(function(hit)
	ApplyKick(hit, "Right Leg")
end)

Character.Torso.Touched:Connect(function(hit)
	ApplyKick(hit, "Right Leg")
end)

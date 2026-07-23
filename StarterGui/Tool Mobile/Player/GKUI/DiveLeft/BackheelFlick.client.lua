local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
local Tween = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

-- Animation setup
local backheelAnimation = Instance.new("Animation")
backheelAnimation.AnimationId = "rbxassetid://74875834034751"
local backheelTrack = nil


Tool.MouseButton1Click:Connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	Player.Character.Torso.RotVelocity = Vector3.new()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	
	local SF = Instance.new("BodyVelocity")
	SF.Parent = Player.Character["Torso"].Parent.HumanoidRootPart
	SF.MaxForce = Vector3.new(math.huge, 2150, math.huge);
	SF.Velocity = Player.Character["Torso"].Parent.HumanoidRootPart.CFrame.rightVector*-35
	game.Debris:AddItem(SF, 0.3)

	Player.Character.Humanoid.WalkSpeed = 0
	Player.Character.Humanoid.JumpPower = 0

	-- Load and play the animation
	backheelTrack = Player.Character.Humanoid:LoadAnimation(backheelAnimation)
	backheelTrack:Play()

	Player.Character.HumanoidRootPart.Anchored = true
	Kick = true
	Player.Character.Humanoid.PlatformStand = true
	wait(.05)
	Player.Character.HumanoidRootPart.Anchored = false
	-- Wait for animation to complete (adjust duration as needed)
	wait(0.5)
	
	-- Stop the animation
	if backheelTrack then
		backheelTrack:Stop()
		backheelTrack:Destroy()
		backheelTrack = nil
	end
	
	wait(0.2)
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	Player.Character.Humanoid.WalkSpeed = 20
	Player.Character.Humanoid.JumpPower = 50
	Kick = false
	wait(0.35)
	TM.SetUsing(false)
end)

Player.Character["Right Arm"].Touched:Connect(function(hit)
	if hit.Name == "TPS" then
		if Kick then
			ChangeOwner(hit)
			Kick = false
			TM.attachBall(hit)
		end
	end
end)

Player.Character["Left Arm"].Touched:Connect(function(hit)
	if hit.Name == "TPS" then
		if Kick then
			ChangeOwner(hit)
			Kick = false
			TM.attachBall(hit)
		end
	end
end)

Player.Character["Torso"].Touched:Connect(function(hit)
	if hit.Name == "TPS" then
		if Kick then
			ChangeOwner(hit)
			Kick = false
			TM.attachBall(hit)
		end
	end
end)

Player.Character["Head"].Touched:Connect(function(hit)
	if hit.Name == "TPS" then
		if Kick then
			ChangeOwner(hit)
			Kick = false
			TM.attachBall(hit)
		end
	end
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)


function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

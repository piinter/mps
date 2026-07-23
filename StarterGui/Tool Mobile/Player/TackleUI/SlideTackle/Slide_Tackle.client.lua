local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Tween = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))
Kick = false
Equipped = true

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

Speed = 30
Range = 22

Tool.MouseButton1Click:connect(function()
	if not workspace.Configuration.SlideTackle.Value then return end
	if not CloseEnoughToABall() then return end
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	Player.Character.Torso.RotVelocity = Vector3.new()
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
	
	local SF = Instance.new("BodyVelocity")
	SF.Parent = Player.Character["Torso"].Parent.HumanoidRootPart
	SF.MaxForce = Vector3.new(math.huge,0,math.huge)
	SF.Velocity = Player.Character["Torso"].Parent.HumanoidRootPart.CFrame.lookVector * 30
	game.Debris:AddItem(SF, 0.3)
	
	local Direction = Enum.EasingDirection.Out
	local Style = Enum.EasingStyle.Back
	local Duration = 0.4
	
	Player.Character.Humanoid.WalkSpeed = 0
	Player.Character.Humanoid.JumpPower = 0
	
	Player.Character.Humanoid.AutoRotate = false

	
	if TM.check() == "R" then
		Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), CFrame.new(1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4), Direction, Style, Duration)
	Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), CFrame.new(-1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4), Direction, Style, Duration)
	Tween.TweenWeld("Right Leg", CFrame.new(0.5,-2,0), CFrame.new(0.5,-1.7,-0.6) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0,0), Direction, Style, Duration)
	Tween.TweenWeld("Head", CFrame.new(0,1.5,0), CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/-6,0,0), Direction, Style, Duration)
	
	Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0,-1.2,0)
		Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(1.5,1.5,0)
		
	else
		
		Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), CFrame.new(-1.5,0.5,0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4), Direction, Style, Duration)
	Tween.TweenWeld("Right Arm", CFrame.new(-1.5,0,0), CFrame.new(1.5,0.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4), Direction, Style, Duration)
	Tween.TweenWeld("Left Leg", CFrame.new(-0.5,-2,0), CFrame.new(-0.5,-1.7,-0.6) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0,0), Direction, Style, Duration)
	Tween.TweenWeld("Head", CFrame.new(0,1.5,0), CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/-6,0,0), Direction, Style, Duration)
	
	Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame + Vector3.new(0,1.2,0)
	Player.Character["HumanoidRootPart"].CFrame = Player.Character["HumanoidRootPart"].CFrame * CFrame.fromEulerAnglesXYZ(1.5,-1.5,0)
	end
	
	Player.Character["HumanoidRootPart"].Anchored = true
	
	Kick = true
	
	wait(0.05)
	
	Player.Character["HumanoidRootPart"].Anchored = false
	Player.Character.Humanoid.PlatformStand = true
	
	wait(0.5)
	TM.ResetWelds()
	Kick = false
	wait(0.2)
	Player.Character.Humanoid.AutoRotate = true
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	Player.Character.Humanoid.WalkSpeed = 20
	Player.Character.Humanoid.JumpPower = 50
	wait(0.2)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if Kick == false then return end
	if hit.Parent:FindFirstChild("Humanoid") then
		game.ReplicatedStorage.Trip_Player:FireServer(hit.Parent)
		Kick = false
	end
	if hit.Name ~= "TPS" then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 35
	local angle = Vector3.new(90000000000,100000,90000000000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if Kick == false then return end
	if hit.Parent:FindFirstChild("Humanoid") then
		game.ReplicatedStorage.Trip_Player:FireServer(hit.Parent)
		Kick = false
	end
	if hit.Name ~= "TPS" then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 35
	local angle = Vector3.new(90000000000,100000,90000000000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function CloseEnoughToABall()
	--[[
		unfortunately you dont use
		collectionservice to track the balls or anything in general, so i have to use
		more inefficient method.
	--]]
	local Character = Player.Character
	if not Character then return end
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end
	local CharacterPosition = HumanoidRootPart.Position
	
	-- DFC stands for distance from character
	local ClosestBall
	local ClosestBallDFC
	
	local Children = workspace:GetChildren()
	for _, Child in pairs(Children) do
		if Child.Name == "TPS" then
			local DescendantPosition = Child.Position
			if ClosestBall and ClosestBallDFC then
				local DistanceFromCharacter = (CharacterPosition - DescendantPosition).Magnitude
				if DistanceFromCharacter < ClosestBallDFC then
					ClosestBall = Child
					ClosestBallDFC = DistanceFromCharacter
				end
			else
				local DistanceFromCharacter = (CharacterPosition - DescendantPosition).Magnitude
				ClosestBall = Child
				ClosestBallDFC = DistanceFromCharacter
			end
		end
	end
	
	if ClosestBallDFC then
		if ClosestBallDFC < Range then
			return true
		else
			return false
		end
	else
		return false
	end
end

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
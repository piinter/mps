local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
local TweenService = game:GetService("TweenService")
RunService = game:GetService("RunService")
local FXEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("FX")

Kick = false
Equipped = false
Reacted = false
CanRotate = false
PowerBoost = false

local power
local Angle
local maxPower = 25

local GrupoIgnorarBola = "Humans"

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

repeat wait() until Player.Character:FindFirstChild("Humanoid")

local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://136192974493578"
local PlayAnim = Player.Character.Humanoid:LoadAnimation(Anim)

local function activateHighlight()
	PowerBoost = true

	if Player.Character then
		FXEvent:FireServer("PowerBoost", Player.Character)
	end
end

script.Parent.Equipped:Connect(function()
	Equipped = true
end)

script.Parent.Unequipped:Connect(function()
	Equipped = false
	PowerBoost = false
end)

Mouse.KeyDown:Connect(function(key)
	if Equipped == false then return end
	if not TM.getHoldingBall() then return end
	if key ~= "e" then return end
	if PowerBoost then return end

	activateHighlight()
end)

Mouse.Button1Down:Connect(function()
	if Equipped == false then return end
	if not TM.getHoldingBall() then return end
	if TM.GetUsing() then return end

	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)

	power = 55
	Angle = 50

	for i = 1, maxPower do
		if TM.getWindUp() then
			power = power + 0.3
			Angle = Angle + 350
			TM.powerUp(i/maxPower)
			wait()
		else
			break
		end
	end
end)

Mouse.Button1Up:Connect(function()
	if not TM.getHoldingBall() then return end
	release()
end)

function release()
	if TM.getWindUp() and TM.GetUsing() and Equipped then

		if TM.getHeldBall().Owner.Value ~= Player then
			game.ReplicatedStorage.ChangeOwner:FireServer(TM.getHeldBall())
		end

		TM.setWindUp(false)
		Kick = true

		if TM.TweenBallCFrame then
			TM.TweenBallCFrame(CFrame.new(0, 3.5, 1.5), 0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		end

		Player.Character.Torso.CollisionGroup = GrupoIgnorarBola
		Player.Character.Head.CollisionGroup = GrupoIgnorarBola

		PlayAnim:Play(nil, nil, 0.8)
		wait(0.3)

		local multiplier = PowerBoost and 1.8 or 1

		local F = Instance.new("BodyVelocity")
		F.Velocity = (Player.Character.Head.CFrame.LookVector * (power * multiplier)) + Vector3.new(0, Angle/250, 0)
		F.MaxForce = Vector3.new(4e+006, Angle, 4e+006)
		F.Parent = TM.getHeldBall()

		TM.dropBall()
		game.Debris:AddItem(F, 0.3)

		PowerBoost = false

		wait(0.7)
		Kick = false

		Player.Character.Torso.CollisionGroup = "Colls"
		Player.Character.Head.CollisionGroup = "Colls"

		TM.ResetWelds()
		TM.resetPowerBar()

		wait(0.2)

		workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
		CanRotate = false
		Player.Character.Humanoid.WalkSpeed = 16
		TM.SetUsing(false)
		TM.setWindUp(false)
	end
end

coroutine.wrap(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if Player.Character and CanRotate == true then
			local rootPart = Player.Character:WaitForChild("HumanoidRootPart")
			rootPart.CFrame = CFrame.new(
				rootPart.CFrame.p,
				rootPart.CFrame.p + Vector3.new(
					workspace.CurrentCamera.CFrame.LookVector.X,
					0,
					workspace.CurrentCamera.CFrame.LookVector.Z
				)
			)
		end
	end)
end)()
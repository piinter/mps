local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false

local power
local maxF

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
	if not TM.getHoldingBall() then return end
	if TM.GetUsing() then return end
	if key ~= "t" then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)
	TM.EditWeld("Right Arm", CFrame.new(1.5,0.2,0.3) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,-0.5,0.8))
	power = 55
	Angle = 50
	maxF = Vector3.new(10e+006, 20, 10e+006)
	for i=1,25 do
		if TM.getWindUp() then
			power = power + 2
			Angle = Angle + 350
			TM.powerUp(i/25)
			wait()
		else 
			break
		end
	end
end)

Mouse.KeyUp:connect(function(key)
	if key ~= "t" then return end
	if not TM.getHoldingBall() then return end
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		if TM.getHeldBall().Owner.Value ~= Player then
			ChangeOwner(TM.getHeldBall())
		end
		TM.setWindUp(false)
		Kick = true
		TM.EditWeld("Right Arm", CFrame.new(1,1.2,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/1.5,0,-0.5))
		F = Instance.new("BodyVelocity")
		F.Velocity = (Player.Character["Head"].CFrame.lookVector * power) + Vector3.new(0,Angle/250,0)
		F.MaxForce = Vector3.new(4e+006,Angle,4e+006)
		F.Parent = TM.getHeldBall()
		TM.dropBall()
		game.Debris:AddItem(F, 0.3)
		wait(0.7)
		Kick = false
		TM.ResetWelds()
		TM.resetPowerBar()
		wait(0.2)
		TM.SetUsing(false)
		TM.setWindUp(false)
	end
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
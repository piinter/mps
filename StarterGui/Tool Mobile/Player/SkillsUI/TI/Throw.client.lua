local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true

local power
local maxF

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

Tool.MouseButton1Down:Connect(function()
	if Equipped == false then return end
	if not TM.getHoldingBall() then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.showPowerBar()
	TM.setWindUp(true)
	TM.EditWeld("Right Arm", CFrame.new(1.2,1.2,0.3) *  CFrame.fromEulerAnglesXYZ(-math.pi/1.2,0,-0.5))
	TM.EditWeld("Left Arm", CFrame.new(-1.2,1.2,0.3) *  CFrame.fromEulerAnglesXYZ(-math.pi/1.2,0,0.5))
	power = 20
	Angle = 10
	maxF = Vector3.new(10e+006, 5, 10e+006)
	for i=1,25 do
		if TM.getWindUp() then
			power = power + 2.1
			Angle = Angle + 250
			TM.powerUp(i/25)
			wait()
		else 
			break
		end
	end
end)

Tool.MouseButton1Up:Connect(function()
	if not TM.getHoldingBall() then return end
	if TM.getWindUp() and TM.GetUsing() and Equipped then
		if TM.getHeldBall().Owner.Value ~= Player then
			ChangeOwner(TM.getHeldBall())
		end
		TM.setWindUp(false)
		Kick = true
		TM.EditWeld("Right Arm", CFrame.new(1.2,1.2,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/1.5,0,-0.5))
		TM.EditWeld("Left Arm", CFrame.new(-1.2,1.2,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/1.5,0,0.5))
		TM.Throw(TM.getHeldBall(), {power, Angle})
		TM.dropBall()
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
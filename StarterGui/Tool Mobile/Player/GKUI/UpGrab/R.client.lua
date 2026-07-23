local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

Tool.MouseButton1Click:Connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	Kick = true
	TM.EditWeld("Left Arm", CFrame.new(-1.2,1.7,-0.6) *  CFrame.fromEulerAnglesXYZ(math.pi/1.1,0,0.3))
	TM.EditWeld("Right Arm", CFrame.new(1.2,1.7,-0.6) *  CFrame.fromEulerAnglesXYZ(math.pi/1.1,0,-0.3))
	wait(0.5)
	Kick = false
	TM.ResetWelds()
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

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()


Tool.MouseButton1Click:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Left Leg", CFrame.new(-0.8,-1.5,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/9.5,-1,-0.5))
	Kick = true
	wait(0.5)
	TM.ResetWelds()
	Kick = false
	wait(0.2)
	TM.SetUsing(false)
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 44
	local angle = Vector3.new(400000,2000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

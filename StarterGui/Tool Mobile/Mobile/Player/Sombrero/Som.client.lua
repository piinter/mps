local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()



Mouse.KeyDown:connect(function(key)
	if workspace.Configuration.Sombrero.Value == true then return end
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
	wait(0.5)
	TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1) *  CFrame.fromEulerAnglesXYZ(0.78,1,0))
	Kick = true
	wait(0.5)
	TM.ResetWelds()
	Kick = false
	wait(0.12)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 20
	local angle = Vector3.new(400000,2000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

local TM = require(script.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local deb = true


Tool.MouseButton1Click:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	TM.EditWeld("Right Leg", CFrame.new(0.5,-1,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/1.5,0,0))
	Kick = true
	wait(0.5)
	TM.ResetWelds()
	Kick = false
	wait(0.2)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * -42
	local angle = Vector3.new(4e+006,8e+006,4e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
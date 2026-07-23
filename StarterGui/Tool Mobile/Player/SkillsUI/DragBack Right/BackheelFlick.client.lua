local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
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
	TM.EditWeld("Left Leg", CFrame.new(-0.7,-1.8,0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/8,1.5,-0.7))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		local force = Player.Character["Left Leg"].CFrame.lookVector * -26
		local angle = Vector3.new(150000,1000,150000)
		Kick = false
		TM.ApplyForce(Ball, angle, force, "Left Leg")
		Plag.Disable()
	end
	Kick = true
	wait(0.2)
	TM.ResetWelds()
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * -26
	local angle = Vector3.new(150000,1000,150000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
		Plag.TriggerPlag(hit, 1)
	end
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
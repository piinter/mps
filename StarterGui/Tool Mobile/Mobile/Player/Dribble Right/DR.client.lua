local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
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
	TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) *  CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		local force = Player.Character["Right Leg"].CFrame.lookVector * 21
		local angle = Vector3.new(400000,2000,400000)
		Kick = false
		TM.ApplyForce(Ball, angle, force, "Right Leg")
	end
	Kick = true
	wait(0.2)
	TM.ResetWelds()
	Kick = false
	wait(0.05)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 21
	local angle = Vector3.new(400000,2000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
		Plag.TriggerPlag(hit, 1)
	end
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
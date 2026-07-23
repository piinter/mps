local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
Kick = false
Equipped = true
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()



script.Parent.MouseButton1Click:Connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(1.2,-1.7,0) *  CFrame.fromEulerAnglesXYZ(math.pi/8,0.1,0.7))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		Kick = false
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame *  CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = power * Vector3.new(1, 0, 1)
		power = power + Vector3.new(0, 30, 0)
		local force = Player.Character["Right Leg"].CFrame.lookVector * 40
		local angle = Vector3.new(9e+009, 9e+009, 9e+009)
		TM.ApplyForce(Ball, angle, power, "Right Leg")
		Plag.Disable()
	end
	Kick = true
	wait(0.3)
	TM.ResetWelds()
		TM.EditWeld("Left Leg", CFrame.new(0,-1.7,0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/-4,-0.2,0.5))
		
	else
		
		TM.EditWeld("Left Leg", CFrame.new(-1.2,-1.7,0) *  CFrame.fromEulerAnglesXYZ(math.pi/8,-0.1,-0.7))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		Kick = false
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame *  CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = power * Vector3.new(1, 0, 1)
		power = power + Vector3.new(0, 30, 0)
		local force = Player.Character["Left Leg"].CFrame.lookVector * 40
		local angle = Vector3.new(9e+009, 9e+009, 9e+009)
		TM.ApplyForce(Ball, angle, power, "Left Leg")
		Plag.Disable()
	end
	Kick = true
	wait(0.15)
	TM.ResetWelds()
	TM.EditWeld("Right Leg", CFrame.new(0,-1.7,0.5) *  CFrame.fromEulerAnglesXYZ(math.pi/-4,0.2,-0.5))
	end
	Kick = false
	wait(0.15)
	TM.ResetWelds()
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	wait(0.1)
	local power = (Player.Character.HumanoidRootPart.CFrame *  CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
	power = power * Vector3.new(1, 0, 1)
	power = power + Vector3.new(0, 30, 0)
	local force = Player.Character["Right Leg"].CFrame.lookVector * 40
	local angle = Vector3.new(9e+009, 9e+009, 9e+009)
	TM.ApplyForce(hit, angle, power, "Right Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
		Plag.TriggerPlag(hit, 1)
	end
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	wait(0.1)
	local power = (Player.Character.HumanoidRootPart.CFrame *  CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
	power = power * Vector3.new(1, 0, 1)
	power = power + Vector3.new(0, 30, 0)
	local force = Player.Character["Left Leg"].CFrame.lookVector * 40
	local angle = Vector3.new(9e+009, 9e+009, 9e+009)
	TM.ApplyForce(hit, angle, power, "Left Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
		Plag.TriggerPlag(hit, 1)
	end
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
Kick = false
Equipped = false

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)


Mouse.Button2Down:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		local force = Player.Character["Right Leg"].CFrame.lookVector * 23.5
		local angle = Vector3.new(90000000000,100000,90000000000)
		Kick = false
		TM.ApplyForce(Ball, angle, force, "Right Leg")
		end
		
	else
		
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) *  CFrame.fromEulerAnglesXYZ(0.4,0,0))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		local force = Player.Character["Left Leg"].CFrame.lookVector * 23.5
		local angle = Vector3.new(90000000000,100000,90000000000)
		Kick = false
		TM.ApplyForce(Ball, angle, force, "Left Leg")
	end
	end
	Kick = true
	wait(0.25)
	TM.ResetWelds()
	Kick = false
	wait(0.1)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "EOS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 23.5
	local angle = Vector3.new(90000000000,100000,90000000000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
		Plag.TriggerPlag(hit, 1)
	end
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "EOS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 23.5
	local angle = Vector3.new(90000000000,100000,90000000000)
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
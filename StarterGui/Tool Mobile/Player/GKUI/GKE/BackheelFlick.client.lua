local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
local Tween = require(script.Parent.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))
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
	TM.EditWeld("Left Arm", CFrame.new(-1.8,0.3,0.1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0.5,-1))
	TM.EditWeld("Right Arm", CFrame.new(1.8,0.3,0.1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,-0.5,1))
	TM.EditWeld("Right Leg", CFrame.new(0.9,-1.7,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/8,-0.2,0.3))
	TM.EditWeld("Left Leg", CFrame.new(-0.9,-1.7,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/8,0.2,-0.3))
	Kick = true
	wait(1)
	TM.SetUsing(false)
	TM.ResetWelds()
	Kick = false
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Leg"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Leg"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Right Arm"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Arm")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Left Arm"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Arm")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Torso")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 30
	local angle = Vector3.new(400000,400000,400000)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Head")
	local Result = 1
	if Result == 1 and workspace.Configuration.Plag.Value == true then
	end
end)


function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

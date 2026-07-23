local TM = require(script.Parent.Parent.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = true

Tool = script.Parent
Player = game.Players.LocalPlayer

local PhysicsService = game:GetService("PhysicsService")
local Torso = Player.Character:FindFirstChild("Torso")
local Head = Player.Character:FindFirstChild("Head")

Tool.MouseButton1Down:connect(function()
	if Equipped == false then return end
	if TM.GetUsing() then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	PhysicsService:SetPartCollisionGroup(Torso, "Humans")
	PhysicsService:SetPartCollisionGroup(Head, "Humans")
	Kick = true
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,0.3,0))
		wait(0.15)
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0,0))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-1) *  CFrame.fromEulerAnglesXYZ(math.pi/6,-0.3,0))
		wait(0.15)
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) *  CFrame.fromEulerAnglesXYZ(-math.pi/4,0,0))
	end
	wait(0.1)
	TM.ResetWelds()
	Kick = false
	PhysicsService:SetPartCollisionGroup(Torso, "Colls")
	PhysicsService:SetPartCollisionGroup(Head, "Colls")
	wait(0.0)
	TM.SetUsing(false)
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if TM.check() == "L" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * -23.5
	local angle = Vector3.new(6e+006,1e+003,6e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Right Leg")
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if TM.check() == "R" then return end
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Torso"].CFrame.lookVector * -23.5
	local angle = Vector3.new(6e+006,1e+003,6e+006)
	Kick = false
	TM.ApplyForce(hit, angle, force, "Left Leg")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

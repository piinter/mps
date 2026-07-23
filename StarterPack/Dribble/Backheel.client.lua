local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
local Plag = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Plag"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()
local PhysicsService = game:GetService("PhysicsService")
local torsos = Player.Character:FindFirstChild("Torso")
local header = Player.Character:FindFirstChild("Head")

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

local function u8(p3)
	p3.Touched:Connect(function(hit)
		if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
		if hit.Name == "TPS" and hit.Anchored == false and Kick then
			Kick = false
			wait(.1)
	local force = -1
	local angle = Vector3.new(2800,10000,2800)
	TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), force, angle, true)
		end;
	end);
	p3.TouchEnded:Connect(function(hit)
		if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
		if hit.Name == "TPS" and hit.Anchored == false and Kick then
			Kick = false
				wait(.1)
	local force = -1
	local angle = Vector3.new(2800,10000,2800)
	TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), force, angle, true)
		end;
	end);
	for v26, hit in pairs(p3:GetTouchingParts()) do
		if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
		if hit.Name == "TPS" and hit.Anchored == false and Kick then
			Kick = false
				wait(.1)
	local force = -1
	local angle = Vector3.new(2800,10000,2800)
	TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), force, angle, true)
		end;
	end;
end;

Mouse.KeyDown:connect(function(key)
	if workspace.Configuration.Sombrero.Value == false then return end
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "h" then return end
	if Kick == true then return end
	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20
	PhysicsService:SetPartCollisionGroup(torsos, "Humans")
	PhysicsService:SetPartCollisionGroup(header, "Humans")
	if TM.check() == "R" then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,0.7) *  CFrame.fromEulerAnglesXYZ(-math.pi/6,0,0))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		Kick = false
		wait(.1)
		local p3 = Player.Character["Right Leg"]
		local force = -1
		local angle = Vector3.new(2800,10000,2800)
		TM.SombreroForce(Ball, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), force, angle, true)
	end
		u8(Player.Character["Right Leg"])
		
	else
		
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,0.7) *  CFrame.fromEulerAnglesXYZ(-math.pi/6,0,0))
	local Plagging = Plag.IsPlagging()
	local Result = Plagging[1]
	local Ball = Plagging[2]
	if Result == true and Ball ~= nil then
		Kick = false
		wait(.1)
		local p3 = Player.Character["Left Leg"]
		local force = -1
		local angle = Vector3.new(2800,10000,2800)
		TM.SombreroForce(Ball, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), force, angle, true)
	end
	u8(Player.Character["Left Leg"])
	end
	Kick = true
	wait(0.2)
	TM.ResetWelds()
	Kick = false
	wait(0.04)
	PhysicsService:SetPartCollisionGroup(torsos, "Colls")
	PhysicsService:SetPartCollisionGroup(header, "Colls")
	TM.SetUsing(false)
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

local RS = game:GetService("ReplicatedStorage")
local Event = RS:WaitForChild("EditLimb")
local Event2 = RS:WaitForChild("ResetWelds")
local Event3 = RS:WaitForChild("CatchBall")
local Event4 = RS:WaitForChild("DropBall")
local Event5 = RS:WaitForChild("ServerRemote")
local Event6 = RS:WaitForChild("Walkspeed")
local Event7 = RS:WaitForChild("Flying")
local Event8 = RS:WaitForChild("HumanoidExploit")
local Event9 = RS:WaitForChild("HopperbinExploit")
local Event10 = RS:WaitForChild("RemoteEventExploit")
local Event11 = RS:WaitForChild("Communication")
local Event12 = RS:WaitForChild("ApplyGKReact")
local Event14 = RS:WaitForChild("React")
local Event15 = RS:WaitForChild("ThrowBall")

-- Creio que esse script seja da idade das pedras
-- None of this sh.t of AC works at all  

bigfooted = false
walkspeeded = false
flew = false
humanoid = false
hopperbin = false
remoting = false

Event.OnServerEvent:connect(function(Player, Limb, CFrame0, CFrame1)
	Event:FireAllClients(Player, Limb, CFrame0, CFrame1)
end)

Event2.OnServerEvent:connect(function(Player)
	Event2:FireAllClients(Player)
end)

Event3.OnServerEvent:connect(function(Player, Ball, Dive)
	local RA = Player.Character:FindFirstChild("Right Arm")
	local b = Ball
	local glue = Instance.new("Weld")
	glue.Name = "handsOn"
	glue.Parent = RA
	glue.Part0 = RA
	glue.Part1 = b
	glue.C0 = CFrame.new(0, -0.5, -1.2)
end)

Event4.OnServerEvent:connect(function(Player)
	local RA = Player.Character:FindFirstChild("Right Arm")
	for _,v in pairs(RA:GetChildren()) do
		if v.Name == "handsOn" then
			v:Destroy()
		end
	end			
end)

Event5.OnServerEvent:Connect(function(player)
	if bigfooted == true then return end
	bigfooted = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Big-Footing.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Big-Footing.")
	wait(3)
	bigfooted = false
end)

Event6.OnServerEvent:Connect(function(player)
	if walkspeeded == true then return end
	walkspeeded = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Walkspeed Exploiting.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Walkspeed Exploiting.")
	wait(3)
	walkspeeded = false
end)

Event7.OnServerEvent:Connect(function(player)
	if flew == true then return end
	flew = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Fly Exploiting.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Fly Exploiting.")
	wait(3)
	flew = false
end)

Event8.OnServerEvent:Connect(function(player)
	if humanoid == true then return end
	humanoid = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Humanoid Exploiting.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Humanoid Exploiting.")
	wait(3)
	humanoid = false
end)

Event9.OnServerEvent:Connect(function(player)
	if hopperbin == true then return end
	hopperbin = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Tool Exploiting.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Tool Exploiting.")
	wait(3)
	hopperbin = false
end)

Event10.OnServerEvent:Connect(function(player)
	if remoting == true then return end
	remoting = true
	player:Kick("Kicked By MPS Anti-Cheat. Reason(s): Remote Event Altering.")
	game.ReplicatedStorage.MakeSystemMessage:FireAllClients("[MPS Anti-Cheat System]: "..player.Name.." has been kicked due to Remote Event Altering.")
	wait(3)
	remoting = false
end)

Event11.OnServerEvent:connect(function(player, args)
	local action = args[1]
	local ball   = args[2]
	local angle  = args[3]
	local power  = args[4]
	
	if action == "MoveCheck" then
			
			local Move = Instance.new("BodyVelocity", ball)
			Move.Velocity = power
			Move.MaxForce = angle
			
			game.Debris:AddItem(Move, 0.3)
		
	end
	
	
end)

Event12.OnServerEvent:Connect(function(player, data)
	local ball = data[1]
	local cframe = data[2]
	
	ball.CFrame = cframe
	
	local React = Instance.new("BodyVelocity", ball)
	React.Name = player.Name
	React.Velocity = player.Character["Torso"].CFrame.lookVector * 40 + Vector3.new(math.random(-50, 50), math.random(0, 40), 0)
	React.MaxForce = Vector3.new(4e+006,4e+006,4e+006)
	
	game.Debris:AddItem(React, 0.3)
end)

Event14.OnServerEvent:connect(function(player, ball, angle, power)
	if ball.Name == "TPS" then
		local React = Instance.new("BodyVelocity", ball)
		React.Name = player.Name
		React.Velocity = power
		React.MaxForce = angle
	
		game.Debris:AddItem(React, 0.3)
	end
end)

Event15.OnServerEvent:connect(function(Player, B, Power)
	local RA = Player.Character:WaitForChild("Right Arm")
	
	for i, v in pairs(RA:GetChildren()) do
		if v:IsA("Weld") then
			v:Remove()
		end
	end
	
	local BV = Instance.new("BodyVelocity", B)
	BV.Velocity = (Player.Character.HumanoidRootPart.CFrame *  CFrame.fromEulerAnglesXYZ(0.5,0,0)).lookVector * (Power * 1.06 * Vector3.new(1, 0, 1)) + Vector3.new(0, Power / 3.5, 0)
	BV.MaxForce = Vector3.new(400000000, 10000000, 400000000)
	
	game.Debris:AddItem(BV, 0.3)
end)

RS.Trip_Player.OnServerEvent:Connect(function(Player, Target)
	if Target:FindFirstChild("Torso") and Player.Character:FindFirstChild("Torso") then
		local Distance = (Player.Character.Torso.Position - Target.Torso.Position).Magnitude
		if Distance <= 25 then
			Target:WaitForChild("Humanoid").PlatformStand = true
			Target:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			Target:WaitForChild("Torso").RotVelocity = Vector3.new()
			wait(1.3)
			Target:WaitForChild("Humanoid").PlatformStand = false
			Target:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
			Target:WaitForChild("Humanoid"):ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
end)

RS.BallSound.OnServerEvent:Connect(function(Player, Ball)
	local ball = workspace.Balls.TPS
	
	
	
	RS.BallSound:FireAllClients({Player.Name, Ball})
end)

RS.Ankle.OnServerEvent:Connect(function(Player)
	local Overhead = game.Lighting.Ankles.Ankles:Clone()
	local Sound = game.Lighting.Ankles.SoundEffect:Clone()
	
	Overhead.Parent = Player.Character:WaitForChild("Head")
	Sound.Parent = workspace
	
	Sound:Play()
	
	game.Debris:AddItem(Overhead, 1)
	game.Debris:AddItem(Sound, 1)
end)

RS.VAR.VAR.OnServerEvent:Connect(function(Player, Ball, Position, GLT, Side, CF)
	for _, Table in pairs(game.ReplicatedStorage.VAR:GetChildren()) do
		if Table.Name == "TPS" then
			Table:Destroy()
		end
	end
	RS.VAR.GLT.Value = GLT
	RS.VAR.CF.Value = CF
	
	local BallClone = Ball:Clone()
	BallClone.Parent = RS.VAR
	BallClone.CFrame = Position
	for i, v in pairs(BallClone:GetChildren()) do
		v:Destroy()
	end
	BallClone.Anchored = true
	BallClone.Transparency = 0.5
	BallClone.CanCollide = false
	RS.VAR.Side.Value = Side
	BallClone.BrickColor = BrickColor.new("Bright red")
	
	game.Debris:AddItem(BallClone, 30)
end)

RS.Marker.OnServerEvent:Connect(function(...)
	RS.Marker:FireAllClients(...)
end)

local function Unpack(Character)
	local Directory = game.ReplicatedStorage.Storage
	local Template = Directory:FindFirstChild("Kit_Template")
	
	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("Accessory") then
			local a = v:Clone()
			Template.Humanoid:AddAccessory(a)
		end
		if v:IsA("Shirt") then
			v:Clone().Parent = Template
		end
		if v:IsA("Pants") then
			v:Clone().Parent = Template
		end
		if v:IsA("ShirtGraphic") then
			v:Clone().Parent = Template
		end
		if v:IsA("BodyColors") then
			v:Clone().Parent = Template
		end
		if v:IsA("Decal") and v.Name == "face" then
			Template.Head.face:Destroy()
			v:Clone().Parent = Template.Head
		end
		if v:IsA("SpecialMesh") then
			v:Clone().Parent = Template.Head
		else
			local Mesh = Instance.new("SpecialMesh", Template.Head)
			Mesh.MeshType = Enum.MeshType.Head
			Mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
		end
		if v:IsA("CharacterMesh") then
			v:Clone().Parent = Template
		end
	end
end

local Id = game.CreatorId
local Appearance = game.Players:GetCharacterAppearanceAsync(Id)

if Appearance ~= nil then
	Appearance.Parent = game.ReplicatedStorage
	Unpack(Appearance)
	game.Debris:AddItem(Appearance, 1)
end
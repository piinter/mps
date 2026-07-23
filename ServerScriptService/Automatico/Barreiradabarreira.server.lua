-- Script pessimo horrivel totalmente feito por IA 

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local PhysicsService = game:GetService("PhysicsService")

local FIXED_CHILD_TEXTURE = "rbxassetid://76726032336875"

local PENALTY_TEX_EMPTY = "rbxassetid://77527292534693" 
local PENALTY_TEX_FULL  = "rbxassetid://132201714069003" 

local activeBarriers = {} 

local homeConfig, awayConfig

task.spawn(function()
	local configFolder = Workspace:WaitForChild("Configuration", 5)
	if not configFolder then return end

	local kitConfigFolder = configFolder:WaitForChild("KitConfig", 5)
	if not kitConfigFolder then return end

	homeConfig = kitConfigFolder:WaitForChild("HomeLogo", 5)
	awayConfig = kitConfigFolder:WaitForChild("AwayLogo", 5)
end)

local function findMeshObject(part)
	if not part then return nil end
	if part:IsA("MeshPart") then return part end

	local namedMesh = part:FindFirstChild("Mesh")
	if namedMesh and namedMesh:IsA("SpecialMesh") then return namedMesh end

	for _, child in pairs(part:GetChildren()) do
		if child:IsA("SpecialMesh") then return child end
	end
	return nil
end

local function applyLogoTexture(rootPart)
	if not homeConfig or not awayConfig then task.wait(1) end
	if not homeConfig then return end

	task.spawn(function()
		local textureId = ""
		local configObject = nil
		local pName = rootPart.Name:lower() 

		if pName == "hko" or pName == "hko1" then
			configObject = homeConfig
		elseif pName == "ako" or pName == "ako1" then
			configObject = awayConfig
		end

		if not configObject then return end

		if configObject:IsA("StringValue") then
			textureId = configObject.Value
		else
			textureId = configObject.Texture
		end

		if textureId == "" then return end

		local mesh = findMeshObject(rootPart)
		if not mesh then
			for i = 1, 4 do
				task.wait(0.5)
				mesh = findMeshObject(rootPart)
				if mesh then break end
			end
		end

		if mesh then
			mesh.TextureId = textureId
		end
	end)
end

local function forceChildTexture(childPart)
	task.spawn(function()
		local mesh = findMeshObject(childPart)
		if not mesh then
			for i = 1, 5 do
				task.wait(0.4)
				mesh = findMeshObject(childPart)
				if mesh then break end
			end
		end
		if mesh then
			mesh.TextureId = FIXED_CHILD_TEXTURE
		end
	end)
end

local function pushPlayerOut(player, barrierPart)
	if not player.Character then return end
	local hrp = player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local barrierCFrame = barrierPart.CFrame
	local barrierSize = barrierPart.Size
	local relPos = barrierCFrame:PointToObjectSpace(hrp.Position)

	local size2 = barrierSize / 2

	local distToEdgeX = size2.X - math.abs(relPos.X)
	local distToEdgeZ = size2.Z - math.abs(relPos.Z)

	local exitVectorLocal = Vector3.new(0,0,0)
	local pushBuffer = 3.5 

	if distToEdgeX < distToEdgeZ then
		local direction = math.sign(relPos.X) 
		if direction == 0 then direction = 1 end
		exitVectorLocal = Vector3.new(direction * (size2.X + pushBuffer), relPos.Y, relPos.Z)
	else
		local direction = math.sign(relPos.Z)
		if direction == 0 then direction = 1 end
		exitVectorLocal = Vector3.new(relPos.X, relPos.Y, direction * (size2.Z + pushBuffer))
	end

	local worldExitPos = barrierCFrame:PointToWorldSpace(exitVectorLocal)
	hrp.CFrame = CFrame.new(worldExitPos) * hrp.CFrame.Rotation

	if hrp:FindFirstChild("AssemblyLinearVelocity") then
		hrp.AssemblyLinearVelocity = Vector3.zero
	end
end

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include
overlapParams.MaxParts = 50

RunService.Heartbeat:Connect(function()
	local characters = {}
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Character then table.insert(characters, plr.Character) end
	end
	overlapParams.FilterDescendantsInstances = characters

	for i = #activeBarriers, 1, -1 do
		local barrierData = activeBarriers[i]
		local hitbox = barrierData.Hitbox
		local root = barrierData.Root
		local barrierTeam = barrierData.Team

		local isPenalty = false
		if root and (root.Name:lower() == "apk" or root.Name:lower() == "hpk") then
			isPenalty = true
		end

		local shouldRemove = false

		if not root or not root.Parent then shouldRemove = true end
		if not hitbox or not hitbox.Parent then shouldRemove = true end
		if root and not root:IsDescendantOf(Workspace) then shouldRemove = true end
		if root and root:IsA("BasePart") and root.Transparency > 0.9 then shouldRemove = true end

		if shouldRemove then
			if hitbox and hitbox.Parent then hitbox:Destroy() end
			table.remove(activeBarriers, i)
			continue 
		end

		local partsInZone = Workspace:GetPartsInPart(hitbox, overlapParams)

		local uniquePlayersInZone = {}
		for _, part in pairs(partsInZone) do
			local model = part.Parent
			if model then
				local player = Players:GetPlayerFromCharacter(model)
				if player and not uniquePlayersInZone[player] then
					uniquePlayersInZone[player] = true
				end
			end
		end

		local attackerCount = 0

		for player, _ in pairs(uniquePlayersInZone) do
			if player and player.Team then
				local pTeam = player.Team.Name
				local isAllowed = false
				local isAttacker = false 

				if isPenalty then
					if pTeam == "-Home GK" or pTeam == "-Away GK" then
						isAllowed = true 
						isAttacker = false 
					end
				end

				if not isAllowed then

					if isPenalty then
						if barrierTeam == "Home" then
							if pTeam == "Away" or pTeam == "sAway" then 
								isAllowed = true 
								isAttacker = true
							end
						elseif barrierTeam == "Away" then
							if pTeam == "Home" or pTeam == "sHome" then 
								isAllowed = true 
								isAttacker = true
							end
						end

					else
						if barrierTeam == "Home" then
							if pTeam == "Home" or pTeam == "-Home GK" or pTeam == "sHome" then 
								isAllowed = true 
							end
						elseif barrierTeam == "Away" then
							if pTeam == "Away" or pTeam == "-Away GK" or pTeam == "sAway" then 
								isAllowed = true 
							end
						end
					end

					if isPenalty and isAllowed and isAttacker then
						attackerCount = attackerCount + 1
						if attackerCount > 1 then
							isAllowed = false 
						end
					end
				end

				if not isAllowed then
					pushPlayerOut(player, hitbox)
				end
			end
		end

		if isPenalty then
			local mesh = findMeshObject(root)
			if mesh then
				if attackerCount >= 1 then
					if mesh.TextureId ~= PENALTY_TEX_FULL then mesh.TextureId = PENALTY_TEX_FULL end
				else
					if mesh.TextureId ~= PENALTY_TEX_EMPTY then mesh.TextureId = PENALTY_TEX_EMPTY end
				end
			end
		end
	end
end)

local function createBarrierForPart(rootOfGroup, partToCopy, teamType)
	if not partToCopy or not partToCopy:IsA("BasePart") then return end

	local hitboxName = partToCopy.Name .. "_Hitbox"
	local existingHitbox = rootOfGroup:FindFirstChild(hitboxName)

	if existingHitbox then
		existingHitbox.CanCollide = false
		existingHitbox.CanTouch = false 
		existingHitbox.CanQuery = true 
		partToCopy.CanCollide = false

		local found = false
		for _, b in pairs(activeBarriers) do 
			if b.Hitbox == existingHitbox then found = true end 
		end
		if not found then
			table.insert(activeBarriers, {Hitbox = existingHitbox, Root = rootOfGroup, Team = teamType})
		end
		return
	end

	local hitbox = Instance.new("Part")
	hitbox.Name = hitboxName
	hitbox.Transparency = 1 

	hitbox.CanCollide = false 
	hitbox.CanTouch = false   
	hitbox.CanQuery = true    
	hitbox.Anchored = true
	hitbox.CastShadow = false

	hitbox.CFrame = partToCopy.CFrame
	hitbox.Size = Vector3.new(partToCopy.Size.X, partToCopy.Size.Y, 500) 

	hitbox.Parent = rootOfGroup 
	partToCopy.CanCollide = false

	table.insert(activeBarriers, {Hitbox = hitbox, Root = rootOfGroup, Team = teamType})
end

local BarreirasFolder = Workspace:FindFirstChild("Barreiras")
if not BarreirasFolder then
	BarreirasFolder = Instance.new("Folder")
	BarreirasFolder.Name = "Barreiras"
	BarreirasFolder.Parent = Workspace
end

local function processBarrier(rootPart)
	if not rootPart:IsA("BasePart") and not rootPart:IsA("Model") then return end

	local name = rootPart.Name:lower()
	local initial = name:sub(1, 1)
	local isCorner = (name:find("cr") or name:find("cl")) ~= nil

	local teamType = nil

	if initial == "a" then 
		if isCorner then teamType = "Home" else teamType = "Away" end
	elseif initial == "h" then 
		if isCorner then teamType = "Away" else teamType = "Home" end
	end

	if not teamType then return end

	applyLogoTexture(rootPart)

	if rootPart:IsA("BasePart") then
		createBarrierForPart(rootPart, rootPart, teamType)
	end

	local childPart = rootPart:FindFirstChild("part") or rootPart:FindFirstChild("Part")
	if childPart and childPart:IsA("BasePart") then
		createBarrierForPart(rootPart, childPart, teamType)
		forceChildTexture(childPart)
	end
end

BarreirasFolder.ChildAdded:Connect(processBarrier)
for _, child in pairs(BarreirasFolder:GetChildren()) do processBarrier(child) end

BarreirasFolder.ChildRemoved:Connect(function(child)
	for i = #activeBarriers, 1, -1 do
		if activeBarriers[i].Root == child then
			if activeBarriers[i].Hitbox then activeBarriers[i].Hitbox:Destroy() end
			table.remove(activeBarriers, i)
		end
	end
end)

task.spawn(function()
	task.wait(2)
	local function bindConfig(config, validNames)
		if not config then return end
		local signal = config:IsA("StringValue") and config:GetPropertyChangedSignal("Value") or config:GetPropertyChangedSignal("Texture")
		signal:Connect(function()
			if Workspace:FindFirstChild("Barreiras") then
				for _, name in pairs(validNames) do
					local root = Workspace.Barreiras:FindFirstChild(name)
					if root then applyLogoTexture(root) end
				end
			end
		end)
	end
	bindConfig(homeConfig, {"hko", "hko1"})
	bindConfig(awayConfig, {"ako", "ako1"})
end)

local GROUP_BALL = "Ball"
pcall(function() PhysicsService:RegisterCollisionGroup(GROUP_BALL) end)
PhysicsService:CollisionGroupSetCollidable(GROUP_BALL, "Colls", true)

local BallsFolder = Workspace:WaitForChild("Balls", 5)

local function setupBall(ball)
	if not ball:IsA("BasePart") and not ball:IsA("Model") then return end
	for _, part in pairs(ball:GetDescendants()) do
		if part:IsA("BasePart") then part.CollisionGroup = GROUP_BALL end
	end
	if ball:IsA("BasePart") then ball.CollisionGroup = GROUP_BALL end

	ball.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") then descendant.CollisionGroup = GROUP_BALL end
	end)
end

if BallsFolder then
	for _, ball in pairs(BallsFolder:GetChildren()) do setupBall(ball) end
	BallsFolder.ChildAdded:Connect(setupBall)
end
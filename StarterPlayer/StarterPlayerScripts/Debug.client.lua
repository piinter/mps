task.wait(5)

local RStorage = game:GetService("ReplicatedStorage")
--local ReactDebug = RStorage.NetworkFolder.NetworkRemotes:WaitForChild("ReactDebug")
local GoalkeepDebug = RStorage.NetworkFolder.NetworkRemotes:WaitForChild("GoalkeepDebug")

local Player = game:GetService("Players").LocalPlayer
local StarterPack = Player.Backpack
local PlayerGui = Player.PlayerGui
local TM = require(StarterPack:WaitForChild("ToolManagment"))

local InputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Data = Player:WaitForChild("PlayerData")
local SettingDataHolder2 = Data.Settings:WaitForChild("GoalkeepDebug")

local Info = TweenInfo.new(
	2.5, -- Length
	Enum.EasingStyle.Quint, -- Easing Style
	Enum.EasingDirection.Out, -- Easing Direction
	0, -- Times repeated
	false, -- Reverse
	2.5 -- Delay
)

local Goals =
	{
		Transparency = 1;
	}

local TextGoals =
	{
		TextTransparency = 1;
	}

GoalkeepDebug.OnClientEvent:Connect(function(BallPosition, BodyPartsPosition, BodyPartsOrientation, ReactedLimb)
	if SettingDataHolder2.Value == true then
		local Position_RA = BodyPartsPosition[1]
		local Position_LA = BodyPartsPosition[2]
		local Position_RL = BodyPartsPosition[3]
		local Position_LL = BodyPartsPosition[4]
		local Position_Torso = BodyPartsPosition[5]
		local Position_Head = BodyPartsPosition[6]

		local Orientation_RA = BodyPartsOrientation[1]
		local Orientation_LA = BodyPartsOrientation[2]
		local Orientation_RL = BodyPartsOrientation[3]
		local Orientation_LL = BodyPartsOrientation[4]
		local Orientation_Torso = BodyPartsOrientation[5]
		local Orientation_Head = BodyPartsOrientation[6]

		local ReactHit = Instance.new("Part")
		ReactHit.Anchored = true
		ReactHit.Shape = "0"
		ReactHit.Size = Vector3.new(0.35, 0.35, 0.35)
		ReactHit.Color = Color3.new(92/255, 240/255, 0)
		ReactHit.CanCollide = false
		ReactHit.Parent = workspace
		ReactHit.CFrame = CFrame.new(BallPosition)

		local RA_Debug = Instance.new("Part")
		RA_Debug.Anchored = true
		RA_Debug.Size = Vector3.new(1, 2, 1)
		RA_Debug.Color = Color3.new(1, 1, 1)
		RA_Debug.Transparency = 0.75
		RA_Debug.CanCollide = false
		RA_Debug.Parent = workspace
		RA_Debug.Orientation = Orientation_RA
		RA_Debug.Position = Position_RA

		local LA_Debug = Instance.new("Part")
		LA_Debug.Anchored = true
		LA_Debug.Size = Vector3.new(1, 2, 1)
		LA_Debug.Color = Color3.new(1, 1, 1)
		LA_Debug.Transparency = 0.75
		LA_Debug.CanCollide = false
		LA_Debug.Parent = workspace
		LA_Debug.Orientation = Orientation_LA
		LA_Debug.Position = Position_LA

		local RL_Debug = Instance.new("Part")
		RL_Debug.Anchored = true
		RL_Debug.Size = Vector3.new(1, 2, 1)
		RL_Debug.Color = Color3.new(1, 1, 1)
		RL_Debug.Transparency = 0.75
		RL_Debug.CanCollide = false
		RL_Debug.Parent = workspace
		RL_Debug.Orientation = Orientation_RL
		RL_Debug.Position = Position_RL

		local LL_Debug = Instance.new("Part")
		LL_Debug.Anchored = true
		LL_Debug.Size = Vector3.new(1, 2, 1)
		LL_Debug.Color = Color3.new(1, 1, 1)
		LL_Debug.Transparency = 0.75
		LL_Debug.CanCollide = false
		LL_Debug.Parent = workspace
		LL_Debug.Orientation = Orientation_LL
		LL_Debug.Position = Position_LL

		local Torso_Debug = Instance.new("Part")
		Torso_Debug.Anchored = true
		Torso_Debug.Size = Vector3.new(2, 2, 1)
		Torso_Debug.Color = Color3.new(1, 1, 1)
		Torso_Debug.Transparency = 0.75
		Torso_Debug.CanCollide = false
		Torso_Debug.Parent = workspace
		Torso_Debug.Orientation = Orientation_Torso
		Torso_Debug.Position = Position_Torso	

		local Head_Debug = Instance.new("Part")
		local Head_Mesh = Instance.new("SpecialMesh")
		Head_Debug.Anchored = true
		Head_Debug.Size = Vector3.new(2, 1, 1)
		Head_Debug.Color = Color3.new(1, 1, 1)
		Head_Debug.Transparency = 0.75
		Head_Debug.CanCollide = false
		Head_Debug.Parent = workspace
		Head_Debug.Orientation = Orientation_Head
		Head_Debug.Position = Position_Head

		Head_Mesh.Parent = Head_Debug
		Head_Mesh.Scale = Vector3.new(1.25, 1.25, 1.25)

		if ReactedLimb == "Right Arm" then
			RA_Debug.Color = Color3.new(1, 0, 0)
		elseif ReactedLimb == "Left Arm" then
			LA_Debug.Color = Color3.new(1, 0, 0)
		elseif ReactedLimb == "Right Leg" then
			RL_Debug.Color = Color3.new(1, 0, 0)
		elseif ReactedLimb == "Left Leg" then
			LL_Debug.Color = Color3.new(1, 0, 0)
		elseif ReactedLimb == "Torso" then
			Torso_Debug.Color = Color3.new(1, 0, 0)
		elseif ReactedLimb == "Head" then
			Head_Debug.Color = Color3.new(1, 0, 0)
		end

		TweenService:Create(ReactHit,Info,Goals):Play()
		game.Debris:AddItem(ReactHit, 5)

		TweenService:Create(RA_Debug,Info,Goals):Play()
		game.Debris:AddItem(RA_Debug, 5)

		TweenService:Create(LA_Debug,Info,Goals):Play()
		game.Debris:AddItem(LA_Debug, 5)

		TweenService:Create(RL_Debug,Info,Goals):Play()
		game.Debris:AddItem(RL_Debug, 5)

		TweenService:Create(LL_Debug,Info,Goals):Play()
		game.Debris:AddItem(LL_Debug, 5)

		TweenService:Create(Torso_Debug,Info,Goals):Play()
		game.Debris:AddItem(Torso_Debug, 5)

		TweenService:Create(Head_Debug,Info,Goals):Play()
		game.Debris:AddItem(Head_Debug, 5)

		game.Debris:AddItem(Head_Mesh, 5)
	end
end)

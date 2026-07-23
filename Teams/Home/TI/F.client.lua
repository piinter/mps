local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local CooldownTime = 1.0 
local WalkSpeedFix = 20
local CatchAnimationDuration = 0.35

local Kick = false
local Equipped = false
local Using = nil
local Catching = false
local LastUseTime = 0 

local Tool = script.Parent
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

repeat task.wait() until Player.Character and Player.Character:FindFirstChild("Humanoid")
local Humanoid = Player.Character.Humanoid

local HoldingAnim = Instance.new("Animation")
HoldingAnim.AnimationId = "rbxassetid://89290464188121"
local HoldingPlay = Humanoid:LoadAnimation(HoldingAnim)
HoldingPlay.Priority = Enum.AnimationPriority.Action

task.spawn(function()
	local playerShopData = Player:WaitForChild("ShopData", 5)
	if playerShopData then
		local equippedHoldId = playerShopData:WaitForChild("EquippedBallHoldId")

		HoldingAnim.AnimationId = equippedHoldId.Value
		HoldingPlay = Humanoid:LoadAnimation(HoldingAnim)
		HoldingPlay.Priority = Enum.AnimationPriority.Action

		equippedHoldId:GetPropertyChangedSignal("Value"):Connect(function()
			local wasPlaying = HoldingPlay.IsPlaying
			if wasPlaying then 
				HoldingPlay:Stop() 
			end

			HoldingAnim.AnimationId = equippedHoldId.Value
			HoldingPlay = Humanoid:LoadAnimation(HoldingAnim)
			HoldingPlay.Priority = Enum.AnimationPriority.Action

			if wasPlaying then 
				HoldingPlay:Play(0.2) 
			end
		end)
	end
end)

local HighTorsoAndHead = Instance.new("Animation")
HighTorsoAndHead.AnimationId = "rbxassetid://76137637923250"
local HighPlayTorsoAndHead = Humanoid:LoadAnimation(HighTorsoAndHead)

local HighHands = Instance.new("Animation")
HighHands.AnimationId = "rbxassetid://116269987260499"
local HighPlayHands = Humanoid:LoadAnimation(HighHands)

local LowTorsoAndHead = Instance.new("Animation")
LowTorsoAndHead.AnimationId = "rbxassetid://134101797422442"
local LowPlayTorsoAndHead = Humanoid:LoadAnimation(LowTorsoAndHead)

local LowHands = Instance.new("Animation")
LowHands.AnimationId = "rbxassetid://100998190981405"
local LowPlayHands = Humanoid:LoadAnimation(LowHands)

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
	Using = nil
	Kick = false
	Catching = false
	StopAllCatchAnims()
	if HoldingPlay then HoldingPlay:Stop() end
end)

function StartCatch(type)
	if not Equipped then return end
	if tick() - LastUseTime < CooldownTime then return end 
	if TM.getHoldingBall() or TM.GetUsing() then return end

	LastUseTime = tick() 
	Using = type
	Kick = true
	Catching = true
	TM.SetUsing(true)

	StopAllCatchAnims()

	if type == "High" then
		HighPlayHands:Play(0.1)
		HighPlayTorsoAndHead:Play(0.1)
	else
		LowPlayHands:Play(0.1)
		LowPlayTorsoAndHead:Play(0.1)
	end

	CheckImmediateTouch()

	task.delay(CatchAnimationDuration, function()
		Catching = false 
	end)

	task.wait(0.55)

	StopAllCatchAnims(0.2)
	Using = nil
	Kick = false
	TM.SetUsing(false)
end

Mouse.KeyDown:connect(function(key)
	if key == "r" then StartCatch("High")
	elseif key == "f" then StartCatch("Low") end
end)

function CheckImmediateTouch()
	if Player.Character:FindFirstChild("Right Arm") then
		for _,v in ipairs(Player.Character["Right Arm"]:GetTouchingParts()) do
			if v.Name == "TPS" then RA_React(v) break end
		end
	end
	if Player.Character:FindFirstChild("Left Arm") then
		for _,v in ipairs(Player.Character["Left Arm"]:GetTouchingParts()) do
			if v.Name == "TPS" then LA_React(v) break end
		end
	end
end

function RA_React(hit)
	if hit.Name == "TPS" and Kick then
		Kick = false
		local catchType = (Using == "High") and "High Catch" or "Low Catch"
		TM.attachBall(hit, "Right Arm", catchType, false)
	end
end

function LA_React(hit)
	if hit.Name == "TPS" and Kick then
		Kick = false
		local catchType = (Using == "High") and "High Catch" or "Low Catch"
		TM.attachBall(hit, "Left Arm", catchType, false)
	end
end

function StopAllCatchAnims(fade)
	fade = fade or 0.1
	HighPlayHands:Stop(fade)
	HighPlayTorsoAndHead:Stop(fade)
	LowPlayHands:Stop(fade)
	LowPlayTorsoAndHead:Stop(fade)
end

RunService.RenderStepped:Connect(function()
	if not Equipped then return end

	if Humanoid.WalkSpeed < WalkSpeedFix then
		Humanoid.WalkSpeed = WalkSpeedFix
	end

	if TM.getHoldingBall() then
		if not Catching then
			if not HoldingPlay.IsPlaying then
				HoldingPlay:Play(0.2)
			end
			StopAllCatchAnims(0.2)
		end
	else
		if HoldingPlay.IsPlaying then
			HoldingPlay:Stop(0.1)
		end
	end
end)

if Player.Character:FindFirstChild("Right Arm") then
	Player.Character["Right Arm"].Touched:Connect(RA_React)
end
if Player.Character:FindFirstChild("Left Arm") then
	Player.Character["Left Arm"].Touched:Connect(LA_React)
end
local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
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

local Tween = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))

local Direction = Enum.EasingDirection.Out
local Style = Enum.EasingStyle.Sine
local Duration = 0.4
local CFRAME_HERE = CFrame.new(0,1.5,0.25) *  CFrame.fromEulerAnglesXYZ(math.pi/8,0,0)
local HeadR = CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/10,-1,0)
local HeadL = CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/10,1,0)
local CFRAME_HERE_2 = CFrame.new(0,1.5,-0.5) *  CFrame.fromEulerAnglesXYZ(-math.pi/8,0,0)

local T = false
local R = false

local Changing = false

local NewCframe = nil

Mouse.KeyDown:connect(function(key)
	if Equipped == false then return end
	if TM.GetUsing() then return end
	if key ~= "q" then return end
	TM.SetUsing(true)
	Tween.TweenWeld("Head", CFrame.new(0,1.5,0), CFRAME_HERE, Direction, Style, Duration)
	Kick = true
	Player.Character["Head"].CollisionGroupId = 2
	Changing = true
	wait(0.2)
	Changing = false
	if T == false and R == false then
		Tween.TweenWeld("Head", CFRAME_HERE, CFRAME_HERE_2, Direction, Enum.EasingStyle.Back, Duration)
		NewCframe = CFRAME_HERE_2
	elseif T == true then
		Tween.TweenWeld("Head", CFRAME_HERE, HeadR, Direction, Enum.EasingStyle.Back, Duration)
		NewCframe = HeadR
	elseif R == true then
		Tween.TweenWeld("Head", CFRAME_HERE, HeadL, Direction, Enum.EasingStyle.Back, Duration)
		NewCframe = HeadL
	end
	wait(0.5)
	Player.Character["Head"].CollisionGroupId = 0
	Tween.TweenWeld("Head", NewCframe, CFrame.new(0,1.5,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, Duration-0.1)
	Kick = false
	wait(0.2)
	T = false
	R = false
	TM.ResetWelds()
	TM.SetUsing(false)
end)

Mouse.KeyDown:connect(function(key)
	if Changing == false then
		return
	end
	if key == "t" then
		T = true
	elseif key == "r" then
		R = true
	end
end)

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	local force = Player.Character["Head"].CFrame.lookVector * 90
	local angle = Vector3.new(math.huge,2e+001,math.huge)
	Kick = false
 
	TM.ApplyForce(hit, angle, force, "Head")
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end

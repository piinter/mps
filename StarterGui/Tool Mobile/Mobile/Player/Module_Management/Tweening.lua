local Tween = {}

local player = game.Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
    character = player.CharacterAdded:wait()
end
local Torso = character:WaitForChild("Torso")
local Head = character:WaitForChild("Head")
local RA = character:WaitForChild("Right Arm")
local LA = character:WaitForChild("Left Arm")
local RL = character:WaitForChild("Right Leg")
local LL = character:WaitForChild("Left Leg")

function Tween.TweenWeld(TargetLimb, StartCFrame, CFrame0, EasingDirection, EasingStyle, Duration)
	game.ReplicatedStorage.EditLimb:FireServer(TargetLimb, CFrame0)	
	local TweenService = game:GetService("TweenService")
	local weldExists = false
	local weld = nil
	local appendiges = {RA, LA, RL, LL, Head}
	local correspondingJoints = {Torso:FindFirstChild("Right Shoulder"), Torso:FindFirstChild("Left Shoulder"), Torso:FindFirstChild("Right Hip"), Torso:FindFirstChild("Left Hip"), Torso:FindFirstChild("Neck")}
	
	local EndCFrame = {}
	EndCFrame.C0 = CFrame0
	
	local Info = TweenInfo.new(
	Duration,
	EasingStyle,
	EasingDirection
	)
	
	for _,v in pairs(Torso:GetChildren()) do
		if v.Name == "Weld" and v.Part1.Name == TargetLimb then
			weldExists = true
			weld = v
		end
	end

	if not weldExists then
		weld = Instance.new("Weld")
	end 
	
	for i,v in pairs(appendiges) do
		if TargetLimb == v.Name then
			correspondingJoints[i].Part1 = nil
			
			weld.Parent = Torso
			weld.Part0 = Torso
			weld.Part1 = v
			weld.C0 = StartCFrame
			local Animation = TweenService:Create(weld, Info, EndCFrame)
			Animation:Play()
		end
	end
end

return Tween
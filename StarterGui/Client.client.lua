local RS = game:GetService("ReplicatedStorage")
local Event = RS:WaitForChild("EditLimb")
local Event2 = RS:WaitForChild("ResetWelds")
local Teams  = game:GetService("Teams")
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
local Using = false

Event.OnClientEvent:connect(function(Player, Limb, CFrame0, CFrame1)
	if Player ~= player then
		EditWeld(Player, Limb, CFrame0, CFrame1)
	end
end)

Event2.OnClientEvent:connect(function(Player)
	if Player ~= player then
		ResetWelds(Player)
	end
end)

game.ReplicatedStorage.BallSound.OnClientEvent:Connect(function(data)
	local name = data[1]
	local ball = data[2]

	if name == game.Players.LocalPlayer.Name then return end
	ball.Sound:Play()
end)




















function EditWeld(p, limb, frame0, frame1)
	local Torso = p.Character:FindFirstChild("Torso")
	local RA = p.Character:FindFirstChild("Right Arm")
	local LA = p.Character:FindFirstChild("Left Arm")
	local RL = p.Character:FindFirstChild("Right Leg")
	local LL = p.Character:FindFirstChild("Left Leg")
	local Head = p.Character:FindFirstChild("Head")

	local weldExists = false
	local weld = nil
	local appendiges = {RA, LA, RL, LL, Head}
	local correspondingJoints = {
		Torso:FindFirstChild("Right Shoulder"),
		Torso:FindFirstChild("Left Shoulder"),
		Torso:FindFirstChild("Right Hip"),
		Torso:FindFirstChild("Left Hip"),
		Torso:FindFirstChild("Neck")
	}

	-- seeing if the limb you want to edit already has a weld keeping it in place
	for _,v in pairs(Torso:GetChildren()) do
		if v.Name == "Weld" and v.Part1.Name == limb then
			weldExists = true
			weld = v
		end
	end

	-- if no weld, make one
	if not weldExists then
		weld = Instance.new("Weld")
	end 

	-- edit the limb
	for i,v in pairs(appendiges) do
		if limb == v.Name then
			if correspondingJoints[i] == nil then repeat wait() until correspondingJoints[i] end
			correspondingJoints[i].Part1 = nil

			weld.Parent = Torso
			weld.Part0 = Torso
			weld.Part1 = v
			weld.C0 = frame0
			if frame1 ~= nil then
				weld.C1 = frame1
			end
		end
	end	
end

function ResetWelds(p)
	local Torso = p.Character:FindFirstChild("Torso")
	local RA = p.Character:FindFirstChild("Right Arm")
	local LA = p.Character:FindFirstChild("Left Arm")
	local RL = p.Character:FindFirstChild("Right Leg")
	local LL = p.Character:FindFirstChild("Left Leg")
	local Head = p.Character:FindFirstChild("Head")
	for _,v in pairs(Torso:GetChildren()) do
		if v:IsA("Weld") then
			v:Destroy()
		end
	end

	local leftShoulder = Torso:FindFirstChild("Left Shoulder")
	local rightShoulder = Torso:FindFirstChild("Right Shoulder")
	local leftHip = Torso:FindFirstChild("Left Hip")
	local rightHip = Torso:FindFirstChild("Right Hip")
	local neck = Torso:FindFirstChild("Neck")

	local joints = {leftShoulder, rightShoulder, leftHip, rightHip, neck}
	local correspondingLimbs = {LA, RA, LL, RL, Head}

	for i,v in pairs(joints) do
		if v == nil then repeat wait() until v end
		v.Part1 = correspondingLimbs[i]
	end	

end



local Plag = {}


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

local Plagging = false
local Ball = nil

function Plag.TriggerPlag(B, Duration)
	Plagging = true
	Ball = B
	if Duration ~= nil then
		wait(Duration)
	else
		wait(1)
	end
	Plagging = false
	Ball = nil
end

function Plag.Disable()
	Plagging = false
	Ball = nil
end

function Plag.IsPlagging()
	return {Plagging, Ball}
	end


return Plag
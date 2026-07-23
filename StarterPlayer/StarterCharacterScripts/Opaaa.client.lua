-- 2a parte do anti cheat que fiz la q funciona um pouco

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerUpdate = ReplicatedStorage:WaitForChild("PlayerUpdate")
local Character = script.Parent

local Sizes = {
	["Right Leg"] = Vector3.new(1, 2, 1),
	["Left Leg"] = Vector3.new(1, 2, 1),
	["Right Arm"] = Vector3.new(1, 2, 1),
	["Left Arm"] = Vector3.new(1, 2, 1),
	["Head"] = Vector3.new(2, 1, 1),
	["Torso"] = Vector3.new(2, 2, 1)
}

local Kicked = false
local TempoUltimoAviso = 0

RunService.RenderStepped:Connect(function()
	if Kicked then return end

	for partName, expectedSize in pairs(Sizes) do
		local part = Character:FindFirstChild(partName)
		if part and part:IsA("Part") then
			if part.Size ~= expectedSize then
				Kicked = true
				PlayerUpdate:FireServer("TamanhoAlterado")
			end
		end
	end

	local tempoAtual = os.clock()
	if tempoAtual - TempoUltimoAviso >= 3 then
		TempoUltimoAviso = tempoAtual
		PlayerUpdate:FireServer("EstouVivo")
	end
end)
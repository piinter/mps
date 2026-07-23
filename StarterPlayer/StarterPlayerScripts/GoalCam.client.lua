local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Event = RS:WaitForChild("FocusCamera")

local function focusOnPlayer(playerName, duration)
	duration = duration or 5

	local target = Players:FindFirstChild(playerName)
	if not target then return end

	-- Espera o personagem e o Humanoid carregarem
	local character = target.Character or target.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	-- 1. Salva o estado atual para retornar depois
	local oldSubject = Camera.CameraSubject
	local oldType = Camera.CameraType

	-- 2. Altera o foco da câmera para o jogador alvo
	-- Usamos 'Custom' para que o mouse/analógico ainda consiga girar a câmera
	Camera.CameraSubject = humanoid
	Camera.CameraType = Enum.CameraType.Custom

	-- 3. Espera o tempo determinado
	task.delay(duration, function()
		-- Retorna a câmera para o jogador local (se ele ainda existir)
		if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
			Camera.CameraSubject = localPlayer.Character.Humanoid
		else
			Camera.CameraSubject = oldSubject
		end
		Camera.CameraType = oldType
	end)
end

Event.OnClientEvent:Connect(function(playerName)
	focusOnPlayer(playerName, 5)
end)
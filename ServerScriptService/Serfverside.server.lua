-- Tentativa horrivel de anti cheat
-- Funciona mas eh bem bugado e facilmente bypassavel, mas da pra usar como base para algo melhor

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerUpdate = ReplicatedStorage:FindFirstChild("PlayerUpdate")

if not PlayerUpdate then
	PlayerUpdate = Instance.new("RemoteEvent")
	PlayerUpdate.Name = "PlayerUpdate"
	PlayerUpdate.Parent = ReplicatedStorage
end

local UltimoSinal = {}
local ContagemSinal = {}

PlayerUpdate.OnServerEvent:Connect(function(player, action)
	local tempoAtual = os.clock()

	if not ContagemSinal[player] then
		ContagemSinal[player] = 0
	end

	ContagemSinal[player] = ContagemSinal[player] + 1

	if ContagemSinal[player] > 10 then
		player:Kick("Problema de rede detectada. (Spam/Lag Exploiting)")
		return
	end

	if action == "TamanhoAlterado" then
		player:Kick("Modificacao ilegal no personagem detectada.")
	elseif action == "EstouVivo" then
		UltimoSinal[player] = tempoAtual
	end
end)

Players.PlayerRemoving:Connect(function(player)
	UltimoSinal[player] = nil
	ContagemSinal[player] = nil
end)

task.spawn(function()
	while task.wait(1) do
		for _, player in ipairs(Players:GetPlayers()) do
			ContagemSinal[player] = 0
		end
	end
end)

task.spawn(function()
	while task.wait(5) do
		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			if character and character:FindFirstChild("HumanoidRootPart") then
				local tempoSinal = UltimoSinal[player]

				if tempoSinal then
					if os.clock() - tempoSinal > 15 then
						player:Kick("Desconexao de seguranca. Script vital desligado.")
					end
				else
					UltimoSinal[player] = os.clock()
				end
			end
		end
	end
end)
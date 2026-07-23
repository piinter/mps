repeat task.wait() until game:IsLoaded()

local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local InputField = script.Parent

-- 1. CONEXÃO
local Pasta = Rep:WaitForChild("__Eventos")
local RF = Pasta:WaitForChild("Function")

-- 2. CONFIGURAÇÕES
local CHAVE_DADOS = "PitchColourR"

-- CAMINHO (Verifique se está correto no seu jogo)
local CAMPO = Workspace:WaitForChild("Campo", 10)
local GRAMA = CAMPO and CAMPO:WaitForChild("Grama", 10)

if not GRAMA then 
	warn("ERRO CRÍTICO: Não achei Workspace.Campo.Grama!") 
	InputField.Text = "ERR"
	return 
end

-- ==========================================================
-- LÓGICA
-- ==========================================================
local function atualizarCor(valorInput, salvar)
	if not valorInput then return end

	-- Segurança: Garante que é entre 0 e 255
	local R = math.clamp(math.floor(valorInput), 0, 255)

	-- Lê a cor atual da grama para manter o Verde e o Azul
	local atualG = math.floor(GRAMA.Color.G * 255)
	local atualB = math.floor(GRAMA.Color.B * 255)

	-- Cria a nova cor
	local novaCor = Color3.fromRGB(R, atualG, atualB)

	-- Aplica na Grama principal
	GRAMA.Color = novaCor

	-- Aplica em TODOS os pastos do jogo
	for _, descendant in Workspace:GetDescendants() do
		if descendant:IsA("BasePart") then
			local nome = string.lower(descendant.Name)
			if nome:find("grama") or nome:find("pasto") or nome:find("grass") or nome:find("lawn") then
				descendant.Color = novaCor
			end
		end
	end

	-- Aplica nas Laterais (se existirem)
	local sides = Workspace:FindFirstChild("Pitch") and Workspace.Pitch:FindFirstChild("Sides")
	if sides then
		for _, v in pairs(sides:GetChildren()) do
			if v:IsA("BasePart") then v.Color = novaCor end
		end
	end

	-- Atualiza o texto da caixa (para corrigir números malucos tipo 32434)
	InputField.Text = tostring(R)

	-- Salva
	if salvar then
		print("Salvando R:", R)
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, R})
		end)
	end
end

-- ==========================================================
-- EVENTOS
-- ==========================================================
InputField.FocusLost:Connect(function()
	local num = tonumber(InputField.Text)
	if num then
		atualizarCor(num, true)
	else
		-- Se digitou letra, volta pro valor atual
		InputField.Text = tostring(math.floor(GRAMA.Color.R * 255))
	end
end)

-- Carregar Inicial
task.spawn(function()
	InputField.Text = "..."
	local sucesso, dados = pcall(function() return RF:InvokeServer("CarregarDados") end)

	if sucesso and dados then
		local r = dados.PitchColourR or 43
		local g = dados.PitchColourG or 171
		local b = dados.PitchColourB or 39

		-- Aplica a cor completa inicial em TODOS os pastos
		local corInicial = Color3.fromRGB(r, g, b)
		for _, descendant in Workspace:GetDescendants() do
			if descendant:IsA("BasePart") then
				local nome = string.lower(descendant.Name)
				if nome:find("grama") or nome:find("pasto") or nome:find("grass") or nome:find("lawn") then
					descendant.Color = corInicial
				end
			end
		end
		InputField.Text = tostring(r)
	else
		print("Erro ao carregar dados de cor")
	end
end)
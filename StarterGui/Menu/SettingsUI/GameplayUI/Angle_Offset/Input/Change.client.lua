local Button = script.Parent -- O script deve estar dentro do Botão
local Config = workspace:WaitForChild("Configuration") -- A pasta de configurações no workspace
local Rep = game:GetService("ReplicatedStorage")

local Pasta = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = Pasta:WaitForChild("Function")

-- Configurações Visuais
local COR_ON = Color3.fromRGB(85, 255, 127) -- Verde
local COR_OFF = Color3.fromRGB(255, 85, 85) -- Vermelho
local TEXTO_ON = "ON"
local TEXTO_OFF = "OFF"

-- Função para aplicar a mudança visual e lógica
local function definirEstado(ativo, salvarNoServer)
	-- 1. Atualiza o valor no Workspace (física/jogo)
	if Config:FindFirstChild("AngleBarFix") then
		Config.AngleBarFix.Value = ativo
	end

	-- 2. Atualiza o Botão (Visual)
	Button.Text = ativo and TEXTO_ON or TEXTO_OFF
	Button.TextColor3 = ativo and COR_ON or COR_OFF

	-- 3. Salva no servidor se necessário
	if salvarNoServer then
		task.spawn(function()
			pcall(function()
				-- O nome da chave ("FixAngleBar") deve ser igual ao do DADOS_PADRAO no servidor
				RF:InvokeServer("MudarValor", {"FixAngleBar", ativo})
			end)
		end)
	end
end

-- ==========================================
-- INICIALIZAÇÃO: Carregar dados salvos
-- ==========================================
task.spawn(function()
	Button.Text = "..."
	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados.FixAngleBar ~= nil then
		definirEstado(dados.FixAngleBar, false)
	else
		definirEstado(false, false) -- Padrão se falhar
	end
end)

-- Evento de Clique
Button.MouseButton1Click:Connect(function()
	-- Pega o valor atual do workspace e inverte (true vira false, false vira true)
	local novoEstado = not Config.AngleBarFix.Value

	-- Toca o som (se existir dentro do botão)
	if Button:FindFirstChild("Success") then
		Button.Success:Play()
	end

	definirEstado(novoEstado, true) -- True para salvar
end)
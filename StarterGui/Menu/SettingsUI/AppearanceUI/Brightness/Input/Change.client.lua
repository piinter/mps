repeat task.wait() until game:IsLoaded()

local Lighting = game:GetService("Lighting")
local Rep = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local InputField = script.Parent -- O TextBox

-- Conectando ao sistema de __Eventos (Mesmo do Server)
local Pasta = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = Pasta:WaitForChild("Function")

-- Configurações
local CHAVE = "Brightness" -- Tem que ser igual ao DADOS_PADRAO do servidor
local EXPOSURE_MIN = -1    -- Bem escuro
local EXPOSURE_MAX = 3     -- Bem claro

-- Função para aplicar a mudança
local function aplicarExposicao(valor, salvarNoServer)
	if not valor then return end

	-- Limita o valor
	local valorFinal = math.clamp(valor, EXPOSURE_MIN, EXPOSURE_MAX)

	-- 1. Efeito Visual Suave (Muda ExposureCompensation em vez de Brightness)
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TweenService:Create(Lighting, tweenInfo, {ExposureCompensation = valorFinal}):Play()

	-- 2. Atualiza texto
	InputField.Text = tostring(valorFinal)

	-- 3. Salva no servidor usando o RemoteFunction unificado
	if salvarNoServer then
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE, valorFinal})
		end)
	end
end

-- ==========================================
-- INICIALIZAÇÃO
-- ==========================================
task.spawn(function()
	InputField.Text = "..."

	-- Pede os dados ao servidor
	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados[CHAVE] ~= nil then
		aplicarExposicao(dados[CHAVE], false) -- Carrega o salvo
	else
		aplicarExposicao(0, false) -- Padrão 0 se der erro
	end
end)

-- ==========================================
-- EVENTOS
-- ==========================================
InputField.FocusLost:Connect(function()
	local numero = tonumber(InputField.Text)
	if numero then
		aplicarExposicao(numero, true) -- Salva
	else
		-- Se digitar errado, volta para o valor atual
		InputField.Text = tostring(Lighting.ExposureCompensation)
	end
end)

-- Filtro: Aceita números e ponto (para poder colocar 14.5, 18.2, etc)
InputField:GetPropertyChangedSignal("Text"):Connect(function()
	InputField.Text = InputField.Text:gsub('[^%d%.]', '')
end)
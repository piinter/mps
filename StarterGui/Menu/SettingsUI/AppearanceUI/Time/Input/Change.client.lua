repeat task.wait() until game:IsLoaded()

local Lighting = game:GetService("Lighting")
local Rep = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local InputField = script.Parent

-- ==========================================================
-- CONEXÃO COM O SEU SISTEMA (Idêntico ao Horario_Func)
-- ==========================================================
local Pasta = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = Pasta:WaitForChild("Function")

-- Chave usada no servidor (Note que no seu exemplo você usou "Tempo")
local CHAVE_DADOS = "Tempo" 

-- ==========================================================
-- LÓGICA DE MUDANÇA
-- ==========================================================
local function atualizarHorario(valor, salvarNoServer)
	if not valor then return end

	-- Lógica de loop de 24h (se for maior que 24, vira 0)
	if valor >= 24 then valor = 0 end
	if valor < 0 then valor = 0 end

	-- 1. Aplica no Lighting (Suavemente)
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(Lighting, tweenInfo, {ClockTime = valor}):Play()

	-- 2. Atualiza o texto (mostra até 2 casas decimais, ex: 12.5)
	InputField.Text = tostring(valor)

	-- 3. ENVIA PARA O SERVIDOR (Exatamente como no seu Horario_Func)
	if salvarNoServer then
		task.spawn(function()
			-- Envia: "MudarValor", {"Tempo", 14.5}
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, valor})
		end)
	end
end

-- ==========================================================
-- INICIALIZAÇÃO (Carregar Dados)
-- ==========================================================
task.spawn(function()
	InputField.Text = "..."

	-- Pede os dados iniciais ao servidor
	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados[CHAVE_DADOS] ~= nil then
		atualizarHorario(dados[CHAVE_DADOS], false)
	else
		-- Padrão se não tiver save
		atualizarHorario(12, false)
	end
end)

-- ==========================================================
-- EVENTOS
-- ==========================================================
InputField.FocusLost:Connect(function()
	local numero = tonumber(InputField.Text)
	if numero then
		atualizarHorario(numero, true) -- Salva
	else
		InputField.Text = tostring(math.floor(Lighting.ClockTime))
	end
end)

-- Filtro: Aceita números e ponto (para poder colocar 14.5, 18.2, etc)
InputField:GetPropertyChangedSignal("Text"):Connect(function()
	InputField.Text = InputField.Text:gsub('[^%d%.]', '')
end)
repeat task.wait() until game:IsLoaded()

local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local InputField = script.Parent -- Tem que ser uma TextBox

-- 1. CONEXÃO COM O SISTEMA (Mesmo do Brightness/Time)
local Pasta = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = Pasta:WaitForChild("Function")

-- 2. CONFIGURAÇÕES
local CHAVE_DADOS = "NetTransparency" -- Nome no DataSettings
-- ATENÇÃO: Usei o caminho do seu script ORIGINAL que funciona:
local CAMINHO_REDES = Workspace:WaitForChild("Campo"):WaitForChild("Nets")

-- ==========================================================
-- LÓGICA VISUAL (Aplica a transparência)
-- ==========================================================
local function aplicarTransparencia(valor, salvarNoServer)
	if not valor then return end

	-- Limita entre 0 (Visível) e 1 (Invisível)
	local valorFinal = math.clamp(valor, 0, 1)

	-- Percorre as redes (Lógica do seu script original)
	for _, union in pairs(CAMINHO_REDES:GetChildren()) do
		-- Verifica os nomes como no original
		if union.Name == "RedeAway" or union.Name == "RedeHome" then
			for _, textura in pairs(union:GetChildren()) do
				if textura:IsA("Texture") then
					textura.Transparency = valorFinal
				end
			end
		end
	end

	-- Atualiza o texto da caixa
	InputField.Text = tostring(valorFinal)

	-- Salva no servidor
	if salvarNoServer then
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, valorFinal})
		end)
	end
end

-- ==========================================================
-- INICIALIZAÇÃO
-- ==========================================================
task.spawn(function()
	InputField.Text = "..."

	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados[CHAVE_DADOS] ~= nil then
		aplicarTransparencia(dados[CHAVE_DADOS], false)
	else
		aplicarTransparencia(0, false) -- Padrão 0 (Visível)
	end
end)

-- ==========================================================
-- EVENTOS
-- ==========================================================
InputField.FocusLost:Connect(function()
	local numero = tonumber(InputField.Text)
	if numero then
		aplicarTransparencia(numero, true) -- Salva
	else
		-- Se digitar errado, limpa ou mantêm (opcional)
		InputField.Text = "" 
	end
end)

-- Filtro: Aceita números e ponto (ex: 0.5)
InputField:GetPropertyChangedSignal("Text"):Connect(function()
	InputField.Text = InputField.Text:gsub('[^%d%.]', '')
end)
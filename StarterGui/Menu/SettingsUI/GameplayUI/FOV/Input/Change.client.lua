local inputField = script.Parent
local fovContainer = inputField.Parent
local camera = workspace.CurrentCamera

local Rep = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Pasta = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = Pasta:WaitForChild("Function")

-- Configurações
local FOV_MIN = 30
local FOV_MAX = 120

-- Função que aplica o FOV visualmente e atualiza o texto
local function aplicarFOV(valor, salvarNoServer)
	if not valor then return end

	local novoFov = math.clamp(valor, FOV_MIN, FOV_MAX)

	-- Aplica na câmera
	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TweenService:Create(camera, tweenInfo, {FieldOfView = novoFov}):Play()

	-- Atualiza o texto da caixa
	inputField.Text = tostring(math.round(novoFov))

	-- Salva no servidor (apenas se solicitado)
	if salvarNoServer then
		task.spawn(function()
			pcall(function()
				RF:InvokeServer("MudarValor", {"FOV", novoFov})
			end)
		end)
	end
end

-- ==========================================
-- INICIALIZAÇÃO: Carregar dados do servidor
-- ==========================================
task.spawn(function()
	inputField.Text = "..." -- Feedback visual de carregamento

	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados.FOV then
		aplicarFOV(dados.FOV, false) -- False porque já está salvo, só estamos carregando
	else
		aplicarFOV(70, false) -- Padrão caso falhe
	end
end)

-- Evento: Jogador digitou e confirmou
inputField.FocusLost:Connect(function(enterPressed)
	local valorDigitado = tonumber(inputField.Text)
	if valorDigitado then
		aplicarFOV(valorDigitado, true) -- True para salvar a nova mudança
	else
		-- Se digitou algo inválido, reseta para o atual
		inputField.Text = tostring(math.round(camera.FieldOfView))
	end
end)

-- Filtro de texto (apenas números)
inputField:GetPropertyChangedSignal("Text"):Connect(function()
	inputField.Text = inputField.Text:gsub('%D+', '')
end)
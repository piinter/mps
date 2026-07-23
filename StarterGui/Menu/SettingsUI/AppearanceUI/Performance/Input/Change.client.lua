repeat task.wait() until game:IsLoaded()
local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local Button = script.Parent

-- 1. CONEXÃO COM O SISTEMA
local PastaEventos = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = PastaEventos:WaitForChild("Function")
local CHAVE_DADOS = "PerformanceMode" -- Nome da variável no servidor

-- 2. CONFIGURAÇÃO DOS CAMINHOS
local GameStorage = Rep:WaitForChild("GameStorage")
local MapStorage = GameStorage:WaitForChild("Map")
local SkyboxStorage = GameStorage:WaitForChild("Skybox")
local MaterialsStorage = GameStorage:WaitForChild("Materials")
local TexturesStorage = GameStorage:WaitForChild("Textures")

-- Referências do Workspace
local RainZone = Workspace:FindFirstChild("RainZone")
local CampoGrama = Workspace:WaitForChild("Campo"):WaitForChild("Grama")

local estadoAtual = false -- false = Modo Normal, true = Modo Leve (Sem lag)

-- ==========================================================
-- TABELA PARA SALVAR PROPRIEDADES ORIGINAIS
-- ==========================================================
local configuracoesOriginais = {}

-- Função para clonar todas as propriedades de um objeto
local function clonarPropriedades(objeto)
	if not objeto then return {} end

	local propriedades = {}

	-- Lista de propriedades que queremos salvar para cada tipo de objeto
	local propriedadesPorTipo = {
		Sky = {"CelestialBodiesShown", "MoonAngularSize", "MoonTextureId", "SkyboxBk", "SkyboxDn", "SkyboxFt", 
			"SkyboxLf", "SkyboxRt", "SkyboxUp", "StarCount", "SunAngularSize", "SunTextureId"},

		Atmosphere = {"Density", "Offset", "Color", "Decay", "Glare", "Haze"},

		Bloom = {"Enabled", "Intensity", "Size", "Threshold"},

		ColorCorrection = {"Brightness", "Contrast", "Enabled", "Saturation", "TintColor"},

		DepthOfField = {"Enabled", "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity"},

		SunRays = {"Enabled", "Intensity", "Spread"}
	}

	local propsParaSalvar = propriedadesPorTipo[objeto.ClassName]

	if propsParaSalvar then
		for _, propName in ipairs(propsParaSalvar) do
			local sucesso, valor = pcall(function()
				return objeto[propName]
			end)
			if sucesso then
				propriedades[propName] = valor
			end
		end
	end

	return propriedades
end

-- Função para aplicar propriedades salvas a um objeto
local function aplicarPropriedades(objeto, propriedadesSalvas)
	if not objeto or not propriedadesSalvas then return end

	for propName, valor in pairs(propriedadesSalvas) do
		pcall(function()
			objeto[propName] = valor
		end)
	end
end

-- Função para salvar todas as configurações originais NO INÍCIO
local function salvarConfiguracoesOriginais()
	for _, objName in pairs({"Sky", "Atmosphere", "Bloom", "ColorCorrection", "DepthOfField", "SunRays"}) do
		local obj = Lighting:FindFirstChild(objName)
		if obj and not configuracoesOriginais[objName] then
			configuracoesOriginais[objName] = clonarPropriedades(obj)
		end

		-- Também verifica no SkyboxStorage caso já tenha sido movido antes
		local objGuardado = SkyboxStorage:FindFirstChild(objName)
		if objGuardado and not configuracoesOriginais[objName] then
			configuracoesOriginais[objName] = clonarPropriedades(objGuardado)
		end
	end
end

-- ==========================================================
-- FUNÇÃO: MODO PERFORMANCE (TUDO EM UM)
-- ==========================================================
local function aplicarPerformance(ativarModoLeve, salvarNoServer)
	estadoAtual = ativarModoLeve

	if ativarModoLeve then
		-- ATIVAR MODO LEVE (PERFORMANCE MÁXIMA)

		-- Remove chuva
		if Workspace:FindFirstChild("RainZone") then
			if SkyboxStorage:FindFirstChild("RainZone") then 
				SkyboxStorage.RainZone:Destroy() 
			end
			Workspace.RainZone.Parent = SkyboxStorage
		end

		-- Move objetos do Lighting para SkyboxStorage (remove efeitos visuais)
		for _, objName in pairs({"Sky", "Atmosphere", "Bloom", "ColorCorrection", "DepthOfField", "SunRays"}) do
			local obj = Lighting:FindFirstChild(objName)
			if obj then
				-- Salva as propriedades antes de mover (caso ainda não tenha salvo)
				if not configuracoesOriginais[objName] then
					configuracoesOriginais[objName] = clonarPropriedades(obj)
				end

				-- Remove duplicata se existir
				if SkyboxStorage:FindFirstChild(objName) then 
					SkyboxStorage[objName]:Destroy() 
				end

				-- Move para storage
				obj.Parent = SkyboxStorage
			end
		end

		-- Move material da grama
		local grassMat = MaterialsStorage:FindFirstChild("Grass")
		if grassMat then
			grassMat.Parent = MaterialService
		end

		-- Remove texturas da grama
		for _, texName in pairs({"Roughness", "Texture"}) do
			local tex = CampoGrama:FindFirstChild(texName)
			if tex then
				if TexturesStorage:FindFirstChild(texName) then 
					TexturesStorage[texName]:Destroy() 
				end
				tex.Parent = TexturesStorage
			end
		end

		Button.Text = "TRUE"
		Button.TextColor3 = Color3.new(0, 1, 0) -- Verde

	else
		-- DESATIVAR MODO LEVE (MODO NORMAL / ORIGINAL)

		-- Restaura chuva
		local rainGuardada = SkyboxStorage:FindFirstChild("RainZone")
		if rainGuardada then 
			rainGuardada.Parent = Workspace 
		end

		-- Restaura objetos do Lighting
		for _, objName in pairs({"Sky", "Atmosphere", "Bloom", "ColorCorrection", "DepthOfField", "SunRays"}) do
			local objGuardado = SkyboxStorage:FindFirstChild(objName)
			if objGuardado then 
				-- Move de volta para Lighting
				objGuardado.Parent = Lighting

				-- Restaura as propriedades originais
				if configuracoesOriginais[objName] then
					aplicarPropriedades(objGuardado, configuracoesOriginais[objName])
				end
			end
		end

		-- Restaura material da grama
		local grassMat = MaterialService:FindFirstChild("Grass")
		if grassMat then 
			grassMat.Parent = MaterialsStorage 
		end

		-- Restaura texturas da grama
		for _, texName in pairs({"Roughness", "Texture"}) do
			local texGuardada = TexturesStorage:FindFirstChild(texName)
			if texGuardada then 
				texGuardada.Parent = CampoGrama 
			end
		end

		Button.Text = "FALSE"
		Button.TextColor3 = Color3.new(1, 0, 0) -- Vermelho
	end

	if salvarNoServer then
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, ativarModoLeve})
		end)
	end
end

-- Salvar as configurações originais ANTES de qualquer alteração
salvarConfiguracoesOriginais()

Button.MouseButton1Click:Connect(function()
	local novoEstado = not estadoAtual
	if script:FindFirstChild("Success") then script.Success:Play() end
	aplicarPerformance(novoEstado, true)
end)

task.spawn(function()
	Button.Text = "..."
	local sucesso, dados = pcall(function() return RF:InvokeServer("CarregarDados") end)

	if sucesso and dados and dados[CHAVE_DADOS] ~= nil then
		aplicarPerformance(dados[CHAVE_DADOS], false)
	else
		-- Padrão - FALSE (Modo Normal)
		aplicarPerformance(false, false)
	end
end)
repeat task.wait() until game:IsLoaded()

local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Button = script.Parent

-- 1. CONEXÃO COM O SISTEMA
local PastaEventos = Rep:WaitForChild("__Eventos")
local RF : RemoteFunction = PastaEventos:WaitForChild("Function")
local CHAVE_DADOS = "PitchTexture"

-- 2. CONFIGURAÇÃO DOS CAMINHOS (Baseado nas suas imagens)
local PASTA_ATIVA = Workspace:WaitForChild("Campo"):WaitForChild("Grama")

-- Caminho corrigido conforme sua imagem:
local PASTA_GUARDADA = Rep:WaitForChild("PitchTextures") 

-- 3. LISTA DE MODOS (Nomes exatos das pastas da imagem)
local CICLO = {
	"Single Stripe",
	"Double Stripe",
	"Diagonal One Stripe",
	"Diagonal Double Stripe",
	"Diamond",
	"Circle",
	"Four Pointed Stars",
	"Special Arrows",
	"Special Stripes Diamond",
	"None"
}

-- ==========================================================
-- FUNÇÃO: APLICAR TEXTURA (Com proteção contra erros)
-- ==========================================================
local function aplicarTextura(modoNome, salvarNoServer)

	-- PASSO A: Limpar o campo (Devolver para o ReplicatedStorage)
	-- Varre todas as pastas possíveis para ver se alguma está no campo
	for _, nomeDaPasta in pairs(CICLO) do
		-- Procura a pasta original no ReplicatedStorage
		local pastaOrigem = PASTA_GUARDADA:FindFirstChild(nomeDaPasta)

		if pastaOrigem then
			-- Verifica o que está no campo agora
			for _, objetoNoCampo in pairs(PASTA_ATIVA:GetChildren()) do
				-- PROTEÇÃO CRÍTICA: Ignora TouchTransmitter e Scripts
				if not objetoNoCampo:IsA("TouchTransmitter") and not objetoNoCampo:IsA("Script") then

					-- Se o objeto tem a "etiqueta" deste modo, devolve pra casa
					if objetoNoCampo:GetAttribute("Origem") == nomeDaPasta then
						objetoNoCampo.Parent = pastaOrigem
					end
				end
			end
		end
	end

	-- Limpeza de segurança (Remove sobras, exceto coisas do sistema)
	for _, lixo in pairs(PASTA_ATIVA:GetChildren()) do
		if not lixo:IsA("TouchTransmitter") and not lixo:IsA("Script") and not lixo:IsA("Terrain") then
			-- Se não tiver etiqueta, manda para a raiz da pasta guardada para não poluir o campo
			if lixo:GetAttribute("Origem") == nil then
				lixo.Parent = PASTA_GUARDADA
			end
		end
	end

	-- PASSO B: Colocar a nova textura
	local pastaDesejada = PASTA_GUARDADA:FindFirstChild(modoNome)

	if pastaDesejada then
		for _, peca in pairs(pastaDesejada:GetChildren()) do
			-- Só move se não for coisa do sistema
			if not peca:IsA("TouchTransmitter") then
				peca:SetAttribute("Origem", modoNome) -- Carimba a origem
				peca.Parent = PASTA_ATIVA
			end
		end
	else
		warn("ERRO: Não achei a pasta '" .. modoNome .. "' dentro de PitchTextures!")
	end

	-- PASSO C: Atualizar Visual e Salvar
	Button.Text = modoNome

	if salvarNoServer then
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, modoNome})
		end)
	end
end

-- ==========================================================
-- CLIQUE (CICLO)
-- ==========================================================
Button.MouseButton1Click:Connect(function()
	local modoAtual = Button.Text

	-- Se o texto atual não estiver na lista, começa do primeiro
	if not table.find(CICLO, modoAtual) then 
		modoAtual = CICLO[#CICLO] -- Truque para o próximo ser o primeiro
	end

	local indexAtual = table.find(CICLO, modoAtual) or 0
	local proximoIndex = (indexAtual % #CICLO) + 1
	local novoModo = CICLO[proximoIndex]

	if script:FindFirstChild("Success") then
		script.Success:Play()
	end

	aplicarTextura(novoModo, true)
end)

-- ==========================================================
-- INICIALIZAÇÃO
-- ==========================================================
task.spawn(function()
	Button.Text = "..."
	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados[CHAVE_DADOS] then
		-- Verifica se o dado salvo ainda existe na lista (caso você mude os nomes depois)
		if table.find(CICLO, dados[CHAVE_DADOS]) then
			aplicarTextura(dados[CHAVE_DADOS], false)
		else
			aplicarTextura("Single Stripe", false)
		end
	else
		aplicarTextura("Single Stripe", false)
	end
end)
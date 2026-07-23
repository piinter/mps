repeat task.wait() until game:IsLoaded()

local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Button = script.Parent

local PastaEventos = Rep:WaitForChild("__Eventos")
local RF = PastaEventos:WaitForChild("Function")
local CHAVE_DADOS = "Stadium"

local PASTA_GUARDADA = Rep:WaitForChild("GameStorage"):WaitForChild("Map")
local NOME_MODELO = "Estadio"

local estadoAtual = true
local emCooldown = false
local TEMPO_TRANSICAO = 0.25

local function tweenCor(obj, corFinal)
	local tween = TweenService:Create(
		obj,
		TweenInfo.new(TEMPO_TRANSICAO, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{TextColor3 = corFinal}
	)
	tween:Play()
	tween.Completed:Wait()
end

local function definirEstadio(ligado, salvarNoServer)
	if emCooldown then return end
	emCooldown = true

	estadoAtual = ligado

	local pastaAtivaAtual = Workspace:FindFirstChild("StadiumMain")

	if ligado then
		local stadiumMainGuardado = PASTA_GUARDADA:FindFirstChild("StadiumMain")
		if stadiumMainGuardado then
			stadiumMainGuardado.Parent = Workspace
			pastaAtivaAtual = stadiumMainGuardado
		end

		if not pastaAtivaAtual then
			emCooldown = false
			return
		end

		local estadioGuardado = PASTA_GUARDADA:FindFirstChild(NOME_MODELO)

		if not estadioGuardado then
			estadioGuardado = pastaAtivaAtual:FindFirstChild(NOME_MODELO)
		end

		if estadioGuardado then
			estadioGuardado.Parent = pastaAtivaAtual
		end

		Button.Text = "TRUE"
		tweenCor(Button, Color3.new(0,1,0))

	else
		if not pastaAtivaAtual then
			emCooldown = false
			return
		end

		local estadioNoCampo = pastaAtivaAtual:FindFirstChild(NOME_MODELO)

		if estadioNoCampo then
			local duplicata = PASTA_GUARDADA:FindFirstChild(NOME_MODELO)
			if duplicata then
				duplicata:Destroy()
			end

			estadioNoCampo.Parent = PASTA_GUARDADA
		end

		local duplicataStadiumMain = PASTA_GUARDADA:FindFirstChild("StadiumMain")
		if duplicataStadiumMain then
			duplicataStadiumMain:Destroy()
		end

		pastaAtivaAtual.Parent = PASTA_GUARDADA

		Button.Text = "FALSE"
		tweenCor(Button, Color3.new(1,0,0))
	end

	if salvarNoServer then
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, ligado})
		end)
	end

	emCooldown = false
end

Button.MouseButton1Click:Connect(function()
	if emCooldown then return end

	local novoEstado = not estadoAtual

	if script:FindFirstChild("Success") then
		script.Success:Play()
	end

	definirEstadio(novoEstado, true)
end)

task.spawn(function()
	Button.Text = "..."
	local sucesso, dados = pcall(function()
		return RF:InvokeServer("CarregarDados")
	end)

	if sucesso and dados and dados[CHAVE_DADOS] ~= nil then
		if dados[CHAVE_DADOS] then
			Button.TextColor3 = Color3.new(1,0,0)
		else
			Button.TextColor3 = Color3.new(0,1,0)
		end
		definirEstadio(dados[CHAVE_DADOS], false)
	else
		Button.TextColor3 = Color3.new(1,0,0)
		definirEstadio(true, false)
	end
end)
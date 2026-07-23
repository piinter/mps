-- PlacaController - PC + Mobile + Console
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local player  = Players.LocalPlayer
local camera  = workspace.CurrentCamera

-- Aguarda a placa carregar
local pasta = workspace:WaitForChild("PlacaTutorial", 10)
if not pasta then return end
local placa = pasta:WaitForChild("Placa", 10)
if not placa then return end
local sgui   = placa:WaitForChild("PlacaGUI", 10)
if not sgui then return end
local fundo  = sgui:WaitForChild("Fundo", 10)
if not fundo then return end
local botao  = fundo:WaitForChild("BotaoLista", 10)
if not botao then return end
local scroll = fundo:WaitForChild("Lista", 10)
if not scroll then return end

-- ── Distância máxima para interagir ──────────────────────────
local DIST_MAX = 20

local aberta   = false
local animando = false

-- Detecta se é Mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ── Fade suave (Heartbeat) ────────────────────────────────────
local function tween(obj, prop, destino, dur)
	local inicio = obj[prop]
	local passos = math.max(1, math.ceil(dur / 0.016))
	local passo  = 0
	local conn
	conn = RunService.Heartbeat:Connect(function()
		passo += 1
		local t = math.min(passo / passos, 1)
		local e = 1 - (1 - t) ^ 4
		obj[prop] = inicio + (destino - inicio) * e
		if t >= 1 then conn:Disconnect() end
	end)
end

local function fadeScroll(abrir)
	if abrir then
		scroll.Visible = true
		scroll.BackgroundTransparency = 1
		for _, item in ipairs(scroll:GetChildren()) do
			if item:IsA("Frame") then
				item.BackgroundTransparency = 1
				for _, filho in ipairs(item:GetChildren()) do
					if filho:IsA("TextLabel") then filho.TextTransparency = 1 end
				end
			end
		end
		tween(scroll, "BackgroundTransparency", 0, 0.35)
		for _, item in ipairs(scroll:GetChildren()) do
			if item:IsA("Frame") then
				tween(item, "BackgroundTransparency", 0, 0.35)
				for _, filho in ipairs(item:GetChildren()) do
					if filho:IsA("TextLabel") then
						tween(filho, "TextTransparency", 0, 0.35)
					end
				end
			end
		end
	else
		tween(scroll, "BackgroundTransparency", 1, 0.25)
		for _, item in ipairs(scroll:GetChildren()) do
			if item:IsA("Frame") then
				tween(item, "BackgroundTransparency", 1, 0.25)
				for _, filho in ipairs(item:GetChildren()) do
					if filho:IsA("TextLabel") then
						tween(filho, "TextTransparency", 1, 0.25)
					end
				end
			end
		end
		task.delay(0.28, function() scroll.Visible = false end)
	end
end

-- ── Toggle principal ──────────────────────────────────────────
local function toggle()
	if animando then return end

	local char = player.Character
	if char then
		local root = char:FindFirstChild("HumanoidRootPart")
		if root and (root.Position - placa.Position).Magnitude > DIST_MAX then
			return
		end
	end

	animando = true
	aberta   = not aberta

	if aberta then
		botao.Text = "Fechar Comandos"
		botao.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		fadeScroll(true)
	else
		botao.Text = "Ver Comandos"
		botao.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		fadeScroll(false)
	end

	task.delay(0.4, function() animando = false end)
end

-- ── PC: hover ─────────────────────────────────────────────────
botao.MouseEnter:Connect(function()
	botao.BackgroundColor3 = aberta
		and Color3.fromRGB(138, 138, 138)
		or  Color3.fromRGB(138, 138, 138)
end)

botao.MouseLeave:Connect(function()
	botao.BackgroundColor3 = aberta
		and Color3.fromRGB(255, 255, 255)
		or  Color3.fromRGB(255, 255, 255)
end)

-- ── PC: clique direto no botão ────────────────────────────────
botao.MouseButton1Click:Connect(toggle)

-- ── Mobile: ProximityPrompt SOMENTE no Mobile ─────────────────
if isMobile then
	local prompt = Instance.new("ProximityPrompt")
	prompt.ObjectText    = "Placa"
	prompt.ActionText    = aberta and "Fechar Lista" or "Ver Tópicos"
	prompt.MaxActivationDistance = DIST_MAX
	prompt.HoldDuration  = 0
	prompt.RequiresLineOfSight = false
	prompt.Parent = placa

	prompt.Triggered:Connect(function()
		prompt.ActionText = aberta and "Ver Tópicos" or "Fechar Lista"
		toggle()
	end)

	RunService.Heartbeat:Connect(function()
		prompt.ActionText = aberta and "Fechar Lista" or "Ver Tópicos"
	end)
end

print("[PlacaController] ✅ Iniciado - PC, Mobile e Console prontos.")

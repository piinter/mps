-- ============================================
-- GUI DE NOTIFICAÇÃO DE GOL
-- LocalScript - Colocar em StarterPlayer > StarterPlayerScripts
-- ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Aguardar RemoteEvent
local goalNotificationEvent = ReplicatedStorage:WaitForChild("GoalNotification", 10)
if not goalNotificationEvent then
	warn("GoalNotification RemoteEvent não encontrado!")
	return
end

-- ============================================
-- CRIAR A GUI
-- ============================================

local function createGoalUI()
	-- Verificar se já existe
	local existing = playerGui:FindFirstChild("GoalNotificationUI")
	if existing then existing:Destroy() end

	-- Criar ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "GoalNotificationUI"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = playerGui

	-- Container principal (invisível no início)
	local container = Instance.new("Frame")
	container.Name = "Container"
	container.Size = UDim2.new(0, 600, 0, 200)
	container.Position = UDim2.new(0.5, 0, -0.3, 0) -- Começa fora da tela (acima)
	container.AnchorPoint = Vector2.new(0.5, 0.5)
	container.BackgroundTransparency = 1
	container.Parent = screenGui

	-- Frame de fundo com gradiente
	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.new(1, 0, 1, 0)
	background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	background.BorderSizePixel = 0
	background.Parent = container

	-- Gradiente
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
	}
	gradient.Rotation = 90
	gradient.Parent = background

	-- Borda arredondada
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = background

	-- Stroke (borda brilhante)
	local stroke = Instance.new("UIStroke")
	stroke.Name = "Stroke"
	stroke.Color = Color3.fromRGB(255, 215, 0)
	stroke.Thickness = 4
	stroke.Transparency = 0
	stroke.Parent = background

	-- Texto "GOAL!" ou "OWN GOAL!"
	local goalText = Instance.new("TextLabel")
	goalText.Name = "GoalText"
	goalText.Size = UDim2.new(1, -40, 0, 70)
	goalText.Position = UDim2.new(0, 20, 0, 20)
	goalText.BackgroundTransparency = 1
	goalText.Text = "GOAL!"
	goalText.Font = Enum.Font.FredokaOne
	goalText.TextSize = 60
	goalText.TextColor3 = Color3.fromRGB(255, 215, 0)
	goalText.TextStrokeTransparency = 0.5
	goalText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	goalText.Parent = container

	-- Texto do jogador
	local playerText = Instance.new("TextLabel")
	playerText.Name = "PlayerText"
	playerText.Size = UDim2.new(1, -40, 0, 50)
	playerText.Position = UDim2.new(0, 20, 0, 100)
	playerText.BackgroundTransparency = 1
	playerText.Text = "Player Name"
	playerText.Font = Enum.Font.GothamBold
	playerText.TextSize = 32
	playerText.TextColor3 = Color3.fromRGB(255, 255, 255)
	playerText.TextStrokeTransparency = 0.7
	playerText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	playerText.Parent = container

	-- Time do jogador
	local teamText = Instance.new("TextLabel")
	teamText.Name = "TeamText"
	teamText.Size = UDim2.new(1, -40, 0, 30)
	teamText.Position = UDim2.new(0, 20, 0, 155)
	teamText.BackgroundTransparency = 1
	teamText.Text = "Team Name"
	teamText.Font = Enum.Font.Gotham
	teamText.TextSize = 20
	teamText.TextColor3 = Color3.fromRGB(200, 200, 200)
	teamText.TextStrokeTransparency = 0.8
	teamText.Parent = container

	-- Partículas de celebração
	local particles = Instance.new("Frame")
	particles.Name = "Particles"
	particles.Size = UDim2.new(1, 0, 1, 0)
	particles.BackgroundTransparency = 1
	particles.ClipsDescendants = true
	particles.Parent = container

	return screenGui, container, goalText, playerText, teamText, stroke, particles
end

-- ============================================
-- CRIAR PARTÍCULAS (CONFETES)
-- ============================================

local function createParticle(parent, color)
	local particle = Instance.new("Frame")
	particle.Size = UDim2.new(0, math.random(8, 15), 0, math.random(8, 15))
	particle.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
	particle.BackgroundColor3 = color
	particle.BorderSizePixel = 0
	particle.Rotation = math.random(0, 360)
	particle.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0.3, 0)
	corner.Parent = particle

	-- Animar queda
	local fallTween = TweenService:Create(
		particle,
		TweenInfo.new(math.random(15, 25) / 10, Enum.EasingStyle.Linear),
		{Position = UDim2.new(particle.Position.X.Scale, 0, 1.2, 0), Rotation = particle.Rotation + math.random(360, 720)}
	)
	fallTween:Play()

	fallTween.Completed:Connect(function()
		particle:Destroy()
	end)
end

-- ============================================
-- MOSTRAR NOTIFICAÇÃO
-- ============================================

local function showGoalNotification(data)
	local screenGui, container, goalText, playerText, teamText, stroke, particles = createGoalUI()

	-- Configurar textos
	if data.IsOwnGoal then
		goalText.Text = "OWN GOAL!"
		goalText.TextColor3 = Color3.fromRGB(255, 50, 50)
		stroke.Color = Color3.fromRGB(255, 50, 50)
	else
		goalText.Text = "⚽ GOAL! ⚽"
		goalText.TextColor3 = Color3.fromRGB(255, 215, 0)
		stroke.Color = data.TeamColor or Color3.fromRGB(255, 215, 0)
	end

	playerText.Text = data.PlayerName or "Unknown Player"
	playerText.TextColor3 = data.TeamColor or Color3.fromRGB(255, 255, 255)

	teamText.Text = (data.TeamName or "Team") .. " Team"

	-- Criar confetes
	if not data.IsOwnGoal then
		for i = 1, 30 do
			task.spawn(function()
				wait(math.random(0, 10) / 20)
				local colors = {
					Color3.fromRGB(255, 215, 0),
					Color3.fromRGB(255, 50, 50),
					Color3.fromRGB(50, 255, 50),
					Color3.fromRGB(50, 150, 255),
					data.TeamColor or Color3.fromRGB(255, 255, 255)
				}
				createParticle(particles, colors[math.random(1, #colors)])
			end)
		end
	end

	-- Animação de entrada (desliza de cima)
	local slideIn = TweenService:Create(
		container,
		TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = UDim2.new(0.5, 0, 0.25, 0)}
	)

	-- Animação de pulso no stroke
	local pulseTween = TweenService:Create(
		stroke,
		TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
		{Thickness = 6}
	)

	-- Animação de escala no texto
	local scaleTween = TweenService:Create(
		goalText,
		TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true),
		{TextSize = 65}
	)

	slideIn:Play()
	task.wait(0.3)
	pulseTween:Play()
	scaleTween:Play()

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://16941093602" -- Coloque o ID do som aqui
	sound.Volume = 0.5
	sound.Parent = screenGui
	sound:Play()
	sound.Ended:Connect(function() sound:Destroy() end)

	-- Aguardar e sair
	task.wait(4)

	-- Animação de saída
	pulseTween:Cancel()
	scaleTween:Cancel()

	local slideOut = TweenService:Create(
		container,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{Position = UDim2.new(0.5, 0, -0.3, 0)}
	)

	slideOut:Play()
	slideOut.Completed:Wait()

	screenGui:Destroy()
end

goalNotificationEvent.OnClientEvent:Connect(function(data)
	showGoalNotification(data)
end)

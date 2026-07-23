-- Script pessimo horrivel totalmente feito por IA 

-- ============================================
-- SCRIPT DE ÁRBITRO - VERSÃO FUNCIONAL
-- ============================================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local ServerStorage = game:GetService("ServerStorage")
local TextChatService = game:GetService("TextChatService")

print("[ÁRBITRO] Iniciando script...")

-- ============================================
-- CONSTANTES
-- ============================================

local CONSTANTS = {
	THROW_IN_HEIGHT = 835,
	GOAL_WAIT_TIME = 5,
	THROW_IN_ANCHOR = 5,
	BALL_SIZE = 2.5,
	LINE_WIDTH = 1.0,
	VERIFICATION_DELAY = 0.15,
	MAX_GOAL_HEIGHT = 848.35,
	BOX_WIDTH = 91.126,
	BOX_CENTER_X = -103.6,
	HOME_BOX_EDGE_Z = 388.152,
	AWAY_BOX_EDGE_Z = -268.764,
	MAX_FOUL_DISTANCE = 20,
	PROXIMITY_DISTANCE = 8,
	BALL_MOVEMENT_THRESHOLD = 2,
	FOUL_TIMEOUT = 40,
	HEARTBEAT_SKIP_FRAMES = 3,
	KICKOFF_BARRIER_TIMEOUT = 8,
	GOAL_VERIFICATION_SAMPLES = 3,
	GOAL_VERIFICATION_INTERVAL = 0.05,
}

local RADIUS = CONSTANTS.BALL_SIZE / 2
local HALF_LINE = CONSTANTS.LINE_WIDTH / 2
local OFFSET = RADIUS + HALF_LINE
local HALF_BOX_WIDTH = CONSTANTS.BOX_WIDTH / 2

local LINES = {
	AwayLineZ = -212.34,
	HomeLineZ = 330.749,
	MinX = -309.153,
	MaxX = 100.721
}

local POSTS_X = {
	Min = math.min(-122.517, -85.935),
	Max = math.max(-122.517, -85.935)
}

local SET_PIECES = {
	AwayGK = "AGK", HomeGK = "HGK", KickOff = "LBALL",
	HomeCR = "HCR", HomeCL = "HCL", AwayCR = "ACR", AwayCL = "ACL",
	HomePK = "HPK", AwayPK = "APK"
}

local MESSAGES = {
	ThrowIn = {"sent the ball out for a", "forced a", "played it out for a"},
	Corner = {"conceded a", "gave away a", "cleared it behind for a"},
	GoalKick = {"missed the target. It's a", "blasted it wide for a", "sent it over the bar for a"},
	Goal = {"scores a screamer! It's a", "finds the back of the net!", "buries it! GOAL!"},
	Foul = {"committed a foul on", "tripped", "pushed"},
	Penalty = {"gave away a penalty!", "fouled inside the box! It's a"}
}

local TEAM_COLORS = {
	Home = {
		Fill = Color3.fromRGB(0, 48, 90),
		Outline = Color3.fromRGB(0, 132, 255),
		Indicator = "hl",
		Folder = "Home"
	},
	Away = {
		Fill = Color3.fromRGB(0, 90, 29),
		Outline = Color3.fromRGB(0, 255, 76),
		Indicator = "al",
		Folder = "Away"
	}
}

-- Times válidos para causar eventos
local VALID_TEAMS = {
	["-Home GK"] = true,
	["-Away GK"] = true,
	["Home"] = true,
	["Away"] = true
}

-- ============================================
-- VARIÁVEIS DE ESTADO
-- ============================================

local gameState = {
	ballInPlay = true,
	waitingForReentry = false,
	verificationDebounce = false,
	lastBallPosition = nil,
	activeFoulTimeout = nil,
	activeKickoffBarrier = nil
}

-- ============================================
-- REMOTE EVENTS
-- ============================================

local refereeEvent = ReplicatedStorage:WaitForChild("RefereeEvent", 5)
if not refereeEvent then
	warn("[ÁRBITRO] RefereeEvent não encontrado! Criando...")
	refereeEvent = Instance.new("RemoteEvent")
	refereeEvent.Name = "RefereeEvent"
	refereeEvent.Parent = ReplicatedStorage
end

local tripEvent = ReplicatedStorage:FindFirstChild("Trip_Player")
if not tripEvent then
	tripEvent = Instance.new("RemoteEvent")
	tripEvent.Name = "Trip_Player"
	tripEvent.Parent = ReplicatedStorage
	print("[ÁRBITRO] Trip_Player criado")
end

local goalNotificationEvent = ReplicatedStorage:FindFirstChild("GoalNotification")
if not goalNotificationEvent then
	goalNotificationEvent = Instance.new("RemoteEvent")
	goalNotificationEvent.Name = "GoalNotification"
	goalNotificationEvent.Parent = ReplicatedStorage
	print("[ÁRBITRO] GoalNotification criado")
end

local POSITIONS_FOLDER = Lighting:WaitForChild("SetPiece_Positions", 5)
if not POSITIONS_FOLDER then
	warn("[ÁRBITRO] SetPiece_Positions não encontrado!")
end

-- ============================================
-- FUNÇÕES AUXILIARES
-- ============================================

local function getRandomMsg(category)
	local list = MESSAGES[category]
	if not list then return "resulted in a" end
	return list[math.random(1, #list)]
end

local function sendAlert(playerName, teamColor, actionText, actionType)
	print(string.format("[ÁRBITRO] Alerta: %s - %s %s", actionType, playerName, actionText))

	-- Enviar via RemoteEvent
	pcall(function()
		refereeEvent:FireAllClients(playerName, teamColor, actionText, actionType)
	end)

	-- Enviar no chat
	local chatMessage = string.format("⚽ %s %s", playerName, actionText)

	task.spawn(function()
		local success, err = pcall(function()
			-- Tentar novo sistema de chat
			if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
				local textChannels = TextChatService:FindFirstChild("TextChannels")
				if textChannels then
					local generalChannel = textChannels:FindFirstChild("RBXGeneral")
					if generalChannel then
						generalChannel:DisplaySystemMessage(chatMessage)
						print("[ÁRBITRO] Mensagem enviada via TextChatService")
						return
					end
				end
			end

			-- Fallback para chat legado
			game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
				Text = chatMessage,
				Color = teamColor,
				Font = Enum.Font.GothamBold,
				FontSize = Enum.FontSize.Size18
			})
			print("[ÁRBITRO] Mensagem enviada via Chat Legado")
		end)

		if not success then
			warn("Erro ao enviar mensagem no chat:", err)
		end
	end)
end

local function getPosValue(name)
	if not POSITIONS_FOLDER then return nil end
	local obj = POSITIONS_FOLDER:FindFirstChild(name)
	if obj then return obj.Value end
	return nil
end

local function isInHomeBox(pos)
	local inZ = (pos.Z <= LINES.HomeLineZ + 5) and (pos.Z >= CONSTANTS.HOME_BOX_EDGE_Z - 2)
	local inX = (pos.X >= CONSTANTS.BOX_CENTER_X - HALF_BOX_WIDTH) and (pos.X <= CONSTANTS.BOX_CENTER_X + HALF_BOX_WIDTH)
	return inZ and inX
end

local function isInAwayBox(pos)
	local inZ = (pos.Z >= LINES.AwayLineZ - 5) and (pos.Z <= CONSTANTS.AWAY_BOX_EDGE_Z + 2)
	local inX = (pos.X >= CONSTANTS.BOX_CENTER_X - HALF_BOX_WIDTH) and (pos.X <= CONSTANTS.BOX_CENTER_X + HALF_BOX_WIDTH)
	return inZ and inX
end

local function clearBalls()
	local ballsFolder = workspace:FindFirstChild("Balls")
	if ballsFolder then
		for _, b in pairs(ballsFolder:GetChildren()) do
			if b.Name == "TPS" then 
				b:Destroy() 
			end
		end
	end
end

local function getLastTouchInfo(ball)
	local ownerVal = ball:FindFirstChild("Owner")
	if ownerVal and ownerVal:IsA("ObjectValue") and ownerVal.Value then
		local p = ownerVal.Value
		if p:IsA("Model") then p = Players:GetPlayerFromCharacter(p) end
		if p and p:IsA("Player") then
			local tName = p.Team and p.Team.Name
			local side = "Neutro"
			if tName == "Home" or tName == "-Home GK" then side = "Home" end
			if tName == "Away" or tName == "-Away GK" then side = "Away" end

			return {
				Name = p.Name, 
				Side = side, 
				Color = p.Team and p.Team.TeamColor.Color or Color3.new(0.5,0.5,0.5), 
				TeamName = tName
			}
		end
	end
	return {Name = "Nobody", Side = "Neutro", Color = Color3.new(0.5,0.5,0.5), TeamName = nil}
end

-- Verificar se o último toque foi de um time válido
local function isValidTeamTouch(ball)
	local touchInfo = getLastTouchInfo(ball)
	if touchInfo.TeamName and VALID_TEAMS[touchInfo.TeamName] then
		return true, touchInfo
	end
	return false, touchInfo
end

local function teleportNearestOpponent(ball, targetTeam)
	if not ball then return end

	local nearestPlayer = nil
	local shortestDist = math.huge

	for _, player in pairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local tName = player.Team and player.Team.Name
			if tName == targetTeam or tName == "-"..targetTeam.." GK" then
				local dist = (player.Character.HumanoidRootPart.Position - ball.Position).Magnitude
				if dist < shortestDist then
					shortestDist = dist
					nearestPlayer = player
				end
			end
		end
	end

	if nearestPlayer then
		local hrp = nearestPlayer.Character.HumanoidRootPart
		hrp.CFrame = CFrame.new(ball.Position + Vector3.new(2, 0, 0))
	end
end

-- ============================================
-- GERENCIAMENTO DE BARREIRAS
-- ============================================

local function ResetActiveBarriers()
	local wsBarreiras = workspace:FindFirstChild("Barreiras")
	local sourceFolder = Lighting:FindFirstChild("Barreiras") or ServerStorage:FindFirstChild("Barreiras")

	if wsBarreiras and sourceFolder then
		for _, barrier in pairs(wsBarreiras:GetChildren()) do
			local initial = barrier.Name:sub(1,1):lower()
			if initial == "a" and sourceFolder:FindFirstChild("Away") then
				barrier.Parent = sourceFolder.Away
			elseif initial == "h" and sourceFolder:FindFirstChild("Home") then
				barrier.Parent = sourceFolder.Home
			else
				if sourceFolder:FindFirstChild("Away") then barrier.Parent = sourceFolder.Away end
			end
		end
	end

	if gameState.activeKickoffBarrier then
		task.cancel(gameState.activeKickoffBarrier)
		gameState.activeKickoffBarrier = nil
	end
end

local function ActivateBarrier(barrierName, ball, isKickoffBarrier)

	task.spawn(function()
		ResetActiveBarriers()
		task.wait(0.1)

		local SourceFolder = Lighting:FindFirstChild("Barreiras") or ServerStorage:FindFirstChild("Barreiras")
		if not SourceFolder then 
			warn("[ÁRBITRO] Pasta Barreiras não encontrada!")
			return 
		end

		local barrierPart = nil
		local originalParent = nil

		if SourceFolder:FindFirstChild("Away") and SourceFolder.Away:FindFirstChild(barrierName) then
			barrierPart = SourceFolder.Away[barrierName]
			originalParent = SourceFolder.Away
		elseif SourceFolder:FindFirstChild("Home") and SourceFolder.Home:FindFirstChild(barrierName) then
			barrierPart = SourceFolder.Home[barrierName]
			originalParent = SourceFolder.Home
		end

		if not barrierPart then
			warn("[ÁRBITRO] Barreira não encontrada:", barrierName)
			return
		end

		local wsBarreiras = workspace:FindFirstChild("Barreiras")
		if not wsBarreiras then
			wsBarreiras = Instance.new("Folder")
			wsBarreiras.Name = "Barreiras"
			wsBarreiras.Parent = workspace
		end

		barrierPart.Parent = wsBarreiras

		if ball then
			local connections = {}
			local isActive = true

			local function cleanup()
				if not isActive then return end
				isActive = false

				for _, conn in pairs(connections) do 
					if conn then conn:Disconnect() end
				end

				if barrierPart and barrierPart.Parent == wsBarreiras then
					barrierPart.Parent = originalParent
				end
			end

			-- Conexão de destruição da bola
			table.insert(connections, ball.AncestryChanged:Connect(function(_, parent)
				if not parent then cleanup() end
			end))

			-- Conexão de toque na bola
			task.spawn(function()
				local ownerValue = ball:WaitForChild("Owner", 5)
				if not ownerValue then return end

				table.insert(connections, ownerValue.Changed:Connect(function()
					if ownerValue.Value ~= nil then
						cleanup()
					end
				end))
			end)

			-- APENAS barreira de kickoff tem timeout
			if isKickoffBarrier then
				gameState.activeKickoffBarrier = task.delay(CONSTANTS.KICKOFF_BARRIER_TIMEOUT, function()
					cleanup()
					gameState.activeKickoffBarrier = nil
				end)
			end
		end
	end)
end

-- ============================================
-- VISUAIS DA BOLA
-- ============================================

local function setupBallVisuals(ball, teamName, showTimer)
	if not ball then return end

	local colors = TEAM_COLORS[teamName]
	if not colors then
		colors = {
			Fill = Color3.fromRGB(95, 0, 0),
			Outline = Color3.fromRGB(255, 1, 5)
		}
	end

	if ball:FindFirstChild("Highlight") then
		ball.Highlight.Enabled = true
		ball.Highlight.FillColor = colors.Fill
		ball.Highlight.OutlineColor = colors.Outline
	end

	if ball:FindFirstChild("BillboardGui") then
		ball.BillboardGui.Enabled = true
		local img = ball.BillboardGui:FindFirstChild("ImageLabel")
		if img then
			img.ImageColor3 = colors.Outline
			img.Visible = not showTimer
		end
	end
end

local function resetBallVisuals(ball)
	if not ball then return end

	if ball:FindFirstChild("Highlight") then
		ball.Highlight.Enabled = false
	end

	if ball:FindFirstChild("BillboardGui") then
		ball.BillboardGui.Enabled = false
	end
end

-- ============================================
-- CRIAÇÃO DE BOLA
-- ============================================

local function spawnBall(position, anchorDuration)
	clearBalls()

	local template = Lighting:FindFirstChild("TPS") or workspace:FindFirstChild("TPS")
	if not template then
		warn("[ÁRBITRO] Template de bola não encontrado!")
		return nil
	end

	local newBall = template:Clone()
	newBall.Name = "TPS"
	newBall.Position = position
	newBall.Velocity = Vector3.new(0,0,0)
	newBall.RotVelocity = Vector3.new(0,0,0)
	newBall.Anchored = false

	local ballsFolder = workspace:FindFirstChild("Balls")
	if not ballsFolder then
		ballsFolder = Instance.new("Folder")
		ballsFolder.Name = "Balls"
		ballsFolder.Parent = workspace
	end

	newBall.Parent = ballsFolder
	resetBallVisuals(newBall)

	if anchorDuration and anchorDuration > 0 then
		newBall.Anchored = true
		setupBallVisuals(newBall, nil, true)

		task.spawn(function()
			local bbGui = newBall:FindFirstChild("BillboardGui")
			if not bbGui then return end

			local timerLabel = bbGui:FindFirstChild("TimerLabel")
			if not timerLabel then
				timerLabel = Instance.new("TextLabel")
				timerLabel.Name = "TimerLabel"
				timerLabel.BackgroundTransparency = 1
				timerLabel.Size = UDim2.new(1, 0, 1, 0)
				timerLabel.Font = Enum.Font.FredokaOne
				timerLabel.TextScaled = true
				timerLabel.TextColor3 = Color3.fromRGB(150, 0, 0)
				timerLabel.TextStrokeTransparency = 0.5
				timerLabel.TextStrokeColor3 = Color3.new(1,1,1)
				timerLabel.ZIndex = 2
				timerLabel.Parent = bbGui
			end

			local icon = bbGui:FindFirstChildWhichIsA("ImageLabel")
			if icon then icon.Visible = false end
			timerLabel.Visible = true

			for i = anchorDuration, 1, -1 do
				if not newBall or not newBall.Parent or not newBall.Anchored then break end
				timerLabel.Text = tostring(i)
				task.wait(1)
			end

			if newBall and newBall.Parent and newBall.Anchored then
				newBall.Anchored = false
				resetBallVisuals(newBall)
			end

			if timerLabel then timerLabel.Visible = false end
			if icon then icon.Visible = true end
		end)
	end
	
	return newBall
end

-- ============================================
-- LATERAL (THROW-IN)
-- ============================================

local function applyLateralAnchor(ball, teamName, duration)
	if not ball or not TEAM_COLORS[teamName] then return end

	local colors = TEAM_COLORS[teamName]
	ball.Anchored = true
	setupBallVisuals(ball, teamName, duration > 0)

	local lightingBarreiras = Lighting:FindFirstChild("Barreiras")
	if lightingBarreiras and lightingBarreiras:FindFirstChild(colors.Folder) then
		local template = lightingBarreiras[colors.Folder]:FindFirstChild(colors.Indicator)
		if template then
			local ind = template:Clone()
			ind.Name = "RangeIndicator"
			ind.CFrame = CFrame.new(ball.Position)
			ind.Orientation = Vector3.new(90, -90, 0)
			ind.CanCollide = false
			ind.Anchored = true
			ind.Parent = ball
		end
	end

	task.spawn(function()
		local isActive = true
		local connections = {}

		local function cleanup()
			if not isActive then return end
			isActive = false

			for _, conn in pairs(connections) do
				if conn then conn:Disconnect() end
			end

			if ball and ball.Parent then
				ball.CFrame = ball.CFrame + Vector3.new(0, 0.3, 0)
				ball.Anchored = false
				resetBallVisuals(ball)
				if ball:FindFirstChild("RangeIndicator") then
					ball.RangeIndicator:Destroy()
				end
			end
		end

		table.insert(connections, ball.AncestryChanged:Connect(function(_, parent)
			if not parent then cleanup() end
		end))

		local bbGui = ball:FindFirstChild("BillboardGui")
		local timerLabel = nil
		if bbGui then
			timerLabel = bbGui:FindFirstChild("TimerLabel")
			if not timerLabel then
				timerLabel = Instance.new("TextLabel")
				timerLabel.Name = "TimerLabel"
				timerLabel.BackgroundTransparency = 1
				timerLabel.Size = UDim2.new(1, 0, 1, 0)
				timerLabel.Font = Enum.Font.FredokaOne
				timerLabel.TextScaled = true
				timerLabel.TextColor3 = colors.Outline
				timerLabel.TextStrokeTransparency = 0.5
				timerLabel.ZIndex = 2
				timerLabel.Parent = bbGui
			end

			if duration > 0 then
				timerLabel.Visible = true
				local icon = bbGui:FindFirstChildWhichIsA("ImageLabel")
				if icon then icon.Visible = false end
			else
				timerLabel.Visible = false
			end
		end

		table.insert(connections, ball.Touched:Connect(function(hit)
			if not isActive then return end
			local player = Players:GetPlayerFromCharacter(hit.Parent)
			if player then
				local tName = player.Team and player.Team.Name
				if tName == teamName or tName == "-"..teamName.." GK" or tName == "s"..teamName then
					cleanup()
				end
			end
		end))

		table.insert(connections, RunService.Heartbeat:Connect(function()
			if not ball or not ball.Parent or not isActive then
				cleanup()
				return
			end

			if ball.AssemblyLinearVelocity.Magnitude > CONSTANTS.BALL_MOVEMENT_THRESHOLD then
				cleanup()
				return
			end

			for _, player in pairs(Players:GetPlayers()) do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local tName = player.Team and player.Team.Name
					if tName == teamName or tName == "-"..teamName.." GK" or tName == "s"..teamName then
						if (player.Character.HumanoidRootPart.Position - ball.Position).Magnitude < CONSTANTS.PROXIMITY_DISTANCE then
							cleanup()
							break
						end
					end
				end
			end
		end))

		if duration and duration > 0 then
			for i = duration, 1, -1 do
				if not isActive or not ball.Anchored then break end
				if timerLabel then timerLabel.Text = tostring(i) end
				task.wait(1)
			end
			if isActive then cleanup() end
		end
	end)
end

-- ============================================
-- TELEPORTE E RESUME
-- ============================================

local function teleportTeamsToKickoff()
	local spawns = {
		["Home"] = Vector3.new(-101.25, 833.975, 123),
		["Away"] = Vector3.new(-101.25, 833.975, -12),
		["-Home GK"] = Vector3.new(-101.25, 833.975, 313.5),
		["-Away GK"] = Vector3.new(-101.25, 833.975, -197.5)
	}

	for _, player in pairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos = spawns[player.Team and player.Team.Name]
			if pos then
				player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
			end
		end
	end
end

local function runResume(barrierType)
	clearBalls()
	task.wait(0.5)

	local kPos = getPosValue(SET_PIECES.KickOff)
	local ball = nil
	if kPos then
		ball = spawnBall(kPos, 0)
	end

	if barrierType and ball then
		ActivateBarrier(barrierType, ball, true)
	else
		ResetActiveBarriers()
	end

	local PlayerSpawns = workspace:FindFirstChild("PlayerSpawns")
	if PlayerSpawns then
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local targetSpawn = nil
				local tName = player.Team and player.Team.Name

				if tName == "Away" then targetSpawn = PlayerSpawns:FindFirstChild("AWA")
				elseif tName == "-Away GK" then targetSpawn = PlayerSpawns:FindFirstChild("AGK")
				elseif tName == "Home" then targetSpawn = PlayerSpawns:FindFirstChild("HOM")
				elseif tName == "-Home GK" then targetSpawn = PlayerSpawns:FindFirstChild("HGK")
				end

				if targetSpawn then
					player.Character.HumanoidRootPart.CFrame = targetSpawn.CFrame
				end
			end
		end
	end
end

-- ============================================
-- VERIFICAÇÃO OTIMIZADA DE GOL
-- ============================================

local function verifyGoal(ball, fieldEnd)
	local samples = {}

	for i = 1, CONSTANTS.GOAL_VERIFICATION_SAMPLES do
		if not ball or not ball.Parent then 
			return false 
		end

		local pos = ball.Position
		local dentroDaLargura = (pos.X > POSTS_X.Min) and (pos.X < POSTS_X.Max)
		local abaixoDoTravessao = (pos.Y < CONSTANTS.MAX_GOAL_HEIGHT)

		local isPastLine = false
		if fieldEnd == "Away" then
			isPastLine = pos.Z < (LINES.AwayLineZ - OFFSET * 1.5)
		else
			isPastLine = pos.Z > (LINES.HomeLineZ + OFFSET * 1.5)
		end

		samples[i] = (dentroDaLargura and abaixoDoTravessao and isPastLine)

		if i < CONSTANTS.GOAL_VERIFICATION_SAMPLES then
			task.wait(CONSTANTS.GOAL_VERIFICATION_INTERVAL)
		end
	end

	local confirmedGoal = true
	for _, sample in ipairs(samples) do
		if not sample then
			confirmedGoal = false
			break
		end
	end

	return confirmedGoal
end

-- ============================================
-- ANÁLISE DE JOGADAS
-- ============================================

local function analyzePlay(ball, eventType, fieldEnd)
	if not gameState.ballInPlay then 
		return 
	end

	-- VERIFICAR TIME VÁLIDO
	local isValid, touchInfo = isValidTeamTouch(ball)
	if not isValid then
		gameState.verificationDebounce = false
		return
	end

	gameState.ballInPlay = false
	gameState.verificationDebounce = false

	local lastTouch = touchInfo
	local ballX = ball.Position.X
	local ballZ = ball.Position.Z

	if eventType == "Lateral" then
		sendAlert(lastTouch.Name, lastTouch.Color, getRandomMsg("ThrowIn") .. " throw-in!", "THROW-IN")

		local restartX = (fieldEnd == "Away") and (LINES.MinX - 7) or (LINES.MaxX + 7)
		local restartZ = math.clamp(ballZ, LINES.AwayLineZ, LINES.HomeLineZ)
		local restartPos = Vector3.new(restartX, CONSTANTS.THROW_IN_HEIGHT, restartZ)

		local b = spawnBall(restartPos, 0)
		ResetActiveBarriers()

		if b then
			if lastTouch.Side == "Home" then
				applyLateralAnchor(b, "Away", CONSTANTS.THROW_IN_ANCHOR)
			elseif lastTouch.Side == "Away" then
				applyLateralAnchor(b, "Home", CONSTANTS.THROW_IN_ANCHOR)
			else
				b.Anchored = false
			end

			local opponentTeam = (lastTouch.Side == "Home") and "Away" or "Home"
			teleportNearestOpponent(b, opponentTeam)
		end

		gameState.waitingForReentry = true

	elseif eventType == "Linha de Fundo" then

		local isGoal = verifyGoal(ball, fieldEnd)

		if isGoal then
			local isOwnGoal = (lastTouch.Side == fieldEnd)
			local kickoffBarrier = nil

			if isOwnGoal then
				sendAlert(lastTouch.Name, lastTouch.Color, "scored an own goal!", "OWN GOAL!")
				pcall(function()
					goalNotificationEvent:FireAllClients({
						PlayerName = lastTouch.Name,
						TeamColor = lastTouch.Color,
						IsOwnGoal = true,
						TeamName = lastTouch.Side
					})
				end)
			else
				sendAlert(lastTouch.Name, lastTouch.Color, getRandomMsg("Goal"), "GOAL!")
				pcall(function()
					goalNotificationEvent:FireAllClients({
						PlayerName = lastTouch.Name,
						TeamColor = lastTouch.Color,
						IsOwnGoal = false,
						TeamName = lastTouch.Side
					})
				end)
			end

			pcall(function()
				local focusCameraEvent = ReplicatedStorage:FindFirstChild("FocusCamera")
				if focusCameraEvent then
					focusCameraEvent:FireAllClients(lastTouch.Name)
				end
			end)

			if fieldEnd == "Away" then
				kickoffBarrier = "ako"
			elseif fieldEnd == "Home" then
				kickoffBarrier = "hko"
			end

			task.spawn(function()
				wait(CONSTANTS.GOAL_WAIT_TIME)
				teleportTeamsToKickoff()
				runResume(kickoffBarrier)
				gameState.ballInPlay = true
				gameState.waitingForReentry = false
				gameState.lastBallPosition = nil
			end)

		else
			print("Não é gol - determinando tipo de jogada...")
			local defendingSide = fieldEnd

			if lastTouch.Side == defendingSide then
				-- ESCANTEIO
				sendAlert(lastTouch.Name, lastTouch.Color, getRandomMsg("Corner") .. " corner kick!", "CORNER KICK")

				local posL, posR
				local barrierName = ""

				if fieldEnd == "Home" then
					posL = getPosValue(SET_PIECES.HomeCL)
					posR = getPosValue(SET_PIECES.HomeCR)
					local distL = posL and math.abs(ballX - posL.X) or 9999
					local distR = posR and math.abs(ballX - posR.X) or 9999
					barrierName = (distL < distR) and "hcl" or "hcr"
				else
					posL = getPosValue(SET_PIECES.AwayCL)
					posR = getPosValue(SET_PIECES.AwayCR)
					local distL = posL and math.abs(ballX - posL.X) or 9999
					local distR = posR and math.abs(ballX - posR.X) or 9999
					barrierName = (distL < distR) and "acl" or "acr"
				end

				local targetPos = nil
				if posL and posR then
					local distL = math.abs(ballX - posL.X)
					local distR = math.abs(ballX - posR.X)
					targetPos = (distL < distR) and posL or posR
				elseif posL then targetPos = posL
				elseif posR then targetPos = posR
				end

				if targetPos then
					local b = spawnBall(targetPos, 0)
					if b then
						ActivateBarrier(barrierName, b, false)
						local opponentTeam = (lastTouch.Side == "Home") and "Away" or "Home"
						teleportNearestOpponent(b, opponentTeam)

						b.AncestryChanged:Connect(function(_, parent)
							if not parent then
								ResetActiveBarriers()
								gameState.waitingForReentry = false
								gameState.ballInPlay = true
							end
						end)
					end
				end
				gameState.waitingForReentry = true

			else
				-- TIRO DE META
				sendAlert(lastTouch.Name, lastTouch.Color, getRandomMsg("GoalKick") .. " goal kick!", "GOAL KICK")

				local targetName = (defendingSide == "Away") and SET_PIECES.AwayGK or SET_PIECES.HomeGK
				local posVal = getPosValue(targetName)
				local barrierName = (defendingSide == "Away") and "agk" or "hgk"

				if posVal then
					local b = spawnBall(posVal, 0)
					if b then
						ActivateBarrier(barrierName, b, false)
						local opponentTeam = (lastTouch.Side == "Home") and "Away" or "Home"
						teleportNearestOpponent(b, opponentTeam)

						b.AncestryChanged:Connect(function(_, parent)
							if not parent then
								ResetActiveBarriers()
								gameState.waitingForReentry = false
								gameState.ballInPlay = true
							end
						end)
					end
				end
				gameState.waitingForReentry = true
			end
		end
	end
end

-- ============================================
-- VERIFICAÇÃO COM DELAY
-- ============================================

local function verifyAndExecute(ball, type, side)
	if gameState.verificationDebounce then return end
	gameState.verificationDebounce = true

	task.spawn(function()
		task.wait(CONSTANTS.VERIFICATION_DELAY)

		if not ball or not ball.Parent then
			gameState.verificationDebounce = false
			return
		end

		local currentPos = ball.Position
		local confirmedOut = false

		if type == "AwayLineZ" and currentPos.Z < (LINES.AwayLineZ - OFFSET) then confirmedOut = true
		elseif type == "HomeLineZ" and currentPos.Z > (LINES.HomeLineZ + OFFSET) then confirmedOut = true
		elseif type == "MinX" and currentPos.X < (LINES.MinX - OFFSET) then confirmedOut = true
		elseif type == "MaxX" and currentPos.X > (LINES.MaxX + OFFSET) then confirmedOut = true
		end

		if confirmedOut then
			analyzePlay(ball, (type == "MinX" or type == "MaxX") and "Lateral" or "Linha de Fundo", side)
		else
			gameState.verificationDebounce = false
		end
	end)
end

-- ============================================
-- SISTEMA DE FALTAS
-- ============================================

if tripEvent then
	tripEvent.OnServerEvent:Connect(function(offenderPlayer, victimCharacter)
		print(string.format("[ÁRBITRO] Falta detectada: %s em %s", 
			offenderPlayer.Name, 
			victimCharacter and victimCharacter.Name or "?"))

		if not gameState.ballInPlay then return end

		if not victimCharacter or not victimCharacter:IsA("Model") then return end
		if not victimCharacter:FindFirstChild("HumanoidRootPart") then return end

		local victimPlayer = Players:GetPlayerFromCharacter(victimCharacter)
		if not victimPlayer then return end

		local offenderTeam = offenderPlayer.Team
		local victimTeam = victimPlayer.Team

		if not offenderTeam or not victimTeam then return end
		if offenderTeam == victimTeam then return end

		if offenderPlayer.Character and offenderPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (offenderPlayer.Character.HumanoidRootPart.Position - victimCharacter.HumanoidRootPart.Position).Magnitude
			if dist > CONSTANTS.MAX_FOUL_DISTANCE then return end
		end

		if gameState.activeFoulTimeout then
			task.cancel(gameState.activeFoulTimeout)
			gameState.activeFoulTimeout = nil
		end

		gameState.ballInPlay = false
		ResetActiveBarriers()

		local victimHum = victimCharacter:FindFirstChild("Humanoid")
		if victimHum then
			victimHum:ChangeState(Enum.HumanoidStateType.Physics)
			task.delay(2, function()
				if victimHum then victimHum:ChangeState(Enum.HumanoidStateType.GettingUp) end
			end)
		end

		local foulLocation = victimCharacter.HumanoidRootPart.Position
		local takingTeam = (offenderTeam.Name == "Home" or offenderTeam.Name == "-Home GK") and "Away" or "Home"
		local offenderSide = (takingTeam == "Home") and "Away" or "Home"

		local isPenalty = false

		if offenderSide == "Home" then
			if isInHomeBox(foulLocation) then isPenalty = true end
		elseif offenderSide == "Away" then
			if isInAwayBox(foulLocation) then isPenalty = true end
		end

		local targetPos = nil
		local barrierName = ""
		local alertMsg = ""
		local alertType = ""

		if isPenalty then
			barrierName = (takingTeam == "Home") and "hpk" or "apk"
			alertMsg = getRandomMsg("Penalty") .. " PENALTY!"
			alertType = "PENALTY KICK!"

			local pkValName = (takingTeam == "Home") and "HPK" or "APK"
			targetPos = getPosValue(pkValName) or foulLocation
		else
			barrierName = (takingTeam == "Away") and "afk" or "hfk"
			alertMsg = getRandomMsg("Foul") .. " " .. victimPlayer.Name .. "!"
			alertType = "FOUL!"

			local hrp = victimCharacter.HumanoidRootPart
			targetPos = Vector3.new(hrp.Position.X, 834.45, hrp.Position.Z)
		end

		sendAlert(offenderPlayer.Name, offenderPlayer.TeamColor.Color, alertMsg, alertType)

		local b = spawnBall(targetPos, 0)

		if b then
			b.AncestryChanged:Connect(function(_, parent)
				if not parent then
					ResetActiveBarriers()
					gameState.ballInPlay = true
					if gameState.activeFoulTimeout then
						task.cancel(gameState.activeFoulTimeout)
						gameState.activeFoulTimeout = nil
					end
				end
			end)

			b.Anchored = true
			setupBallVisuals(b, takingTeam, true)

			local timerLabel = nil
			if b:FindFirstChild("BillboardGui") then
				local img = b.BillboardGui:FindFirstChild("ImageLabel")
				if img then img.Visible = false end

				timerLabel = b.BillboardGui:FindFirstChild("TimerLabel")
				if not timerLabel then
					timerLabel = Instance.new("TextLabel")
					timerLabel.Name = "TimerLabel"
					timerLabel.BackgroundTransparency = 1
					timerLabel.Size = UDim2.new(1, 0, 1, 0)
					timerLabel.Font = Enum.Font.FredokaOne
					timerLabel.TextScaled = true
					timerLabel.TextColor3 = TEAM_COLORS[takingTeam].Outline
					timerLabel.TextStrokeTransparency = 0.5
					timerLabel.ZIndex = 2
					timerLabel.Parent = b.BillboardGui
				end
				timerLabel.Visible = true
			end

			ActivateBarrier(barrierName, b, false)

			local isLocked = true

			task.spawn(function()
				for i = 3, 1, -1 do
					if not b or not b.Parent then break end
					if timerLabel then timerLabel.Text = tostring(i) end
					task.wait(1)
				end
				isLocked = false
				if timerLabel then timerLabel.Visible = false end
				if b and b:FindFirstChild("BillboardGui") then
					local img = b.BillboardGui:FindFirstChild("ImageLabel")
					if img then img.Visible = true end
				end
			end)

			local connection
			connection = b.Touched:Connect(function(hit)
				if not b.Anchored or isLocked then return end

				local player = Players:GetPlayerFromCharacter(hit.Parent)
				if player then
					local pTeam = player.Team and player.Team.Name
					local isCobrador = false
					if takingTeam == "Home" and (pTeam == "Home" or pTeam == "-Home GK" or pTeam == "sHome") then isCobrador = true end
					if takingTeam == "Away" and (pTeam == "Away" or pTeam == "-Away GK" or pTeam == "sAway") then isCobrador = true end

					if isCobrador then
						b.CFrame = b.CFrame + Vector3.new(0, 0.3, 0)
						b.Anchored = false
						resetBallVisuals(b)

						local ownerVal = b:FindFirstChild("Owner")
						if ownerVal then ownerVal.Value = hit.Parent end

						gameState.ballInPlay = true
						if connection then connection:Disconnect() end
						if gameState.activeFoulTimeout then
							task.cancel(gameState.activeFoulTimeout)
							gameState.activeFoulTimeout = nil
						end

					end
				end
			end)
		end

		gameState.activeFoulTimeout = task.delay(CONSTANTS.FOUL_TIMEOUT, function()
			if not gameState.ballInPlay then
				gameState.ballInPlay = true
				ResetActiveBarriers()
			end
			gameState.activeFoulTimeout = nil
		end)
	end)
end

-- ============================================
-- LIMPEZA AUTOMÁTICA
-- ============================================

local ballsFolder = workspace:FindFirstChild("Balls")
if ballsFolder then
	ballsFolder.ChildRemoved:Connect(function(child)
		task.wait()
		if #ballsFolder:GetChildren() == 0 then
			gameState.ballInPlay = true
			gameState.waitingForReentry = false
			gameState.verificationDebounce = false
			ResetActiveBarriers()
		end
	end)
end

-- ============================================
-- LOOP PRINCIPAL
-- ============================================

local frameCount = 0

RunService.Heartbeat:Connect(function()
	frameCount = frameCount + 1
	if frameCount % CONSTANTS.HEARTBEAT_SKIP_FRAMES ~= 0 then return end

	local ballFolder = workspace:FindFirstChild("Balls")
	local ball = ballFolder and ballFolder:FindFirstChild("TPS")
	if not ball then 
		gameState.lastBallPosition = nil 
		return 
	end

	local currentPos = ball.Position
	if not gameState.lastBallPosition then 
		gameState.lastBallPosition = currentPos 
		return 
	end

	if gameState.waitingForReentry then
		local inX = (currentPos.X > LINES.MinX + 1) and (currentPos.X < LINES.MaxX - 1)
		local inZ = (currentPos.Z > LINES.AwayLineZ + 1) and (currentPos.Z < LINES.HomeLineZ - 1)

		if inX and inZ then
			gameState.waitingForReentry = false
			gameState.ballInPlay = true
			ResetActiveBarriers()
		end
		gameState.lastBallPosition = currentPos
		return
	end

	if gameState.ballInPlay and not gameState.verificationDebounce then
		if currentPos.Z < (LINES.AwayLineZ - OFFSET) then
			if gameState.lastBallPosition.Z >= (LINES.AwayLineZ - OFFSET) then 
				verifyAndExecute(ball, "AwayLineZ", "Away") 
			end

		elseif currentPos.Z > (LINES.HomeLineZ + OFFSET) then
			if gameState.lastBallPosition.Z <= (LINES.HomeLineZ + OFFSET) then 
				verifyAndExecute(ball, "HomeLineZ", "Home") 
			end

		elseif currentPos.X < (LINES.MinX - OFFSET) then
			if gameState.lastBallPosition.X >= (LINES.MinX - OFFSET) then 
				verifyAndExecute(ball, "MinX", "Away") 
			end

		elseif currentPos.X > (LINES.MaxX + OFFSET) then
			if gameState.lastBallPosition.X <= (LINES.MaxX + OFFSET) then 
				verifyAndExecute(ball, "MaxX", "Home") 
			end
		end
	end

	gameState.lastBallPosition = currentPos
end)

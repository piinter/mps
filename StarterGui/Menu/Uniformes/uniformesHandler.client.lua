-- nao esta funcionando no momento

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local localPlayer = Players.LocalPlayer

local CONFIGS = {
	RETRY_TIME = 10,
	ATUAL_NUMERO = 0,
}

local mainFrame = script.Parent:WaitForChild('Frame', math.huge)
local abrir = script.Parent:WaitForChild('Abrir', math.huge)
local aumentarNumero = mainFrame:WaitForChild('aumentaNumero', math.huge)
local diminuiNumero = mainFrame:WaitForChild('diminuiNumero', math.huge)
local getConfig = ReplicatedStorage:WaitForChild('getConfig', math.huge)
local updateNumero = ReplicatedStorage:WaitForChild('mudarNumero', math.huge)

local function reciveConfig(configName)
	local recivedConfig = nil
	
	recivedConfig = getConfig:InvokeServer(configName)
	
	if recivedConfig == nil then
		local startTime = tick()
		repeat task.wait()
			recivedConfig = getConfig:InvokeServer(configName)
		until recivedConfig ~= nil or tick() - startTime >= CONFIGS.RETRY_TIME
	end
	
	return recivedConfig
end

CONFIGS.NUMEROS_PERMITIDOS = reciveConfig('GetNumeros')
CONFIGS.CORES_PERMITIDAS = reciveConfig('GetCores')

local function desserializarColor3(s)
	if typeof(s) ~= 'string' then return end
	local r, g, b = string.match(s, "(%d+)%-(%d+)%-(%d+)")
	return Color3.fromRGB(r, g, b)
end

local function prepareColors()
	for i, cor in CONFIGS.CORES_PERMITIDAS do	
		cor = desserializarColor3(cor)
		
		local Template = mainFrame.cores.Template:Clone()
		Template.BackgroundColor3 = cor
		Template.Parent = mainFrame.cores
		Template.Visible = true
		
		Template.MouseButton1Click:Connect(function()
			updateNumero:FireServer('MudarCor', cor)
			mainFrame.numero.TextColor3 = cor
		end)
	end
end

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local torso = character:WaitForChild('Torso', math.huge)
local Numero = torso:WaitForChild('Numero', math.huge)

abrir.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

Numero.Numero:GetPropertyChangedSignal("Text"):Connect(function()
	mainFrame.numero_display.Text = Numero.Numero.Text
	mainFrame.numero.Text = Numero.Numero.Text
end)

aumentarNumero.MouseButton1Click:Connect(function()
	if CONFIGS.ATUAL_NUMERO +1 >= CONFIGS.NUMEROS_PERMITIDOS[1] and CONFIGS.ATUAL_NUMERO +1 <= CONFIGS.NUMEROS_PERMITIDOS[2] then
		updateNumero:FireServer('MudarNumero', tonumber(CONFIGS.ATUAL_NUMERO)  and CONFIGS.ATUAL_NUMERO +1 or 1)
		CONFIGS.ATUAL_NUMERO +=1
	end
end)

diminuiNumero.MouseButton1Click:Connect(function()
	if CONFIGS.ATUAL_NUMERO -1 >= CONFIGS.NUMEROS_PERMITIDOS[1] then
		updateNumero:FireServer('MudarNumero', CONFIGS.ATUAL_NUMERO -1)
		CONFIGS.ATUAL_NUMERO -=1
	else
		updateNumero:FireServer('MudarNumero', '')
		CONFIGS.ATUAL_NUMERO = 0
	end
end)

mainFrame.numero_display.Text = Numero.Numero.Text
CONFIGS.ATUAL_NUMERO = Numero.Numero.Text ~= '' and Numero.Numero.Text or 0
mainFrame.numero.Text = Numero.Numero.Text
mainFrame.numero.TextColor3 = Numero.Numero.TextColor3
prepareColors()
repeat task.wait() until game:IsLoaded()

local Rep = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local InputField = script.Parent

local Pasta = Rep:WaitForChild("__Eventos")
local RF = Pasta:WaitForChild("Function")

local CHAVE_DADOS = "PitchColourB"
local CAMPO = Workspace:WaitForChild("Campo", 10)
local GRAMA = CAMPO and CAMPO:WaitForChild("Grama", 10)

if not GRAMA then return end

local function atualizarCor(valorInput, salvar)
	if not valorInput then return end

	local B = math.clamp(math.floor(valorInput), 0, 255)

	-- Lê R e G da grama atual
	local atualR = math.floor(GRAMA.Color.R * 255)
	local atualG = math.floor(GRAMA.Color.G * 255)

	local novaCor = Color3.fromRGB(atualR, atualG, B)
	GRAMA.Color = novaCor

	-- Aplica em TODOS os pastos do jogo
	for _, descendant in Workspace:GetDescendants() do
		if descendant:IsA("BasePart") then
			local nome = string.lower(descendant.Name)
			if nome:find("grama") or nome:find("pasto") or nome:find("grass") or nome:find("lawn") then
				descendant.Color = novaCor
			end
		end
	end

	local sides = Workspace:FindFirstChild("Pitch") and Workspace.Pitch:FindFirstChild("Sides")
	if sides then
		for _, v in pairs(sides:GetChildren()) do
			if v:IsA("BasePart") then v.Color = novaCor end
		end
	end

	InputField.Text = tostring(B)

	if salvar then
		print("Salvando B:", B)
		task.spawn(function()
			RF:InvokeServer("MudarValor", {CHAVE_DADOS, B})
		end)
	end
end

InputField.FocusLost:Connect(function()
	local num = tonumber(InputField.Text)
	if num then
		atualizarCor(num, true)
	else
		InputField.Text = tostring(math.floor(GRAMA.Color.B * 255))
	end
end)

task.spawn(function()
	InputField.Text = "..."
	local sucesso, dados = pcall(function() return RF:InvokeServer("CarregarDados") end)
	if sucesso and dados then
		local b = dados.PitchColourB or 0
		InputField.Text = tostring(b)
	end
end)
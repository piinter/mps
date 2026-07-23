local Players = game:GetService("Players")
local player = Players.LocalPlayer
local sign = script.Parent
local updateEvent = sign:WaitForChild("UpdateSignText")
local gui = nil
local toggleButton = nil

local function createToggleButton(playerGui)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SignToggleGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 120, 0, 40)
	button.Position = UDim2.new(0.9, -60, 0.9, -20)
	button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	button.BorderSizePixel = 0
	button.Text = "Editar Placa"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button

	return screenGui, button
end

local function createGui(playerGui)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SignGui"
	screenGui.ResetOnSpawn = false
	screenGui.Enabled = false
	screenGui.Parent = playerGui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 300, 0, 150)
	frame.Position = UDim2.new(0.5, -150, 0.5, -75)
	frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	frame.BorderSizePixel = 2
	frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
	frame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 30)
	title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	title.BorderSizePixel = 0
	title.Text = "Editar Placa"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.Parent = frame

	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 8)
	titleCorner.Parent = title

	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0.9, 0, 0, 40)
	textBox.Position = UDim2.new(0.05, 0, 0, 45)
	textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	textBox.BorderSizePixel = 1
	textBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
	textBox.Text = ""
	textBox.PlaceholderText = "Digite o texto da placa..."
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 14
	textBox.ClearTextOnFocus = false
	textBox.Parent = frame

	local textBoxCorner = Instance.new("UICorner")
	textBoxCorner.CornerRadius = UDim.new(0, 4)
	textBoxCorner.Parent = textBox

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0.9, 0, 0, 35)
	button.Position = UDim2.new(0.05, 0, 0, 100)
	button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	button.BorderSizePixel = 0
	button.Text = "Atualizar Placa"
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.Parent = frame

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 4)
	buttonCorner.Parent = button

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	end)

	button.MouseButton1Click:Connect(function()
		local newText = textBox.Text
		updateEvent:FireServer(newText)

		button.Text = "Atualizado!"
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		task.wait(1)
		button.Text = "Atualizar Placa"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		screenGui.Enabled = false
	end)

	return screenGui
end

sign.Unequipped:Connect(function()
	if toggleButton then
		toggleButton:Destroy()
		toggleButton = nil
	end
	if gui then
		gui:Destroy()
		gui = nil
	end
end)

sign.Equipped:Connect(function()
	local playerGui = player:WaitForChild("PlayerGui")

	if not gui then
		gui = createGui(playerGui)
	end

	if not toggleButton then
		local toggleGui, btn = createToggleButton(playerGui)
		toggleButton = toggleGui

		btn.MouseButton1Click:Connect(function()
			gui.Enabled = not gui.Enabled
		end)
	end
end)
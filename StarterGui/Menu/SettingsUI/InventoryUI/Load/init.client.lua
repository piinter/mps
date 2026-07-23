local player = game.Players.LocalPlayer
local data = player:WaitForChild("PlayerData")
local pinsFolder = data:WaitForChild("Pins")
local template = script:WaitForChild("Template")

local function addPin(child)
	if not child:IsA("StringValue") then return end

	-- Evita duplicar pelo asset id
	for _, ui in ipairs(script.Parent:GetChildren()) do
		if ui:IsA("Frame") and ui.Image.Image == child.Value then
			return
		end
	end

	-- Nome lógico baseado no asset (fallback)
	local pinName = child.Name ~= "Value" and child.Name or "Pin"

	local pin = template:Clone()
	pin.Name = pinName
	pin.Label.Text = pinName
	pin.Image.Image = child.Value
	pin.Parent = script.Parent
	pin.Visible = true
end

-- Carrega os existentes
for _, child in ipairs(pinsFolder:GetChildren()) do
	addPin(child)
end

-- Escuta novos
pinsFolder.ChildAdded:Connect(addPin)

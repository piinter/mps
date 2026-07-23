local frame = script.Parent
local button = frame:WaitForChild("Equip")
local itemName = frame.Name
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local EquipEvent = ReplicatedStorage:WaitForChild("EquipBallHold")

local GAMEPASS_ID = 1728323893

local shopData = player:WaitForChild("ShopData")
local ownedFolder = shopData:WaitForChild("OwnedBallHolds")
local equippedName = shopData:WaitForChild("EquippedBallHoldName")

local function UpdateButtonText()
	if ownedFolder:FindFirstChild(itemName) then
		if equippedName.Value == itemName then
			button.Text = "Equipado"
			button.TextColor3 = Color3.fromRGB(12, 197, 43)
		else
			button.Text = "Equipar"
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
	else
		button.Text = "Comprar"
		button.TextColor3 = Color3.fromRGB(251, 189, 255)
	end
end

UpdateButtonText()

ownedFolder.ChildAdded:Connect(UpdateButtonText)
equippedName:GetPropertyChangedSignal("Value"):Connect(UpdateButtonText)

button.MouseButton1Click:Connect(function()
	if ownedFolder:FindFirstChild(itemName) then
		if equippedName.Value ~= itemName then
			EquipEvent:FireServer(itemName)
		end
	else
		if GAMEPASS_ID > 0 then
			MarketplaceService:PromptGamePassPurchase(player, GAMEPASS_ID)
		end
	end
end)
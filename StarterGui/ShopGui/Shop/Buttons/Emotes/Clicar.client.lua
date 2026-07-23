local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local botao = script.Parent.Parent:FindFirstChild('Emotes')
local menuPrincipal = playerGui:WaitForChild("ShopGui"):WaitForChild("Shop")
local MENU = menuPrincipal:FindFirstChild("BallHolds")
local OTHER = menuPrincipal:FindFirstChild("Emotes")

botao.MouseButton1Click:Connect(function()
	if MENU and OTHER then
		MENU.Visible = false
		OTHER.Visible = true
	end
end)
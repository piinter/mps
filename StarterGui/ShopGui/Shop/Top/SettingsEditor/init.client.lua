local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local Backpack = Player.Backpack

local Settings = require(Backpack.ToolManage:WaitForChild("Keybinds"))

local Player_data = Player:WaitForChild("Data")

local buttons = script.Parent:WaitForChild("Buttons")

local sections = script.Parent

local active_section = "BallHolds"

local button_connections = {}

for _, button in pairs(buttons:GetChildren()) do

	if button:IsA("ImageButton") then

		button.MouseButton1Click:Connect(function()

			script.Success:Play()

			sections[active_section].Visible = false

			if #button_connections ~= 0 then

				for _, button_connection in pairs(button_connections) do

					button_connection:Disconnect()

				end

			end

			local new_section = sections[button.Name]

			new_section.Visible = true

			active_section = button.Name

		end)

	end

end
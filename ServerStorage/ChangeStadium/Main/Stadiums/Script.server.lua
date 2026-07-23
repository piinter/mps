local folder = game.ServerStorage.Estadios
local scrollingFrame = script.Parent
local main = script.Parent.Parent.Parent.Main

local function createButtons()
	for _, model in pairs(folder:GetChildren()) do
		if model:IsA("Model") then
			local button = main.Template.Button:Clone()
			button.Name = model.Name
			button.Text = model.Name
			button.Parent = scrollingFrame
			button.Visible = true

			button.MouseButton1Click:Connect(function()
				if game.Workspace:FindFirstChild("StadiumMain") then
					game.Workspace.StadiumMain:Destroy()
					model.StadiumMain:clone().Parent = game.Workspace
				end
			end)
		end
	end
end

createButtons()
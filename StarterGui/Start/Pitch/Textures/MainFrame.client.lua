
local folder = game.ReplicatedStorage.PitchTextures
local scrollingFrame = script.Parent
local main = script.Parent.Parent.Parent.Pitch

local function createButtons()
	for _, model in pairs(folder:GetChildren()) do
		if model:IsA("Folder") then
			local button = main.Templates.Texture:Clone()
			button.Name = model.Name
			button.LeagueName.Text = model.Name
			button.Parent = scrollingFrame
			button.Visible = true
			button.Image = model.Texture.ImageLabel.Image

			button.MouseButton1Click:Connect(function()
				if game.ReplicatedStorage.GameStorage.Textures:FindFirstChild("Texture") then
					if game.Workspace.Campo.Grama:FindFirstChild("Texture") then
						game.ReplicatedStorage.GameStorage.Textures.Texture:Destroy()
						game.ReplicatedStorage.GameStorage.Textures.Roughness:Destroy()
						game.Workspace.Campo.Grama.Texture:Destroy()
						game.Workspace.Campo.Grama.Roughness:Destroy()
						model.Texture:clone().Parent = game.Workspace.Campo.Grama
						model.Roughness:clone().Parent = game.Workspace.Campo.Grama
					else
						game.ReplicatedStorage.GameStorage.Textures.Texture:Destroy()
						game.ReplicatedStorage.GameStorage.Textures.Roughness:Destroy()
						model.Texture:clone().Parent = game.ReplicatedStorage.GameStorage.Textures
						model.Roughness:clone().Parent = game.ReplicatedStorage.GameStorage.Textures
					end
				else
					game.Workspace.Campo.Grama.Texture:Destroy()
					game.Workspace.Campo.Grama.Roughness:Destroy()
					model.Texture:clone().Parent = game.Workspace.Campo.Grama
					model.Roughness:clone().Parent = game.Workspace.Campo.Grama
				end
			end)
		end
	end
end

createButtons()
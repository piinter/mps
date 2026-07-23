
local folder = game.ReplicatedStorage.Weather
local scrollingFrame = script.Parent
local main = script.Parent.Parent.Parent.Pitch

local function createButtons()
	for _, model in pairs(folder:GetChildren()) do
		if model:IsA("Folder") then
			local button = main.Templates.Weather:Clone()
			button.Name = model.Name
			button.LeagueName.Text = model.Name
			button.Parent = scrollingFrame
			button.Visible = true
			button.Image = model.Logo.Texture

			button.MouseButton1Click:Connect(function()
				if game.ReplicatedStorage.GameStorage.Skybox:FindFirstChild("RainZone") then
					if game.Workspace:FindFirstChild("RainZone") then
						game.ReplicatedStorage.GameStorage.Skybox.RainZone:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Sky:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Atmosphere:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Bloom:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.ColorCorrection:Destroy()
						game.Workspace.RainZone:Destroy()
						game.Lighting.Sky:Destroy()
						game.Lighting.Atmosphere:Destroy()
						game.Lighting.Bloom:Destroy()
						game.Lighting.ColorCorrection:Destroy()
						wait(0.1)
						model.Weather.RainZone:clone().Parent = game.Workspace
						model.Atmosphere:clone().Parent = game.Lighting
						model.Bloom:clone().Parent = game.Lighting
						model.Sky:clone().Parent = game.Lighting
						model.ColorCorrection:clone().Parent = game.Lighting
					else
						game.ReplicatedStorage.GameStorage.Skybox.RainZone:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Sky:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Atmosphere:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.Bloom:Destroy()
						game.ReplicatedStorage.GameStorage.Skybox.ColorCorrection:Destroy()
						wait(0.1)
						model.Weather.RainZone:clone().Parent = game.ReplicatedStorage.GameStorage.Skybox
						model.Atmosphere:clone().Parent = game.ReplicatedStorage.GameStorage.Skybox
						model.Bloom:clone().Parent = game.ReplicatedStorage.GameStorage.Skybox
						model.Sky:clone().Parent = game.ReplicatedStorage.GameStorage.Skybox
						model.ColorCorrection:clone().Parent = game.ReplicatedStorage.GameStorage.Skybox
					end
				else
					game.Workspace.RainZone:Destroy()
					game.Lighting.Sky:Destroy()
					game.Lighting.Atmosphere:Destroy()
					game.Lighting.Bloom:Destroy()
					game.Lighting.ColorCorrection:Destroy()
					wait(0.1)
					model.Weather.RainZone:clone().Parent = game.Workspace
					model.Atmosphere:clone().Parent = game.Lighting
					model.Bloom:clone().Parent = game.Lighting
					model.Sky:clone().Parent = game.Lighting
					model.ColorCorrection:clone().Parent = game.Lighting
				end
			end)
		end
	end
end

createButtons()
if game.Workspace:FindFirstChild("Entrada") then
	script.Parent.Text = "Copa ROBLOX Entrance (ON)"
else
	script.Parent.Text = "Copa ROBLOX Entrance (OFF)"
end
local Player = script.Parent.Parent.Parent.Parent.Parent.Parent

function leftClick(mouse)
	if game.Workspace:FindFirstChild("Entrada") then
		script.Parent.Parent.Parent.Parent.PrivateComands.Visible = false
		game.Workspace.Entrada:Destroy()
		script.Parent.Text = "Copa ROBLOX Entrance (OFF)"
		workspace.Configuration.Map.Entrada.Value = false
	else
		script.Parent.Parent.Parent.Parent.PrivateComands.Visible = false
		game.Lighting.Entrada:Clone().Parent = game.Workspace
		script.Parent.Text = "Copa ROBLOX Entrance (ON)"
		workspace.Configuration.Map.Entrada.Value = true
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.Map.Entrada.Changed:Connect(function()
	if workspace.Configuration.Map.Entrada.Value == true then
		script.Parent.Text = "Copa ROBLOX Entrance (ON)"
	else
		script.Parent.Text = "Copa ROBLOX Entrance (OFF)"
	end
end)


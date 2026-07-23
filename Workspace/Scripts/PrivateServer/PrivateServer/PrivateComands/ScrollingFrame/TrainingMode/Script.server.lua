if game.Workspace:FindFirstChild("TrainingMode") then
	script.Parent.Text = "Training Mode (ON)"
else
	script.Parent.Text = "Training Mode (OFF)"
end

local Player = script.Parent.Parent.Parent.Parent.Parent.Parent

function leftClick(mouse)
	if game.Workspace:FindFirstChild("TrainingMode") then
		script.Parent.Text = "Training Mode (OFF)"
		workspace.Configuration.Map.TrainingMode.Value = false
		game.Workspace.TrainingMode:Destroy()
	else
		script.Parent.Text = "Training Mode (ON)"
		workspace.Configuration.Map.TrainingMode.Value = false
		game.ServerStorage.TrainingMode:Clone().Parent = game.Workspace
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.Map.TrainingMode.Changed:Connect(function()
	if workspace.Configuration.Map.TrainingMode.Value == true then
		script.Parent.Text = "Training Mode (ON)"
	else
		script.Parent.Text = "Training Mode (OFF)"
	end
end)


script.Parent.Visible = game.Workspace.Configuration.AngleBar.Value

game.Workspace.Configuration.AngleBar.Changed:Connect(function()

	script.Parent.Visible = game.Workspace.Configuration.AngleBar.Value
end)
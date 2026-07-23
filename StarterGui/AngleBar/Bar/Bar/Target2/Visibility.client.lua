script.Parent.Visible = game.Workspace.Configuration.AngleBarTG.Value

game.Workspace.Configuration.AngleBarTG.Changed:Connect(function()

	script.Parent.Visible = game.Workspace.Configuration.AngleBarTG.Value
end)
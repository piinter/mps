script.Parent.Visible = game.Workspace.Configuration.SpawnPublicBall.Value

game.Workspace.Configuration.SpawnPublicBall.Changed:Connect(function()
	script.Parent.Visible = game.Workspace.Configuration.SpawnPublicBall.Value
end)
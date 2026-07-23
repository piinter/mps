script.Parent.Text = workspace.Scoreboard.Information.HomeScore.Value

workspace.Scoreboard.Information.HomeScore:GetPropertyChangedSignal("Value"):connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.HomeScore.Value
end)
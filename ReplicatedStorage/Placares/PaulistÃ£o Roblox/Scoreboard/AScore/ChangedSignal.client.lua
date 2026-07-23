script.Parent.Text = workspace.Scoreboard.Information.AwayScore.Value

workspace.Scoreboard.Information.AwayScore:GetPropertyChangedSignal("Value"):connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.AwayScore.Value
end)
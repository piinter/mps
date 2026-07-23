workspace.Scoreboard.Information.AwayScore:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.AwayScore.Value
end)
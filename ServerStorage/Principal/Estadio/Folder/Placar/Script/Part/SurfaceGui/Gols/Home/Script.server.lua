workspace.Scoreboard.Information.HomeScore:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.HomeScore.Value
end)
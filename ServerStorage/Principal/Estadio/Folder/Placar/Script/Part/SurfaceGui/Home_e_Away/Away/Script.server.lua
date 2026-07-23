workspace.Scoreboard.Information.AwayName:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.AwayName.Value
end)

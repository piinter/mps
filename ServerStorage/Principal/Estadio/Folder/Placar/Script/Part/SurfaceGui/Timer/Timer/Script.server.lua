workspace.Scoreboard.Timer.Minutes:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Timer.Minutes.Value..":"..workspace.Scoreboard.Timer.Seconds.Value
end)

workspace.Scoreboard.Timer.Seconds:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Timer.Minutes.Value..":"..workspace.Scoreboard.Timer.Seconds.Value
end)
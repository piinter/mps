workspace.Scoreboard.Information.HomeName:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.HomeName.Value
end)

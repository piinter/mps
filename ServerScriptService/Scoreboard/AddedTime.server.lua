workspace.Scoreboard.Timer.Minutes.Changed:Connect(function()
	if workspace.Scoreboard.Timer.Minutes.Value == 45 or workspace.Scoreboard.Timer.Minutes.Value == 90 or workspace.Scoreboard.Timer.Minutes.Value == 105 or workspace.Scoreboard.Timer.Minutes.Value == 120 then
		if workspace.Scoreboard.Timer.AddedTime.Value ~= 0 then
			script.Parent.Timer.Disabled = true
			workspace.Scoreboard.Timer.Seconds.Value = 0
			workspace.Scoreboard.AddedTime:FireAllClients()
		end
	end
end)
while true do
	wait()
	if workspace.Scoreboard.Timer.Seconds.Value < 10 then
		local i = workspace.Scoreboard.Timer.Seconds.Value
		workspace.Scoreboard.Timer.StringSeconds.Value = "0"..i
	else
		workspace.Scoreboard.Timer.StringSeconds.Value = workspace.Scoreboard.Timer.Seconds.Value
	end
	if workspace.Scoreboard.Timer.Minutes.Value < 10 then
		local i = workspace.Scoreboard.Timer.Minutes.Value
		workspace.Scoreboard.Timer.StringMinutes.Value = "0"..i
	else
		workspace.Scoreboard.Timer.StringMinutes.Value = workspace.Scoreboard.Timer.Minutes.Value
	end
end
while true do
	wait(0.3)
	if script.Disabled == true then return end
	if workspace.Scoreboard.Timer.Seconds.Value == 59 then
		workspace.Scoreboard.Timer.Seconds.Value = 0
		workspace.Scoreboard.Timer.Minutes.Value = workspace.Scoreboard.Timer.Minutes.Value + 1
	else
		workspace.Scoreboard.Timer.Seconds.Value = workspace.Scoreboard.Timer.Seconds.Value + 1
	end
end
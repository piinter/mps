workspace.Scoreboard.Timer.Minutes:GetPropertyChangedSignal("Value"):connect(function()
	local Minutes = ""
	local Seconds = ""
	if workspace.Scoreboard.Timer.Minutes.Value < 10 then 
		Minutes = "0"..workspace.Scoreboard.Timer.Minutes.Value
	else
		Minutes = workspace.Scoreboard.Timer.Minutes.Value
	end
	if workspace.Scoreboard.Timer.Seconds.Value < 10 then 
		Seconds = "0"..workspace.Scoreboard.Timer.Seconds.Value
	else
		Seconds = workspace.Scoreboard.Timer.Seconds.Value
	end
	script.Parent.Text = Minutes..":"..Seconds
end)

workspace.Scoreboard.Timer.Seconds:GetPropertyChangedSignal("Value"):connect(function()
	local Minutes = ""
	local Seconds = ""
	if workspace.Scoreboard.Timer.Minutes.Value < 10 then 
		Minutes = "0"..workspace.Scoreboard.Timer.Minutes.Value
	else
		Minutes = workspace.Scoreboard.Timer.Minutes.Value
	end
	if workspace.Scoreboard.Timer.Seconds.Value < 10 then 
		Seconds = "0"..workspace.Scoreboard.Timer.Seconds.Value
	else
		Seconds = workspace.Scoreboard.Timer.Seconds.Value
	end
	script.Parent.Text = Minutes..":"..Seconds
end)
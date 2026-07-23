-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

workspace.Scoreboard.Timer.Minutes:GetPropertyChangedSignal("Value"):connect(function()
	local v1
	if workspace.Scoreboard.Timer.Minutes.Value < 10 then
		v1 = "0" .. workspace.Scoreboard.Timer.Minutes.Value
	else
		v1 = workspace.Scoreboard.Timer.Minutes.Value
	end
	local v2
	if workspace.Scoreboard.Timer.Seconds.Value < 10 then
		v2 = "0" .. workspace.Scoreboard.Timer.Seconds.Value
	else
		v2 = workspace.Scoreboard.Timer.Seconds.Value
	end
	script.Parent.Text = v1 .. ":" .. v2
end)
workspace.Scoreboard.Timer.Seconds:GetPropertyChangedSignal("Value"):connect(function()
	local v1
	if workspace.Scoreboard.Timer.Minutes.Value < 10 then
		v1 = "0" .. workspace.Scoreboard.Timer.Minutes.Value
	else
		v1 = workspace.Scoreboard.Timer.Minutes.Value
	end
	local v2
	if workspace.Scoreboard.Timer.Seconds.Value < 10 then
		v2 = "0" .. workspace.Scoreboard.Timer.Seconds.Value
	else
		v2 = workspace.Scoreboard.Timer.Seconds.Value
	end
	script.Parent.Text = v1 .. ":" .. v2
end)
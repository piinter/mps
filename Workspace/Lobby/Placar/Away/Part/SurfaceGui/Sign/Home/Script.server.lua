-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

script.Parent.Text = workspace.Scoreboard.Information.AwayScore.Value
workspace.Scoreboard.Information.AwayScore:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.AwayScore.Value
end)
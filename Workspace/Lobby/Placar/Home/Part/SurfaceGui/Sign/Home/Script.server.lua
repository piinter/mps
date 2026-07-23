-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

script.Parent.Text = workspace.Scoreboard.Information.HomeScore.Value
workspace.Scoreboard.Information.HomeScore:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = workspace.Scoreboard.Information.HomeScore.Value
end)
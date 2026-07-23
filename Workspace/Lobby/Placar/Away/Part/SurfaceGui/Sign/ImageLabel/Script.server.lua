-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

script.Parent.Image = workspace.Configuration.KitConfig.AwayLogo.Texture
workspace.Configuration.KitConfig.AwayLogo:GetPropertyChangedSignal("Texture"):Connect(function()
	script.Parent.Image = workspace.Configuration.KitConfig.AwayLogo.Texture
end)
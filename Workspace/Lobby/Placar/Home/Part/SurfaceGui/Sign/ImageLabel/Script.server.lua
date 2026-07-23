-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

script.Parent.Image = workspace.Configuration.KitConfig.HomeLogo.Texture
workspace.Configuration.KitConfig.HomeLogo:GetPropertyChangedSignal("Texture"):Connect(function()
	script.Parent.Image = workspace.Configuration.KitConfig.HomeLogo.Texture
end)
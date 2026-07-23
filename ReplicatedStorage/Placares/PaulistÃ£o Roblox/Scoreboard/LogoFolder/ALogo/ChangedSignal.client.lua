script.Parent.Image = workspace.Configuration.KitConfig.AwayLogo.Texture

workspace.Configuration.KitConfig.AwayLogo:GetPropertyChangedSignal("Texture"):connect(function()
	script.Parent.Image = workspace.Configuration.KitConfig.AwayLogo.Texture
end)
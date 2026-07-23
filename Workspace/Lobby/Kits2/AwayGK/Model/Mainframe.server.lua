-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Bunni.lol Decompiler

local v_u_kitconfig = workspace.Configuration.KitConfig
local v_u_parent = script.Parent
v_u_parent.Pants.PantsTemplate = v_u_kitconfig.Pants_GGK.PantsTemplate
v_u_parent.Shirt.ShirtTemplate = v_u_kitconfig.Shirt_GGK.ShirtTemplate
workspace.Configuration.KitConfig.Pants_B:GetPropertyChangedSignal("PantsTemplate"):Connect(function()
	-- upvalues: (copy) v_u_parent, (copy) v_u_kitconfig
	v_u_parent.Pants.PantsTemplate = v_u_kitconfig.Pants_GGK.PantsTemplate
	v_u_parent.Shirt.ShirtTemplate = v_u_kitconfig.Shirt_GGK.ShirtTemplate
end)
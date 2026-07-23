local UserInputService = game:GetService("UserInputService")

local IsMobile = UserInputService.TouchEnabled --Is true if on mobile.

if IsMobile then --Only does things if it's on mobile.	
	script.Parent.Visible = true
	--workspace.Configuration.Plag.Value = true
end

local player = game.Players
local lclplr = player:FindFirstChild(script.Parent.Name)
local legs = script.Parent.HumanoidRootPart:FindFirstChild("Legs")

if legs then
	legs.LegLOD.BrickColor = lclplr.TeamColor
	script:Destroy()
end
local Debris = game:service("Debris")
local Tool = script.Parent

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Equipped = false
local Activated = false

local function MakePart(position)
	script.Parent.RemoteEvent:FireServer(position)
end

Tool.Equipped:connect(function(mouse)
	Equipped = true
end)

Tool.Unequipped:connect(function()
	Equipped = false
end)

Mouse.Button1Down:connect(function()
	if Equipped then
		Activated = true
	end
end)

Mouse.Button1Up:connect(function()
	Activated = false
end)

game:GetService("RunService").RenderStepped:connect(function()
	if Equipped and Activated then
		MakePart(Mouse.Hit.p)
	end
end)
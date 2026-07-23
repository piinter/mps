local shoot = script.Parent:WaitForChild("Shoot"):Clone()
local pass = script.Parent:WaitForChild("Pass"):Clone()
local long = script.Parent:WaitForChild("Long"):Clone()
local tackle = script.Parent:WaitForChild("Tackle"):Clone()
local dribble = script.Parent:WaitForChild("Dribble"):Clone()

script.Parent:WaitForChild("Shoot"):Destroy()
script.Parent:WaitForChild("Pass"):Destroy()
script.Parent:WaitForChild("Long"):Destroy()
script.Parent:WaitForChild("Tackle"):Destroy()
script.Parent:WaitForChild("Dribble"):Destroy()


	shoot.Parent = script.Parent
	pass.Parent = script.Parent
	long.Parent = script.Parent
	tackle.Parent = script.Parent
	dribble.Parent = script.Parent
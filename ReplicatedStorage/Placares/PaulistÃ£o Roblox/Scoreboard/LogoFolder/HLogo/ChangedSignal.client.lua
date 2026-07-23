local ReplicatedStorage = game:GetService("ReplicatedStorage")
local globalLogo = ReplicatedStorage:WaitForChild("GlobalLogo")

script.Parent.Image = globalLogo.Value

globalLogo:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Image = globalLogo.Value
end)

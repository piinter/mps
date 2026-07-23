local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
local QDown = false

local Tween = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))
local Mouse = game.Players.LocalPlayer:GetMouse()

local Direction = Enum.EasingDirection.Out
local Style = Enum.EasingStyle.Back
local Duration = 0.2
local CFRAME_HERE_1 = CFrame.new(1.8,0.4,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/0.41,-0.2,1)
local CFRAME_HERE_2 = CFrame.new(-1.8,0.4,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/0.41,0.2,-1)

local function Marker(Position, Target)
	if Target == nil or Target:FindFirstAncestor("Ignore") then
		return
	end
	game.ReplicatedStorage.Marker:FireServer(Position)
	
	for i, v in pairs(workspace.Markers:GetChildren()) do
		if v.Name == game.Players.LocalPlayer.Name then
			v:Destroy()
		end
	end
	
	local FakeColor = Instance.new("Part", game.ReplicatedStorage)
	FakeColor.BrickColor = game.Players.LocalPlayer.TeamColor
	
	local Color = FakeColor.Color
	local Marker = game.Lighting.Marker:Clone()
	
	Marker.Parent = workspace.Markers
	Marker.Marker.Icon.ImageColor3 = Color
	Marker.Marker.Label.Text = game.Players.LocalPlayer.Name
	Marker.Marker.Label.TextColor3 = Color
	Marker.Name = game.Players.LocalPlayer.Name
	Marker.Position = Position
	
	game.Debris:AddItem(Marker, 3)
	game.Debris:AddItem(FakeColor, 0)
end

script.Parent.Equipped:Connect(function (mouse)
	mouse.KeyDown:Connect(function (key)
		
		key = key:lower()
		if key == "q" then
			if QDown == false then
				
				QDown = true
				Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), CFRAME_HERE_1, Direction, Style, Duration)
				
				Marker(Mouse.Hit.p, Mouse.Target)
				
				wait(0.7)
				TM.ResetWelds()
				QDown = false
				
			end
		end
		
	end)
end)
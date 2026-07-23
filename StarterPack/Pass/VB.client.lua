local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))

local VDown = false
local BDown = false

local Tween = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))

local Direction = Enum.EasingDirection.Out
local Style = Enum.EasingStyle.Back
local Duration = 0.2
local CFRAME_HERE_1 = CFrame.new(1.8,0.4,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/0.41,-0.2,1)
local CFRAME_HERE_2 = CFrame.new(-1.8,0.4,-0.3) *  CFrame.fromEulerAnglesXYZ(math.pi/0.41,0.2,-1)

script.Parent.Equipped:Connect(function (mouse)
	mouse.KeyDown:Connect(function (key)
		
		key = key:lower()
		if key == "b" then
			if BDown == false and VDown == true or VDown == false then
				
				BDown = true
				Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), CFRAME_HERE_1, Direction, Style, Duration)
				wait(0.7)
				TM.ResetWelds()
				BDown = false
				
			end
		elseif key == "v" then
			if VDown == false and BDown == true or BDown == false then
				
				VDown = true
				Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), CFRAME_HERE_2, Direction, Style, Duration)
				wait(0.7)
				TM.ResetWelds()
				VDown = false
				
			end
		end
		
	end)
end)
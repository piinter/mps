local Tween = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"))

local Direction = Enum.EasingDirection.Out
local Style = Enum.EasingStyle.Back
local Duration = 0.2
local CFRAME_HERE

--RIGHT ARM--
Tween.TweenWeld("Right Arm", CFrame.new(1.5,0,0), CFRAME_HERE, Direction, Style, Duration)
--LEFT ARM--
Tween.TweenWeld("Left Arm", CFrame.new(-1.5,0,0), CFRAME_HERE, Direction, Style, Duration)
--RIGHT LEG--
Tween.TweenWeld("Right Leg", CFrame.new(0.5,-2,0), CFRAME_HERE, Direction, Style, Duration)
--Left LEG--
Tween.TweenWeld("Left Leg", CFrame.new(-0.5,-2,0), CFRAME_HERE, Direction, Style, Duration)
--HEAD--
Tween.TweenWeld("Head", CFrame.new(0,1.5,0), CFRAME_HERE, Direction, Style, Duration)

--[[
INSTRUCTIONS:
✦ Replace "CFRAME_HERE" with the cframe of the tool
✦ To know which limb to assign it to, look at the first set of words, that are placed in between quotation marks.
]]--
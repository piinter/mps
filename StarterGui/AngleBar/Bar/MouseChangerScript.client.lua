local screenGui = script.Parent.Parent
local frame = script.Parent
local players = game:GetService("Players")
local player = players.LocalPlayer or players.PlayerAdded:Wait()
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local IsMobile = UserInputService.TouchEnabled
local OldPosition = script.Parent.Position
local ABConfig = game.Workspace.Configuration.AngleBarFix

mouse.Move:Connect(function()
	if IsMobile then return end
	if ABConfig.Value == true then
		script.Parent.Position = OldPosition
		OldPosition = script.Parent.Position
		return
	end
	local xDimension = mouse.X
	local yDimension = mouse.Y
	local xResolution = screenGui.AbsoluteSize.X
	local yResolution = screenGui.AbsoluteSize.Y
	local framePosXStart = math.round(xResolution * frame.Position.X.Scale) + frame.Position.X.Offset
	local framePosXEnd = framePosXStart + math.round(xResolution * frame.Size.X.Scale) + frame.Size.X.Offset
	local framePosXMid = math.round((framePosXEnd - framePosXStart)/2)
	local framePosYStart = math.round(yResolution * frame.Position.Y.Scale) + frame.Position.Y.Offset
	local framePosYEnd = framePosYStart + math.round(xResolution * frame.Size.Y.Scale) + frame.Size.Y.Offset
	local framePosYMid = math.round((framePosYEnd - framePosYStart)/2)
	frame.Position = UDim2.new(0, xDimension-framePosXMid, 0, yDimension-framePosYMid)
end)
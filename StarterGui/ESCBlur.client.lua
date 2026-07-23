local GuiService = game:GetService('GuiService')
repeat wait() until workspace.CurrentCamera
local Camera = workspace.CurrentCamera
local Blur,Color = Instance.new('BlurEffect'),Instance.new('ColorCorrectionEffect')
Blur.Size = 0 Blur.Name = 'ESCB' Color.Saturation = 0 Color.Name = 'ESCC'

local TS = game:GetService('TweenService')

local NewBlur,NewColor = Blur:Clone(),Color:Clone()
NewBlur.Parent,NewColor.Parent = Camera,Camera

GuiService.MenuOpened:Connect(function()
	local Size = NewBlur.Size
	local Saturation = NewColor.Saturation
	TS:Create(NewBlur, TweenInfo.new(1), {Size = 25}):Play()
	TS:Create(NewColor, TweenInfo.new(1), {Saturation = -0.5}):Play()
end)
GuiService.MenuClosed:Connect(function()
	for i,v in pairs(Camera:GetChildren()) do
		if v.Name == "ESCB" then
			local OldBlur = v
			TS:Create(OldBlur, TweenInfo.new(1), {Size = 0}):Play()
		end
		if v.Name == "ESCC" then
			local OldCamera = v
			TS:Create(OldCamera, TweenInfo.new(1), {Saturation = 0}):Play()
		end
	end
end)

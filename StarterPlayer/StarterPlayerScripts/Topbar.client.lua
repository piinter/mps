--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local iconModule = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Icon")
local Player = game.Players.LocalPlayer
local icon = require(iconModule)
local playerGui = Player.PlayerGui

local BallCamUI = playerGui:WaitForChild("Menu"):WaitForChild("CamerasGUI"):WaitForChild("Main")
local Uniforms = playerGui:WaitForChild("Menu"):WaitForChild("Uniformes"):WaitForChild("Frame"):WaitForChild("UIScale")
local SettingsScaleUI = playerGui:WaitForChild("Menu"):WaitForChild("SettingsUI"):WaitForChild("UIScale")

SettingsScaleUI:GetPropertyChangedSignal("Scale"):Connect(function()
	if SettingsScaleUI.Scale <= 0.05 then
		SettingsScaleUI.Parent.Visible = false
	else
		SettingsScaleUI.Parent.Visible = true
	end
end)

local function OpenMenu(uiElm, PosFinal)
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local goal = { Position = PosFinal }
	local tween = TweenService:Create(uiElm, tweenInfo, goal)
	tween:Play()
end


local menu = icon.new()
	:setImage(90334229823797)
	:setLabel("Menu")
	:setMenu({
		icon.new()
		:setImage(123802788977158)
		:setName('Settings')
		:bindEvent('selected', function()
			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
			TweenService:Create(SettingsScaleUI, Info, { Scale = 1.25 }):Play()
		end)
		:bindEvent('deselected', function()
			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
			TweenService:Create(SettingsScaleUI, Info, { Scale = 0 }):Play()			
		end),

		icon.new()
		:setImage(84386086469298)
		:setName('Cameras')
		:bindEvent('selected', function()
			OpenMenu(BallCamUI, UDim2.new(0.5, 0, 0.75, 0))
		end)
		:bindEvent('deselected', function()
			OpenMenu(BallCamUI, UDim2.new(0.5, 0, 1.25, 0))
		end),
		
		icon.new()
		:setImage(104742980794507)
		:setName('Uniforms')
		:bindEvent('selected', function()
			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
			TweenService:Create(Uniforms, Info, { Scale = 1.25 }):Play()
		end)
		:bindEvent('deselected', function()
			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
			TweenService:Create(Uniforms, Info, { Scale = 0 }):Play()			
		end),
	})

local ShopScale = playerGui:WaitForChild("ShopGui"):WaitForChild("Shop"):WaitForChild("UIScale")

ShopScale:GetPropertyChangedSignal("Scale"):Connect(function()
	if ShopScale.Scale <= 0.05 then
		ShopScale.Parent.Visible = false
	else
		ShopScale.Parent.Visible = true
	end
end)

local shopIcon = icon.new()
	:setImage(3926307971)
	:setLabel("Loja")
	:setName("Shop")
	:bindEvent('selected', function()
		local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
		TweenService:Create(ShopScale, Info, { Scale = 1.25 }):Play()
	end)
	:bindEvent('deselected', function()
		local Info = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0)
		TweenService:Create(ShopScale, Info, { Scale = 0 }):Play()
	end)
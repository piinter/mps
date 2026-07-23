game.ReplicatedFirst:RemoveDefaultLoadingScreen()
local TweenService = game:GetService("TweenService")
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local starterGui = game:GetService("StarterGui")
local start = playerGui:WaitForChild("Start")
playerGui:SetTopbarTransparency(1)
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local gui = script:WaitForChild("NewLoadingUI"):Clone()
gui.Parent = playerGui
start.Enabled = false

local function onLoaded()
	repeat wait() until game:IsLoaded()
	wait(4)
	TweenService:Create(gui.Background, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),{Rotation = 45}):Play()
--	wait(4)
	gui.Background:TweenPosition(UDim2.new(1, 0, -1, 0), "Out", "Linear", 0.25, true)
	wait(1)
	starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
	starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	start.Enabled = true
	script:Destroy()
end

if game:IsLoaded() then
	onLoaded()
else
	game.Loaded:Wait()
	onLoaded()
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	
character:WaitForChild("HumanoidRootPart").AncestryChanged:Connect(function(_, parent)
		if parent == workspace then
			onLoaded()
		end
	end)
end)

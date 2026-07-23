--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
 
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
 
local GlobalAnnouncementEvent = ReplicatedStorage:WaitForChild("GlobalAnnouncementEvent")
 
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
 
local container = playerGui:FindFirstChild("AnnouncementContainer")
if not container then
    container = Instance.new("ScreenGui")
    container.Name = "AnnouncementContainer"
    container.ResetOnSpawn = false
    container.IgnoreGuiInset = true
    container.Parent = playerGui
end
 
local activeAnnouncements = {}
local topPadding = 60
local paddingBetween = 3
 
local function addAnnouncement(bg, textLabel, sound, height)
    bg.ImageTransparency = 1
    textLabel.TextTransparency = 1
    
    local stroke = textLabel:FindFirstChildOfClass("UIStroke")
    if stroke then
        stroke.Transparency = 1
    end
    
    bg.AnchorPoint = Vector2.new(0.5, 0)
    local screenHeight = container.AbsoluteSize.Y
    local startY = topPadding + (0.15 * screenHeight)
    
    local targetY = topPadding
    for _, ann in ipairs(activeAnnouncements) do
        targetY = targetY + ann.height + paddingBetween
    end
    
    bg.Position = UDim2.new(0.5, 0, 0, startY)
    bg.Parent = container
    
    table.insert(activeAnnouncements, { instance = bg, bg = bg, height = height })
    
    local slideTween = TweenService:Create(bg, tweenInfo, {
    Position = UDim2.new(0.5, 0, 0, targetY),
    ImageTransparency = 0.6
    })
    local textFadeIn = TweenService:Create(textLabel, tweenInfo, { TextTransparency = 0 })
    local strokeFadeIn = stroke and TweenService:Create(stroke, tweenInfo, { Transparency = 0.3 })
    
    slideTween:Play()
    textFadeIn:Play()
    if strokeFadeIn then strokeFadeIn:Play() end
    sound:Play()
end
 
local function removeAnnouncement(bg, textLabel, sound)
    local index
    for i, ann in ipairs(activeAnnouncements) do
        if ann.instance == bg then
            index = i
            break
        end
    end
    if not index then return end
    
    local stroke = textLabel:FindFirstChildOfClass("UIStroke")
    
    local bgFadeOut = TweenService:Create(bg, tweenInfo, { ImageTransparency = 1 })
    local textFadeOut = TweenService:Create(textLabel, tweenInfo, { TextTransparency = 1 })
    local strokeFadeOut = stroke and TweenService:Create(stroke, tweenInfo, { Transparency = 1 })
    
    bgFadeOut:Play()
    textFadeOut:Play()
    if strokeFadeOut then strokeFadeOut:Play() end
    
    bgFadeOut.Completed:Connect(function()
        bg:Destroy()
        sound:Destroy()
        local removedHeight = activeAnnouncements[index].height
        table.remove(activeAnnouncements, index)
        
        local pullAmount = removedHeight + paddingBetween
        for i = index, #activeAnnouncements do
            local ann = activeAnnouncements[i]
            local currentPos = ann.bg.Position
            local newPos = UDim2.new(0.5, 0, 0, currentPos.Y.Offset - pullAmount)
            local pullTween = TweenService:Create(ann.bg, tweenInfo, { Position = newPos })
            pullTween:Play()
        end
    end)
end
 
local function showAnnouncement(data)
    if typeof(data) ~= "table" or type(data.text) ~= "string" then return end
    
    local AnnouncementUI = ReplicatedStorage:WaitForChild("AnnouncementUI")
    local bg = AnnouncementUI:WaitForChild("BG"):Clone()
    local textLabel = bg:WaitForChild("Text")
    
    textLabel.Text = data.text
    
    bg.Parent = container
    task.wait()
    local height = bg.AbsoluteSize.Y
    bg.Parent = nil
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://71450094482101" -- replace with your notification sound
    sound.Volume = 0.5
    sound.Parent = bg
    
    addAnnouncement(bg, textLabel, sound, height)
    task.wait(data.duration or 5)
    removeAnnouncement(bg, textLabel, sound)
end
 
GlobalAnnouncementEvent.OnClientEvent:Connect(showAnnouncement)


--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local TextChatService = game:GetService("TextChatService")
 
--// RemoteEvents
local GlobalAnnouncementEvent = Instance.new("RemoteEvent")
GlobalAnnouncementEvent.Name = "GlobalAnnouncementEvent"
GlobalAnnouncementEvent.Parent = ReplicatedStorage

local GlobalRequestEvent = Instance.new("RemoteEvent")
GlobalRequestEvent.Name = "GlobalRequestEvent"
GlobalRequestEvent.Parent = ReplicatedStorage

--// Whitelisted Users
local Admins = {
["oyiseh"] = true,
}
 
--// Command Setup
local globalCommand = Instance.new("TextChatCommand")
globalCommand.Name = "GlobalAnnouncement"
globalCommand.PrimaryAlias = "/global" -- Replace with your own prefix
globalCommand.Parent = TextChatService

globalCommand.Triggered:Connect(function(textSource, rawMessage)
    local player = game.Players:GetPlayerByUserId(textSource.UserId)
    if not player or not Admins[player.Name] then return end
    
    local announcementText = rawMessage:sub(#globalCommand.PrimaryAlias + 1):gsub("^%s+", "")
    if announcementText == "" then return end
    if #announcementText > 1000 then return end
    
    local data = {  
    text = announcementText,  
    duration = 5, -- Change the Duration if you want  
    sender = player.DisplayName  
    }  
    
    local success, err = pcall(function()  
        MessagingService:PublishAsync("GlobalAnnouncement", data)  
    end)  
    if not success then  
        warn("Failed to publish announcement:", err)  
    end
end)

MessagingService:SubscribeAsync("GlobalAnnouncement", function(message)
    local data = message.Data
    if typeof(data) == "table" and data.text and data.sender then
        GlobalAnnouncementEvent:FireAllClients({
        text = data.sender .. ": " .. data.text, -- Add verified symbol if you want, i don't have any verified symbol in this code but you can search it on Google
        duration = data.duration or 5,
        id = tostring(tick())
        })
    end
end)

GlobalRequestEvent.OnServerEvent:Connect(function(player, announcementText)
    if not Admins[player.Name] then return end
    if type(announcementText) ~= "string" or announcementText == "" then return end
    if #announcementText > 1000 then return end
    
    local data = {  
    text = announcementText,  
    duration = 5,  
    sender = player.DisplayName  
    }  
    
    local success, err = pcall(function()  
        MessagingService:PublishAsync("GlobalAnnouncement", data)  
    end)  
    if not success then  
        warn("Failed to publish announcement:", err)  
    end
end)


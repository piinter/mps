local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remoteGetServerRegion = ReplicatedStorage.RemoteGetServerRegion
local serverRegion = remoteGetServerRegion:InvokeServer()

script.Parent.Text = "Server Host: "..serverRegion

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local remoteGetServerRegion = ReplicatedStorage.RemoteGetServerRegion

local serverRegion

remoteGetServerRegion.OnServerInvoke = function()
	if not serverRegion then
		local success,data
		local failures = 0
		local maxFailures = 10
		while failures < maxFailures do
			local success, result = pcall(function()
				local json = HttpService:GetAsync("http://ip-api.com/json")
				data = HttpService:JSONDecode(json)
			end)
			if success then
				break
			else
				failures = failures + 1
				if failures == maxFailures then
					error("Failed to get server region")
				else
					wait(0.1)
				end
			end
		end
		if data then
			serverRegion = data.regionName
		end
	end
	
	return serverRegion
end
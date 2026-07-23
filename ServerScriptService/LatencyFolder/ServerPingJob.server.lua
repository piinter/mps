local rfunc = Instance.new("RemoteFunction")
rfunc.Parent = game.Workspace
rfunc.Name = "ClientPingMeter"

function rfunc.OnServerInvoke()
	return true
end

local event = Instance.new("RemoteFunction")
event.Parent = game.Workspace
event.Name = "GlobalServerClientPing"
	
local PingClient = Instance.new("BindableFunction")
PingClient.Name = "PingClient"
PingClient.Parent = game.ServerScriptService:WaitForChild("LatencyFolder")
 
function PingClient.OnInvoke(playername)
	if game.Players:FindFirstChild(playername) then
		local stime = os.clock()
		local result = game.Workspace:WaitForChild("GlobalServerClientPing"):InvokeClient(game.Players:FindFirstChild(playername))
		local etime = os.clock()
		local ttime = math.floor((etime - stime) * 1000)
		return ttime
	else
		return false
	end
end


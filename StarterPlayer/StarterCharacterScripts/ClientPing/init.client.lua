local pingrate = 1 -- Ping rate (seconds)

while true do
	ptick = tick()
	result = game.Workspace.ClientPingMeter:InvokeServer()
	if result == true then
		ctick = tick()
		ttick = math.floor(((ctick - ptick) *1000) + 0.5)  --[[%86400*1000]]
		game.ReplicatedStorage.UpdatePing:FireServer(ttick)
	end
	wait(pingrate)
end
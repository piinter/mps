local RS = game:GetService("ReplicatedStorage")
local Event13 = RS:WaitForChild("UpdateUniform1")
local Event14 = RS:WaitForChild("UpdateUniform2")

Event13.OnServerEvent:connect(function(player, TextBack)
	local Character = player.Character
	local CharTable = Character:GetChildren()
	
	if Character.Torso:FindFirstChild("UNINAME") then
		Character.Torso.UNINAME:Destroy()
	end
	local UNIFORM = game.ServerStorage.KitStorage.UNINAME:Clone()
	UNIFORM.Parent = Character.Torso
	UNIFORM.NAME.Text = TextBack
end)

Event14.OnServerEvent:connect(function(player, TextBack)
	local Character = player.Character
	local CharTable = Character:GetChildren()

	if Character.Torso:FindFirstChild("UNINUMBER") then
		Character.Torso.UNINUMBER:Destroy()
	end
	local UNIFORM = game.ServerStorage.KitStorage.UNINUMBER:Clone()
	UNIFORM.Parent = Character.Torso
	UNIFORM.NUMBER.Text = TextBack
end)

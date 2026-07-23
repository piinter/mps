local nametag = script:WaitForChild("Zzz")


game.ReplicatedStorage.IsAFK.OnServerEvent:Connect(function(plr, isAFK)
	local char = plr.Character or plr.CharacterAdded:Wait()
	local head = char:WaitForChild("Head")

	if isAFK and not head:FindFirstChild(nametag.Name) then
		nametag:Clone().Parent = head
		local Head = char:WaitForChild("Head")
		local LL = char:WaitForChild("Left Leg")
		local RL = char:WaitForChild("Right Leg")
		local RA = char:WaitForChild("Right Arm")
		local LA = char:WaitForChild("Left Arm")
		local Torso = char:WaitForChild("Torso")
	elseif not isAFK and head:FindFirstChild(nametag.Name) then
		head[nametag.Name]:Destroy()
		local Head = char:WaitForChild("Head")
		local LL = char:WaitForChild("Left Leg")
		local RL = char:WaitForChild("Right Leg")
		local RA = char:WaitForChild("Right Arm")
		local LA = char:WaitForChild("Left Arm")
		local Torso = char:WaitForChild("Torso")
	end
end)
local Groups = game:GetService("GroupService")

local indexCheck = function(v: ProximityPrompt)
	if v:GetAttribute("GroupID") ~= 0 then
		local gName
		local s,res = pcall(function()
			return Groups:GetGroupInfoAsync(v:GetAttribute("GroupID"))
		end)
		if s then v.ObjectText = "Você precisa estar no grupo "..res.Name else v.ObjectText = "Você precisa estar no grupo "..v:GetAttribute("GroupID") end
	elseif v:GetAttribute("Plus") then
		v.ObjectText = " "
	end
end

for i,v in pairs(workspace:FindFirstChild('Lobby'):FindFirstChild('Kits'):GetDescendants()) do
	if v:IsA("ProximityPrompt") then
		indexCheck(v)
		v.Triggered:Connect(function(pl)
			if v:GetAttribute("GroupID") ~= 0 then 
				if not pl:IsInGroup(v:GetAttribute("GroupID")) then 
					return
				end 
			end
			
			if pl.Character then
				for _, x in pairs(pl.Character:GetDescendants()) do
					if x:IsA("Shirt") or x:IsA("ShirtGraphic") or x:IsA("Pants") then x:Destroy() end
				end
				v.Parent.Shirt:Clone().Parent = pl.Character
				v.Parent.Pants:Clone().Parent = pl.Character
			end
		end)
	end
end
Keywords = {"rtp","re","RTP","RE"}

game.Players.PlayerAdded:connect(function(plr)
	plr.Chatted:connect(function(msg)
		for _, v in pairs(Keywords) do
			if v:lower() == msg:lower() then
				pcall(function()
					local Pos = plr.Character:GetPrimaryPartCFrame()
					plr:LoadCharacter()
					plr.Character:SetPrimaryPartCFrame(Pos)
					if plr.Character:FindFirstChild("ForceField") then
						plr.Character["ForceField"]:Destroy()
					end
				end)
			end
		end
	end)
	
	plr.CharacterAdded:connect(function(char)
		repeat wait() until char.Humanoid
		char.Humanoid.Died:connect(function(OMG)
			plr:LoadCharacter(true)
		end)
	end)
end)
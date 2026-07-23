-- kitmenu script 2.0

local KitCon = game.Workspace.Configuration.KitConfig
local HomeS = KitCon.Shirt_B
local HomeP = KitCon.Pants_B
local HomeGKS = KitCon.Shirt_BGK
local HomeGKP = KitCon.Pants_BGK
local AwayS = KitCon.Shirt_G
local AwayP = KitCon.Pants_G
local AwayGKS = KitCon.Shirt_GGK
local AwayGKP = KitCon.Pants_GGK

function KitmenuHome(character)
	if not character:findFirstChild("Shirt") then 
		local newshirt = HomeS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	else
		character:findFirstChild("Shirt"):Destroy()
		local newshirt = HomeS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	end

	if not character:findFirstChild("Pants") then 
		local newpants = HomeP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	else 
		character:findFirstChild("Pants"):Destroy()
		local newpants = HomeP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	end
end

function KitmenuAway(character)
	if not character:findFirstChild("Shirt") then 
		local newshirt = AwayS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	else
		character:findFirstChild("Shirt"):Destroy()
		local newshirt = AwayS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	end

	if not character:findFirstChild("Pants") then 
		local newpants = AwayP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	else 
		character:findFirstChild("Pants"):Destroy()
		local newpants = AwayP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	end
end

function KitmenuHomeGK(character)
	if not character:findFirstChild("Shirt") then 
		local newshirt = HomeGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	else
		character:findFirstChild("Shirt"):Destroy()
		local newshirt = HomeGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	end

	if not character:findFirstChild("Pants") then 
		local newpants = HomeGKP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	else 
		character:findFirstChild("Pants"):Destroy()
		local newpants = HomeGKP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	end
end

function KitmenuAwayGK(character)
	if not character:findFirstChild("Shirt") then 
		local newshirt = AwayGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	else
		character:findFirstChild("Shirt"):Destroy()
		local newshirt = AwayGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	end

	if not character:findFirstChild("Pants") then 
		local newpants = AwayGKP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	else 
		character:findFirstChild("Pants"):Destroy()
		local newpants = AwayGKP:Clone()
		newpants.Parent = character
		newpants.Name = "Pants"
	end
end

function KitmenuFans(character)
	if KitCon.FansShirt.Value == false then return end
	if not character:findFirstChild("Shirt") then 
		local newshirt = HomeGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	else
		character:findFirstChild("Shirt"):Destroy()
		local newshirt = HomeGKS:Clone()
		newshirt.Parent = character
		newshirt.Name = "Shirt"
	end
end

game.Players.PlayerAdded:connect(function(p)
	p.CharacterAdded:connect(function(char)
		wait(1.12)
		local plr = game.Players:findFirstChild(char.Name)
		print(char.Name)

		if plr.TeamColor == BrickColor.new("Bright blue") then 
			KitmenuHome(char)
		elseif plr.TeamColor == BrickColor.new("Bright green") then 
			KitmenuAway(char)
		elseif plr.TeamColor == BrickColor.new("Really blue") then 
			KitmenuHomeGK(char)
		elseif plr.TeamColor == BrickColor.new("Camo") then 
			KitmenuAwayGK(char)
		elseif plr.TeamColor == BrickColor.new("Medium stone grey") then 
			KitmenuFans(char)
		end
	end)
end)

AwayS.Changed:Connect(function()
	game.ReplicatedStorage.Kits.Container.Away.Shirt.ShirtTemplate = AwayS.ShirtTemplate
end)
AwayP.Changed:Connect(function()
	game.ReplicatedStorage.Kits.Container.Away.Pants.PantsTemplate = AwayP.PantsTemplate
end)
HomeS.Changed:Connect(function()
	game.ReplicatedStorage.Kits.Container.Home.Shirt.ShirtTemplate = HomeS.ShirtTemplate
end)
HomeP.Changed:Connect(function()
	game.ReplicatedStorage.Kits.Container.Home.Pants.PantsTemplate = HomeP.PantsTemplate
end)
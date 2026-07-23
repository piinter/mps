--INSTRUCTIONS:
--Put this script in the part that you want
--Instead of Mid gray put the team color they change to
--Subscribe to UnaffectedGaming

local changedTeam = BrickColor.new("Really blue"); -- replace Mid gray with the team color they change to

local part = script.Parent;

part.Touched:connect(function(hit)

	local plr = game.Players:GetPlayerFromCharacter(hit.Parent);

	if #game:GetService("Teams")["-Home GK"]:GetPlayers() < 1 then
		plr.TeamColor = changedTeam;
	else
		return
	end	
end)
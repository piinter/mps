
local Player = script.Parent.Parent.Parent.Parent.Parent.Parent

function leftClick(mouse)
	game.ServerStorage.ChangeStadium:Clone().Parent = Player.PlayerGui
end

script.Parent.MouseButton1Click:connect(leftClick)


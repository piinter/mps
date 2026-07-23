bin = script.Parent  
char = nil

function onButton1Down(mouse) 
local plr = game.Players:getPlayerFromCharacter(char)
if plr ~= nil then
local plrgui = plr:findFirstChild("PlayerGui")
if plrgui ~= nil then
local find = plrgui:findFirstChild("DeathNote" .. " - " .. plr.Name)
if find == nil then
local new = Instance.new("ScreenGui")
new.Name = "DeathNote" .. " - " .. plr.Name
new.Parent = plrgui
local deathnote = script:findFirstChild("Notebook")
if deathnote ~= nil then
deathnote.Parent = new
end
end
end
end
end

function onDeselected() 
local plr = game.Players:getPlayerFromCharacter(char)
if plr ~= nil then
local plrgui = plr:findFirstChild("PlayerGui")
if plrgui ~= nil then
local find = plrgui:findFirstChild("DeathNote" .. " - " .. plr.Name)
if find ~= nil then
local ntbk = find:findFirstChild("Notebook")
if ntbk ~= nil then
ntbk.Parent = script
find.Parent = nil
end
end
end
end
end

function onSelected(mouse)
char = script.Parent.Parent
local user = script:findFirstChild("Notebook"):findFirstChild("User")
user.Value = game.Players:getPlayerFromCharacter(char).Name
mouse.Icon = ""
mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end

bin.Equipped:connect(onSelected)
bin.Unequipped:connect(onDeselected)
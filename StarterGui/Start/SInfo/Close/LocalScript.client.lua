--Script made by sermi, edited by me, karaoke60000! (I added the right click function)
--To open GUI, left click. To close, right click!
function leftClick(mouse)
	script.Parent.Parent.Parent.SInfo.Visible = false
end
script.Parent.MouseButton1Click:connect(leftClick)
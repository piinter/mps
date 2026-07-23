--Script made by sermi, edited by me, karaoke60000! (I added the right click function)
--To open GUI, left click. To close, right click!
function leftClick(mouse)
	if 	script.Parent.Parent.drag.Enabled == false then
		script.Parent.Parent.drag.Enabled = true
	elseif 	script.Parent.Parent.drag.Enabled == true then
		script.Parent.Parent.drag.Enabled = false
	end
end
script.Parent.MouseButton1Click:connect(leftClick)
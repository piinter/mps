--Script made by sermi, edited by me, karaoke60000! (I added the right click function)
--To open GUI, left click. To close, right click!
function leftClick(mouse)
	if 	script.Parent.Parent.GKUI.Visible == false then
		script.Parent.Parent.GKUI.Visible = true
		script.Parent.Parent.SkillsUI.Visible = false
		script.Parent.Parent.DribbleUI.Visible = false
		script.Parent.Parent.TackleUI.Visible = false
		script.Parent.Parent.ShootUI.Visible = false
	elseif 	script.Parent.Parent.GKUI.Visible == true then
		script.Parent.Parent.GKUI.Visible = false
	end
end
script.Parent.MouseButton1Click:connect(leftClick)
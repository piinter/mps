function leftClick(mouse)
	script.Parent.Parent.PrivateComands.Visible = not script.Parent.Parent.PrivateComands.Visible
end
script.Parent.MouseButton1Click:connect(leftClick)
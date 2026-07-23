if workspace.Configuration.FirstTouch.Value == true then
	script.Parent.Text = "First Touch Mode (ON)"
else
	script.Parent.Text = "First Touch Mode (OFF)"
end

function leftClick(mouse)
	if 	workspace.Configuration.FirstTouch.Value == false then
		workspace.Configuration.FirstTouch.Value = true
		script.Parent.Text = "First Touch Mode (ON)"
	else
		workspace.Configuration.FirstTouch.Value = false
		script.Parent.Text = "First Touch Mode (OFF)"
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.FirstTouch.Changed:Connect(function()
	if workspace.Configuration.FirstTouch.Value == true then
		script.Parent.Text = "First Touch Mode (ON)"
	else
		script.Parent.Text = "First Touch Mode (OFF)"
	end
end)



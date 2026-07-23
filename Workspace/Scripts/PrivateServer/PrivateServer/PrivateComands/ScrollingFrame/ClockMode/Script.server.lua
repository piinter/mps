if workspace.Configuration.Tempo.Value == true then
	script.Parent.Text = "Clock Mode (ON)"
else
	script.Parent.Text = "Clock Mode (OFF)"
end

function leftClick(mouse)
	if 	workspace.Configuration.Tempo.Value == false then
		workspace.Configuration.Tempo.Value = true
		script.Parent.Text = "Clock Mode (ON)"
	else
		workspace.Configuration.Tempo.Value = false
		script.Parent.Text = "Clock Mode (OFF)"
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.Tempo.Changed:Connect(function()
	if workspace.Configuration.Tempo.Value == true then
		script.Parent.Text = "Clock Mode (ON)"
	else
		script.Parent.Text = "Clock Mode (OFF)"
	end
end)



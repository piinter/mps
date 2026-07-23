
if 	workspace.Configuration.SpawnPublicBall.Value == false then
	script.Parent.Text = "Personal Ball Mode (OFF)"
else
	script.Parent.Text = "Personal Ball Mode (ON)"
end

function leftClick(mouse)
	if 	workspace.Configuration.SpawnPublicBall.Value == false then
		workspace.Configuration.SpawnPublicBall.Value = true
		script.Parent.Text = "Personal Ball Mode (ON)"
	else
		workspace.Configuration.SpawnPublicBall.Value = false
		script.Parent.Text = "Personal Ball Mode (OFF)"
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.SpawnPublicBall.Changed:Connect(function()
	if workspace.Configuration.SpawnPublicBall.Value == true then
		script.Parent.Text = "Personal Ball Mode (ON)"
	else
		script.Parent.Text = "Personal Ball Mode (OFF)"
	end
end)

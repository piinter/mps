if game.TextChatService.BubbleChatConfiguration.Enabled == false then
	script.Parent.Text = "Bubble Chat Mode (OFF)"
else
	script.Parent.Text = "Bubble Chat Mode (ON)"
end

function leftClick(mouse)
	if game.TextChatService.BubbleChatConfiguration.Enabled == false then
		game.TextChatService.BubbleChatConfiguration.Enabled = true
		workspace.Configuration.Map.BubbleChat.Value = true
		script.Parent.Text = "Bubble Chat Mode (ON)"
	else
		game.TextChatService.BubbleChatConfiguration.Enabled = false
		workspace.Configuration.Map.BubbleChat.Value = false
		script.Parent.Text = "Bubble Chat Mode (OFF)"
	end
end

script.Parent.MouseButton1Click:connect(leftClick)

workspace.Configuration.Map.BubbleChat.Changed:Connect(function()
	if workspace.Configuration.Map.BubbleChat.Value == true then
		script.Parent.Text = "Bubble Chat Mode (ON)"
	else
		script.Parent.Text = "Bubble Chat Mode (OFF)"
	end
end)

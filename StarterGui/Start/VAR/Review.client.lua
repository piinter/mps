local TweenService = game:GetService("TweenService")

game.ReplicatedStorage.VAR.VAR.OnClientEvent:Connect(function(Line, Side, Position)
	if Side == false then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
		
		script.Parent.Visible = true
		
		local Ball = nil
		
		if game.ReplicatedStorage.VAR:FindFirstChild("TPS") then
			Ball = game.ReplicatedStorage.VAR.TPS:Clone()
			Ball.Parent = workspace
		end
		
		if workspace.Nets:FindFirstChild("Home Net") then
			workspace.Nets["Home Net"].Parent = game.ReplicatedStorage
		end
		
		if workspace.Nets:FindFirstChild("Away Net") then
			workspace.Nets["Away Net"].Parent = game.ReplicatedStorage
		end
		
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		
		local Goal = {}
		Goal.CFrame = Position
		
		local Info = TweenInfo.new(
			0.5,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		)
		
		local Animation = TweenService:Create(workspace.CurrentCamera, Info, Goal)
		Animation:Play()
		
		wait(3)
		
		script.Parent.Bottom:TweenSize(UDim2.new(1, 0, -1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		script.Parent.Side:TweenSize(UDim2.new(-1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		
		wait(0.3)
		
		if Line == true then
			script.Parent.Container.Label.Text = "GOAL!"
			script.Parent.Container.Label.TextColor3 = Color3.fromRGB(0, 255, 127)
		elseif Line == false then
			script.Parent.Container.Label.Text = "NO GOAL!"
			script.Parent.Container.Label.TextColor3 = Color3.fromRGB(255, 105, 105)
		end
		
		script.Parent.Bottom.Position = UDim2.new(0, 0, 0, 0)
		script.Parent.Side.Position = UDim2.new(0, 0, 0, 0)
		
		script.Parent.Bottom.Size = UDim2.new(1, 0, 1, 0)
		script.Parent.Side.Size = UDim2.new(1, 0, 1, 0)
		
		script.Parent.Bottom:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		script.Parent.Side:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		
		wait(5)
		
		if game.ReplicatedStorage:FindFirstChild("Home Net") then
			game.ReplicatedStorage["Home Net"].Parent = workspace.Nets
		end
		
		if game.ReplicatedStorage:FindFirstChild("Away Net") then
			game.ReplicatedStorage["Away Net"].Parent = workspace.Nets
		end
		
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		
		if Ball ~= nil then
			Ball:Destroy()
		end
		
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
		
		script.Parent.Visible = false
		
		script.Parent.Bottom.Position = UDim2.new(0, 0, 1, 0)
		script.Parent.Side.Position = UDim2.new(1, 0, 0, 0)
		
		script.Parent.Bottom.Size = UDim2.new(1, 0, 0, 0)
		script.Parent.Side.Size = UDim2.new(0, 0, 1, 0)
		
		script.Parent.Container.Label.Text = "Decision"
		script.Parent.Container.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		
	elseif Side == true then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
		
		script.Parent.Visible = true
		
		local Ball = nil
		
		if game.ReplicatedStorage.VAR:FindFirstChild("TPS") then
			Ball = game.ReplicatedStorage.VAR.TPS:Clone()
			Ball.Parent = workspace
		end
		
		if workspace.Nets:FindFirstChild("Home Net") then
			workspace.Nets["Home Net"].Parent = game.ReplicatedStorage
		end
		
		if workspace.Nets:FindFirstChild("Away Net") then
			workspace.Nets["Away Net"].Parent = game.ReplicatedStorage
		end
		
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		
		local Goal = {}
		Goal.CFrame = Position
		
		local Info = TweenInfo.new(
			0.5,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		)
		
		local Animation = TweenService:Create(workspace.CurrentCamera, Info, Goal)
		Animation:Play()
		
		wait(3)
		
		script.Parent.Bottom:TweenSize(UDim2.new(1, 0, -1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		script.Parent.Side:TweenSize(UDim2.new(-1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		
		wait(0.3)
		
		if Line == true then
			script.Parent.Container.Label.Text = "GOAL!"
			script.Parent.Container.Label.TextColor3 = Color3.fromRGB(0, 255, 127)
		elseif Line == false then
			script.Parent.Container.Label.Text = "NO GOAL!"
			script.Parent.Container.Label.TextColor3 = Color3.fromRGB(255, 105, 105)
		end
		
		script.Parent.Bottom.Position = UDim2.new(0, 0, 0, 0)
		script.Parent.Side.Position = UDim2.new(0, 0, 0, 0)
		
		script.Parent.Bottom.Size = UDim2.new(1, 0, 1, 0)
		script.Parent.Side.Size = UDim2.new(1, 0, 1, 0)
		
		script.Parent.Bottom:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		script.Parent.Side:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
		
		wait(5)
		
		if game.ReplicatedStorage:FindFirstChild("Home Net") then
			game.ReplicatedStorage["Home Net"].Parent = workspace.Nets
		end
		
		if game.ReplicatedStorage:FindFirstChild("Away Net") then
			game.ReplicatedStorage["Away Net"].Parent = workspace.Nets
		end
		
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		
		if Ball ~= nil then
			Ball:Destroy()
		end
		
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
		
		script.Parent.Visible = false
		
		script.Parent.Bottom.Position = UDim2.new(0, 0, 1, 0)
		script.Parent.Side.Position = UDim2.new(1, 0, 0, 0)
		
		script.Parent.Bottom.Size = UDim2.new(1, 0, 0, 0)
		script.Parent.Side.Size = UDim2.new(0, 0, 1, 0)
		
		script.Parent.Container.Label.Text = "Decision"
		script.Parent.Container.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end)
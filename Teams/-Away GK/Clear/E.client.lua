

local v1 = require(script.Parent.Parent:WaitForChild("ToolManagment"));
Kick = false;
Equipped = false;
Tool = script.Parent;
Player = game.Players.LocalPlayer;
Mouse = Player:GetMouse();
Jumped = false;
while true do
	wait();
	if Player.Character:FindFirstChild("Humanoid") then
		break;
	end;
end;
local v2 = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"));
local v3 = CFrame.new(1.5, 1.4, 0) * CFrame.fromEulerAnglesXYZ(-math.pi / 0.9, math.pi / 4, 0);
local v4 = CFrame.new(-1.5, 1.4, 0) * CFrame.fromEulerAnglesXYZ(-math.pi / 0.9, math.pi / 0.57, 0);
local v5 = CFrame.new(1.8, 0.4, -0.3) * CFrame.fromEulerAnglesXYZ(math.pi / 0.41, -0.2, 1);
local v6 = CFrame.new(-1.8, 0.4, -0.3) * CFrame.fromEulerAnglesXYZ(math.pi / 0.41, 0.2, -1);
local v7 = CFrame.new(1.5, 1.4, 0) * CFrame.fromEulerAnglesXYZ(-math.pi / 0.9, math.pi / 4, 0);
local v8 = CFrame.new(-1.5, 1.4, 0) * CFrame.fromEulerAnglesXYZ(-math.pi / 0.9, math.pi / 0.57, 0);
script.Parent.Equipped:connect(function(p1)
	Equipped = true;
end);
script.Parent.Unequipped:connect(function(p2)
	Equipped = false;
end);
local l__Enum_EasingDirection_Out__1 = Enum.EasingDirection.Out;
local l__Enum_EasingStyle_Back__2 = Enum.EasingStyle.Back;
Mouse.KeyDown:connect(function(p3)
	if Equipped == false then
		return;
	end;
	if v1.GetUsing() then
		return;
	end;
	if p3 ~= "e" then
		return;
	end;
	v1.SetUsing(true);
	Player.Character.Torso.RotVelocity = Vector3.new();
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
	local v9 = Instance.new("BodyVelocity", Player.Character.HumanoidRootPart);
	v9.Velocity = Player.Character.Torso.CFrame.rightVector * 35;
	v9.Velocity = v9.Velocity * Vector3.new(1, 0, 1);
	v1.AllowClick(true)
	if Player.Backpack.Module_Management.Airbourne_Tweak.Airbourne.Value == false then
		Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, -1.3);
		v9.Velocity = v9.Velocity + Vector3.new(0, 16.5, 0);
		v9.MaxForce = Vector3.new(math.huge, 4000, math.huge);
		v2.TweenWeld("Right Arm", CFrame.new(1.5, 0, 0), v5, l__Enum_EasingDirection_Out__1, Enum.EasingStyle.Circular, 0.2);
		v2.TweenWeld("Left Arm", CFrame.new(-1.5, 0, 0), v6, l__Enum_EasingDirection_Out__1, Enum.EasingStyle.Circular, 0.2);
	else
		Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 0, -1);
		Jumped = true;
		v9.Velocity = v9.Velocity + Vector3.new(0, 8, 0);
		v9.MaxForce = Vector3.new(math.huge, 3000, math.huge);
		v2.TweenWeld("Left Arm", CFrame.new(-1.5, 0, 0), v4, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	end;
	game.Debris:AddItem(v9, 0.6);
	Player.Character.Humanoid.PlatformStand = true;
	Kick = true;
	wait(0.1);
	if Jumped == false then
		v2.TweenWeld("Right Arm", v5, v7, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
		v2.TweenWeld("Left Arm", v6, v8, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	end;
	wait(0.2);
	if Jumped == false then
		v9.MaxForce = Vector3.new(math.huge, 1500, math.huge);
	else
		v9.MaxForce = Vector3.new(math.huge, 1500, math.huge);
	end;
	wait(0.5);
	v1.AllowClick(false)
	v1.Click(false)
	Kick = false;
	Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	Player.Character.Humanoid.PlatformStand = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	if Jumped == false then
		v2.TweenWeld("Right Arm", v7, CFrame.new(1.5, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
		v2.TweenWeld("Left Arm", v8, CFrame.new(-1.5, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	else
		v2.TweenWeld("Left Arm", v4, CFrame.new(-1.5, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	end;
	Jumped = false;
	v1.ResetWelds()
	wait(0.35)
	v1.SetUsing(false)
end);

Player.Character["Head"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	if v1.ClickedAlready() == false then
		v1.ApplyGKForce(hit)
	else
		ChangeOwner(hit)
		v1.attachBall(hit)
	end
end)

Player.Character["Torso"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	if v1.ClickedAlready() == false then
		v1.ApplyGKForce(hit)
	else
		ChangeOwner(hit)
		v1.attachBall(hit)
	end
end)

Player.Character["Right Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	if v1.ClickedAlready() == false then
		v1.ApplyGKForce(hit)
	else
		ChangeOwner(hit)
		v1.attachBall(hit)
	end
end)

Player.Character["Left Arm"].Touched:connect(function(hit)
	if hit.Name ~= "TPS" then return end
	if Kick == false then return end
	Kick = false
	if v1.ClickedAlready() == false then
		v1.ApplyGKForce(hit)
	else
		ChangeOwner(hit)
		v1.attachBall(hit)
	end
end)

Player.Character["Right Leg"].Touched:connect(function(p8)
	if p8.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v22 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 60 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v23 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p8, "Right Leg");
	local v24 = Instance.new("BodyVelocity");
	v24.Velocity = Vector3.new(1, 1, 1) * math.huge
	v24.MaxForce = 20
	v24.Parent = p8;
	game.Debris:AddItem(v24, 0.3);
end);
Player.Character["Left Leg"].Touched:connect(function(p9)
	if p9.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v25 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 60 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v26 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p9, "Left Leg");
	local v27 = Instance.new("BodyVelocity");
	v27.Velocity = Vector3.new(1, 1, 1) * math.huge
	v27.MaxForce = 20
	v27.Parent = p9;
	game.Debris:AddItem(v27, 0.3);
end);

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
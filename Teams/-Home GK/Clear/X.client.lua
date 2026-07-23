

local v1 = require(script.Parent.Parent:WaitForChild("ToolManagment"));
Kick = false;
Equipped = false;
Tool = script.Parent;
Player = game.Players.LocalPlayer;
Mouse = Player:GetMouse();
while true do
	wait();
	if Player.Character:FindFirstChild("Humanoid") then
		break;
	end;
end;
local v2 = require(script.Parent.Parent:WaitForChild("Module_Management"):WaitForChild("Tweening"));
local v3 = CFrame.new(0.9, -1.7, -0.3) * CFrame.fromEulerAnglesXYZ(math.pi / 8, -0.2, 0.3);
local v4 = CFrame.new(-0.9, -1.7, -0.3) * CFrame.fromEulerAnglesXYZ(math.pi / 8, 0.2, -0.3);
local v5 = CFrame.new(1.8, 0.3, 0.1) * CFrame.fromEulerAnglesXYZ(math.pi / 6, -0.5, 1);
local v6 = CFrame.new(-1.8, 0.3, 0.1) * CFrame.fromEulerAnglesXYZ(math.pi / 6, 0.5, -1);
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
	if p3 ~= "x" then
		return;
	end;
	v1.SetUsing(true);
	Player.Character.Humanoid.WalkSpeed = Player.Character.Humanoid.WalkSpeed - 5;
	v2.TweenWeld("Right Leg", CFrame.new(0.5, -2, 0), v3, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	v2.TweenWeld("Right Arm", CFrame.new(1.5, 0, 0), v5, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	v2.TweenWeld("Left Leg", CFrame.new(-0.5, -2, 0), v4, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	v2.TweenWeld("Left Arm", CFrame.new(-1.5, 0, 0), v6, l__Enum_EasingDirection_Out__1, l__Enum_EasingStyle_Back__2, 0.4);
	Kick = true;
	wait(0.5);
	Kick = false;
	v2.TweenWeld("Right Leg", v3, CFrame.new(0.5, -2, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	v2.TweenWeld("Right Arm", v5, CFrame.new(1.5, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	v2.TweenWeld("Left Leg", v4, CFrame.new(-0.5, -2, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	v2.TweenWeld("Left Arm", v6, CFrame.new(-1.5, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2);
	wait(1);
	Player.Character.Humanoid.WalkSpeed = Player.Character.Humanoid.WalkSpeed + 5;
	v1.SetUsing(false);
	v1.ResetWelds();
end);
Player.Character.Head.Touched:connect(function(p4)
	if p4.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v7 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v8 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p4, "Head");
	local v9 = Instance.new("BodyVelocity");
	v9.Velocity = v7;
	v9.MaxForce = v8;
	v9.Parent = p4;
	game.Debris:AddItem(v9, 0.3);
end);
Player.Character.Torso.Touched:connect(function(p5)
	if p5.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v10 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v11 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p5, "Torso");
	local v12 = Instance.new("BodyVelocity");
	v12.Velocity = v10;
	v12.MaxForce = v11;
	v12.Parent = p5;
	game.Debris:AddItem(v12, 0.3);
end);
Player.Character["Right Arm"].Touched:connect(function(p6)
	if p6.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v13 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v14 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p6, "Right Arm");
	local v15 = Instance.new("BodyVelocity");
	v15.Velocity = v13;
	v15.MaxForce = v14;
	v15.Parent = p6;
	game.Debris:AddItem(v15, 0.3);
end);
Player.Character["Left Arm"].Touched:connect(function(p7)
	if p7.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v16 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v17 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p7, "Left Arm");
	local v18 = Instance.new("BodyVelocity");
	v18.Velocity = v16;
	v18.MaxForce = v17;
	v18.Parent = p7;
	game.Debris:AddItem(v18, 0.3);
end);
Player.Character["Right Leg"].Touched:connect(function(p8)
	if p8.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v19 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v20 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p8, "Right Leg");
	local v21 = Instance.new("BodyVelocity");
	v21.Velocity = v19;
	v21.MaxForce = v20;
	v21.Parent = p8;
	game.Debris:AddItem(v21, 0.3);
end);
Player.Character["Left Leg"].Touched:connect(function(p9)
	if p9.Name ~= "TPS" then
		return;
	end;
	if Kick == false then
		return;
	end;
	local v22 = (Player.Character.Torso.CFrame * CFrame.fromEulerAnglesXYZ(0, math.random(-10, 10) / 10, 0)).lookVector * 40 * Vector3.new(1, 0, 1) + Vector3.new(0, math.random(5, 30), 0);
	local v23 = Vector3.new(math.huge, math.huge, math.huge);
	Kick = false;
	v1.ApplyGKForce(p9, "Left Leg");
	local v24 = Instance.new("BodyVelocity");
	v24.Velocity = v22;
	v24.MaxForce = v23;
	v24.Parent = p9;
	game.Debris:AddItem(v24, 0.3);
end);

local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))
Kick = false
Equipped = false
Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

-- [ADICIONADO] Variáveis de controle de tempo
local StartTime = 0
local MinDribbleDuration = 0.3 -- Tempo MÍNIMO que o drible precisa durar (em segundos)
local CooldownAfterFinish = 0.1 -- Pequena pausa após terminar para estabilizar

script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

local E, Q, M, N, T, R, G, H, Y, X, Z = false, false, false, false, false, false, false, false, false, false, false
local Combo = false

Mouse.KeyDown:connect(function(key)
	if key ~= "c" then return end
	if Equipped == false or TM.GetUsing() then return end

	-- Registra o momento em que o drible começou
	StartTime = tick()

	TM.SetUsing(true)
	Player.Character.Humanoid.WalkSpeed = 20

	local isRight = (TM.check() == "R")
	if isRight then
		TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,-0.5,0))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
	else
		TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,1) * CFrame.fromEulerAnglesXYZ(-0.785,0.5,0))
		TM.EditWeld("Left Arm", CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
	end

	Combo = true
	Kick = false
end)

Mouse.KeyUp:connect(function(key)
	if key ~= "c" or Equipped == false or not Combo then return end

	-- [LÓGICA ANTI-SPAM] Calcula quanto tempo passou desde o clique
	local timePassed = tick() - StartTime
	if timePassed < MinDribbleDuration then
		wait(MinDribbleDuration - timePassed) -- Força o script a esperar o tempo mínimo
	end

	local isRight = (TM.check() == "R")

	-- Execução do drible (animação de chute)
	if isRight then
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,4))
		TM.EditWeld("Left Arm",  CFrame.new(-1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,4,-4))

		if E == false and Q == false and N == false and T == false and R == false and G == false and H == false and Y == false and X == false and Z == false then
			TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) * CFrame.fromEulerAnglesXYZ(0.4,0,0))
		elseif E then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.8,-0.5) * CFrame.fromEulerAnglesXYZ(0.4,0,0))
		elseif Q then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-0.7) * CFrame.fromEulerAnglesXYZ(0.64,0,0))
		elseif M or N then TM.EditWeld("Right Leg", CFrame.new(1.2,-1.7,0) * CFrame.fromEulerAnglesXYZ(math.pi/8,0.1,0.7))
		elseif T then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,-1,0))
		elseif R then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.7,-1) * CFrame.fromEulerAnglesXYZ(0.78,1,0))
		elseif G and workspace.Configuration.Sombrero.Value == true then TM.EditWeld("Right Leg", CFrame.new(0.5, -1.5, -0.7) * CFrame.fromEulerAnglesXYZ(math.pi / 6, 0, 0))
		elseif H and workspace.Configuration.Sombrero.Value == true then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,0.7) * CFrame.fromEulerAnglesXYZ(-math.pi/6,0,0))
		elseif Y then TM.EditWeld("Right Leg", CFrame.new(0.5,-1.5,-0.7) * CFrame.fromEulerAnglesXYZ(0.65,0,0))
		elseif Z or X then TM.EditWeld("Right Leg", CFrame.new(0.7,-1.8,0.5) * CFrame.fromEulerAnglesXYZ(math.pi/-3,-1.5,-0.7))
		end
	else
		-- Lado Esquerdo
		TM.EditWeld("Left Arm",  CFrame.new(-1.75,0.25,0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,-4))
		TM.EditWeld("Right Arm", CFrame.new(1.75,0.25,-0.5) * CFrame.fromEulerAnglesXYZ(-math.pi/1,-4,4))

		if E == false and Q == false and N == false and T == false and R == false and G == false and H == false and Y == false and X == false and Z == false then
			TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) * CFrame.fromEulerAnglesXYZ(0.4,0,0))
		elseif E then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.8,-0.5) * CFrame.fromEulerAnglesXYZ(0.4,0,0))
		elseif Q then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-0.7) * CFrame.fromEulerAnglesXYZ(0.64,0,0))
		elseif M or N then TM.EditWeld("Left Leg", CFrame.new(-1.2,-1.7,0) * CFrame.fromEulerAnglesXYZ(math.pi/8,-0.1,-0.7))
		elseif T then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1) * CFrame.fromEulerAnglesXYZ(0.78,-1,0))
		elseif R then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.7,-1.1) * CFrame.fromEulerAnglesXYZ(math.pi/4,1,0))
		elseif G and workspace.Configuration.Sombrero.Value == true then TM.EditWeld("Left Leg", CFrame.new(-0.5, -1.5, -0.7) * CFrame.fromEulerAnglesXYZ(math.pi / 6, 0, 0))
		elseif H and workspace.Configuration.Sombrero.Value == true then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,0.7) * CFrame.fromEulerAnglesXYZ(-math.pi/6,0,0))
		elseif Y then TM.EditWeld("Left Leg", CFrame.new(-0.5,-1.5,-0.7) * CFrame.fromEulerAnglesXYZ(0.65,0,0))
		elseif Z or X then TM.EditWeld("Left Leg", CFrame.new(-0.7,-1.8,0.5) * CFrame.fromEulerAnglesXYZ(math.pi/-3,1.5,0.7))
		end
	end

	Kick = true
	wait(0.1)
	TM.ResetWelds()
	Kick = false

	E, Q, M, N, T, R, G, H, Y, X, Z = false, false, false, false, false, false, false, false, false, false, false
	Combo = false
	wait(CooldownAfterFinish)
	TM.SetUsing(false)
	Player.Character.Humanoid.WalkSpeed = 20
end)

-- Mantive as funções KeyDown secundárias e Touched iguais abaixo...
Mouse.KeyDown:connect(function(key)
	if Combo == false then return end
	if key == "e" then E = true elseif key == "q" then Q = true elseif key == "m" then M = true elseif key == "n" then N = true
	elseif key == "t" then T = true elseif key == "r" then R = true elseif key == "g" then G = true elseif key == "h" then H = true
	elseif key == "y" then Y = true elseif key == "x" then X = true elseif key == "z" then Z = true end
end)

Player.Character["Right Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "L" or hit.Name ~= "TPS" or Kick == false then return end

	if E == false and Q == false and M == false and N == false and T == false and R == false and G == false and H == false and Y == false and X == false and Z == false then
		TM.ApplyForce(hit, Vector3.new(400000,400000,400000), Player.Character["Right Leg"].CFrame.lookVector * 0, "Right Leg")
	elseif R or T then
		TM.ApplyForce(hit, Vector3.new(9000000000,30000,9000000000), Player.Character["Right Leg"].CFrame.lookVector * 25, "Right Leg")
	elseif E then
		TM.ApplyForce(hit, Vector3.new(6e+006,1e+003,6e+006), Player.Character["Right Leg"].CFrame.lookVector * -23.5, "Right Leg")
	elseif Q then
		TM.ApplyForce(hit, Vector3.new(9000000000,1000000000,9000000000), Player.Character["Right Leg"].CFrame.lookVector * 25, "Right Leg")
	elseif M then
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = (power * Vector3.new(1, 0, 1)) + Vector3.new(0, 18, 0)
		TM.ApplyForce(hit, Vector3.new(9e+009, 9e+009, 9e+009), power, "Right Leg")
	elseif N then
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = (power * Vector3.new(1, 0, 1)) + Vector3.new(0, 30, 0)
		TM.ApplyForce(hit, Vector3.new(9e+009, 9e+009, 9e+009), power, "Right Leg")
	elseif G then
		wait(.1)
		local p3 = Player.Character["Right Leg"]
		TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -25, p3.CFrame.lookVector.Y * 55, p3.CFrame.lookVector.Z * -25), 1, Vector3.new(4e+006,16e+006,4e+006), true)
	elseif H then
		wait(.1)
		local p3 = Player.Character["Right Leg"]
		TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), -1, Vector3.new(2800,10000,2800), true)
	elseif Y then
		TM.ApplyForce(hit, Vector3.new(10,5000000,10), Player.Character["Right Leg"].CFrame.lookVector * 57, "Right Leg")
	elseif X then
		TM.ApplyForce(hit, Vector3.new(150000,1000,150000), Player.Character["Right Leg"].CFrame.lookVector * -26, "Right Leg")
	elseif Z then
		TM.ApplyForce(hit, Vector3.new(150000,1000,150000), Player.Character["Right Leg"].CFrame.lookVector * 26, "Right Leg")
	end
	Kick = false
end)

Player.Character["Left Leg"].Touched:connect(function(hit)
	if hit.Name == "LegLOD" and hit.Parent ~= Player.Character.Torso and hit.BrickColor ~= Player.Character.HumanoidRootPart.Legs.LegLOD.BrickColor and Kick == true then Kick = false TM.SlowPlayer(17,0.7,20) return end
	if TM.check() == "R" or hit.Name ~= "TPS" or Kick == false then return end

	if E == false and Q == false and M == false and N == false and T == false and R == false and G == false and H == false and Y == false and X == false and Z == false then
		TM.ApplyForce(hit, Vector3.new(400000,400000,400000), Player.Character["Left Leg"].CFrame.lookVector * 0, "Left Leg")
	elseif R or T then
		TM.ApplyForce(hit, Vector3.new(9000000000,30000,9000000000), Player.Character["Left Leg"].CFrame.lookVector * 25, "Left Leg")
	elseif E then
		TM.ApplyForce(hit, Vector3.new(6e+006,1e+003,6e+006), Player.Character["Left Leg"].CFrame.lookVector * -23.5, "Left Leg")
	elseif Q then
		TM.ApplyForce(hit, Vector3.new(9000000000,1000000000,9000000000), Player.Character["Left Leg"].CFrame.lookVector * 25, "Left Leg")
	elseif M then
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = (power * Vector3.new(1, 0, 1)) + Vector3.new(0, 18, 0)
		TM.ApplyForce(hit, Vector3.new(9e+009, 9e+009, 9e+009), power, "Left Leg")
	elseif N then
		wait(0.1)
		local power = (Player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(1,0,0)).lookVector * 41
		power = (power * Vector3.new(1, 0, 1)) + Vector3.new(0, 30, 0)
		TM.ApplyForce(hit, Vector3.new(9e+009, 9e+009, 9e+009), power, "Left Leg")
	elseif G then
		wait(.1)
		local p3 = Player.Character["Left Leg"]
		TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -25, p3.CFrame.lookVector.Y * 55, p3.CFrame.lookVector.Z * -25), 1, Vector3.new(4e+006,16e+006,4e+006), true)
	elseif H then
		wait(.1)
		local p3 = Player.Character["Left Leg"]
		TM.SombreroForce(hit, Vector3.new(p3.CFrame.lookVector.X * -28.5, p3.CFrame.lookVector.Y * 60, p3.CFrame.lookVector.Z * -28.5), -1, Vector3.new(2800,10000,2800), true)
	elseif Y then
		TM.ApplyForce(hit, Vector3.new(10,5000000,10), Player.Character["Left Leg"].CFrame.lookVector * 57, "Left Leg")
	elseif X then
		TM.ApplyForce(hit, Vector3.new(150000,1000,150000), Player.Character["Left Leg"].CFrame.lookVector * 26, "Left Leg")
	elseif Z then
		TM.ApplyForce(hit, Vector3.new(150000,1000,150000), Player.Character["Left Leg"].CFrame.lookVector * -26, "Left Leg")
	end
	Kick = false
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
local TM = require(script.Parent.Parent:WaitForChild("ToolManagment"))

Kick = false
Equipped = false

Tool = script.Parent
Player = game.Players.LocalPlayer
Mouse = Player:GetMouse()

repeat wait() until Player.Character:FindFirstChild("Humanoid")

-- Animações
local TorsoAndHead = Instance.new("Animation")
TorsoAndHead.AnimationId = "rbxassetid://115825540849158"
local PlayTorsoAndHead = Player.Character.Humanoid:LoadAnimation(TorsoAndHead)

local End = Instance.new("Animation")
End.AnimationId = "rbxassetid://94253841029311"
local PlayAnimEnd = Player.Character.Humanoid:LoadAnimation(End)

-- Equipar/Desequipar
script.Parent.Equipped:connect(function(m)
	Equipped = true
end)

script.Parent.Unequipped:connect(function(m)
	Equipped = false
end)

-- Função de soltar bola (tecla G)
Mouse.KeyDown:connect(function(key)
	if key ~= "g" then return end
	if Equipped == false then return end
	if TM.GetUsing() then return end

	-- NOVA VERIFICAÇÃO: Se não tiver segurando a bola, para o script aqui
	if not TM.getHoldingBall() then return end
	-- Verificação extra de segurança para garantir que o objeto bola existe
	if not TM.getHeldBall() then return end

	TM.SetUsing(true) -- Define que está usando uma ação para evitar spam

	-- Cria impulso leve na bola para frente e para baixo
	local F = Instance.new("BodyVelocity") -- Mudei para local para melhor performance

	-- Verifica se está andando para frente
	local UIS = game:GetService("UserInputService")
	if UIS:IsKeyDown(Enum.KeyCode.W) then	
		F.Velocity = Player.Character["HumanoidRootPart"].CFrame.lookVector * (Player.Character.Humanoid.WalkSpeed + 3) + Player.Character["HumanoidRootPart"].CFrame.upVector * -3.5
	else 
		F.Velocity = Player.Character["HumanoidRootPart"].CFrame.lookVector * (3) + Player.Character["HumanoidRootPart"].CFrame.upVector * -3.5
	end

	F.Parent = TM.getHeldBall()

	-- Adiciona rotação leve na bola
	local S = Instance.new("BodyAngularVelocity")
	S.Parent = TM.getHeldBall()
	S.AngularVelocity = Player.Character["HumanoidRootPart"].CFrame.rightVector * (-10)
	S.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

	-- Solta a bola
	TM.dropBall()

	-- Toca animações (Só acontece se passar das verificações lá em cima)
	PlayAnimEnd:Play(nil,nil, 1)
	PlayTorsoAndHead:AdjustWeight(1,0)
	PlayTorsoAndHead:AdjustWeight(2,0.15)

	-- Remove forças após o tempo
	game.Debris:AddItem(F, 0.3)
	wait(0.15)
	game.Debris:AddItem(S, 0.2)

	TM.SetUsing(false)
end)

function ChangeOwner(ball)
	game.ReplicatedStorage.ChangeOwner:FireServer(ball)
end
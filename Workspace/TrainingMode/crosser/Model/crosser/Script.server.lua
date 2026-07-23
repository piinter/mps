local debris = game:GetService("Debris")

local FORCAS = {
	FRACA = {valor = 79, cor = Color3.fromRGB(0, 255, 0)}, 
	MEDIA = {valor = 87, cor = Color3.fromRGB(255, 255, 0)},  
	FORTE = {valor = 100, cor = Color3.fromRGB(255, 0, 0)} 
}

local tocando = false

local function aplicarChute(hit)
	if hit.Name ~= "TPS" or hit.Locked == true or tocando then return end

	tocando = true

	local sorteio = math.random(1, 102)
	local fDada

	if sorteio <= 33 then
		fDada = FORCAS.FRACA
	elseif sorteio <= 67 then
		fDada = FORCAS.MEDIA
	else 
		fDada = FORCAS.FORTE
	end

	local F = Instance.new("BodyVelocity")
	F.Parent = hit
	F.Velocity = (script.Parent.CFrame.lookVector + Vector3.new(0, 0.15, 0)).Unit * fDada.valor
	F.MaxForce = Vector3.new(4e12, 3e11, 4e12)
	debris:AddItem(F, 0.2)

	if hit:FindFirstChild("Owner") then hit.Owner.Value = nil end
	hit:SetNetworkOwner(nil)

	for _, antigo in pairs(hit:GetChildren()) do
		if antigo:IsA("Highlight") then antigo:Destroy() end
	end

	local brilho = Instance.new("Highlight")
	brilho.Parent = hit
	brilho.FillColor = fDada.cor
	brilho.OutlineColor = Color3.new(1, 1, 1) 
	brilho.FillTransparency = 0.4 

	debris:AddItem(brilho, 2.5)

	task.wait(0.1)
	tocando = false
end

script.Parent.Touched:Connect(aplicarChute)
script.Parent.TouchEnded:Connect(aplicarChute)
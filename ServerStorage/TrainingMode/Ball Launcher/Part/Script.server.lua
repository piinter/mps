-- nao me lembro sobre qual coordenada eh qual então boa sorte

local TweenService = game:GetService("TweenService")
local debris = game:GetService("Debris")

local AngleFolder = script.Parent:WaitForChild("Angle")
local CurveFolder = script.Parent:WaitForChild("Curves")
local Angle = AngleFolder:GetChildren()
local Curve = CurveFolder:GetChildren()

local Rango = workspace:WaitForChild("Rango") 

local targetPosition = Vector3.new(-103.721, 838.999, 235.599)


local DECISION_TIME = 0.3

local ARC_MIN, ARC_MAX = 10, 26

local SPEED_MIN, SPEED_MAX = 130, 150


local DEADZONE_X_FRAC = 0.45
local DEADZONE_Z_FRAC = 0.45


local CORNER_CHANCE = 0.59


local function getRandomPointOnSurfaceBiased(part)
	local cf, sz = part.CFrame, part.Size
	local hx, hz = sz.X * 0.5, sz.Z * 0.5
	local yLocal =  sz.Y * 0.5    
	
	local bx = math.clamp(hx * DEADZONE_X_FRAC, 0, hx * 0.95)
	local bz = math.clamp(hz * DEADZONE_Z_FRAC, 0, hz * 0.95)

	local function sampleOuter(h)
		 
		local mag = bx + math.random() * (h - bx)
		if math.random(0,1) == 0 then mag = -mag end
		return mag
	end

	local function sampleOuterZ(h)
		local mag = bz + math.random() * (h - bz)
		if math.random(0,1) == 0 then mag = -mag end
		return mag
	end

	local rx, rz
	if math.random() < CORNER_CHANCE then
		
		rx = sampleOuter(hx)
		rz = sampleOuterZ(hz)
	else
		
		if math.random(0,1) == 0 then
			rx = sampleOuter(hx)
			
			repeat
				rz = (math.random() - 0.5) * (2 * hz)
			until math.abs(rz) > (hz * DEADZONE_Z_FRAC * 0.45)  
		else
			rz = sampleOuterZ(hz)
			repeat
				rx = (math.random() - 0.5) * (2 * hx)
			until math.abs(rx) > (hx * DEADZONE_X_FRAC * 0.45)
		end
	end

	
	local worldPos =
		cf.Position +
		cf.RightVector * rx +
		cf.UpVector    * yLocal +
		cf.LookVector  * rz

	return worldPos
end

local function onTouched(hit)
	if hit.Name ~= "TPS" then return end

	
	local bv = hit:FindFirstChildOfClass("BodyVelocity")
	if bv then bv:Destroy() end
	hit.AssemblyLinearVelocity = Vector3.zero
	hit.AssemblyAngularVelocity = Vector3.zero

	
	hit.Anchored = true

	local highlight = Instance.new("Highlight")
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(229, 106, 5)
	highlight.Parent = hit

	local showTween = TweenService:Create(
		highlight,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ OutlineTransparency = 0 }
	)
	showTween:Play()

	
	local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween = TweenService:Create(hit, tweenInfo, { CFrame = CFrame.new(targetPosition) })
	tween:Play()
	tween.Completed:Wait()

	task.wait(0.1)

	
	local hideTween = TweenService:Create(
		highlight,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ OutlineTransparency = 1 }
	)
	hideTween:Play()
	debris:AddItem(highlight, 0.4)

	
	hit.Anchored = false

	
	task.wait(DECISION_TIME)

	local origin = hit.Position
	local targetPoint

	if Rango and Rango:IsA("BasePart") then
		
		targetPoint = getRandomPointOnSurfaceBiased(Rango)
	else
		
		local fallbackCF = Angle[1] and Angle[1].CFrame or CFrame.new(targetPosition) * CFrame.new(0,0,-1)
		targetPoint = (fallbackCF.Position + fallbackCF.LookVector * 50)
		warn("[BallLauncher] No se encontró el Part 'Rango'. Usando dirección de fallback.")
	end

	
	local dir = (targetPoint - origin).Unit

	
	local randomSpread = Vector3.new(
		math.random(-2, 2) * 0.008,
		math.random(-2, 2) * 0.008,
		math.random(-2, 2) * 0.008
	)
	dir = (dir + randomSpread).Unit

	
	local speed = math.random(SPEED_MIN, SPEED_MAX)
	local arcLift = (math.random(0,1) == 1 and 1 or -1) * math.random(ARC_MIN, ARC_MAX)

	local finalVelocity = (dir * speed) + Vector3.new(0, arcLift, 0)

	local F = Instance.new("BodyVelocity")
	F.MaxForce = Vector3.new(4e10, 3e10, 4e10)
	F.Velocity = finalVelocity
	F.Parent = hit
	debris:AddItem(F, 0.25)

	
	local chosenCurve = Curve[math.random(1, #Curve)]:Clone()
	chosenCurve.Parent = hit
	debris:AddItem(chosenCurve, 0.5)
end

script.Parent.Touched:Connect(onTouched)

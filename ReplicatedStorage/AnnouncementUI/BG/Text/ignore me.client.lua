--// AutoScale Stroke
local ui = script.Parent
local stroke = ui:FindFirstChildOfClass("UIStroke")
local baseThickness = 2.5

local function updateStroke()
    local screenY = workspace.CurrentCamera.ViewportSize.Y
    stroke.Thickness = baseThickness * (screenY / 720)
end

updateStroke()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateStroke)


function Press()
script.Parent.Parent.Parent:findFirstChild("Page2").Visible = true
script.Parent.Parent.Parent:findFirstChild("Page3").Visible = false
end

script.Parent.MouseButton1Down:connect(Press)

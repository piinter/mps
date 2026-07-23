i = 20
while i > 0 do
	script.Parent.TextTransparency = script.Parent.TextTransparency + 0.05
	i = i - 1
	wait()
end
script.Parent.Parent:Destroy()
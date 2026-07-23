debounce = false

script.Parent.Touched:connect(function(otherPart)
  if otherPart.Name == "TPS" and not debounce then
	debounce = true
	script.Parent.Sound:Play()
	wait(0.2)
	debounce = false
end
end)
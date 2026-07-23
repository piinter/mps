debounce = false

script.Parent.Touched:connect(function(otherPart)
  if otherPart.Name == "TPS" and not debounce then
	debounce = true
	script.Parent.Scored:Play()
	wait(5)
	debounce = false
end
end)
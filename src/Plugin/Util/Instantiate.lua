local Parent = "Parent"
return function(Class, Properties)
	local I = Instance.new(Class)
	for Key, Val in pairs(Properties) do
		if Key ~= Parent then
			I[Key] = Val
		end
	end
	if Properties.Parent then
		I.Parent = Properties.Parent
	end
	return I
end
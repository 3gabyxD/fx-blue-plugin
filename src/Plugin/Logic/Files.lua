local Main = script.Parent.Parent
local Actions = Main.Actions

local Cache = require(script.Parent.Cache)

local function serialize(value)
	if type(value) == "table" then
		local stream = "{"
		for i, v in pairs(value) do
			stream ..= "[" .. i .. "]" .. " = " .. serialize(v) .. ", "
		end
		return stream .. "}"
	elseif type(value) == "userdata" then
		return typeof(value) .. ".new(" .. tostring(value) .. ")"
	end
	return tostring(value)
	--[[
	local typ = type(value)
	if typ == "table" then
	elseif typ == "userdata" then
		if typeof(value) == "CFrame" then
			local x = {value:GetComponents()}
			local out = "CFrame.new("
			for i, v in pairs(x) do
				if i == #x then
					out ..= x .. ")"
				else
					out ..= x .. ", "
				end
			end
		elseif typeof(value) == "Vector3" then
			return "Vector3.new("
			.. value.X .. ", "
			.. value.Y .. ", "
			.. value.Z .. ")"
		elseif typeof(value) == "Color3" then
			return "Vector3"
		end
	end
	]]--
end

return {
	Disabled = false,

	NewFile = function(self)
		Cache.File = {
			packages = {},
			name = "",
			elements = {}, --> assets
			frames = {}, --> key (name of element), val (dict of properties)
		}
	end,

	RegisterElement = function(self, Element)
		Cache.File.elements[#Cache.File.elements+1] = Element
		Cache.File.frames[Element.Name] = {}
	end,

	SaveFile = function(self)
		local file = Cache.File
		local out = ""
		out ..= "return {\n"

		--> Packages >--
		out ..= "\tpackages = {"
		for _, package in pairs(file.packages) do
			out ..= " \"" .. package .. "\", "
		end
		out ..= "},\n"

		--> Assets >--
		out ..= "\tassets = {"
		for _, asset in pairs(file.elements) do
			out ..= " \"" .. asset.Name .. "\", "
		end
		out ..= "},\n"

		--> Manipulations >--
		out ..= "\tframes = {\n"
		for key, val in pairs(file.frames) do
			out ..= "\t\t[\"" .. key .. "\"] = {\n"
			for _, vals in pairs(val) do
				out ..= "\t\t\t{\n"
				for property, value in pairs(vals) do
					out ..= "\t\t\t\t" .. property .. " = " .. serialize(value) .. ",\n"
				end
				out ..= "\t\t\t},\n"
			end
		end
		out ..= "\t}\n"

		print(out)
		return out
	end,

	OpenFile = function(self, FileName)

	end,

	Init = function(self)
		Actions.NewFile.Event:Connect(function(...)
			self:NewFile(...)
		end)

		Actions.RegisterElement.Event:Connect(function(...)
			self:RegisterElement(...)
		end)

		Actions.SaveFile.Event:Connect(function(...)
			self:SaveFile(...)
		end)

		Actions.OpenFile.Event:Connect(function(...)
			self:OpenFile(...)
		end)
	end,

	-- Start = function(self)
	-- end
}
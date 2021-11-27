local TweenService = game:GetService("TweenService")


return {
	playing = {},
	cache = {},
	dumpcache = function(self, obj)
		if obj:IsA("GuiObject") then
			self.cache[obj] = {BackgroundTransparency = obj.BackgroundTransparency}
			if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
				self.cache[obj]["ImageTransparency"] = obj.ImageTransparency
			elseif obj:IsA("TextButton") or obj:IsA("TextLabel") or obj:IsA("TextBox") then
				self.cache[obj]["TextTransparency"] = obj.TextTransparency
				self.cache[obj]["TextStrokeTransparency"] = obj.TextStrokeTransparency
			end
		end
	end,

	cacheall = function(self, ui)
		self:dumpcache(ui)
		for _, obj in pairs(ui:GetDescendants()) do
			self:dumpcache(obj)
		end
	end,
	get = function(self, val, t)
		return 1 - ((1-val) * (1-t))
	end,
	set = function(self, ui, t)
		if not self.cache[ui] then
			error("Dump cache before setting transparency")
			return
		end
		for _, obj in pairs(ui:GetDescendants()) do
			for prop, val in pairs(self.cache[obj]) do
				obj[prop] = self:get(val, t)
			end
		end
	end,
	fade = function(self, ui, speed, start, goal)
		local info = TweenInfo.new(speed)
		if self.cache[ui] then
			for prop, val in pairs(self.cache[ui]) do
				ui[prop] = self:get(val, start)
				TweenService:Create(
					ui, info, {[prop] = self:get(val, goal)}
				):Play()
			end
		end
		for _, obj in pairs(ui:GetDescendants()) do
			if self.cache[obj] then
				for prop, val in pairs(self.cache[obj]) do
					obj[prop] = self:get(val, start)
					TweenService:Create(
						obj, info, {[prop] = self:get(val, goal)}
					):Play()
				end
			end
		end
	end
}
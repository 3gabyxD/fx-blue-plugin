local Main = script.Parent.Parent
local Actions = Main.Actions
local Cache = require(script.Parent.Cache)

local ease = require(script.ease)

local function getCurrent(frameset, property, time)
    local last, next
    local interpolation
    for index = #frameset, 1, -1 do
        local frame = frameset[index]
        if frame.time > time and frame[property] then
            next = frame[property]
            for i = index - 1, 1, -1  do
                local _frame = frameset[i]
                if _frame[property] then
                    last = _frame[property]
                    local position = (time - _frame.time) / (frame.time - _frame.time)
                    if type(_frame.easing) == "table" then
                        --bezier intrpolation
                        if _frame.bezier == nil then
                            _frame.bezier = ease.cubicbezier(
                                _frame.easing[2][1],
                                _frame.easing[2][2],
                                _frame.easing[3][1],
                                _frame.easing[3][2]
                            )
                        end
                        interpolation = _frame.bezier(position)

                    elseif type(_frame.easing) == "string" then

                    end
                    break
                end
            end
        end
    end

    if type(last) == "number" then
        return last + (next - last) * interpolation
    end

    return last:Lerp(next, interpolation)
end

return {
	Disabled = false,

    Render = function(self, Element, Time)
        local File = Cache.File
    end,

	Init = function(self)
		Actions.RenderFrame.Event:Connect(function(Element, Time)
            self:Render(Element, Time)
		end)
	end,

	-- Start = function(self)
	-- end
}
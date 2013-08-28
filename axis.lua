axis = function(x, y)

	local self = {}

	local x = x or width/2
	local y = y or height/2

	local getXaxis = function()
		return 0, y, width, y
	end

	local getYaxis = function()
		return x, 0, x, height
	end

	self.getPoint = function()
		return x, y
	end

	self.setPoint = function(_x, _y)
		x = _x
		y = _y
	end

	self.draw = function()
		love.graphics.line(getXaxis())
		love.graphics.line(getYaxis())

		local valueX = 0
		for _x = x, 0, - unit do
			love.graphics.print(valueX, _x, y)
			valueX = valueX - 1
		end

		valueX = 0
		for _x = x, width, unit do
			love.graphics.print(valueX, _x, y)
			valueX = valueX + 1
		end

		local valueY = 0
		for _y = y, 0, - unit do
			love.graphics.print(valueY, x, _y)
			valueY = valueY + 1
		end

		valueY = 0
		for _y = y, height, unit do
			love.graphics.print(valueY, x, _y)
			valueY = valueY - 1
		end
	end

	return self
end
require('axis')
require('line')
require('parabola')
require('formulas')

cartesian = function()

	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	unit = 30

	offset = {x, y}

	pointsBeforeX = 0
	pointsAfterX = 0
	
	pointsBeforeY = 0
	pointsAfterY = 0

	thickness = 0.01

	convertPointToPixel = function(_x, _y)
		return (_x*unit) + offset.x, (-_y*unit) + offset.y
	end

	convertPixelToPoint = function(px,py)
		if (px < offset.x ) then
			x = -(offset.x-px)/unit
		else
			x = (px-offset.x)/unit
		end
		if (py > offset.y) then
			y = -(py-offset.y)/unit
		else
			y = (offset.y-py)/unit
		end
		return x,y
	end

	local self = {}

	self.setOffset = function(_x, _y)
		offset.x = _x
		offset.y = _y
		pointsBeforeX = _x / unit
		pointsAfterX = (width - _x) / unit
		pointsBeforeY = (height - _y) / unit
		pointsAfterY = _y / unit 
	end

	self.setUnit = function(_unit)
		if _unit >= 20 and _unit <= 350 then
			unit = _unit
		end
	end

	self.getUnit = function()
		return unit
	end

	self.axis = axis()
	self.line = line()
	self.parabola = parabola()
	self.formulas = formulas()

	self.draw = function()
		love.graphics.setColor(200, 200, 200)
		self.axis.draw()
		self.setOffset(self.axis.getPoint())
		self.line.draw()
		self.parabola.draw()
		self.formulas.draw()
	end

	return self
end
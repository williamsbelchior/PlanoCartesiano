line = function()
	local self = {}
	local list = {}
	local line = {}

	local drawLine = function(ox, oy, dx, dy)
		local m = self.getSlope(ox, oy, dx, dy)
		local b = self.getIntersection(dx, dy, m)		
		for x = -pointsBeforeX, pointsAfterX, thickness do
			y = self.getLinearEquation(x, m, b)
			love.graphics.point(convertPointToPixel(x, y))
		end
	end

	self.draw = function()
		for i = 1, table.getn(list), 4 do
			drawLine(list[i], list[i+1], list[i+2], list[i+3])
		end
		if table.getn(line) == 2 then
			dx, dy = convertPixelToPoint(love.mouse.getX(), love.mouse.getY())
			drawLine(line[1], line[2], dx, dy)
		end
	end

	self.getSlope = function(_ox, _oy, _dx, _dy)
		return (_dy - _oy) / (_dx - _ox)
	end

	self.getIntersection = function(_x, _y, _m)
		return _y - (_x * _m)
	end

	self.getLinearEquation = function(_x, _m, _b)
		return _x * _m + _b
	end

	self.add = function(ox, oy, dx, dy)
		ox, oy = ox, oy
		dx, dy = dx, dy
		table.insert(list, ox)
		table.insert(list, oy)
		table.insert(list, dx)
		table.insert(list, dy)
	end

	self.setPoint = function(_x, _y)
		_x, _y = convertPixelToPoint(_x, _y)
		table.insert(line, _x)
		table.insert(line, _y)
		if table.getn(line) == 4 then
			self.add(line[1],line[2],line[3],line[4])
			line = {}
		end
	end

	self.dropPoint = function()
		line = {}
	end

	return self
end
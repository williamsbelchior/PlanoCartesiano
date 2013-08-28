parabola = function()

	local self = {}

	local list = {}
	local line = {}

	local focus = {x, y}
	local vertex = {x, y}

	local horizontalAxis = false

	self.getVertex = function()
		return vertex.x, vertex.y
	end
	
	self.getFocus = function()
		return focus.x, focus.y
	end
	
	self.isHorizontal = function()
		return horizontalAxis
	end

	self.setVertex = function(x, y)
		vertex.x = x
		vertex.y = y
	end

	self.setFocus = function(x, y)
		focus.x = x
		focus.y = y
	end

	self.setHorizontal = function(bool)
		horizontalAxis = bool
	end

	local vertAxis = function(h, k, d)
		local a = 1/4*d
		local b = -h/2*d
		local c = math.pow(h,2)/4*d + k
		for x = -pointsBeforeX, pointsAfterX, thickness do
			local y = a * math.pow(x,2) + b * x + c
			love.graphics.point(convertPointToPixel(x, y))
		end
	end

	local horizAxis = function(h, k, d)
		local a = 1/4*d
		local b = -k/2*d
		local c = math.pow(k,2)/4*d + h
		for y = -pointsBeforeY, pointsAfterY, thickness do
			local x = a * math.pow(y,2) + b * y + c
			love.graphics.point(convertPointToPixel(x, y))
		end
	end

	local drawParabola = function(h, k, fx, fy)
		h, k = h, k
		fx, fy = fx, fy
		if h == fx then
			vertAxis(h, k, fy - k)
		else
			horizAxis(h, k, fx - h)
		end
	end

	self.setPoint = function(_x, _y)
		_x, _y = convertPixelToPoint(_x, _y)
		if table.getn(line) == 2 then
			if self.isHorizontal() then
				_y = line[2]
				_x = (_x - line[1])/0.250 + line[1]
			else
				_x = line[1]
				_y = (_y - line[2])/0.250 + line[2]
			end
		end
		table.insert(line, _x)
		table.insert(line, _y)
		if table.getn(line) == 4 then
			local h, k = line[1], line[2]
			local fx, fy = line[3], line[4]
			table.insert(list, h)
			table.insert(list, k)
			table.insert(list, fx)
			table.insert(list, fy)
			line = {}
		end
	end

	self.draw = function()
		for i = 1, table.getn(list), 4 do
			drawParabola(list[i],list[i+1],list[i+2],list[i+3])
		end
		if table.getn(line) == 2 then
			x, y = convertPixelToPoint(love.mouse.getX(), love.mouse.getY())
			if self.isHorizontal() then
				local d = (x - line[1])/0.250
				horizAxis(line[1], line[2], d)
			else
				local d = (y - line[2])/0.250
				vertAxis(line[1], line[2], d)
			end
		end
	end

	return self
end
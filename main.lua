require('cmdKey')
require('cartesian')

function love.load()
	lg = love.graphics
	lm = love.mouse
	lk = love.keyboard
	resetKey()
	cartesian = cartesian()
end

function love.draw()
	cartesian.draw()
end

function love.update(dt)
	if lm.isDown("l") and lk.isDown("lctrl") then
		resetKey()
		cartesian.axis.setPoint(lm.getPosition())
	end
end

function love.keyreleased(key)
	commandKey = key
	switch(commandKey) : caseof {
		["escape"] = function() resetKey() end,
		["q"] = function() love.event.quit() end,
		["v"] = function() cartesian.parabola.setHorizontal(false) commandKey = "p" end,
		["h"] = function() cartesian.parabola.setHorizontal(true) commandKey = "p" end,
	}
	cartesian.formulas.setCommandKey(commandKey)
end

function love.mousereleased(x, y, button)
	if button == "wd" then
		cartesian.setUnit(cartesian.getUnit() - 5)
	elseif button == "m" then
		cartesian.setUnit(30)
	elseif button == "wu" then
		cartesian.setUnit(cartesian.getUnit() + 5)
	elseif button == "l" then
		switch(commandKey) : caseof {
			["l"] = function() cartesian.line.setPoint(x, y) end,
			["p"] = function() cartesian.parabola.setPoint(x, y) end,
		}
	elseif button == "r" then
		cartesian.line.dropPoint()
	end
end

function resetKey()
	commandKey = "escape"
end

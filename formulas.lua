formulas = function()

	local self = {}

	local allFunctions = {}

	local alphabet = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","u","v","w","x","y","z"}

	local enterFunctionStr = ""

	local degree = 0
	local degreeStr = ""
	local saveDegree = false

	local currentCoefficient = 1
	local coefficients = {}
	local coefficientStr = ""
	local saveCoefficients = false

	local consoleHeight = 60
	local consoleWidth = 400
	local consoleX = width/2 - consoleWidth/2
	local consoleY = height/2 - consoleHeight/2

	local fun = function(x, coef)
		local y = 0
		local max = table.getn(coef)
		local exp
		for i = 1, max do
			exp = max - i
			y = y + coef[i] * math.pow(x,exp)
		end
		return y
	end

	local setDegree = function(newDegree)
		degreeStr = ""
		degree = newDegree
		saveDegree = false
		saveCoefficients = true
		enterFunctionStr = "Salvar coeficente "..alphabet[currentCoefficient]
	end

	local isSetDegree = function(key)
		return (key == 'return' or key == 'enter') and saveDegree and degreeStr ~= ""
	end

	local isWritingDegree = function(key)
		return saveDegree and tonumber(key) ~= nil and table.getn(alphabet) > tonumber(degreeStr..key)
	end

	local addCoefficient = function(coefficient)
		coefficientStr = ""
		table.insert(coefficients, coefficient)
		if currentCoefficient == degree + 1 then
			saveCoefficients = false
			currentCoefficient = 1
			table.insert(allFunctions, coefficients)
			coefficients = {}
		else
			currentCoefficient = currentCoefficient + 1
			enterFunctionStr = "Salvar coeficente "..alphabet[currentCoefficient]
		end
	end

	local isAddCoefficient = function(key)
		return (key == 'return' or key == 'enter') and saveCoefficients and coefficientStr ~= ""
	end

	local isWritingCoefficients = function(key)
		return saveCoefficients and (tonumber(key) ~= nil or (key == "-" and coefficientStr:len() == 0))
	end

	local isDeleting = function(key)
		return key == 'backspace'
	end

	local deleteLastCharacter = function(str)
		return str:sub(0, str:len() - 1)
	end

	local isInitConsole = function(key)
		return key == "f"
	end

	local initConsole = function()
		saveDegree = true
		enterFunctionStr = "Salvar grau"
	end

	local isCancel = function(key)
		return key == 'escape'
	end

	local cancelConsole = function()
		enterFunctionStr = ""
		degree = 0
		degreeStr = ""
		saveDegree = false
		currentCoefficient = 1
		coefficients = {}
		coefficientStr = ""
		saveCoefficients = false
	end

	local drawConsole = function()
		love.graphics.rectangle("fill", consoleX, consoleY, consoleWidth, consoleHeight)
		love.graphics.setColor( 0, 0, 0)
		love.graphics.print("ESC = Cancelar ENTER = "..enterFunctionStr, consoleX + 10, consoleY + 40)
	end

	local drawDegree = function()
		love.graphics.print("Entre com o grau: "..degreeStr, consoleX + 10, consoleY + 10)
	end

	local drawCoefficients = function()
		love.graphics.print("Entre com o coeficiente "..alphabet[currentCoefficient]..": "..coefficientStr, consoleX + 10, consoleY + 10)
	end

	local drawGraphics = function()
		for i = 1, table.getn(allFunctions) do
			for x = -pointsBeforeX, pointsAfterX, thickness do
				y = fun(x, allFunctions[i])
				love.graphics.point(convertPointToPixel(x, y))
			end
		end
	end

	self.draw = function()
		if saveDegree or saveCoefficients then drawConsole() end
		if saveDegree then drawDegree() end
		if saveCoefficients then drawCoefficients() end
		love.graphics.setColor( 255, 255, 255)
		if table.getn(allFunctions) > 0 then drawGraphics() end
	end

	self.setCommandKey = function(key)
		if isAddCoefficient(key) then addCoefficient(tonumber(coefficientStr)) end
		if isSetDegree(key) then setDegree(tonumber(degreeStr)) end
		if isWritingDegree(key) then degreeStr = degreeStr..key end
		if isWritingCoefficients(key) then coefficientStr = coefficientStr..key end
		if isDeleting(key) and saveDegree then degreeStr = deleteLastCharacter(degreeStr) end
		if isDeleting(key) and saveCoefficients then coefficientStr = deleteLastCharacter(coefficientStr) end
		if isInitConsole(key) then initConsole() end
		if isCancel(key) then cancelConsole() end
	end

	return self

end
-- Fluz Hub | Duels [v1.5.2] | by jesuslmk
-- Repositorio: jexzzz21/fluzhubnew

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local coreGui = game:GetService("CoreGui")

local lp = players.LocalPlayer
local camera = workspace.CurrentCamera

if coreGui:FindFirstChild("FluzHubGui") then
	coreGui.FluzHubGui:Destroy()
end

local screenGui = Instance.new("ScreenGui", coreGui)
screenGui.Name = "FluzHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botón Flotante con el ID exacto solicitado
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0.02, 0, 0.25, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
toggleButton.Image = "rbxassetid://8126145670"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

local tStroke = Instance.new("UIStroke", toggleButton)
tStroke.Color = Color3.fromRGB(45, 50, 65)
tStroke.Thickness = 1.5

-- Ventana Principal Calcada a T3RA Hub
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 620, 0, 380)
mainFrame.Position = UDim2.new(0.5, -310, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(35, 40, 55)
mStroke.Thickness = 1

-- Header Superior Estilo T3RA con el Logo Exacto
local topHeaderCard = Instance.new("Frame", mainFrame)
topHeaderCard.Size = UDim2.new(0, 210, 0, 36)
topHeaderCard.Position = UDim2.new(0, 12, 0, 10)
topHeaderCard.BackgroundColor3 = Color3.fromRGB(22, 25, 33)
topHeaderCard.BorderSizePixel = 0
Instance.new("UICorner", topHeaderCard).CornerRadius = UDim.new(0, 6)

local topCardStroke = Instance.new("UIStroke", topHeaderCard)
topCardStroke.Color = Color3.fromRGB(45, 120, 220)
topCardStroke.Thickness = 1

local headerAvatar = Instance.new("ImageLabel", topHeaderCard)
headerAvatar.Size = UDim2.new(0, 26, 0, 26)
headerAvatar.Position = UDim2.new(0, 5, 0, 5)
headerAvatar.BackgroundTransparency = 1
headerAvatar.Image = "rbxassetid://8126145670"
Instance.new("UICorner", headerAvatar).CornerRadius = UDim.new(0, 13)

local titleLabel = Instance.new("TextLabel", topHeaderCard)
titleLabel.Size = UDim2.new(1, -38, 1, 0)
titleLabel.Position = UDim2.new(0, 36, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Fluz Hub | Duels"
titleLabel.TextColor3 = Color3.fromRGB(235, 240, 250)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Barra Superior con Versión en Amarillo y Controles (Minimizar, Maximizar, Destruir)
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, -230, 0, 36)
topBar.Position = UDim2.new(0, 230, 0, 10)
topBar.BackgroundTransparency = 1

local versionLabel = Instance.new("TextLabel", topBar)
versionLabel.Size = UDim2.new(0, 200, 1, 0)
versionLabel.Position = UDim2.new(0, 10, 0, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "[v1.5.2]"
versionLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
versionLabel.TextSize = 11
versionLabel.Font = Enum.Font.GothamBold
versionLabel.TextXAlignment = Enum.TextXAlignment.Left

local function createTopControl(text, posX, callback)
	local btn = Instance.new("TextButton", topBar)
	btn.Size = UDim2.new(0, 75, 0, 24)
	btn.Position = UDim2.new(1, posX, 0.5, -12)
	btn.BackgroundColor3 = Color3.fromRGB(25, 28, 38)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(180, 190, 210)
	btn.TextSize = 9
	btn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
	btn.MouseButton1Click:Connect(callback)
end

createTopControl("Minimizar", -245, function() mainFrame.Visible = false end)
createTopControl("Maximizar", -160, function() mainFrame.Visible = true end)
createTopControl("Destruir", -75, function() screenGui:Destroy() end)

-- Sidebar Lateral (Secciones Principales y Configs)
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 175, 1, -60)
sidebar.Position = UDim2.new(0, 12, 0, 52)
sidebar.BackgroundColor3 = Color3.fromRGB(11, 13, 17)
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 380)
sidebar.ScrollBarThickness = 2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)

local uiLayout = Instance.new("UIListLayout", sidebar)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 3)

local sidebarPad = Instance.new("UIPadding", sidebar)
sidebarPad.PaddingTop = UDim.new(0, 6)
sidebarPad.PaddingLeft = UDim.new(0, 6)
sidebarPad.PaddingRight = UDim.new(0, 6)

local function addCategoryHeader(text)
	local lbl = Instance.new("TextLabel", sidebar)
	lbl.Size = UDim2.new(1, 0, 0, 22)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(90, 100, 120)
	lbl.TextSize = 9
	lbl.Font = Enum.Font.GothamBold
	lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-- Contenedor de Páginas
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -200, 1, -60)
container.Position = UDim2.new(0, 194, 0, 52)
container.BackgroundColor3 = Color3.fromRGB(11, 13, 17)
container.BorderSizePixel = 0
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

local pages = {}
local function createPage(name)
	local p = Instance.new("ScrollingFrame", container)
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.CanvasSize = UDim2.new(0, 0, 0, 550)
	p.ScrollBarThickness = 3
	
	local l = Instance.new("UIListLayout", p)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.Padding = UDim.new(0, 8)
	
	local pad = Instance.new("UIPadding", p)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingLeft = UDim.new(0, 12)
	pad.PaddingRight = UDim.new(0, 12)
	
	pages[name] = p
	return p
end

local pageHome = createPage("Inicio")
local pageAimbot = createPage("Aimbot")
local pageVisuals = createPage("Visuales")
local pageMovement = createPage("Movimiento")
local pageGraphics = createPage("Gráficos")
local pageAnims = createPage("Animaciones")

pages["Inicio"].Visible = true

local function createTabBtn(name, targetPage)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(160, 170, 190)
	btn.TextSize = 10
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
	
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		targetPage.Visible = true
	end)
end

addCategoryHeader("Funciones Principales")
createTabBtn("Inicio", pageHome)
createTabBtn("Aimbot", pageAimbot)
createTabBtn("Visuales", pageVisuals)
createTabBtn("Movimiento", pageMovement)
createTabBtn("Gráficos", pageGraphics)

addCategoryHeader("Configs & Extra")
createTabBtn("Animaciones", pageAnims)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- PÁGINA INICIO (Perfil, Cuenta, Sistema, Juego Actual con Logo Exacto)
local function createSectionCard(parent, title, height)
	local f = Instance.new("Frame", parent)
	f.Size = UDim2.new(1, 0, 0, height)
	f.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
	f.BorderSizePixel = 0
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	local pad = Instance.new("UIPadding", f)
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingLeft = UDim.new(0, 12)
	pad.PaddingRight = UDim.new(0, 12)
	
	local t = Instance.new("TextLabel", f)
	t.Size = UDim2.new(1, 0, 0, 18)
	t.BackgroundTransparency = 1
	t.Text = title
	t.TextColor3 = Color3.fromRGB(140, 150, 170)
	t.TextSize = 10
	t.Font = Enum.Font.GothamBold
	t.TextXAlignment = Enum.TextXAlignment.Left
	return f
end

local homeCard1 = createSectionCard(pageHome, "Perfil del Jugador", 95)
local pAvatar = Instance.new("ImageLabel", homeCard1)
pAvatar.Size = UDim2.new(0, 36, 0, 36)
pAvatar.Position = UDim2.new(0, 0, 0, 24)
pAvatar.BackgroundTransparency = 1
pAvatar.Image = "rbxassetid://8126145670"
Instance.new("UICorner", pAvatar).CornerRadius = UDim.new(0, 18)

local pInfo = Instance.new("TextLabel", homeCard1)
pInfo.Size = UDim2.new(1, -45, 0, 50)
pInfo.Position = UDim2.new(0, 45, 0, 22)
pInfo.BackgroundTransparency = 1
pInfo.TextColor3 = Color3.fromRGB(220, 230, 240)
pInfo.TextSize = 10
pInfo.Font = Enum.Font.GothamMedium
pInfo.TextXAlignment = Enum.TextXAlignment.Left
pInfo.TextYAlignment = Enum.TextYAlignment.Top
pInfo.Text = "Usuario: @" .. lp.Name .. "\nID: " .. lp.UserId .. "\nEdad de la cuenta: " .. lp.AccountAge .. " días"

local homeCard2 = createSectionCard(pageHome, "Sistema", 55)
local sysInfo = Instance.new("TextLabel", homeCard2)
sysInfo.Size = UDim2.new(1, 0, 0, 20)
sysInfo.Position = UDim2.new(0, 0, 0, 22)
sysInfo.BackgroundTransparency = 1
sysInfo.TextColor3 = Color3.fromRGB(200, 210, 220)
sysInfo.TextSize = 10
sysInfo.Font = Enum.Font.GothamMedium
sysInfo.TextXAlignment = Enum.TextXAlignment.Left
sysInfo.Text = "Ejecutor actual: Delta"

local homeCard3 = createSectionCard(pageHome, "Información del Servidor", 75)
local sInfo = Instance.new("TextLabel", homeCard3)
sInfo.Size = UDim2.new(1, 0, 0, 35)
sInfo.Position = UDim2.new(0, 0, 0, 22)
sInfo.BackgroundTransparency = 1
sInfo.TextColor3 = Color3.fromRGB(200, 210, 220)
sInfo.TextSize = 10
sInfo.Font = Enum.Font.GothamMedium
sInfo.TextXAlignment = Enum.TextXAlignment.Left
sInfo.TextYAlignment = Enum.TextYAlignment.Top
sInfo.Text = "Juego Actual\n[⚔️DUELS] Duels - Place ID: " .. game.PlaceId

-- PÁGINA AIMBOT (Silent Aim + Crosshair)
local _G_SilentAim = false
local _G_Crosshair = false

local btnAim = Instance.new("TextButton", pageAimbot)
btnAim.Size = UDim2.new(1, 0, 0, 36)
btnAim.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnAim.Text = "  Silent Aim: OFF"
btnAim.TextColor3 = Color3.fromRGB(180, 190, 210)
btnAim.TextSize = 11
btnAim.Font = Enum.Font.GothamMedium
btnAim.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnAim).CornerRadius = UDim.new(0, 6)

btnAim.MouseButton1Click:Connect(function()
	_G_SilentAim = not _G_SilentAim
	btnAim.Text = _G_SilentAim and "  Silent Aim: ON" or "  Silent Aim: OFF"
	btnAim.TextColor3 = _G_SilentAim and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(180, 190, 210)
end)

local crosshairGui = Instance.new("Frame", screenGui)
crosshairGui.Size = UDim2.new(0, 6, 0, 6)
crosshairGui.Position = UDim2.new(0.5, -3, 0.5, -3)
crosshairGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
crosshairGui.Visible = false
Instance.new("UICorner", crosshairGui).CornerRadius = UDim.new(1, 0)

local btnCross = Instance.new("TextButton", pageAimbot)
btnCross.Size = UDim2.new(1, 0, 0, 36)
btnCross.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnCross.Text = "  Crosshair: OFF"
btnCross.TextColor3 = Color3.fromRGB(180, 190, 210)
btnCross.TextSize = 11
btnCross.Font = Enum.Font.GothamMedium
btnCross.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnCross).CornerRadius = UDim.new(0, 6)

btnCross.MouseButton1Click:Connect(function()
	_G_Crosshair = not _G_Crosshair
	crosshairGui.Visible = _G_Crosshair
	btnCross.Text = _G_Crosshair and "  Crosshair: ON" or "  Crosshair: OFF"
	btnCross.TextColor3 = _G_Crosshair and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(180, 190, 210)
end)

local function getClosestPlayer()
	local targetPart = nil
	local shortestDist = math.huge
	for _, v in pairs(players:GetPlayers()) do
		if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
			if v.Character.Humanoid.Health > 0 then
				local part = v.Character.HumanoidRootPart
				local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
				if onScreen then
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - userInput:GetMouseLocation()).Magnitude
					if dist < shortestDist then
						shortestDist = dist
						targetPart = part
					end
				end
			end
		end
	end
	return targetPart
end

local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(self, k)
	if _G_SilentAim and not checkcaller() and k == "Hit" then
		local targetPart = getClosestPlayer()
		if targetPart then
			return targetPart.CFrame
		end
	end
	return oldIndex(self, k)
end)
setreadonly(mt, true)

-- PÁGINA VISUALES (ESP RGB)
local _G_ESP = false
local espObjects = {}

local btnEsp = Instance.new("TextButton", pageVisuals)
btnEsp.Size = UDim2.new(1, 0, 0, 36)
btnEsp.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnEsp.Text = "  Esp: OFF"
btnEsp.TextColor3 = Color3.fromRGB(180, 190, 210)
btnEsp.TextSize = 11
btnEsp.Font = Enum.Font.GothamMedium
btnEsp.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnEsp).CornerRadius = UDim.new(0, 6)

btnEsp.MouseButton1Click:Connect(function()
	_G_ESP = not _G_ESP
	btnEsp.Text = _G_ESP and "  Esp: ON" or "  Esp: OFF"
	btnEsp.TextColor3 = _G_ESP and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(180, 190, 210)
	if not _G_ESP then
		for _, box in pairs(espObjects) do if box then box:Destroy() end end
		espObjects = {}
	end
end)

runService.RenderStepped:Connect(function()
	if _G_ESP then
		local hue = tick() % 5 / 5
		local rgbColor = Color3.fromHSV(hue, 1, 1)
		for _, v in pairs(players:GetPlayers()) do
			if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				if not hrp:FindFirstChild("FluzESP") then
					local highlight = Instance.new("Highlight", hrp)
					highlight.Name = "FluzESP"
					highlight.FillTransparency = 0.5
					table.insert(espObjects, highlight)
				else
					hrp.FluzESP.FillColor = rgbColor
					hrp.FluzESP.OutlineColor = rgbColor
				end
			end
		end
	end
end)

-- PÁGINA MOVIMIENTO (Velocidad y Salto con Sliders)
local function createSlider(parent, name, min, max, callback)
	local f = Instance.new("Frame", parent)
	f.Size = UDim2.new(1, 0, 0, 50)
	f.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
	f.BorderSizePixel = 0
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	local l = Instance.new("TextLabel", f)
	l.Size = UDim2.new(1, -12, 0, 20)
	l.Position = UDim2.new(0, 6, 0, 4)
	l.BackgroundTransparency = 1
	l.Text = "  " .. name .. ": " .. min
	l.TextColor3 = Color3.fromRGB(180, 190, 210)
	l.TextSize = 10
	l.Font = Enum.Font.GothamMedium
	l.TextXAlignment = Enum.TextXAlignment.Left
	
	local bar = Instance.new("TextButton", f)
	bar.Size = UDim2.new(1, -24, 0, 6)
	bar.Position = UDim2.new(0, 12, 0, 32)
	bar.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
	bar.Text = ""
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
	
	local fill = Instance.new("Frame", bar)
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	
	local dragging = false
	bar.MouseButton1Down:Connect(function() dragging = true end)
	userInput.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	userInput.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			local val = math.floor(min + (max - min) * pos)
			l.Text = "  " .. name .. ": " .. val
			callback(val)
		end
	end)
end

createSlider(pageMovement, "Velocidad", 16, 120, function(v)
	pcall(function() lp.Character.Humanoid.WalkSpeed = v end)
end)

createSlider(pageMovement, "Altura de Salto", 50, 200, function(v)
	pcall(function() lp.Character.Humanoid.JumpPower = v end)
end)

-- PÁGINA GRÁFICOS (Shaders, Bajar FPS, Mostrar FPS)
local _G_FPSShow = false
local fpsLabel = Instance.new("TextLabel", screenGui)
fpsLabel.Size = UDim2.new(0, 100, 0, 25)
fpsLabel.Position = UDim2.new(0, 15, 0, 15)
fpsLabel.BackgroundTransparency = 0.5
fpsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
fpsLabel.TextSize = 12
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Visible = false
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 4)

local lastTick = tick()
local frameCount = 0
runService.RenderStepped:Connect(function()
	frameCount = frameCount + 1
	if tick() - lastTick >= 1 then
		fpsLabel.Text = "FPS: " .. frameCount
		frameCount = 0
		lastTick = tick()
	end
end)

local btnFps = Instance.new("TextButton", pageGraphics)
btnFps.Size = UDim2.new(1, 0, 0, 36)
btnFps.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnFps.Text = "  Mostrar FPS: OFF"
btnFps.TextColor3 = Color3.fromRGB(180, 190, 210)
btnFps.TextSize = 11
btnFps.Font = Enum.Font.GothamMedium
btnFps.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnFps).CornerRadius = UDim.new(0, 6)

btnFps.MouseButton1Click:Connect(function()
	_G_FPSShow = not _G_FPSShow
	fpsLabel.Visible = _G_FPSShow
	btnFps.Text = _G_FPSShow and "  Mostrar FPS: ON" or "  Mostrar FPS: OFF"
	btnFps.TextColor3 = _G_FPSShow and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(180, 190, 210)
end)

local btnShader = Instance.new("TextButton", pageGraphics)
btnShader.Size = UDim2.new(1, 0, 0, 36)
btnShader.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnShader.Text = "  Shader Bonito (Cinemático): OFF"
btnShader.TextColor3 = Color3.fromRGB(180, 190, 210)
btnShader.TextSize = 11
btnShader.Font = Enum.Font.GothamMedium
btnShader.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnShader).CornerRadius = UDim.new(0, 6)

local shaderEffect = nil
btnShader.MouseButton1Click:Connect(function()
	if not shaderEffect or not lighting:FindFirstChild("FluzShader") then
		shaderEffect = Instance.new("ColorCorrectionEffect", lighting)
		shaderEffect.Name = "FluzShader"
		shaderEffect.Brightness = 0.05
		shaderEffect.Contrast = 0.2
		shaderEffect.Saturation = 0.15
		btnShader.Text = "  Shader Bonito (Cinemático): ON"
		btnShader.TextColor3 = Color3.fromRGB(50, 200, 100)
	else
		shaderEffect:Destroy()
		shaderEffect = nil
		btnShader.Text = "  Shader Bonito (Cinemático): OFF"
		btnShader.TextColor3 = Color3.fromRGB(180, 190, 210)
	end
end)

local btnLowFps = Instance.new("TextButton", pageGraphics)
btnLowFps.Size = UDim2.new(1, 0, 0, 36)
btnLowFps.BackgroundColor3 = Color3.fromRGB(18, 21, 28)
btnLowFps.Text = "  Modo Bajar FPS (Ahorro): OFF"
btnLowFps.TextColor3 = Color3.fromRGB(180, 190, 210)
btnLowFps.TextSize = 11
btnLowFps.Font = Enum.Font.GothamMedium
btnLowFps.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnLowFps).CornerRadius = UDim.new(0, 6)

local lowFpsActive = false
btnLowFps.MouseButton1Click:Connect(function()
	lowFpsActive = not lowFpsActive
	btnLowFps.Text = lowFpsActive and "  Modo Bajar FPS (Ahorro): ON" or "  Modo Bajar FPS (Ahorro): OFF"
	btnLowFps.TextColor3 = lowFpsActive and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(180, 190, 210)
	task.spawn(function()
		while lowFpsActive do
			task.wait(1 / 15)
		end
	end)
end)

-- PÁGINA ANIMACIONES (Zombie Funcional Sin Bugs de Caminata)
local function applyZombieAnimation()
	pcall(function()
		if lp.Character then
			local animateScript = lp.Character:FindFirstChild("Animate")
			if animateScript then
				local zombieData = {
					idle = {"616158929"},
					walk = {"616168032"},
					run  = {"616163682"},
					jump 
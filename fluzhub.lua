
-- SERVICIOS Y VARIABLES LOCALES
local players = game:GetService("Players")
local lp = players.LocalPlayer
local ws = game:GetService("Workspace")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local marketplace = game:GetService("MarketplaceService")
local textService = game:GetService("TextService")

local SILENT_AIM_ON = false
local WALL_CHECK_ON = true
local TEAM_CHECK_ON = true
local TARGET_PART = "Head"
local AUTOFARM_ON = false
local ESP_ON = false

local SpeedEnabled = false
local WalkSpeedValue = 16
local JumpEnabled = false
local JumpPowerValue = 50
local FlyEnabled = false
local NoClipEnabled = false

-- OBTENER INFO DEL JUEGO
local gameName = "Roblox Experience"
local gameIconId = "rbxassetid://6023426915"
pcall(function()
	local info = marketplace:GetProductInfo(game.PlaceId)
	if info then
		gameName = info.Name or gameName
		if info.IconImageAssetId and info.IconImageAssetId > 0 then
			gameIconId = "rbxassetid://" .. info.IconImageAssetId
		end
	end
end)

-- CREACIÓN DE LA UI PRINCIPAL (ESTILO AXEL HUB)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FluzHubModern"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
toggleButton.Image = "rbxassetid://6023426915"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 12)
local btnStroke = Instance.new("UIStroke", toggleButton)
btnStroke.Color = Color3.fromRGB(40, 40, 40)
btnStroke.Thickness = 1.5

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local frameStroke = Instance.new("UIStroke", mainFrame)
frameStroke.Color = Color3.fromRGB(45, 45, 45)
frameStroke.Thickness = 1

-- BARRA SUPERIOR MINIMALISTA
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundTransparency = 1

local hubIcon = Instance.new("ImageLabel", topBar)
hubIcon.Size = UDim2.new(0, 20, 0, 20)
hubIcon.Position = UDim2.new(0, 12, 0, 8)
hubIcon.BackgroundTransparency = 1
hubIcon.Image = "rbxassetid://6023426915"

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(0, 300, 1, 0)
titleLabel.Position = UDim2.new(0, 40, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Fluz Hub\n<font size='9' color='rgb(140,140,140)'>by jexzzz</font>"
titleLabel.RichText = true
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -64, 0, 6)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
minimizeBtn.TextSize = 14
minimizeBtn.Font = Enum.Font.GothamBold

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -32, 0, 6)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold

-- BARRA LATERAL (SIDEBAR)
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 160, 1, -36)
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.BackgroundTransparency = 1
sidebar.CanvasSize = UDim2.new(0, 0, 0, 350)
sidebar.ScrollBarThickness = 0

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 2)

local sidebarPadding = Instance.new("UIPadding", sidebar)
sidebarPadding.PaddingTop = UDim.new(0, 8)
sidebarPadding.PaddingLeft = UDim.new(0, 8)
sidebarPadding.PaddingRight = UDim.new(0, 8)

-- CONTENEDOR PRINCIPAL DE PÁGINAS
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -165, 1, -44)
contentContainer.Position = UDim2.new(0, 162, 0, 40)
contentContainer.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
contentContainer.BorderSizePixel = 0
Instance.new("UICorner", contentContainer).CornerRadius = UDim.new(0, 8)
local contentStroke = Instance.new("UIStroke", contentContainer)
contentStroke.Color = Color3.fromRGB(35, 35, 35)
contentStroke.Thickness = 1

local function createPage()
	local page = Instance.new("ScrollingFrame", contentContainer)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.CanvasSize = UDim2.new(0, 0, 0, 450)
	page.ScrollBarThickness = 3
	page.Visible = false
	
	local layout = Instance.new("UIListLayout", page)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 6)
	
	local pad = Instance.new("UIPadding", page)
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	
	return page
end

local pageHome = createPage()
pageHome.Visible = true
local pageAimbot = createPage()
local pageVisuals = createPage()
local pageMovement = createPage()
local pageAutoFarm = createPage()
local pageAnims = createPage()
local pageGraphics = createPage()

local function createTabButton(name, targetPage, order)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundTransparency = 1
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(160, 160, 160)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.LayoutOrder = order
	
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(contentContainer:GetChildren()) do
			if p:IsA("ScrollingFrame") then p.Visible = false end
		end
		for _, b in pairs(sidebar:GetChildren()) do
			if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(160, 160, 160) end
		end
		targetPage.Visible = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

createTabButton("🏠 Inicio", pageHome, 1)
createTabButton("🎯 Aimbot / Combat", pageAimbot, 2)
createTabButton("👁️ Visuales & ESP", pageVisuals, 3)
createTabButton("⚡ Movimiento", pageMovement, 4)
createTabButton("💰 AutoFarm", pageAutoFarm, 5)
createTabButton("🎭 Animaciones", pageAnims, 6)
createTabButton("💡 Gráficos", pageGraphics, 7)

-- PERFIL DE USUARIO EN LA SIDEBAR
local userProfile = Instance.new("Frame", sidebar)
userProfile.Size = UDim2.new(1, 0, 0, 45)
userProfile.Position = UDim2.new(0, 0, 0.8, 0)
userProfile.BackgroundTransparency = 1
userProfile.LayoutOrder = 99

local avatarPreview = Instance.new("ImageLabel", userProfile)
avatarPreview.Size = UDim2.new(0, 32, 0, 32)
avatarPreview.Position = UDim2.new(0, 4, 0, 6)
avatarPreview.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
avatarPreview.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner", avatarPreview).CornerRadius = UDim.new(1, 0)

local userLabel = Instance.new("TextLabel", userProfile)
userLabel.Size = UDim2.new(1, -40, 1, 0)
userLabel.Position = UDim2.new(0, 40, 0, 0)
userLabel.BackgroundTransparency = 1
userLabel.Text = lp.Name .. "\n<font size='9' color='rgb(120,120,120)'>Delta User</font>"
userLabel.RichText = true
userLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
userLabel.TextSize = 10
userLabel.Font = Enum.Font.GothamMedium
userLabel.TextXAlignment = Enum.TextXAlignment.Left

-- COMPONENTES
local function createCard(parent, title, height)
	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, height)
	card.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	card.BorderSizePixel = 0
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
	
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = Color3.fromRGB(42, 42, 42)
	stroke.Thickness = 1
	
	local label = Instance.new("TextLabel", card)
	label.Size = UDim2.new(1, -16, 0, 24)
	label.Position = UDim2.new(0, 10, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 11
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	return card
end

local function createToggle(parent, name, defaultState, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(42, 42, 42)
	
	local statusIndicator = Instance.new("Frame", btn)
	statusIndicator.Size = UDim2.new(0, 10, 0, 10)
	statusIndicator.Position = UDim2.new(1, -22, 0.5, -5)
	statusIndicator.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", statusIndicator).CornerRadius = UDim.new(1, 0)
	
	local active = defaultState
	btn.MouseButton1Click:Connect(function()
		active = not active
		statusIndicator.BackgroundColor3 = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
		callback(active)
	end)
end

local function createSlider(parent, name, minVal, maxVal, defaultVal, callback)
	local container = Instance.new("Frame", parent)
	container.Size = UDim2.new(1, 0, 0, 45)
	container.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, -10, 0, 18)
	label.Position = UDim2.new(0, 10, 0, 4)
	label.BackgroundTransparency = 1
	label.Text = "  " .. name .. ": " .. defaultVal
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 10
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left

	local sliderBg = Instance.new("Frame", container)
	sliderBg.Size = UDim2.new(1, -20, 0, 8)
	sliderBg.Position = UDim2.new(0, 10, 0, 28)
	sliderBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 4)

	local sliderFill = Instance.new("Frame", sliderBg)
	local initialSize = (defaultVal - minVal) / (maxVal - minVal)
	sliderFill.Size = UDim2.new(initialSize, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 4)

	local dragging = false
	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)

	uis.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	uis.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
			sliderFill.Size = UDim2.new(pos, 0, 1, 0)
			local val = math.floor(minVal + (maxVal - minVal) * pos)
			label.Text = "  " .. name .. ": " .. val
			callback(val)
		end
	end)
end

-- CONTENIDO DE PÁGINAS (INICIO LLAMATIVO)
local gameCard = createCard(pageHome, "Información de la Partida", 85)
local gameImg = Instance.new("ImageLabel", gameCard)
gameImg.Size = UDim2.new(0, 45, 0, 45)
gameImg.Position = UDim2.new(0, 10, 0, 32)
gameImg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gameImg.Image = gameIconId
Instance.new("UICorner", gameImg).CornerRadius = UDim.new(0, 6)

local gameInfoLabel = Instance.new("TextLabel", gameCard)
gameInfoLabel.Size = UDim2.new(1, -65, 0, 45)
gameInfoLabel.Position = UDim2.new(0, 62, 0, 32)
gameInfoLabel.BackgroundTransparency = 1
gameInfoLabel.Text = "Juego: " .. gameName .. "\nPlace ID: " .. game.PlaceId
gameInfoLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
gameInfoLabel.TextSize = 10
gameInfoLabel.Font = Enum.Font.GothamMedium
gameInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
gameInfoLabel.TextWrapped = true

local userCard = createCard(pageHome, "Perfil y Dispositivo", 100)
local avatarBig = Instance.new("ImageLabel", userCard)
avatarBig.Size = UDim2.new(0, 50, 0, 50)
avatarBig.Position = UDim2.new(0, 10, 0, 35)
avatarBig.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
avatarBig.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner", avatarBig).CornerRadius = UDim.new(1, 0)

local userDetailedLabel = Instance.new("TextLabel", userCard)
userDetailedLabel.Size = UDim2.new(1, -70, 0, 60)
userDetailedLabel.Position = UDim2.new(0, 68, 0, 32)
userDetailedLabel.BackgroundTransparency = 1
userDetailedLabel.Text = "Usuario: " .. lp.Name .. "\nID: " .. lp.UserId .. "\nAntigüedad: " .. lp.AccountAge .. " días\nHora Local: Cargando..."
userDetailedLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
userDetailedLabel.TextSize = 10
userDetailedLabel.Font = Enum.Font.GothamMedium
userDetailedLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Actualizar hora en vivo
task.spawn(function()
	while true do
		local date = os.date("*t")
		local hours = string.format("%02d", date.hour)
		local mins = string.format("%02d", date.min)
		local secs = string.format("%02d", date.sec)
		userDetailedLabel.Text = "Usuario: " .. lp.Name .. "\nID: " .. lp.UserId .. "\nAntigüedad: " .. lp.AccountAge .. " días\nHora Local: " .. hours .. ":" .. mins .. ":" .. secs
		task.wait(1)
	end
end)

createToggle(pageAimbot, "🎯 Silent Aim", false, function(state) SILENT_AIM_ON = state end)
createToggle(pageAimbot, "🧱 Wall Check", true, function(state) WALL_CHECK_ON = state end)
createToggle(pageAimbot, "👥 Team Check", true, function(state) TEAM_CHECK_ON = state end)

createToggle(pageVisuals, "👁️ ESP Players", false, function(state) ESP_ON = state end)

createToggle(pageMovement, "⚡ Speed Hack", false, function(state) SpeedEnabled = state end)
createSlider(pageMovement, "Velocidad", 1, 50, 16, function(val) WalkSpeedValue = val end)
createToggle(pageMovement, "🦘 High Jump", false, function(state) JumpEnabled = state end)
createSlider(pageMovement, "Potencia Salto", 50, 200, 50, function(val) JumpPowerValue = val end)
createToggle(pageMovement, "🛸 Fly Mode", false, function(state) FlyEnabled = state end)
createToggle(pageMovement, "👻 Noclip", false, function(state) NoClipEnabled = state end)

createToggle(pageAutoFarm, "💰 AutoFarm Monedas", false, function(state) AUTOFARM_ON = state end)

local function createAnimButton(name, animId)
	local btn = Instance.new("TextButton", pageAnims)
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	btn.MouseButton1Click:Connect(function()
		pcall(function()
			if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
				local animateScript = lp.Character:FindFirstChild("Animate")
				if animateScript then
					for _, animObj in pairs(animateScript:GetChildren()) do
						if animObj:IsA("StringValue") then
							for _, anim in pairs(animObj:GetChildren()) do
								if anim:IsA("Animation") then
									anim.AnimationId = "rbxassetid://" .. animId
								end
							end
						end
					end
				end
			end
		end)
	end)
end

createAnimButton("Toy Animation Pack", "782841498")
createAnimButton("Zombie Animation", "616158929")

local function setLightingMode(mode)
	if mode == "Bright" then
		lighting.Brightness = 3
		lighting.ClockTime = 14
		lighting.GlobalShadows = false
	else
		lighting.Brightness = 1
		lighting.GlobalShadows = true
	end
end

local btnBright = Instance.new("TextButton", pageGraphics)
btnBright.Size = UDim2.new(1, 0, 0, 32)
btnBright.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
btnBright.Text = "  💡 Fullbright"
btnBright.TextColor3 = Color3.fromRGB(200, 200, 200)
btnBright.TextSize = 11
btnBright.Font = Enum.Font.GothamMedium
btnBright.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnBright).CornerRadius = UDim.new(0, 6)
btnBright.MouseButton1Click:Connect(function() setLightingMode("Bright") end)

-- CONTROLES BARRA SUPERIOR
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentContainer.Visible = not minimized
	sidebar.Visible = not minimized
	mainFrame.Size = minimized and UDim2.new(0, 600, 0, 36) or UDim2.new(0, 600, 0, 380)
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- LOGICA DE COMBATE CON WALL CHECK Y TEAM CHECK REALES
local function isEnemy(player)
	if player == lp then return false end
	if TEAM_CHECK_ON and lp.Team and player.Team and lp.Team == player.Team then 
		return false 
	end
	return true
end

local function isVisible(targetPart)
	if not WALL_CHECK_ON then return true end
	if not lp.Character or not lp.Character:FindFirstChild("Head") then return false end
	
	local origin = lp.Character.Head.Position
	local direction = (targetPart.Position - origin)
	
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {lp.Character}
	raycastParams.IgnoreWater = true
	
	local result = ws:Raycast(origin, direction, raycastParams)
	if result then
		local hitPart = result.Instance
		if hitPart:IsDescendantOf(targetPart.Parent) then
			return true
		end
		return false
	end
	return true
end

local function cleanActivate()
	pcall(function()
		if lp.Character then
			local tool = lp.Character:FindFirstChildOfClass("Tool")
			if tool then
				tool:Activate()
				for _, remote in pairs(tool:GetDescendants()) do
					if remote:IsA("RemoteEvent") then
						local rName = remote.Name:lower()
						if rName:find("shoot") or rName:find("fire") or rName:find("attack") or rName:find("hit") then
							remote:FireServer()
						end
					end
				end
			end
		end
	end)
end

task.spawn(function()
	while true do
		task.wait(0.08)
		if SILENT_AIM_ON then
			pcall(function()
				local validTargetFound = false
				for _, v in pairs(players:GetPlayers()) do
					if isEnemy(v) and v.Character then
						local hum = v.Character:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							local targetPart = v.Character:FindFirstChild(TARGET_PART) or v.Character:FindFirstChild("Head")
							if targetPart and v.Character:FindFirstChild("HumanoidRootPart") and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
								local dist = (lp.Character.HumanoidRootPart.Position - targetPart.Position).Magnitude
								if dist < 350 and isVisible(targetPart) then
									validTargetFound = true
									break
								end
							end
						end
					end
				end
				if validTargetFound then cleanActivate() end
			end)
		end
	end
end)

runService.RenderStepped:Connect(function()
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		local hum = lp.Character.Humanoid
		hum.WalkSpeed = SpeedEnabled and WalkSpeedValue or 16
		if JumpEnabled then hum.JumpPower = JumpPowerValue end
	end
	if FlyEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
		lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0)
	end
end)

runService.Stepped:Connect(function()
	if NoClipEnabled and lp.Character then
		for _, p in pairs(lp.Character:GetDescendants()) do
			if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
		end
	end
end)

runService.RenderStepped:Connect(function()
	for _, p in pairs(players:GetPlayers()) do
		if p ~= lp and p.Character then
			local enemy = isEnemy(p)
			if ESP_ON and enemy then
				if not p.Character:FindFirstChild("Highlight") then
					local hl = Instance.new("Highlight", p.Character)
					hl.FillColor = Color3.fromRGB(150, 150, 150)
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				end
			else
				if p.Character:FindFirstChild("Highlight") then p.Character.Highlight:Destroy() end
			end
		end
	end
end)
-- SERVICIOS Y VARIABLES LOCALES
local players = game:GetService("Players")
local lp = players.LocalPlayer
local ws = game:GetService("Workspace")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local vim = game:GetService("VirtualInputManager")
local lighting = game:GetService("Lighting")
local camera = ws.CurrentCamera

local SILENT_AIM_ON = false
local TARGET_PART = "Head"
local KILL_ALL_ON = false
local AUTOFARM_ON = false
local ESP_ON = false
local HITBOX_ON = false
local HITBOX_SIZE = 5

local SpeedEnabled = false
local WalkSpeedValue = 16
local JumpEnabled = false
local JumpPowerValue = 50
local FlyEnabled = false
local NoClipEnabled = false
local InfiniteJumpEnabled = false

-- CREACIÓN DE LA UI PRINCIPAL
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FluzHubUltimate"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
toggleButton.Image = "rbxassetid://8126145670"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 10)
local btnStroke = Instance.new("UIStroke", toggleButton)
btnStroke.Color = Color3.fromRGB(138, 43, 226)
btnStroke.Thickness = 2

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 580, 0, 360)
mainFrame.Position = UDim2.new(0.5, -290, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", mainFrame)
frameStroke.Color = Color3.fromRGB(85, 26, 139)
frameStroke.Thickness = 2

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 12)

local topBarCover = Instance.new("Frame", topBar)
topBarCover.Size = UDim2.new(1, 0, 0, 12)
topBarCover.Position = UDim2.new(0, 0, 1, -12)
topBarCover.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
topBarCover.BorderSizePixel = 0

local hubIcon = Instance.new("ImageLabel", topBar)
hubIcon.Size = UDim2.new(0, 26, 0, 26)
hubIcon.Position = UDim2.new(0, 10, 0, 7)
hubIcon.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
hubIcon.Image = "rbxassetid://8126145670"
Instance.new("UICorner", hubIcon).CornerRadius = UDim.new(0, 6)

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(0, 380, 1, 0)
titleLabel.Position = UDim2.new(0, 46, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FLUZ HUB | " .. game.Name .. " [v2.0]  |  Activos: " .. #players:GetPlayers()
titleLabel.TextColor3 = Color3.fromRGB(220, 200, 255)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
minimizeBtn.Position = UDim2.new(1, -68, 0, 6)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 60)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 14
minimizeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 160, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
sidebar.BorderSizePixel = 0

local sidebarPadding = Instance.new("UIPadding", sidebar)
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 8)
sidebarPadding.PaddingRight = UDim.new(0, 8)

local sidebarLayout = Instance.new("UIListLayout", sidebar)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 5)

local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -160, 1, -40)
contentContainer.Position = UDim2.new(0, 160, 0, 40)
contentContainer.BackgroundTransparency = 1

local function createPage()
	local page = Instance.new("ScrollingFrame", contentContainer)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.CanvasSize = UDim2.new(0, 0, 0, 450)
	page.ScrollBarThickness = 3
	page.Visible = false
	
	local layout = Instance.new("UIListLayout", page)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)
	
	local pad = Instance.new("UIPadding", page)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingLeft = UDim.new(0, 12)
	pad.PaddingRight = UDim.new(0, 12)
	
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
	btn.BackgroundColor3 = Color3.fromRGB(22, 15, 35)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(180, 160, 210)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.LayoutOrder = order
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	btn.MouseButton1Click:Connect(function()
		pageHome.Visible = false
		pageAimbot.Visible = false
		pageVisuals.Visible = false
		pageMovement.Visible = false
		pageAutoFarm.Visible = false
		pageAnims.Visible = false
		pageGraphics.Visible = false
		targetPage.Visible = true
	end)
end

createTabButton("🏠 Inicio", pageHome, 1)
createTabButton("🎯 Aimbot / Silent", pageAimbot, 2)
createTabButton("👁️ Visuales & ESP", pageVisuals, 3)
createTabButton("⚡ Movimiento", pageMovement, 4)
createTabButton("💰 AutoFarm Monedas", pageAutoFarm, 5)
createTabButton("🎭 Animaciones", pageAnims, 6)
createTabButton("💡 Gráficos", pageGraphics, 7)

local function createCard(parent, title, height)
	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, height)
	card.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
	card.BorderSizePixel = 0
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = Color3.fromRGB(60, 25, 90)
	stroke.Thickness = 1
	
	local label = Instance.new("TextLabel", card)
	label.Size = UDim2.new(1, -16, 0, 24)
	label.Position = UDim2.new(0, 10, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = title
	label.TextColor3 = Color3.fromRGB(220, 180, 255)
	label.TextSize = 11
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	return card
end

local function createToggle(parent, name, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
	btn.Text = "  " .. name .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(200, 180, 230)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(60, 25, 90)
	
	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.BackgroundColor3 = active and Color3.fromRGB(110, 38, 194) or Color3.fromRGB(18, 12, 28)
		btn.Text = "  " .. name .. (active and ": ON" or ": OFF")
		callback(active)
	end)
end

local function createSlider(parent, name, minVal, maxVal, defaultVal, callback)
	local container = Instance.new("Frame", parent)
	container.Size = UDim2.new(1, 0, 0, 45)
	container.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, 0, 0, 18)
	label.BackgroundTransparency = 1
	label.Text = "  " .. name .. ": " .. defaultVal
	label.TextColor3 = Color3.fromRGB(200, 180, 230)
	label.TextSize = 10
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left

	local sliderBg = Instance.new("Frame", container)
	sliderBg.Size = UDim2.new(1, 0, 0, 14)
	sliderBg.Position = UDim2.new(0, 0, 0, 22)
	sliderBg.BackgroundColor3 = Color3.fromRGB(22, 15, 35)
	Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 4)

	local sliderFill = Instance.new("Frame", sliderBg)
	local initialSize = (defaultVal - minVal) / (maxVal - minVal)
	sliderFill.Size = UDim2.new(initialSize, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
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

local profileCard = createCard(pageHome, "Perfil del Jugador", 100)
local avatarPreview = Instance.new("ImageLabel", profileCard)
avatarPreview.Size = UDim2.new(0, 40, 0, 40)
avatarPreview.Position = UDim2.new(0, 10, 0, 35)
avatarPreview.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
avatarPreview.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner", avatarPreview).CornerRadius = UDim.new(1, 0)

local accountAgeDays = lp.AccountAge
local userInfoLabel = Instance.new("TextLabel", profileCard)
userInfoLabel.Size = UDim2.new(1, -65, 0, 55)
userInfoLabel.Position = UDim2.new(0, 60, 0, 32)
userInfoLabel.BackgroundTransparency = 1
userInfoLabel.Text = "Usuario: @" .. lp.Name .. "\nID: " .. lp.UserId .. "\nCuenta creada hace: " .. accountAgeDays .. " días\nEjecutor: Delta"
userInfoLabel.TextColor3 = Color3.fromRGB(180, 160, 210)
userInfoLabel.TextSize = 10
userInfoLabel.Font = Enum.Font.GothamMedium
userInfoLabel.TextXAlignment = Enum.TextXAlignment.Left

local serverCard = createCard(pageHome, "Información del Servidor & Juego", 75)
local serverInfoLabel = Instance.new("TextLabel", serverCard)
serverInfoLabel.Size = UDim2.new(1, -20, 0, 40)
serverInfoLabel.Position = UDim2.new(0, 10, 0, 28)
serverInfoLabel.BackgroundTransparency = 1
serverInfoLabel.Text = "Juego: " .. game.Name .. "\nPlace ID: " .. game.PlaceId
serverInfoLabel.TextColor3 = Color3.fromRGB(180, 160, 210)
serverInfoLabel.TextSize = 10
serverInfoLabel.Font = Enum.Font.GothamMedium
serverInfoLabel.TextXAlignment = Enum.TextXAlignment.Left

createToggle(pageAimbot, "🎯 Silent Aim / Auto Shoot", function(state) SILENT_AIM_ON = state end)

local function createPartButton(name, partName)
	local btn = Instance.new("TextButton", pageAimbot)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
	btn.Text = "  Objetivo: " .. name
	btn.TextColor3 = Color3.fromRGB(200, 180, 230)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	btn.MouseButton1Click:Connect(function()
		TARGET_PART = partName
		btn.BackgroundColor3 = Color3.fromRGB(110, 38, 194)
		task.wait(0.2)
		btn.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
	end)
end

createPartButton("Cabeza (Head)", "Head")
createPartButton("Torso (HumanoidRootPart)", "HumanoidRootPart")
createPartButton("Extremidades / Pies", "LeftFoot")

createToggle(pageAimbot, "💀 Kill All (Auto Knife)", function(state) KILL_ALL_ON = state end)
createToggle(pageVisuals, "👁️ ESP Players (Highlight + Arma)", function(state) ESP_ON = state end)
createToggle(pageVisuals, "📦 Hitbox Expander", function(state) HITBOX_ON = state end)

createToggle(pageMovement, "⚡ Speed Hack", function(state) SpeedEnabled = state end)
createSlider(pageMovement, "Velocidad", 1, 50, 16, function(val) WalkSpeedValue = val end)
createToggle(pageMovement, "🦘 High Jump", function(state) JumpEnabled = state end)
createSlider(pageMovement, "Potencia Salto", 50, 200, 50, function(val) JumpPowerValue = val end)
createToggle(pageMovement, "🛸 Fly Mode (Vuelo)", function(state) FlyEnabled = state end)
createToggle(pageMovement, "👻 Noclip (Atravesar paredes)", function(state) NoClipEnabled = state end)
createToggle(pageMovement, "🦘 Infinite Jump", function(state) InfiniteJumpEnabled = state end)

createToggle(pageAutoFarm, "💰 AutoFarm Monedas / Drops", function(state) AUTOFARM_ON = state end)

local function createAnimButton(name, animId)
	local btn = Instance.new("TextButton", pageAnims)
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
	btn.Text = "  Aplicar Animación: " .. name
	btn.TextColor3 = Color3.fromRGB(200, 180, 230)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
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
createAnimButton("Adidas / Street Style", "616156119")
createAnimButton("Knight Animation", "657595757")
createAnimButton("Zombie Animation", "616158929")

local function setLightingMode(mode)
	if mode == "Bright" then
		lighting.Brightness = 3
		lighting.ClockTime = 14
		lighting.GlobalShadows = false
		lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
	elseif mode == "FPS" then
		lighting.Brightness = 1
		lighting.GlobalShadows = false
		for _, v in pairs(ws:GetDescendants()) do
			if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
		end
	else
		lighting.Brightness = 1
		lighting.GlobalShadows = true
	end
end

local btnBright = Instance.new("TextButton", pageGraphics)
btnBright.Size = UDim2.new(1, 0, 0, 32)
btnBright.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
btnBright.Text = "  💡 Modo Iluminación Brillante (Fullbright)"
btnBright.TextColor3 = Color3.fromRGB(200, 180, 230)
btnBright.TextSize = 11
btnBright.Font = Enum.Font.GothamBold
btnBright.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnBright).CornerRadius = UDim.new(0, 6)
btnBright.MouseButton1Click:Connect(function() setLightingMode("Bright") end)

local btnFPS = Instance.new("TextButton", pageGraphics)
btnFPS.Size = UDim2.new(1, 0, 0, 32)
btnFPS.BackgroundColor3 = Color3.fromRGB(18, 12, 28)
btnFPS.Text = "  ⚡ Modo Gráficos Bajos (Optimizar FPS)"
btnFPS.TextColor3 = Color3.fromRGB(200, 180, 230)
btnFPS.TextSize = 11
btnFPS.Font = Enum.Font.GothamBold
btnFPS.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnFPS).CornerRadius = UDim.new(0, 6)
btnFPS.MouseButton1Click:Connect(function() setLightingMode("FPS") end)

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	contentContainer.Visible = not minimized
	sidebar.Visible = not minimized
	mainFrame.Size = minimized and UDim2.new(0, 580, 0, 40) or UDim2.new(0, 580, 0, 360)
	minimizeBtn.Text = minimized and "+" or "-"
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local function isEnemy(player)
	if player == lp then return false end
	if lp.Team and player.Team and lp.Team == player.Team then return false end
	return true
end

local function cleanActivate()
	pcall(function()
		if lp.Character then
			local tool = lp.Character:FindFirstChildOfClass("Tool")
			if tool then tool:Activate()
			else
				vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
				task.wait(0.01)
				vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
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
				local shortestDistance = math.huge
				for _, v in pairs(players:GetPlayers()) do
					if isEnemy(v) and v.Character then
						local hum = v.Character:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							local targetPart = v.Character:FindFirstChild(TARGET_PART) or v.Character:FindFirstChild("Head")
							if targetPart and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
								local origin = lp.Character.HumanoidRootPart.Position
								local dist = (origin - targetPart.Position).Magnitude
								if dist < 350 then
									local rp = RaycastParams.new()
									rp.FilterType = Enum.RaycastFilterType.Exclude
									rp.FilterDescendantsInstances = {lp.Character}
									local res = ws:Raycast(origin, (targetPart.Position - origin).Unit * dist, rp)
									if not res or res.Instance:IsDescendantOf(v.Character) then
										if dist < shortestDistance then
											shortestDistance = dist
											validTargetFound = true
										end
									end
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

task.spawn(function()
	while true do
		task.wait(0.5)
		if AUTOFARM_ON then
			pcall(function()
				if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
					local hrp = lp.Character.HumanoidRootPart
					for _, obj in pairs(ws:GetDescendants()) do
						if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("moneda") or obj.Name:lower():find("cash") or obj.Name:lower():find("gold")) then
							hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
							task.wait(0.1)
						end
					end
				end
			end)
		end
	end
end)

runService.RenderStepped:Connect(function()
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		local hum = lp.Character.Humanoid
		hum.WalkSpeed = SpeedEnabled and WalkSpeedValue or 16
		if JumpEnabled then
			hum.JumpPower = JumpPowerValue
		end
	end

	if FlyEnabled and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = lp.Character.HumanoidRootPart
		hrp.Velocity = Vector3.new(0, 1, 0)
	end
end)

uis.JumpRequest:Connect(function()
	if InfiniteJumpEnabled and lp.Character then
		local h = lp.Character:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

runService.Stepped:Connect(function()
	if NoClipEnabled and lp.Character then
		for _, p in pairs(lp.Character:GetDescendants()) do
			if p:Is
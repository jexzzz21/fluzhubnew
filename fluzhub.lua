-- SERVICIOS Y VARIABLES LOCALES
local players = game:GetService("Players")
local lp = players.LocalPlayer
local ws = game:GetService("Workspace")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local localizationService = game:GetService("LocalizationService")
local camera = ws.CurrentCamera

local AUTO_SHOOT_ON = false
local KILL_ALL_ON = false
local ESP_ON = false
local HITBOX_ON = false
local HITBOX_SIZE = 5
local WalkSpeedValue = 16
local SpeedEnabled = false
local NoClipEnabled = false
local InfiniteJumpEnabled = false

-- CONSTRUCCIÓN DE LA UI PRINCIPAL
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FluzHubRGBFull"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.Image = "rbxassetid://85600975100250"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 10)
local btnStroke = Instance.new("UIStroke", toggleButton)
btnStroke.Color = Color3.fromRGB(0, 170, 255)
btnStroke.Thickness = 2

local mainFrame = Instance.new("ImageLabel", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 400)
mainFrame.Position = UDim2.new(0.08, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.Image = "rbxassetid://12508966325"
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", mainFrame)
frameStroke.Thickness = 2

-- CAPA SUPERIOR (BARRA DE TÍTULO CON FUENTE DE MINECRAFT)
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(0, 110, 1, 0)
titleLabel.Position = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "fluz hub by jesuslmk"
titleLabel.TextSize = 9
titleLabel.Font = Enum.Font.Arcade
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local flagLabel = Instance.new("TextLabel", topBar)
flagLabel.Size = UDim2.new(0, 24, 0, 24)
flagLabel.Position = UDim2.new(0, 122, 0, 8)
flagLabel.BackgroundTransparency = 1
flagLabel.TextSize = 13
flagLabel.Font = Enum.Font.GothamBold

task.spawn(function()
	pcall(function()
		local region = localizationService:GetCountryRegionForPlayerAsync(lp)
		if region and #region == 2 then
			local b1 = string.byte(region, 1) - 65 + 127397
			local b2 = string.byte(region, 2) - 65 + 127397
			flagLabel.Text = utf8.char(b1) .. utf8.char(b2)
		else
			flagLabel.Text = "🌐"
		end
	end)
end)

local avatarImg = Instance.new("ImageLabel", topBar)
avatarImg.Size = UDim2.new(0, 28, 0, 28)
avatarImg.Position = UDim2.new(1, -36, 0, 6)
avatarImg.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
avatarImg.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

local tabGeneralBtn = Instance.new("TextButton", mainFrame)
tabGeneralBtn.Size = UDim2.new(0.44, 0, 0, 25)
tabGeneralBtn.Position = UDim2.new(0.04, 0, 0, 45)
tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
tabGeneralBtn.Text = "GENERAL"
tabGeneralBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabGeneralBtn.TextSize = 11
tabGeneralBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", tabGeneralBtn).CornerRadius = UDim.new(0, 6)

local tabMiscBtn = Instance.new("TextButton", mainFrame)
tabMiscBtn.Size = UDim2.new(0.44, 0, 0, 25)
tabMiscBtn.Position = UDim2.new(0.52, 0, 0, 45)
tabMiscBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
tabMiscBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
tabMiscBtn.TextSize = 11
tabMiscBtn.Font = Enum.Font.FredokaOne
Instance.new("UICorner", tabMiscBtn).CornerRadius = UDim.new(0, 6)

local generalContainer = Instance.new("ScrollingFrame", mainFrame)
generalContainer.Size = UDim2.new(1, 0, 0, 315)
generalContainer.Position = UDim2.new(0, 0, 0, 78)
generalContainer.BackgroundTransparency = 1
generalContainer.CanvasSize = UDim2.new(0, 0, 0, 250)
generalContainer.ScrollBarThickness = 3
generalContainer.Visible = true

local miscContainer = Instance.new("ScrollingFrame", mainFrame)
miscContainer.Size = UDim2.new(1, 0, 0, 315)
miscContainer.Position = UDim2.new(0, 0, 0, 78)
miscContainer.BackgroundTransparency = 1
miscContainer.CanvasSize = UDim2.new(0, 0, 0, 320)
miscContainer.ScrollBarThickness = 3
miscContainer.Visible = false

tabGeneralBtn.MouseButton1Click:Connect(function()
	generalContainer.Visible = true
	miscContainer.Visible = false
	tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	tabGeneralBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabMiscBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	tabMiscBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

tabMiscBtn.MouseButton1Click:Connect(function()
	generalContainer.Visible = false
	miscContainer.Visible = true
	tabMiscBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
	tabMiscBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabGeneralBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	tabGeneralBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local function createButton(parent, name, yPos, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0.9, 0, 0, 32)
	btn.Position = UDim2.new(0.05, 0, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.BackgroundColor3 = active and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(25, 25, 30)
		callback(active)
	end)
end

local function createSlider(parent, name, yPos, minVal, maxVal, defaultVal, callback)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(0.9, 0, 0, 18)
	label.Position = UDim2.new(0.05, 0, 0, yPos)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. defaultVal
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.TextSize = 10
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left

	local sliderBg = Instance.new("Frame", parent)
	sliderBg.Size = UDim2.new(0.9, 0, 0, 14)
	sliderBg.Position = UDim2.new(0.05, 0, 0, yPos + 20)
	sliderBg.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 4)

	local sliderFill = Instance.new("Frame", sliderBg)
	local initialSize = (defaultVal - minVal) / (maxVal - minVal)
	sliderFill.Size = UDim2.new(initialSize, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
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
			label.Text = name .. ": " .. val
			callback(val)
		end
	end)
end

local function isEnemy(player)
	if player == lp then return false end
	if lp.Team and player.Team and lp.Team == player.Team then
		return false
	end
	return true
end

local function equipKnife()
	if lp.Character and lp.Backpack then
		for _, tool in pairs(lp.Backpack:GetChildren()) do
			if tool:IsA("Tool") then
				local name = string.lower(tool.Name)
				if name:find("knife") or name:find("cuchillo") or name:find("blade") or name:find("dagger") then
					lp.Character.Humanoid:EquipTool(tool)
					break
				end
			end
		end
	end
end

createButton(generalContainer, "🎯 Auto Shoot (Silent Wall): OFF", 10, function(state)
	AUTO_SHOOT_ON = state
end)

createButton(generalContainer, "💀 Kill All: OFF", 50, function(state)
	KILL_ALL_ON = state
	if state then equipKnife() end
end)

createButton(generalContainer, "👁️ ESP Players: OFF", 90, function(state)
	ESP_ON = state
end)

createButton(miscContainer, "⚡ Speed Hack: OFF", 10, function(state)
	SpeedEnabled = state
end)

createSlider(miscContainer, "Velocidad de Movimiento", 50, 1, 50, 16, function(val)
	WalkSpeedValue = val
end)

createButton(miscContainer, "📦 Hitbox Expander: OFF", 110, function(state)
	HITBOX_ON = state
end)

createButton(miscContainer, "👻 Noclip: OFF", 150, function(state)
	NoClipEnabled = state
end)

createButton(miscContainer, "🦘 Infinite Jump: OFF", 190, function(state)
	InfiniteJumpEnabled = state
end)

createButton(miscContainer, "🔄 Reset Configs", 230, function()
	SpeedEnabled = false
	WalkSpeedValue = 16
	HITBOX_ON = false
	NoClipEnabled = false
	InfiniteJumpEnabled = false
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		lp.Character.Humanoid.WalkSpeed = 16
	end
end)

-- MOTOR DE EFECTO RGB Y SILENT AIM A TRAVÉS DE PAREDES
runService.RenderStepped:Connect(function()
	local hue = tick() % 5 / 5
	local rgbColor = Color3.fromHSV(hue, 1, 1)
	
	titleLabel.TextColor3 = rgbColor
	frameStroke.Color = rgbColor

	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		lp.Character.Humanoid.WalkSpeed = SpeedEnabled and WalkSpeedValue or 16
	end

	-- Lógica Silent Aim con detección de paredes/enemigos cercanos a través del mapa
	if AUTO_SHOOT_ON then
		local closestEnemy = nil
		local shortestDistance = math.huge

		for _, v in pairs(players:GetPlayers()) do
			if isEnemy(v) and v.Character and v.Character:FindFirstChild("Head") then
				local hum = v.Character:FindFirstChildOfClass("Humanoid")
				if hum and hum.Health > 0 then
					local head = v.Character.Head
					local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
					
					-- Detecta enemigos incluso si están detrás de paredes usando la posición 3D directa
					if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
						local dist = (lp.Character.HumanoidRootPart.Position - head.Position).Magnitude
						if dist < shortestDistance then
							shortestDistance = dist
							closestEnemy = head
						end
					end
				end
			end
		end

		if closestEnemy and shortestDistance < 300 then
			pcall(function()
				-- Simula un disparo directo al objetivo detectado por el wall/silent aim
				mouse1press()
				task.wait(0.03)
				mouse1release()
			end)
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.2)
		pcall(function()
			if KILL_ALL_ON then
				equipKnife()
				for _, v in pairs(players:GetPlayers()) do
					if not KILL_ALL_ON then break end
					if isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						local hum = v.Character:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
								lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
								mouse1press()
								task.wait(0.05)
								mouse1release()
							end
						end
					end
				end
			end
		end)
	end
end)

uis.JumpRequest:Connect(function()
	if InfiniteJumpEnabled and lp.Character then
		local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

runService.Stepped:Connect(function()
	if NoClipEnabled and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

runService.RenderStepped:Connect(function()
	for _, p in pairs(players:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			local enemy = isEnemy(p)
			
			if HITBOX_ON and enemy then
				hrp.Size = Vector3.new(HITBOX_SIZE, HITBOX_SIZE, HITBOX_SIZE)
				hrp.Transparency = ESP_ON and 0.7 or 1
				hrp.Color = Color3.new(1, 0, 1)
				hrp.CanCollide = false
			else
				hrp.Size = Vector3.new(2, 2, 1)
				hrp.Transparency = 1
			end

			if ESP_ON and enemy then
				if not p.Character:FindFirstChild("Highlight") then
					Instance.new("Highlight", p.Character).FillColor = Color3.new(1, 0, 0)
				end
			elseif p.Character:FindFirstChild("Highlight") and not enemy then
				p.Character.Highlight:Destroy()
			elseif not ESP_ON and p.Character:FindFirstChild("Highlight") then
				p.Character.Highlight:Destroy()
			end
		end
	end
end)
-- SERVICIOS Y VARIABLES LOCALES
local players = game:GetService("Players")
local lp = players.LocalPlayer
local ws = game:GetService("Workspace")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local FLING_ALL_ON = false
local ESP_ON = false
local HITBOX_ON = false
local HITBOX_SIZE = 5
local WalkSpeedValue = 16
local SpeedEnabled = false
local NoClipEnabled = false
local InfiniteJumpEnabled = false

-- CONSTRUCCIÓN DE LA UI (DISEÑO DE BARRA LATERAL)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "CustomImageCombatUI"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleButton.Image = "rbxassetid://85600975100250"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true

local btnCorner = Instance.new("UICorner", toggleButton)
btnCorner.CornerRadius = UDim.new(0, 10)

local btnStroke = Instance.new("UIStroke", toggleButton)
btnStroke.Color = Color3.fromRGB(0, 170, 255)
btnStroke.Thickness = 2

-- Ventana en modo barra lateral alta y delgada
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 180, 0, 360)
mainFrame.Position = UDim2.new(0.08, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", mainFrame)
frameStroke.Color = Color3.fromRGB(45, 45, 55)
frameStroke.Thickness = 1.5

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FLUZ HUB"
titleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold

local function createButton(name, yPos, callback)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0.9, 0, 0, 32)
	btn.Position = UDim2.new(0.05, 0, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 10
	btn.Font = Enum.Font.GothamMedium
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	local active = false
	btn.MouseButton1Click:Connect(function()
		active = not active
		btn.BackgroundColor3 = active and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(25, 25, 30)
		callback(active)
	end)
end

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- VERIFICACIÓN DE EQUIPO
local function isEnemy(player)
	if player == lp then return false end
	if lp.Team and player.Team and lp.Team == player.Team then
		return false
	end
	return true
end

createButton("🌪️ FLING ALL: OFF", 40, function(state)
	FLING_ALL_ON = state
end)

createButton("⚡ Speed (25): OFF", 77, function(state)
	SpeedEnabled = state
	WalkSpeedValue = state and 25 or 16
end)

createButton("👁️ ESP Players: OFF", 114, function(state)
	ESP_ON = state
end)

createButton("📦 Hitbox Expander: OFF", 151, function(state)
	HITBOX_ON = state
end)

createButton("👻 Noclip: OFF", 188, function(state)
	NoClipEnabled = state
end)

createButton("🦘 Infinite Jump: OFF", 225, function(state)
	InfiniteJumpEnabled = state
end)

createButton("🔄 Reset Speed", 262, function()
	WalkSpeedValue = 16
	SpeedEnabled = false
	if lp.Character and lp.Character:FindFirstChild("Humanoid") then
		lp.Character.Humanoid.WalkSpeed = 16
	end
end)

-- MOTOR DE FLING Y VELOCIDAD
task.spawn(function()
	local function flingTarget(targetHRP)
		local character = lp.Character
		if not character or not character:FindFirstChild("HumanoidRootPart") then return end
		local hrp = character.HumanoidRootPart
		
		local vel = Instance.new("BodyAngularVelocity")
		vel.Name = "FlingForce"
		vel.Parent = hrp
		vel.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		vel.AngularVelocity = Vector3.new(0, 99999, 0)
		
		local startTime = tick()
		while tick() - startTime < 0.25 do
			if not FLING_ALL_ON then break end
			hrp.CFrame = targetHRP.CFrame
			task.wait()
		end
		vel:Destroy()
	end

	while true do
		task.wait(0.2)
		pcall(function()
			if lp.Character and lp.Character:FindFirstChild("Humanoid") then
				lp.Character.Humanoid.WalkSpeed = WalkSpeedValue
			end

			if FLING_ALL_ON then
				for _, v in pairs(players:GetPlayers()) do
					if not FLING_ALL_ON then break end
					if isEnemy(v) and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						local hum = v.Character:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							flingTarget(v.Character.HumanoidRootPart)
						end
					end
				end
			end
		end)
	end
end)

-- INFINITE JUMP (Corregido para evitar errores en Delta)
uis.JumpRequest:Connect(function()
	if InfiniteJumpEnabled and lp.Character then
		local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

-- NOCLIP
runService.Stepped:Connect(function()
	if NoClipEnabled and lp.Character then
		for _, part in pairs(lp.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

-- HITBOX Y ESP
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
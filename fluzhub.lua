-- FluzHub v3.0 | [⚔️DUELS] | by: jesuslmk
-- Repositorio: jexzzz21/fluzhubnew

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local lp = players.LocalPlayer
local camera = workspace.CurrentCamera

if lp.PlayerGui:FindFirstChild("FluzHubGui") then
	lp.PlayerGui.FluzHubGui:Destroy()
end

local screenGui = Instance.new("ScreenGui", lp.PlayerGui)
screenGui.Name = "FluzHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botón Flotante con Estilo IDéntico
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 42, 0, 42)
toggleButton.Position = UDim2.new(0.02, 0, 0.28, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
toggleButton.Image = "rbxassetid://6023426915"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

local tStroke = Instance.new("UIStroke", toggleButton)
tStroke.Color = Color3.fromRGB(45, 50, 65)
tStroke.Thickness = 1.5

-- Ventana Principal (Estilo de Referencia Exacto: Paneles Grises Cohesionados)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 540, 0, 340)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(40, 45, 60)
mStroke.Thickness = 1

-- Tarjeta / Encabezado Flotante Superior Estilo T3RA
local topHeaderCard = Instance.new("Frame", mainFrame)
topHeaderCard.Size = UDim2.new(0, 240, 0, 36)
topHeaderCard.Position = UDim2.new(0, 12, 0, 12)
topHeaderCard.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
topHeaderCard.BorderSizePixel = 0
Instance.new("UICorner", topHeaderCard).CornerRadius = UDim.new(0, 6)

local topCardStroke = Instance.new("UIStroke", topHeaderCard)
topCardStroke.Color = Color3.fromRGB(50, 150, 255)
topCardStroke.Thickness = 1

local headerAvatar = Instance.new("ImageLabel", topHeaderCard)
headerAvatar.Size = UDim2.new(0, 26, 0, 26)
headerAvatar.Position = UDim2.new(0, 5, 0, 5)
headerAvatar.BackgroundTransparency = 1
pcall(function()
	headerAvatar.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)
Instance.new("UICorner", headerAvatar).CornerRadius = UDim.new(0, 13)

local titleLabel = Instance.new("TextLabel", topHeaderCard)
titleLabel.Size = UDim2.new(1, -38, 1, 0)
titleLabel.Position = UDim2.new(0, 36, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FluzHub | by jesuslmk"
titleLabel.TextColor3 = Color3.fromRGB(235, 240, 250)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Barra Superior General de la Ventana
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 48)
topBar.BackgroundTransparency = 1
topBar.BorderSizePixel = 0

local windowTitle = Instance.new("TextLabel", topBar)
windowTitle.Size = UDim2.new(0, 300, 1, 0)
windowTitle.Position = UDim2.new(0, 265, 0, 0)
windowTitle.BackgroundTransparency = 1
windowTitle.Text = "[⚔️DUELS] [v3.0]"
windowTitle.TextColor3 = Color3.fromRGB(140, 150, 170)
windowTitle.TextSize = 11
windowTitle.Font = Enum.Font.GothamMedium
windowTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar Lateral Exacto
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 160, 1, -65)
sidebar.Position = UDim2.new(0, 12, 0, 56)
sidebar.BackgroundColor3 = Color3.fromRGB(14, 16, 21)
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 250)
sidebar.ScrollBarThickness = 2
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 6)

local uiLayout = Instance.new("UIListLayout", sidebar)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 4)

local sidebarPad = Instance.new("UIPadding", sidebar)
sidebarPad.PaddingTop = UDim.new(0, 6)
sidebarPad.PaddingLeft = UDim.new(0, 6)
sidebarPad.PaddingRight = UDim.new(0, 6)

-- Contenedor de Páginas (Panel Derecho Estilo Tarjeta)
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -184, 1, -65)
container.Position = UDim2.new(0, 178, 0, 56)
container.BackgroundColor3 = Color3.fromRGB(14, 16, 21)
container.BorderSizePixel = 0
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

local pages = {}
local function createPage(name)
	local p = Instance.new("ScrollingFrame", container)
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.CanvasSize = UDim2.new(0, 0, 0, 450)
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
local pageCombat = createPage("Combat")
local pageAnims = createPage("Animaciones")

pages["Inicio"].Visible = true

local function createTabBtn(name, targetPage)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(160, 170, 190)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		targetPage.Visible = true
	end)
end

createTabBtn("Inicio", pageHome)
createTabBtn("Combat", pageCombat)
createTabBtn("Animaciones", pageAnims)

-- Perfil de Usuario Integrado Abajo Izquierda (Estilo Referencia)
local userProfileFrame = Instance.new("Frame", sidebar)
userProfileFrame.Size = UDim2.new(1, 0, 0, 46)
userProfileFrame.Position = UDim2.new(0, 0, 0.75, 0)
userProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
userProfileFrame.BorderSizePixel = 0
Instance.new("UICorner", userProfileFrame).CornerRadius = UDim.new(0, 6)

local userAvatar = Instance.new("ImageLabel", userProfileFrame)
userAvatar.Size = UDim2.new(0, 32, 0, 32)
userAvatar.Position = UDim2.new(0, 7, 0, 7)
userAvatar.BackgroundTransparency = 1
pcall(function()
	userAvatar.Image = players:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)
Instance.new("UICorner", userAvatar).CornerRadius = UDim.new(0, 16)

local userNameLbl = Instance.new("TextLabel", userProfileFrame)
userNameLbl.Size = UDim2.new(1, -44, 0, 15)
userNameLbl.Position = UDim2.new(0, 44, 0, 8)
userNameLbl.BackgroundTransparency = 1
userNameLbl.Text = lp.Name
userNameLbl.TextColor3 = Color3.fromRGB(240, 245, 250)
userNameLbl.TextSize = 10
userNameLbl.Font = Enum.Font.GothamBold
userNameLbl.TextXAlignment = Enum.TextXAlignment.Left

local userSubLbl = Instance.new("TextLabel", userProfileFrame)
userSubLbl.Size = UDim2.new(1, -44, 0, 15)
userSubLbl.Position = UDim2.new(0, 44, 0, 22)
userSubLbl.BackgroundTransparency = 1
userSubLbl.Text = "Activo: Delta"
userSubLbl.TextColor3 = Color3.fromRGB(50, 200, 100)
userSubLbl.TextSize = 9
userSubLbl.Font = Enum.Font.GothamMedium
userSubLbl.TextXAlignment = Enum.TextXAlignment.Left

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- DASHBOARD HOME
local homeCard = Instance.new("Frame", pageHome)
homeCard.Size = UDim2.new(1, 0, 0, 110)
homeCard.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
homeCard.BorderSizePixel = 0
Instance.new("UICorner", homeCard).CornerRadius = UDim.new(0, 6)
local hPad = Instance.new("UIPadding", homeCard)
hPad.PaddingTop = UDim.new(0, 12)
hPad.PaddingLeft = UDim.new(0, 12)

local infoLabel = Instance.new("TextLabel", homeCard)
infoLabel.Size = UDim2.new(1, 0, 1, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(50, 200, 100)
infoLabel.TextSize = 11
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

runService.RenderStepped:Connect(function()
	infoLabel.Text = "Status: Online (Protected)\nDeveloper: jesuslmk\nGame: [⚔️DUELS]\nUser: " .. lp.Name .. "\nTime: " .. os.date("%H:%M:%S")
end)

-- COMBAT SYSTEM (Silent Aim + Aim Part Selector)
local _G_SilentAim = false
local _G_AimPart = "Torso"
local partModes = {"Torso", "Head", "Leg", "Random"}
local partIndex = 1

local function getTargetPart(character)
	local mode = _G_AimPart
	if mode == "Random" then
		local opts = {"Head", "Torso", "LeftLowerLeg", "RightLowerLeg"}
		mode = opts[math.random(1, #opts)]
	end
	
	if mode == "Head" then
		return character:FindFirstChild("Head")
	elseif mode == "Leg" then
		return character:FindFirstChild("LeftLowerLeg") or character:FindFirstChild("RightLowerLeg") or character:FindFirstChild("HumanoidRootPart")
	else
		return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	end
end

local function getClosestPlayer()
	local targetPart = nil
	local shortestDist = math.huge
	
	for _, v in pairs(players:GetPlayers()) do
		if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
			if v.Character.Humanoid.Health > 0 then
				if not v.Team or v.Team ~= lp.Team then
					local part = getTargetPart(v.Character)
					if part then
						local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
						if onScreen then
							local mousePos = userInput:GetMouseLocation()
							local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
							if dist < shortestDist then
								local rayParams = RaycastParams.new()
								rayParams.FilterDescendantsInstances = {lp.Character, v.Character}
								rayParams.FilterType = Enum.RaycastFilterType.Exclude
								local result = workspace:Raycast(camera.CFrame.Position, (part.Position - camera.CFrame.Position), rayParams)
								
								if not result then
									shortestDist = dist
									targetPart = part
								end
							end
						end
					end
				end
			end
		end
	end
	return targetPart
end

-- Botones Combat con Estilo de Referencia
local btnAim = Instance.new("TextButton", pageCombat)
btnAim.Size = UDim2.new(1, 0, 0, 36)
btnAim.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
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

local btnPart = Instance.new("TextButton", pageCombat)
btnPart.Size = UDim2.new(1, 0, 0, 36)
btnPart.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
btnPart.Text = "  Aim Part: Torso"
btnPart.TextColor3 = Color3.fromRGB(50, 200, 100)
btnPart.TextSize = 11
btnPart.Font = Enum.Font.GothamMedium
btnPart.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnPart).CornerRadius = UDim.new(0, 6)

btnPart.MouseButton1Click:Connect(function()
	partIndex = partIndex % #partModes + 1
	_G_AimPart = partModes[partIndex]
	btnPart.Text = "  Aim Part: " .. _G_AimPart
end)

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

-- ANIMACIONES BLINDADAS (Ninja, Toy, Zombie, Levitation, Adidas)
local function applyAnimationPack(packType)
	pcall(function()
		if lp.Character then
			local animateScript = lp.Character:FindFirstChild("Animate")
			if animateScript then
				local anims = {
					["Ninja"] = {
						idle = {"656117409", "656118796"},
						walk = {"656121766"},
						run  = {"656118839"},
						jump = {"656117878"},
						fall = {"656115606"},
						swim = {"656116490"}
					},
					["Toy"] = {
						idle = {"782841498"},
						walk = {"782845736"},
						run  = {"782842759"},
						jump = {"782847020"},
						fall = {"782843345"},
						swim = {"782844575"}
					},
					["Zombie"] = {
						idle = {"616158929"},
						walk = {"616168032"},
						run  = {"616163682"},
						jump = {"616161997"},
						fall = {"616160354"},
						swim = {"616165520"}
					},
					["Levitation"] = {
						idle = {"707829716"},
						walk = {"707823501"},
						run  = {"707826189"},
						jump = {"707817789"},
						fall = {"707814984"},
						swim = {"707821611"}
					},
					["Adidas"] = {
						idle = {"12635419566"},
						walk = {"10681050834"},
						run  = {"10681050834"},
						jump = {"11571549528"},
						fall = {"9399340635"},
						swim = {"10653799381"}
					}
				}
				
				local selected = anims[packType]
				if selected then
					for folderName, idList in pairs(selected) do
						local folder = nil
						for _, child in pairs(animateScript:GetChildren()) do
							if child:IsA("StringValue") and child.Name:lower() == folderName:lower() then
								folder = child
								break
							end
						end
						
						if folder then
							for _, animChild in pairs(folder:GetChildren()) do
								if animChild:IsA("Animation") then
									animChild:Destroy()
								end
							end
							
							for index, animId in ipairs(idList) do
								local newAnim = Instance.new("Animation")
								newAnim.Name = folderName .. index
								newAnim.AnimationId = "rbxassetid://" .. animId
								newAnim.Parent = folder
							end
						end
					end
					
					animateScript.Enabled = false
					task.wait(0.05)
					animateScript.Enabled = true
				end
			end
		end
	end)
end

local function createAnimBtn(name, typeKey)
	local btn = Instance.new("TextButton", pageAnims)
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(20, 23, 31)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(180, 190, 210)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(function() applyAnimationPack(typeKey) end)
end

createAnimBtn("Ninja Animation Pack", "Ninja")
createAnimBtn("Toy Animation Pack", "Toy")
createAnimBtn("Zombie Animation Pack", "Zombie")
createAnimBtn("Levitation Animation Pack", "Levitation")
createAnimBtn("Adidas Animation Pack", "Adidas")
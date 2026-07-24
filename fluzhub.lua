-- FluzHub v2.8 | [⚔️DUELS] | by: jesuslmk
-- Repositorio: jexzzz21/fluzhubnew

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local lp = players.LocalPlayer
local camera = workspace.CurrentCamera

-- Limpieza previa
if lp.PlayerGui:FindFirstChild("FluzHubGui") then
	lp.PlayerGui.FluzHubGui:Destroy()
end

local screenGui = Instance.new("ScreenGui", lp.PlayerGui)
screenGui.Name = "FluzHubGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botón Flotante Principal
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 42, 0, 42)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
toggleButton.Image = "rbxassetid://6023426915"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

local tStroke = Instance.new("UIStroke", toggleButton)
tStroke.Color = Color3.fromRGB(0, 150, 255)
tStroke.Thickness = 1.5

-- Ventana Principal (Minimalista Oscura con Neon Azul)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 480, 0, 300)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(0, 150, 255)
mStroke.Thickness = 1

-- Barra Superior
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 6)

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(1, -15, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FluzHub | [⚔️DUELS] — by: jesuslmk"
titleLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar de Pestañas
local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 120, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
sidebar.ScrollBarThickness = 0

local uiLayout = Instance.new("UIListLayout", sidebar)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 3)

-- Contenedor de Páginas
local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -120, 1, -30)
container.Position = UDim2.new(0, 120, 0, 30)
container.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
	local p = Instance.new("ScrollingFrame", container)
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.CanvasSize = UDim2.new(0, 0, 0, 350)
	p.ScrollBarThickness = 2
	
	local l = Instance.new("UIListLayout", p)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.Padding = UDim.new(0, 5)
	
	local pad = Instance.new("UIPadding", p)
	pad.PaddingTop = UDim.new(0, 8)
	pad.PaddingLeft = UDim.new(0, 8)
	pad.PaddingRight = UDim.new(0, 8)
	
	pages[name] = p
	return p
end

local pageHome = createPage("Home")
local pageCombat = createPage("Combat")
local pageAnims = createPage("Anims")

pages["Home"].Visible = true

local function createTabBtn(name, targetPage)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -8, 0, 28)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(150, 180, 220)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
	
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do p.Visible = false end
		targetPage.Visible = true
	end)
end

createTabBtn("Home", pageHome)
createTabBtn("Combat", pageCombat)
createTabBtn("Anims", pageAnims)

toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- HOME PANEL
local infoLabel = Instance.new("TextLabel", pageHome)
infoLabel.Size = UDim2.new(1, 0, 0, 80)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
infoLabel.TextSize = 11
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

runService.RenderStepped:Connect(function()
	infoLabel.Text = "Status: Secure\nDeveloper: jesuslmk\nGame: [⚔️DUELS]\nUser: " .. lp.Name
end)

-- COMBAT: SILENT AIM & ESP RGB
local _G_SilentAim = false
local _G_ESP = false

local function getClosestPlayer()
	local target = nil
	local shortestDist = math.huge
	
	for _, v in pairs(players:GetPlayers()) do
		if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
			if v.Character.Humanoid.Health > 0 and (not v.Team or v.Team ~= lp.Team) then
				local hrp = v.Character.HumanoidRootPart
				local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
				if onScreen then
					local mousePos = userInput:GetMouseLocation()
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					if dist < shortestDist then
						local rayParams = RaycastParams.new()
						rayParams.FilterDescendantsInstances = {lp.Character, v.Character}
						rayParams.FilterType = Enum.RaycastFilterType.Exclude
						local result = workspace:Raycast(camera.CFrame.Position, (hrp.Position - camera.CFrame.Position), rayParams)
						if not result then
							shortestDist = dist
							target = hrp
						end
					end
				end
			end
		end
	end
	return target
end

-- Botón Silent Aim
local btnAim = Instance.new("TextButton", pageCombat)
btnAim.Size = UDim2.new(1, 0, 0, 30)
btnAim.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
btnAim.Text = "  Silent Aim: OFF"
btnAim.TextColor3 = Color3.fromRGB(160, 160, 160)
btnAim.TextSize = 11
btnAim.Font = Enum.Font.GothamMedium
btnAim.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnAim).CornerRadius = UDim.new(0, 5)

btnAim.MouseButton1Click:Connect(function()
	_G_SilentAim = not _G_SilentAim
	btnAim.Text = _G_SilentAim and "  Silent Aim: ON" or "  Silent Aim: OFF"
	btnAim.TextColor3 = _G_SilentAim and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(160, 160, 160)
end)

-- Botón ESP RGB
local btnEsp = Instance.new("TextButton", pageCombat)
btnEsp.Size = UDim2.new(1, 0, 0, 30)
btnEsp.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
btnEsp.Text = "  ESP RGB: OFF"
btnEsp.TextColor3 = Color3.fromRGB(160, 160, 160)
btnEsp.TextSize = 11
btnEsp.Font = Enum.Font.GothamMedium
btnEsp.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnEsp).CornerRadius = UDim.new(0, 5)

btnEsp.MouseButton1Click:Connect(function()
	_G_ESP = not _G_ESP
	btnEsp.Text = _G_ESP and "  ESP RGB: ON" or "  ESP RGB: OFF"
	if not _G_ESP then
		btnEsp.TextColor3 = Color3.fromRGB(160, 160, 160)
		for _, v in pairs(players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("FluzESP") then
				v.Character.FluzESP:Destroy()
			end
		end
	end
end)

runService.RenderStepped:Connect(function()
	if _G_ESP then
		local rgbColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
		btnEsp.TextColor3 = rgbColor
		for _, v in pairs(players:GetPlayers()) do
			if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local highlight = v.Character:FindFirstChild("FluzESP")
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Name = "FluzESP"
					highlight.Adornee = v.Character
					highlight.Parent = v.Character
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
				end
				highlight.FillColor = rgbColor
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			end
		end
	end
end)

-- MetaTable Hook para Silent Aim
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, k)
	if _G_SilentAim and not checkcaller() and k == "Hit" then
		local targetHRP = getClosestPlayer()
		if targetHRP then
			return targetHRP.CFrame
		end
	end
	return oldIndex(self, k)
end)
setreadonly(mt, true)


-- ANIMS: SISTEMA RIGUROSO DE ANIMACIONES CORREGIDO
local originalAnimationIds = {}

local function applyAnimationPack(packType)
	pcall(function()
		if lp.Character then
			local animateScript = lp.Character:FindFirstChild("Animate")
			if animateScript then
				if next(originalAnimationIds) == nil then
					for _, folder in pairs(animateScript:GetChildren()) do
						if folder:IsA("StringValue") then
							originalAnimationIds[folder.Name] = {}
							for _, child in pairs(folder:GetChildren()) do
								if child:IsA("Animation") then
									table.insert(originalAnimationIds[folder.Name], child.AnimationId)
								end
							end
						end
					end
				end

				local anims = {
					["Ninja"] = {
						idle = {"rbxassetid://656117409", "rbxassetid://656118796"},
						walk = {"rbxassetid://656121766"},
						run  = {"rbxassetid://656118839"},
						jump = {"rbxassetid://656117878"},
						fall = {"rbxassetid://656115606"},
						swim = {"rbxassetid://656116490"}
					},
					["Toy"] = {
						idle = {"rbxassetid://782841498"},
						walk = {"rbxassetid://782845736"},
						run  = {"rbxassetid://782842759"},
						jump = {"rbxassetid://782847020"},
						fall = {"rbxassetid://782843345"},
						swim = {"rbxassetid://782844575"}
					},
					["Zombie"] = {
						idle = {"rbxassetid://616158929"},
						walk = {"rbxassetid://616168032"},
						run  = {"rbxassetid://616163682"},
						jump = {"rbxassetid://616161997"},
						fall = {"rbxassetid://616160354"},
						swim = {"rbxassetid://616165520"}
					},
					["Levitation"] = {
						idle = {"rbxassetid://707829716"},
						walk = {"rbxassetid://707823501"},
						run  = {"rbxassetid://707826189"},
						jump = {"rbxassetid://707817789"},
						fall = {"rbxassetid://707814984"},
						swim = {"rbxassetid://707821611"}
					},
					["Adidas"] = {
						idle = {"rbxassetid://12635419566"},
						walk = {"rbxassetid://10681050834"},
						run  = {"rbxassetid://10681050834"},
						jump = {"rbxassetid://11571549528"},
						fall = {"rbxassetid://9399340635"},
						swim = {"rbxassetid://10653799381"}
					}
				}
				
				local selected = (packType == "Default") and nil or anims[packType]
				
				for _, folder in pairs(animateScript:GetChildren()) do
					if folder:IsA("StringValue") then
						local fName = folder.Name
						local targetList = selected and selected[fName:lower()] or originalAnimationIds[fName]
						if targetList then
							local idx = 1
							for _, child in pairs(folder:GetChildren()) do
								if child:IsA("Animation") then
									child.AnimationId = targetList[idx] or targetList[1]
									idx = idx + 1
								end
							end
						end
					end
				end
				
				animateScript.Enabled = false
				task.wait(0.05)
				animateScript.Enabled = true
			end
		end
	end)
end

local function createAnimBtn(name, typeKey)
	local btn = Instance.new("TextButton", pageAnims)
	btn.Size = UDim2.new(1, 0, 0, 28)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(160, 160, 160)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
	btn.MouseButton1Click:Connect(function() applyAnimationPack(typeKey) end)
end

createAnimBtn("Ninja Pack", "Ninja")
createAnimBtn("Toy Pack", "Toy")
createAnimBtn("Zombie Pack", "Zombie")
createAnimBtn("Levitation Pack", "Levitation")
createAnimBtn("Adidas Pack", "Adidas")
createAnimBtn("Restaurar / Original", "Default")
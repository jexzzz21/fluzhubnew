-- FluzHub v2.7 | [⚔️DUELS] | by: jesuslmk
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

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 48, 0, 48)
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
toggleButton.Image = "rbxassetid://6023426915"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 10)

local tStroke = Instance.new("UIStroke", toggleButton)
tStroke.Color = Color3.fromRGB(0, 255, 150)
tStroke.Thickness = 1.5

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(0, 255, 150)
mStroke.Thickness = 1

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 8)

local hubIcon = Instance.new("ImageLabel", topBar)
hubIcon.Size = UDim2.new(0, 20, 0, 20)
hubIcon.Position = UDim2.new(0, 12, 0, 8)
hubIcon.BackgroundTransparency = 1
hubIcon.Image = "rbxassetid://6023426915"
hubIcon.ScaleType = Enum.ScaleType.Fit

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(0, 300, 1, 0)
titleLabel.Position = UDim2.new(0, 40, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FluzHub | [⚔️DUELS] — by: jesuslmk"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
titleLabel.TextSize = 11
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local sidebar = Instance.new("ScrollingFrame", mainFrame)
sidebar.Size = UDim2.new(0, 130, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
sidebar.BorderSizePixel = 0
sidebar.CanvasSize = UDim2.new(0, 0, 0, 200)
sidebar.ScrollBarThickness = 2

local uiLayout = Instance.new("UIListLayout", sidebar)
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 4)

local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, -130, 1, -35)
container.Position = UDim2.new(0, 130, 0, 35)
container.BackgroundTransparency = 1

local pages = {}
local function createPage(name)
	local p = Instance.new("ScrollingFrame", container)
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.CanvasSize = UDim2.new(0, 0, 0, 400)
	p.ScrollBarThickness = 3
	
	local l = Instance.new("UIListLayout", p)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.Padding = UDim.new(0, 6)
	
	local pad = Instance.new("UIPadding", p)
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingLeft = UDim.new(0, 10)
	pad.PaddingRight = UDim.new(0, 10)
	
	pages[name] = p
	return p
end

local pageHome = createPage("Home")
local pageCombat = createPage("Combat")
local pageAnims = createPage("Anims")

pages["Home"].Visible = true

local function createTabBtn(name, targetPage)
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(180, 180, 180)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamMedium
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	
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

local infoLabel = Instance.new("TextLabel", pageHome)
infoLabel.Size = UDim2.new(1, 0, 0, 90)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
infoLabel.TextSize = 12
infoLabel.Font = Enum.Font.GothamBold
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top

runService.RenderStepped:Connect(function()
	local timeStr = os.date("%H:%M:%S")
	infoLabel.Text = "Status: Online (Protected)\nDeveloper: jesuslmk\nGame: [⚔️DUELS]\nLocalTime: " .. timeStr .. "\nUser: " .. lp.Name
end)

local _G_SilentAim = false
local _G_AimPart = "Torso" -- Opciones: Head, Torso, Leg, Random
local partModes = {"Torso", "Head", "Leg", "Random"}
local partIndex = 1

local function getTargetPart(character)
	local selectedMode = _G_AimPart
	if selectedMode == "Random" then
		local options = {"Head", "Torso", "LeftLowerLeg", "RightLowerLeg"}
		selectedMode = options[math.random(1, #options)]
	end
	
	if selectedMode == "Head" then
		return character:FindFirstChild("Head")
	elseif selectedMode == "Leg" then
		return character:FindFirstChild("LeftLowerLeg") or character:FindFirstChild("RightLowerLeg") or character:FindFirstChild("HumanoidRootPart")
	else
		return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
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

local btnAim = Instance.new("TextButton", pageCombat)
btnAim.Size = UDim2.new(1, 0, 0, 35)
btnAim.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
btnAim.Text = "  Silent Aim: OFF"
btnAim.TextColor3 = Color3.fromRGB(200, 200, 200)
btnAim.TextSize = 11
btnAim.Font = Enum.Font.GothamMedium
btnAim.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnAim).CornerRadius = UDim.new(0, 6)

btnAim.MouseButton1Click:Connect(function()
	_G_SilentAim = not _G_SilentAim
	if _G_SilentAim then
		btnAim.Text = "  Silent Aim: ON"
		btnAim.TextColor3 = Color3.fromRGB(0, 255, 150)
	else
		btnAim.Text = "  Silent Aim: OFF"
		btnAim.TextColor3 = Color3.fromRGB(200, 200, 200)
	end
end)

local btnPart = Instance.new("TextButton", pageCombat)
btnPart.Size = UDim2.new(1, 0, 0, 35)
btnPart.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
btnPart.Text = "  Aim Part: Torso"
btnPart.TextColor3 = Color3.fromRGB(200, 200, 200)
btnPart.TextSize = 11
btnPart.Font = Enum.Font.GothamMedium
btnPart.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", btnPart).CornerRadius = UDim.new(0, 6)

btnPart.MouseButton1Click:Connect(function()
	partIndex = partIndex % #partModes + 1
	_G_AimPart = partModes[partIndex]
	btnPart.Text = "  Aim Part: " .. _G_AimPart
	if _G_AimPart == "Head" then
		btnPart.TextColor3 = Color3.fromRGB(255, 50, 50)
	elseif _G_AimPart == "Leg" then
		btnPart.TextColor3 = Color3.fromRGB(50, 150, 255)
	elseif _G_AimPart == "Random" then
		btnPart.TextColor3 = Color3.fromRGB(255, 150, 0)
	else
		btnPart.TextColor3 = Color3.fromRGB(0, 255, 150)
	end
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
						local folder = animateScript:FindFirstChild(folderName:lower()) or animateScript:FindFirstChild(folderName)
						if not folder then
							for _, child in pairs(animateScript:GetChildren()) do
								if child:IsA("StringValue") and child.Name:lower() == folderName:lower() then
									folder = child
									break
								end
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
	btn.Size = UDim2.new(1, 0, 0, 32)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
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

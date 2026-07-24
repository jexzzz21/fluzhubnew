-- Fluz Hub | Duels [v1.5.2]
local p, rs, ui, ws, lit, cg = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Workspace"), game:GetService("Lighting"), game:GetService("CoreGui")
local lp, cam = p.LocalPlayer, ws.CurrentCamera
if cg:FindFirstChild("FluzHubGui") then cg.FluzHubGui:Destroy() end
local sg = Instance.new("ScreenGui", cg) sg.Name, sg.ResetOnSpawn = "FluzHubGui", false

local tb = Instance.new("ImageButton", sg)
tb.Size, tb.Position, tb.BackgroundColor3, tb.Image, tb.Active, tb.Draggable = UDim2.new(0,45,0,45), UDim2.new(0.02,0,0.25,0), Color3.fromRGB(18,20,26), "rbxassetid://8126145670", true, true
tb.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", tb).CornerRadius = UDim.new(0,8)
local ts = Instance.new("UIStroke", tb) ts.Color, ts.Thickness = Color3.fromRGB(45,50,65), 1.5

local mf = Instance.new("Frame", sg)
mf.Size, mf.Position, mf.BackgroundColor3, mf.Visible = UDim2.new(0,620,0,380), UDim2.new(0.5,-310,0.5,-190), Color3.fromRGB(15,17,22), false
Instance.new("UICorner", mf).CornerRadius = UDim.new(0,8)
local ms = Instance.new("UIStroke", mf) ms.Color, ms.Thickness = Color3.fromRGB(35,40,55), 1

local th = Instance.new("Frame", mf)
th.Size, th.Position, th.BackgroundColor3 = UDim2.new(0,210,0,36), UDim2.new(0,12,0,10), Color3.fromRGB(22,25,33)
Instance.new("UICorner", th).CornerRadius = UDim.new(0,6)
local ths = Instance.new("UIStroke", th) ths.Color, ths.Thickness = Color3.fromRGB(45,120,220), 1

local ha = Instance.new("ImageLabel", th)
ha.Size, ha.Position, ha.BackgroundTransparency, ha.Image = UDim2.new(0,26,0,26), UDim2.new(0,5,0,5), true, "rbxassetid://8126145670"
Instance.new("UICorner", ha).CornerRadius = UDim.new(0,13)

local tl = Instance.new("TextLabel", th)
tl.Size, tl.Position, tl.BackgroundTransparency, tl.Text, tl.TextColor3, tl.TextSize, tl.Font, tl.TextXAlignment = UDim2.new(1,-38,1,0), UDim2.new(0,36,0,0), true, "Fluz Hub | Duels", Color3.fromRGB(235,240,250), 11, Enum.Font.GothamBold, Enum.TextXAlignment.Left

local tbar = Instance.new("Frame", mf)
tbar.Size, tbar.Position, tbar.BackgroundTransparency = UDim2.new(1,-230,0,36), UDim2.new(0,230,0,10), true

local vl = Instance.new("TextLabel", tbar)
vl.Size, vl.Position, vl.BackgroundTransparency, vl.Text, vl.TextColor3, vl.TextSize, vl.Font, vl.TextXAlignment = UDim2.new(0,200,1,0), UDim2.new(0,10,0,0), true, "[v1.5.2]", Color3.fromRGB(255,215,0), 11, Enum.Font.GothamBold, Enum.TextXAlignment.Left

local function ctc(txt, px, cb)
	local b = Instance.new("TextButton", tbar)
	b.Size, b.Position, b.BackgroundColor3, b.Text, b.TextColor3, b.TextSize, b.Font = UDim2.new(0,75,0,24), UDim2.new(1,px,0.5,-12), Color3.fromRGB(25,28,38), txt, Color3.fromRGB(180,190,210), 9, Enum.Font.GothamBold
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,4)
	b.MouseButton1Click:Connect(cb)
end
ctc("Minimizar", -245, function() mf.Visible = false end)
ctc("Maximizar", -160, function() mf.Visible = true end)
ctc("Destruir", -75, function() sg:Destroy() end)

local sb = Instance.new("ScrollingFrame", mf)
sb.Size, sb.Position, sb.BackgroundColor3, sb.CanvasSize, sb.ScrollBarThickness = UDim2.new(0,175,1,-60), UDim2.new(0,12,0,52), Color3.fromRGB(11,13,17), UDim2.new(0,0,0,380), 2
Instance.new("UICorner", sb).CornerRadius = UDim.new(0,6)
local ul = Instance.new("UIListLayout", sb) ul.SortOrder, ul.Padding = Enum.SortOrder.LayoutOrder, UDim.new(0,3)
local sbp = Instance.new("UIPadding", sb) sbp.PaddingTop, sbp.PaddingLeft, sbp.PaddingRight = UDim.new(0,6), UDim.new(0,6), UDim.new(0,6)

local function ach(txt)
	local l = Instance.new("TextLabel", sb)
	l.Size, l.BackgroundTransparency, l.Text, l.TextColor3, l.TextSize, l.Font, l.TextXAlignment = UDim2.new(1,0,0,22), true, txt, Color3.fromRGB(90,100,120), 9, Enum.Font.GothamBold, Enum.TextXAlignment.Left
end

local cnt = Instance.new("Frame", mf)
cnt.Size, cnt.Position, cnt.BackgroundColor3 = UDim2.new(1,-200,1,-60), UDim2.new(0,194,0,52), Color3.fromRGB(11,13,17)
Instance.new("UICorner", cnt).CornerRadius = UDim.new(0,6)

local pages = {}
local function cp(name)
	local p_ = Instance.new("ScrollingFrame", cnt)
	p_.Size, p_.BackgroundTransparency, p_.Visible, p_.CanvasSize, p_.ScrollBarThickness = UDim2.new(1,0,1,0), true, false, UDim2.new(0,0,0,550), 3
	local l_ = Instance.new("UIListLayout", p_) l_.SortOrder, l_.Padding = Enum.SortOrder.LayoutOrder, UDim.new(0,8)
	local pad_ = Instance.new("UIPadding", p_) pad_.PaddingTop, pad_.PaddingLeft, pad_.PaddingRight = UDim.new(0,12), UDim.new(0,12), UDim.new(0,12)
	pages[name] = p_
	return p_
end

local pHome, pAim, pVis, pMov, pGrp, pAni = cp("Inicio"), cp("Aimbot"), cp("Visuales"), cp("Movimiento"), cp("Gráficos"), cp("Animaciones")
pages["Inicio"].Visible = true

local function ctb(name, tp)
	local b = Instance.new("TextButton", sb)
	b.Size, b.BackgroundColor3, b.Text, b.TextColor3, b.TextSize, b.Font, b.TextXAlignment = UDim2.new(1,0,0,30), Color3.fromRGB(18,21,28), "  "..name, Color3.fromRGB(160,170,190), 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,5)
	b.MouseButton1Click:Connect(function()
		for _, v in pairs(pages) do v.Visible = false end
		tp.Visible = true
	end)
end

ach("Funciones Principales")
ctb("Inicio", pHome)
ctb("Aimbot", pAim)
ctb("Visuales", pVis)
ctb("Movimiento", pMov)
ctb("Gráficos", pGrp)
ach("Configs & Extra")
ctb("Animaciones", pAni)

tb.MouseButton1Click:Connect(function() mf.Visible = not mf.Visible end)

local function csc(par, title, h)
	local f = Instance.new("Frame", par)
	f.Size, f.BackgroundColor3 = UDim2.new(1,0,0,h), Color3.fromRGB(18,21,28)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)
	local pad = Instance.new("UIPadding", f) pad.PaddingTop, pad.PaddingLeft, pad.PaddingRight = UDim.new(0,10), UDim.new(0,12), UDim.new(0,12)
	local t = Instance.new("TextLabel", f)
	t.Size, t.BackgroundTransparency, t.Text, t.TextColor3, t.TextSize, t.Font, t.TextXAlignment = UDim2.new(1,0,0,18), true, title, Color3.fromRGB(140,150,170), 10, Enum.Font.GothamBold, Enum.TextXAlignment.Left
	return f
end

local hc1 = csc(pHome, "Perfil del Jugador", 95)
local pa = Instance.new("ImageLabel", hc1)
pa.Size, pa.Position, pa.BackgroundTransparency, pa.Image = UDim2.new(0,36,0,36), UDim2.new(0,0,0,24), true, "rbxassetid://8126145670"
Instance.new("UICorner", pa).CornerRadius = UDim.new(0,18)

local pi = Instance.new("TextLabel", hc1)
pi.Size, pi.Position, pi.BackgroundTransparency, pi.TextColor3, pi.TextSize, pi.Font, pi.TextXAlignment, pi.TextYAlignment = UDim2.new(1,-45,0,50), UDim2.new(0,45,0,22), true, Color3.fromRGB(220,230,240), 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, Enum.TextYAlignment.Top
pi.Text = "Usuario: @"..lp.Name.."\nID: "..lp.UserId.."\nEdad: "..lp.AccountAge.." días"

local hc2 = csc(pHome, "Sistema", 55)
local si = Instance.new("TextLabel", hc2)
si.Size, si.Position, si.BackgroundTransparency, si.TextColor3, si.TextSize, si.Font, si.TextXAlignment = UDim2.new(1,0,0,20), UDim2.new(0,0,0,22), true, Color3.fromRGB(200,210,220), 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
si.Text = "Ejecutor: Delta"

local hc3 = csc(pHome, "Información del Servidor", 75)
local srv = Instance.new("TextLabel", hc3)
srv.Size, srv.Position, srv.BackgroundTransparency, srv.TextColor3, srv.TextSize, srv.Font, srv.TextXAlignment, srv.TextYAlignment = UDim2.new(1,0,0,35), UDim2.new(0,0,0,22), true, Color3.fromRGB(200,210,220), 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, Enum.TextYAlignment.Top
srv.Text = "Juego Actual\n[⚔️DUELS] Place ID: "..game.PlaceId

local saOn, crOn = false, false
local bAim = Instance.new("TextButton", pAim)
bAim.Size, bAim.BackgroundColor3, bAim.Text, bAim.TextColor3, bAim.TextSize, bAim.Font, bAim.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Silent Aim: OFF", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bAim).CornerRadius = UDim.new(0,6)
bAim.MouseButton1Click:Connect(function()
	saOn = not saOn
	bAim.Text = saOn and "  Silent Aim: ON" or "  Silent Aim: OFF"
	bAim.TextColor3 = saOn and Color3.fromRGB(50,200,100) or Color3.fromRGB(180,190,210)
end)

local ch = Instance.new("Frame", sg)
ch.Size, ch.Position, ch.BackgroundColor3, ch.Visible = UDim2.new(0,6,0,6), UDim2.new(0.5,-3,0.5,-3), Color3.fromRGB(255,255,255), false
Instance.new("UICorner", ch).CornerRadius = UDim.new(1,0)

local bCr = Instance.new("TextButton", pAim)
bCr.Size, bCr.BackgroundColor3, bCr.Text, bCr.TextColor3, bCr.TextSize, bCr.Font, bCr.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Crosshair: OFF", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bCr).CornerRadius = UDim.new(0,6)
bCr.MouseButton1Click:Connect(function()
	crOn = not crOn
	ch.Visible = crOn
	bCr.Text = crOn and "  Crosshair: ON" or "  Crosshair: OFF"
	bCr.TextColor3 = crOn and Color3.fromRGB(50,200,100) or Color3.fromRGB(180,190,210)
end)

local function gcp()
	local tp, sd = nil, math.huge
	for _, v in pairs(p:GetPlayers()) do
		if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
			local pt = v.Character.HumanoidRootPart
			local sp, onS = cam:WorldToViewportPoint(pt.Position)
			if onS then
				local d = (Vector2.new(sp.X, sp.Y) - ui:GetMouseLocation()).Magnitude
				if d < sd then sd, tp = d, pt end
			end
		end
	end
	return tp
end

local mt = getrawmetatable(game)
local oi = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(s, k)
	if saOn and not checkcaller() and k == "Hit" then
		local tp = gcp()
		if tp then return tp.CFrame end
	end
	return oi(s, k)
end)
setreadonly(mt, true)

local espOn, esps = false, {}
local bEsp = Instance.new("TextButton", pVis)
bEsp.Size, bEsp.BackgroundColor3, bEsp.Text, bEsp.TextColor3, bEsp.TextSize, bEsp.Font, bEsp.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Esp: OFF", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bEsp).CornerRadius = UDim.new(0,6)
bEsp.MouseButton1Click:Connect(function()
	espOn = not espOn
	bEsp.Text = espOn and "  Esp: ON" or "  Esp: OFF"
	bEsp.TextColor3 = espOn and Color3.fromRGB(50,200,100) or Color3.fromRGB(180,190,210)
	if not espOn then for _, x in pairs(esps) do if x then x:Destroy() end end esps = {} end
end)

rs.RenderStepped:Connect(function()
	if espOn then
		local col = Color3.fromHSV(tick() % 5 / 5, 1, 1)
		for _, v in pairs(p:GetPlayers()) do
			if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				if not hrp:FindFirstChild("FluzESP") then
					local hl = Instance.new("Highlight", hrp) hl.Name, hl.FillTransparency = "FluzESP", 0.5
					table.insert(esps, hl)
				else
					hrp.FluzESP.FillColor, hrp.FluzESP.OutlineColor = col, col
				end
			end
		end
	end
end)

local function cs(par, name, min, max, cb)
	local f = Instance.new("Frame", par)
	f.Size, f.BackgroundColor3 = UDim2.new(1,0,0,50), Color3.fromRGB(18,21,28)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)
	local l = Instance.new("TextLabel", f)
	l.Size, l.Position, l.BackgroundTransparency, l.Text, l.TextColor3, l.TextSize, l.Font, l.TextXAlignment = UDim2.new(1,-12,0,20), UDim2.new(0,6,0,4), true, "  "..name..": "..min, Color3.fromRGB(180,190,210), 10, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
	local bar = Instance.new("TextButton", f)
	bar.Size, bar.Position, bar.BackgroundColor3, bar.Text = UDim2.new(1,-24,0,6), UDim2.new(0,12,0,32), Color3.fromRGB(30,35,45), ""
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
	local fill = Instance.new("Frame", bar)
	fill.Size, fill.BackgroundColor3 = UDim2.new(0,0,1,0), Color3.fromRGB(50,150,255)
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
	local dg = false
	bar.MouseButton1Down:Connect(function() dg = true end)
	ui.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dg = false end end)
	ui.InputChanged:Connect(function(i)
		if dg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local pos = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			local val = math.floor(min + (max - min) * pos)
			l.Text = "  "..name..": "..val
			cb(val)
		end
	end)
end

cs(pMov, "Velocidad", 16, 120, function(v) pcall(function() lp.Character.Humanoid.WalkSpeed = v end) end)
cs(pMov, "Altura de Salto", 50, 200, function(v) pcall(function() lp.Character.Humanoid.JumpPower = v end) end)

local fpsL = Instance.new("TextLabel", sg)
fpsL.Size, fpsL.Position, fpsL.BackgroundTransparency, fpsL.BackgroundColor3, fpsL.TextColor3, fpsL.TextSize, fpsL.Font, fpsL.Visible = UDim2.new(0,100,0,25), UDim2.new(0,15,0,15), 0.5, Color3.fromRGB(0,0,0), Color3.fromRGB(50,255,50), 12, Enum.Font.GothamBold, false
Instance.new("UICorner", fpsL).CornerRadius = UDim.new(0,4)
local lt, fc = tick(), 0
rs.RenderStepped:Connect(function()
	fc = fc + 1
	if tick() - lt >= 1 then fpsL.Text = "FPS: "..fc fc, lt = 0, tick() end
end)

local bFps = Instance.new("TextButton", pGrp)
bFps.Size, bFps.BackgroundColor3, bFps.Text, bFps.TextColor3, bFps.TextSize, bFps.Font, bFps.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Mostrar FPS: OFF", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bFps).CornerRadius = UDim.new(0,6)
bFps.MouseButton1Click:Connect(function()
	fpsL.Visible = not fpsL.Visible
	bFps.Text = fpsL.Visible and "  Mostrar FPS: ON" or "  Mostrar FPS: OFF"
	bFps.TextColor3 = fpsL.Visible and Color3.fromRGB(50,200,100) or Color3.fromRGB(180,190,210)
end)

local bSh = Instance.new("TextButton", pGrp)
bSh.Size, bSh.BackgroundColor3, bSh.Text, bSh.TextColor3, bSh.TextSize, bSh.Font, bSh.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Shader Bonito: OFF", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bSh).CornerRadius = UDim.new(0,6)
local sh = nil
bSh.MouseButton1Click:Connect(function()
	if not sh or not lit:FindFirstChild("FluzShader") then
		sh = Instance.new("ColorCorrectionEffect", lit) sh.Name, sh.Brightness, sh.Contrast, sh.Saturation = "FluzShader", 0.05, 0.2, 0.15
		bSh.Text, bSh.TextColor3 = "  Shader Bonito: ON", Color3.fromRGB(50,200,100)
	else
		sh:Destroy() sh = nil
		bSh.Text, bSh.TextColor3 = "  Shader Bonito: OFF", Color3.fromRGB(180,190,210)
	end
end)

local bAni = Instance.new("TextButton", pAni)
bAni.Size, bAni.BackgroundColor3, bAni.Text, bAni.TextColor3, bAni.TextSize, bAni.Font, bAni.TextXAlignment = UDim2.new(1,0,0,36), Color3.fromRGB(18,21,28), "  Aplicar Animación Zombie", Color3.fromRGB(180,190,210), 11, Enum.Font.GothamMedium, Enum.TextXAlignment.Left
Instance.new("UICorner", bAni).CornerRadius = UDim.new(0,6)
bAni.MouseButton1Click:Connect(function()
	pcall(function()
		local anim = lp.Character and lp.Character:FindFirstChild("Animate")
		if anim then
			local zd = {idle={"616158929"}, walk={"616168032"}, run={"616163682"}, jump={"616161997"}, fall={"616160354"}, swim={"616165520"}}
			for k, ids in pairs(zd) do
				local f = anim:FindFirstChild(k)
				if f then
					for _, c in pairs(f:GetChildren()) do if c:IsA("Animation") then c:Destroy() end end
					for _, id in ipairs(ids) do
						local a = Instance.new("Animation") a.AnimationId, a.Parent = "rbxassetid://"..id, f
					end
				end
			end
			anim.Enabled = false task.wait(0.05) anim.Enabled = true
		end
	end)
	bAni.TextColor3 = Color3.fromRGB(50,200,100)
end)

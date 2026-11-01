-- ==============================================================================
-- RCL SCRIPT v27.8 - ULTIMATE MOBILE EDITION (FULL SOURCE)
-- CRIADOR: Pelipe_404
-- ==============================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Proteção e Limpeza prévia de instâncias antigas
pcall(function()
    for _, v in ipairs({"RCL_FloatingButton", "RCL_Script_Hub", "RCL_IntroGui"}) do
        if CoreGui:FindFirstChild(v) then CoreGui[v]:Destroy() end
    end
end)

-- ==============================================================================
-- SEÇÃO 1: TELA DE INTRODUÇÃO (VOIDWARE STYLE)
-- ==============================================================================
local introGui = Instance.new("ScreenGui", CoreGui)
introGui.Name = "RCL_IntroGui"
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local introFrame = Instance.new("Frame", introGui)
introFrame.Size = UDim2.new(0, 320, 0, 180)
introFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
introFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
introFrame.BorderSizePixel = 0
Instance.new("UICorner", introFrame).CornerRadius = UDim.new(0, 12)

local introStroke = Instance.new("UIStroke", introFrame)
introStroke.Color = Color3.fromRGB(80, 80, 120)
introStroke.Thickness = 1.5

local introLogo = Instance.new("ImageLabel", introFrame)
introLogo.Size = UDim2.new(0, 50, 0, 50)
introLogo.Position = UDim2.new(0.5, -25, 0, 20)
introLogo.BackgroundTransparency = 1
introLogo.Image = "rbxassetid://82176801785735"

local introTitle = Instance.new("TextLabel", introFrame)
introTitle.Size = UDim2.new(1, 0, 0, 30)
introTitle.Position = UDim2.new(0, 0, 0, 75)
introTitle.Text = "RCL Script"
introTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
introTitle.TextSize = 18
introTitle.Font = Enum.Font.GothamBold
introTitle.BackgroundTransparency = 1

local barBg = Instance.new("Frame", introFrame)
barBg.Size = UDim2.new(0, 260, 0, 6)
barBg.Position = UDim2.new(0.5, -130, 0, 125)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local statusLbl = Instance.new("TextLabel", introFrame)
statusLbl.Size = UDim2.new(1, 0, 0, 20)
statusLbl.Position = UDim2.new(0, 0, 0, 142)
statusLbl.Text = "Iniciando sistemas..."
statusLbl.TextColor3 = Color3.fromRGB(150, 150, 180)
statusLbl.TextSize = 11
statusLbl.Font = Enum.Font.Gotham
statusLbl.BackgroundTransparency = 1

-- ==============================================================================
-- SEÇÃO 2: PAINEL PRINCIPAL DO HUB (ESTRUTURA COMPLETA)
-- ==============================================================================
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "RCL_Script_Hub"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = false

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 540, 0, 360)
main.Position = UDim2.new(0.5, -270, 0.4, -180)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local minimized = false

-- Confirmação de fecho
local confOv = Instance.new("Frame", main)
confOv.Size = UDim2.new(1, 0, 1, 0)
confOv.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
confOv.BackgroundTransparency = 0.5
confOv.Visible = false
confOv.ZIndex = 15

local confBox = Instance.new("Frame", confOv)
confBox.Size = UDim2.new(0, 280, 0, 130)
confBox.Position = UDim2.new(0.5, -140, 0.5, -65)
confBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
confBox.ZIndex = 16
Instance.new("UICorner", confBox).CornerRadius = UDim.new(0, 10)

local confTxt = Instance.new("TextLabel", confBox)
confTxt.Size = UDim2.new(1, 0, 0, 50)
confTxt.Position = UDim2.new(0, 0, 0, 15)
confTxt.Text = "Quer Fechar O Hub?"
confTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
confTxt.TextSize = 15
confTxt.Font = Enum.Font.GothamBold
confTxt.BackgroundTransparency = 1
confTxt.ZIndex = 16

local yesBtn = Instance.new("TextButton", confBox)
yesBtn.Size = UDim2.new(0, 110, 0, 32)
yesBtn.Position = UDim2.new(0, 20, 0, 75)
yesBtn.Text = "Sim"
yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
yesBtn.TextSize = 13
yesBtn.Font = Enum.Font.GothamBold
yesBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
yesBtn.ZIndex = 16
Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 6)

local noBtn = Instance.new("TextButton", confBox)
noBtn.Size = UDim2.new(0, 110, 0, 32)
noBtn.Position = UDim2.new(1, -130, 0, 75)
noBtn.Text = "Não"
noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noBtn.TextSize = 13
noBtn.Font = Enum.Font.GothamBold
noBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 70)
noBtn.ZIndex = 16
Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 12)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
closeBtn.ZIndex = 10
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -66, 0, 12)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 13
minBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
minBtn.ZIndex = 10
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() confOv.Visible = true end)
noBtn.MouseButton1Click:Connect(function() confOv.Visible = false end)
yesBtn.MouseButton1Click:Connect(function() screenGui:Destroy() if CoreGui:FindFirstChild("RCL_FloatingButton") then CoreGui.RCL_FloatingButton:Destroy() end end)

-- Barra Lateral & Logótipo
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local lImg = Instance.new("ImageLabel", sidebar)
lImg.Size = UDim2.new(0, 36, 0, 36)
lImg.Position = UDim2.new(0, 15, 0, 12)
lImg.BackgroundTransparency = 1
lImg.Image = "rbxassetid://82176801785735"

local lLbl = Instance.new("TextLabel", sidebar)
lLbl.Size = UDim2.new(1, -60, 0, 45)
lLbl.Position = UDim2.new(0, 58, 0, 12)
lLbl.Text = "RCL Script"
lLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lLbl.Font = Enum.Font.GothamBold
lLbl.TextSize = 18
lLbl.BackgroundTransparency = 1
lLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Contador de FPS
local fpsLbl = Instance.new("TextLabel", main)
fpsLbl.Size = UDim2.new(0, 120, 0, 20)
fpsLbl.Position = UDim2.new(0, 185, 0, 15)
fpsLbl.Text = "FPS: 60"
fpsLbl.TextColor3 = Color3.fromRGB(46, 204, 113)
fpsLbl.Font = Enum.Font.GothamBold
fpsLbl.TextSize = 13
fpsLbl.BackgroundTransparency = 1

local fc, currentFPS = 0, 60
RunService.RenderStepped:Connect(function() fc = fc + 1 end)
task.spawn(function()
    while task.wait(1) do
        if fpsLbl and fpsLbl.Parent then
            currentFPS = fc
            fpsLbl.Text = "FPS: " .. tostring(currentFPS)
            if minimized then
                lLbl.Text = "RCL Script [v27.8]  |  FPS: " .. tostring(currentFPS)
            end
            fc = 0
        end
    end
end)

-- Sistema de Minimizar Perfeito
local tabButtons, tabsList = {}, {}
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        main.Size = UDim2.new(0, 540, 0, 50)
        fpsLbl.Visible = false
        confOv.Visible = false
        closeBtn.Visible = false
        minBtn.Position = UDim2.new(1, -36, 0.5, -13)
        sidebar.Size = UDim2.new(1, 0, 1, 0)
        lImg.Position = UDim2.new(0, 12, 0, 11)
        lImg.Size = UDim2.new(0, 28, 0, 28)
        lLbl.Size = UDim2.new(1, -120, 1, 0)
        lLbl.Position = UDim2.new(0, 45, 0, 0)
        lLbl.Text = "RCL Script [v27.8]  |  FPS: " .. tostring(currentFPS)
        for _, btn in ipairs(tabButtons) do btn.Visible = false end
        for _, t in ipairs(tabsList) do t.Visible = false end
    else
        minBtn.Text = "-"
        main.Size = UDim2.new(0, 540, 0, 360)
        sidebar.Size = UDim2.new(0, 170, 1, 0)
        fpsLbl.Visible = true
        lImg.Position = UDim2.new(0, 15, 0, 12)
        lImg.Size = UDim2.new(0, 36, 0, 36)
        lLbl.Size = UDim2.new(1, -60, 0, 45)
        lLbl.Position = UDim2.new(0, 58, 0, 12)
        lLbl.Text = "RCL Script"
        closeBtn.Visible = true
        minBtn.Position = UDim2.new(1, -66, 0, 12)
        for _, btn in ipairs(tabButtons) do btn.Visible = true end
        tabsList[1].Visible = true
    end
end)

-- Construtor de Abas
local function createTab()
    local c = Instance.new("ScrollingFrame", main)
    c.Size = UDim2.new(1, -185, 1, -65)
    c.Position = UDim2.new(0, 180, 0, 55)
    c.BackgroundTransparency = 1
    c.CanvasSize = UDim2.new(0, 0, 0, 350)
    c.ScrollBarThickness = 4
    c.Visible = false
    local l = Instance.new("UIListLayout", c)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, 8)
    table.insert(tabsList, c)
    return c
end

local t1 = createTab() -- Início
local t2 = createTab() -- Player
local t3 = createTab() -- Teleporte
local t4 = createTab() -- Scripts
t1.Visible = true

local function createTabBtn(txt, y, targetTab)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1, -20, 0, 30)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(170, 170, 200)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    table.insert(tabButtons, b)

    b.MouseButton1Click:Connect(function()
        if minimized then return end
        t1.Visible = (targetTab == t1)
        t2.Visible = (targetTab == t2)
        t3.Visible = (targetTab == t3)
        t4.Visible = (targetTab == t4)
        for _, btn in ipairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
            btn.TextColor3 = Color3.fromRGB(170, 170, 200)
            btn.Font = Enum.Font.GothamMedium
        end
        b.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
    end)
    return b
end

local b1 = createTabBtn("   🏠 Início", 82, t1)
b1.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.Font = Enum.Font.GothamBold
createTabBtn("   👤 Player", 116, t2)
createTabBtn("   🌐 Teleporte", 150, t3)
createTabBtn("   📜 Scripts", 184, t4)

local function addRow(parent, text, widget)
    local r = Instance.new("Frame", parent)
    r.Size = UDim2.new(1, -10, 0, 42)
    r.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", r)
    l.Size = UDim2.new(1, -120, 1, 0)
    l.Position = UDim2.new(0, 15, 0, 0)
    l.Text = text
    l.TextColor3 = Color3.fromRGB(230, 230, 255)
    l.Font = Enum.Font.GothamMedium
    l.TextSize = 13
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    if widget then
        widget.Position = UDim2.new(1, -115, 0.5, -15)
        widget.Parent = r
    end
end

-- ==============================================================================
-- SEÇÃO 3: CONTEÚDO DAS ABAS (EXPLOITS E OPÇÕES)
-- ==============================================================================

-- Aba 1: Início
local function addInfo(parent, title, val)
    local r = Instance.new("Frame", parent)
    r.Size = UDim2.new(1, -10, 0, 42)
    r.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 8)
    local l1 = Instance.new("TextLabel", r)
    l1.Size = UDim2.new(0, 120, 1, 0)
    l1.Position = UDim2.new(0, 15, 0, 0)
    l1.Text = title
    l1.TextColor3 = Color3.fromRGB(180, 180, 210)
    l1.Font = Enum.Font.GothamMedium
    l1.TextSize = 13
    l1.BackgroundTransparency = 1
    l1.TextXAlignment = Enum.TextXAlignment.Left
    local l2 = Instance.new("TextLabel", r)
    l2.Size = UDim2.new(1, -140, 1, 0)
    l2.Position = UDim2.new(0, 130, 0, 0)
    l2.Text = val
    l2.TextColor3 = Color3.fromRGB(255, 255, 255)
    l2.Font = Enum.Font.GothamBold
    l2.TextSize = 13
    l2.BackgroundTransparency = 1
    l2.TextXAlignment = Enum.TextXAlignment.Right
end

addInfo(t1, "Nome do Hub", "RCL Script")
addInfo(t1, "Versão Atual", "v27.8")
addInfo(t1, "Criador / Dono", "Pelipe_404")
addInfo(t1, "Estado", "Ativo & Protegido")

-- Aba 2: Player (Noclip, Fly, Anti-Fling)
local noclipEnabled, flyEnabled, antiFlingEnabled = false, false, false
local flySpeed = 50
local bv, bg

local function makeToggle(txt, parent, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 100, 0, 30)
    b.Text = "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    addRow(parent, txt, b)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

makeToggle("Atravessar Paredes (Noclip)", t2, function(b)
    noclipEnabled = not noclipEnabled
    b.Text = noclipEnabled and "ON" or "OFF"
    b.BackgroundColor3 = noclipEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
end)
RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, v in ipairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
        end
    end
end)

makeToggle("Modo Voo (Fly)", t2, function(b)
    flyEnabled = not flyEnabled
    b.Text = flyEnabled and "ON" or "OFF"
    b.BackgroundColor3 = flyEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
    local c = player.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hrp, hum = c.HumanoidRootPart, c:FindFirstChild("Humanoid")
    if flyEnabled then
        bv = Instance.new("BodyVelocity", hrp) bv.Velocity, bv.MaxForce = Vector3.new(), Vector3.new(math.huge, math.huge, math.huge)
        bg = Instance.new("BodyGyro", hrp) bg.MaxTorque, bg.CFrame = Vector3.new(math.huge, math.huge, math.huge), hrp.CFrame
        if hum then hum.PlatformStand = true end
        task.spawn(function()
            while flyEnabled and c and hrp and hrp.Parent do
                local cam = workspace.CurrentCamera
                local md = hum.MoveDirection
                if bv and bg then
                    bv.Velocity = (cam.CFrame.LookVector * (md.Z * -flySpeed)) + (cam.CFrame.RightVector * (md.X * flySpeed)) + Vector3.new(0, md.Y * flySpeed, 0)
                    bg.CFrame = cam.CFrame
                end
                task.wait()
            end
        end)
    else
        if bv then bv:Destroy() end if bg then bg:Destroy() end if hum then hum.PlatformStand = false end
    end
end)

makeToggle("Anti-Fling", t2, function(b)
    antiFlingEnabled = not antiFlingEnabled
    b.Text = antiFlingEnabled and "ON" or "OFF"
    b.BackgroundColor3 = antiFlingEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
end)
RunService.Stepped:Connect(function()
    if antiFlingEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local r = player.Character.HumanoidRootPart
        if r.Velocity.Magnitude > 250 or r.RotVelocity.Magnitude > 250 then
            r.Velocity, r.RotVelocity = Vector3.new(), Vector3.new()
        end
    end
end)

-- Aba 3: Teleporte
local spBtn = Instance.new("TextButton")
spBtn.Size = UDim2.new(0, 100, 0, 30)
spBtn.Text = "TELEPORTAR"
spBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spBtn.Font = Enum.Font.GothamBold
spBtn.TextSize = 10
spBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
Instance.new("UICorner", spBtn).CornerRadius = UDim.new(0, 6)
addRow(t3, "Ir para o Ponto de Spawn", spBtn)
spBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("SpawnLocation") then player.Character.HumanoidRootPart.CFrame = o.CFrame + Vector3.new(0, 3, 0) break end
        end
    end
end)

local rjBtn = Instance.new("TextButton")
rjBtn.Size = UDim2.new(0, 100, 0, 30)
rjBtn.Text = "REENTRAR"
rjBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rjBtn.Font = Enum.Font.GothamBold
rjBtn.TextSize = 10
rjBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
Instance.new("UICorner", rjBtn).CornerRadius = UDim.new(0, 6)
addRow(t3, "Reentrar no Servidor Atual", rjBtn)
rjBtn.MouseButton1Click:Connect(function()
    if #Players:GetPlayers() <= 1 then player:Kick("Reconectando...") task.wait(1) TeleportService:Teleport(game.PlaceId, player) else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player) end
end)

-- Aba 4: Scripts Externos
local function addScript(name, url)
    local r = Instance.new("Frame", t4)
    r.Size = UDim2.new(1, -10, 0, 45)
    r.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 8)
    local l = Instance.new("TextLabel", r)
    l.Size = UDim2.new(1, -130, 1, 0)
    l.Position = UDim2.new(0, 15, 0, 0)
    l.Text = name
    l.TextColor3 = Color3.fromRGB(230, 230, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    local eb = Instance.new("TextButton", r)
    eb.Size = UDim2.new(0, 100, 0, 30)
    eb.Position = UDim2.new(1, -110, 0.5, -15)
    eb.Text = "EXECUTAR"
    eb.TextColor3 = Color3.fromRGB(255, 255, 255)
    eb.Font = Enum.Font.GothamBold
    eb.TextSize = 11
    eb.BackgroundColor3 = Color3.fromRGB(50, 120, 70)
    Instance.new("UICorner", eb).CornerRadius = UDim.new(0, 6)
    eb.MouseButton1Click:Connect(function() task.spawn(function() pcall(function() loadstring(game:HttpGet(url))() end) end) end)
end

addScript("Robin Hub", "https://raw.githubusercontent.com/PhillipeScripts/RCL/main/RobinHub.lua")
addScript("Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
addScript("TP Tool", "https://raw.githubusercontent.com/jLn0nD/TP-Tool/main/tptool.lua")

-- ==============================================================================
-- SEÇÃO 4: FINALIZAÇÃO DA INTRO E BOTÃO FLUTUANTE TÁTIL
-- ==============================================================================
task.spawn(function()
    task.wait(0.1)
    local tween = TweenService:Create(barFill, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
    tween:Play()
    tween.Completed:Wait()
    statusLbl.Text = "Pronto!"
    task.wait(0.3)
    introGui:Destroy()

    local floatGui = Instance.new("ScreenGui", CoreGui)
    floatGui.Name = "RCL_FloatingButton"
    floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local floatBtn = Instance.new("ImageButton", floatGui)
    float

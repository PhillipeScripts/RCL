-- RCL Script - Versão com Botão de Fechar e Confirmação Restaurados
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Limpa qualquer versão anterior para evitar conflito
pcall(function()
    if CoreGui:FindFirstChild("RCL_Script_Hub") then CoreGui.RCL_Script_Hub:Destroy() end
    if CoreGui:FindFirstChild("RCL_FloatingButton") then CoreGui.RCL_FloatingButton:Destroy() end
    if CoreGui:FindFirstChild("RCL_IntroGui") then CoreGui.RCL_IntroGui:Destroy() end
end)

local noclipEnabled = false
local flyEnabled = false
local speedEnabled = false

local flySpeed = 50
local playerSpeed = 16
local bv, bg

-- ==========================================
-- TELA DE INICIALIZAÇÃO (INTRO)
-- ==========================================
local introGui = Instance.new("ScreenGui")
introGui.Name = "RCL_IntroGui"
introGui.Parent = CoreGui
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(0, 320, 0, 180)
introFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
introFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
introFrame.BorderSizePixel = 0
introFrame.Parent = introGui

Instance.new("UICorner", introFrame).CornerRadius = UDim.new(0, 12)
local introStroke = Instance.new("UIStroke")
introStroke.Color = Color3.fromRGB(80, 80, 120)
introStroke.Thickness = 1.5
introStroke.Parent = introFrame

local introLogo = Instance.new("ImageLabel")
introLogo.Size = UDim2.new(0, 50, 0, 50)
introLogo.Position = UDim2.new(0.5, -25, 0, 20)
introLogo.BackgroundTransparency = 1
introLogo.Image = "rbxassetid://82176801785735"
introLogo.Parent = introFrame

local introTitle = Instance.new("TextLabel")
introTitle.Size = UDim2.new(1, 0, 0, 30)
introTitle.Position = UDim2.new(0, 0, 0, 75)
introTitle.Text = "RCL Script"
introTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
introTitle.TextSize = 18
introTitle.Font = Enum.Font.GothamBold
introTitle.BackgroundTransparency = 1
introTitle.Parent = introFrame

local barBackground = Instance.new("Frame")
barBackground.Size = UDim2.new(0, 260, 0, 6)
barBackground.Position = UDim2.new(0.5, -130, 0, 125)
barBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
barBackground.BorderSizePixel = 0
barBackground.Parent = introFrame
Instance.new("UICorner", barBackground).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBackground
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Position = UDim2.new(0, 0, 0, 142)
statusText.Text = "Iniciando sistemas..."
statusText.TextColor3 = Color3.fromRGB(150, 150, 180)
statusText.TextSize = 11
statusText.Font = Enum.Font.Gotham
statusText.BackgroundTransparency = 1
statusText.Parent = introFrame

-- ==========================================
-- BOTÃO FLUTUANTE
-- ==========================================
local floatGui = Instance.new("ScreenGui")
floatGui.Name = "RCL_FloatingButton"
floatGui.Parent = CoreGui
floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
floatGui.Enabled = false

local floatBtn = Instance.new("ImageButton")
floatBtn.Size = UDim2.new(0, 50, 0, 50)
floatBtn.Position = UDim2.new(0, 50, 0.4, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
floatBtn.Image = "rbxassetid://82176801785735"
floatBtn.Active = true
floatBtn.Parent = floatGui

Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1, 0)
local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(80, 80, 120)
floatStroke.Thickness = 2
floatStroke.Parent = floatBtn

local dragging = false
local dragInput, dragStart, startPos

floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = floatBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

floatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        floatBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- INTERFACE PRINCIPAL DO HUB
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RCL_Script_Hub"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 540, 0, 360)
mainFrame.Position = UDim2.new(0.5, -270, 0.4, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 90)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

floatBtn.MouseButton1Click:Connect(function()
    if not dragging then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- ==========================================
-- SISTEMA DE CONFIRMAÇÃO DE FECHO
-- ==========================================
local confirmOverlay = Instance.new("Frame")
confirmOverlay.Size = UDim2.new(1, 0, 1, 0)
confirmOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
confirmOverlay.BackgroundTransparency = 0.5
confirmOverlay.Visible = false
confirmOverlay.ZIndex = 15 -- Fica por cima de tudo no hub
confirmOverlay.Parent = mainFrame

local confirmBox = Instance.new("Frame")
confirmBox.Size = UDim2.new(0, 280, 0, 130)
confirmBox.Position = UDim2.new(0.5, -140, 0.5, -65)
confirmBox.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
confirmBox.BorderSizePixel = 0
confirmBox.ZIndex = 16
confirmBox.Parent = confirmOverlay
Instance.new("UICorner", confirmBox).CornerRadius = UDim.new(0, 10)

local confirmText = Instance.new("TextLabel")
confirmText.Size = UDim2.new(1, 0, 0, 50)
confirmText.Position = UDim2.new(0, 0, 0, 15)
confirmText.Text = "Quer Fechar O Hub?"
confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmText.TextSize = 15
confirmText.Font = Enum.Font.GothamBold
confirmText.BackgroundTransparency = 1
confirmText.ZIndex = 16
confirmText.Parent = confirmBox

local yesBtn = Instance.new("TextButton")
yesBtn.Size = UDim2.new(0, 110, 0, 32)
yesBtn.Position = UDim2.new(0, 20, 0, 75)
yesBtn.Text = "Sim"
yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
yesBtn.TextSize = 13
yesBtn.Font = Enum.Font.GothamBold
yesBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
yesBtn.ZIndex = 16
yesBtn.Parent = confirmBox
Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 6)

local noBtn = Instance.new("TextButton")
noBtn.Size = UDim2.new(0, 110, 0, 32)
noBtn.Position = UDim2.new(1, -130, 0, 75)
noBtn.Text = "Não"
noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noBtn.TextSize = 13
noBtn.Font = Enum.Font.GothamBold
noBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 70)
noBtn.ZIndex = 16
noBtn.Parent = confirmBox
Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 6)

-- Botão de Fechar Principal (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -34, 0, 12)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 13
closeButton.Font = Enum.Font.GothamBold
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
closeButton.ZIndex = 10
closeButton.Parent = mainFrame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- Ações dos botões de fecho
closeButton.MouseButton1Click:Connect(function()
    confirmOverlay.Visible = true
end)

noBtn.MouseButton1Click:Connect(function()
    confirmOverlay.Visible = false
end)

yesBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    floatGui:Destroy()
end)

-- Barra Lateral
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(0, 36, 0, 36)
logoImage.Position = UDim2.new(0, 15, 0, 12)
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://82176801785735"
logoImage.Parent = sidebar

local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, -60, 0, 45)
logoLabel.Position = UDim2.new(0, 58, 0, 12)
logoLabel.Text = "RCL Script"
logoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
logoLabel.TextSize = 18
logoLabel.Font = Enum.Font.GothamBold
logoLabel.BackgroundTransparency = 1
logoLabel.Parent = sidebar

local subLogo = Instance.new("TextLabel")
subLogo.Size = UDim2.new(1, -15, 0, 20)
subLogo.Position = UDim2.new(0, 15, 0, 54)
subLogo.Text = "Painel Oficial"
subLogo.TextColor3 = Color3.fromRGB(130, 130, 160)
subLogo.TextSize = 10
subLogo.Font = Enum.Font.Gotham
subLogo.BackgroundTransparency = 1
subLogo.Parent = sidebar

-- Contedores de Abas
local function createTabContainer()
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -185, 1, -65)
    container.Position = UDim2.new(0, 180, 0, 55)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.CanvasSize = UDim2.new(0, 0, 0, 400)
    container.ScrollBarThickness = 4
    container.Visible = false
    container.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = container
    return container
end

local tabContainer1 = createTabContainer()
tabContainer1.Visible = true
local tabContainer2 = createTabContainer()
local tabContainer3 = createTabContainer()

local tabContainer4 = Instance.new("Frame")
tabContainer4.Size = UDim2.new(1, -185, 1, -65)
tabContainer4.Position = UDim2.new(0, 180, 0, 55)
tabContainer4.BackgroundTransparency = 1
tabContainer4.BorderSizePixel = 0
tabContainer4.Visible = false
tabContainer4.Parent = mainFrame

local function createTabButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(170, 170, 200)
    btn.TextSize, btn.Font = 12, Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

local tab1Btn = createTabButton("   🏠 Início", 82)
local tab2Btn = createTabButton("   👤 Player", 116)
local tab3Btn = createTabButton("   🌐 Teleporte", 150)
local tab4Btn = createTabButton("   📜 Scripts", 184)

tab1Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
tab1Btn.Font = Enum.Font.GothamBold

local function selectTab(activeContainer, activeBtn)
    tabContainer1.Visible = (activeContainer == tabContainer1)
    tabContainer2.Visible = (activeContainer == tabContainer2)
    tabContainer3.Visible = (activeContainer == tabContainer3)
    tabContainer4.Visible = (activeContainer == tabContainer4)

    for _, btn in ipairs({tab1Btn, tab2Btn, tab3Btn, tab4Btn}) do
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
        btn.TextColor3 = Color3.fromRGB(170, 170, 200)
        btn.Font = Enum.Font.GothamMedium
    end
    activeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activeBtn.Font = Enum.Font.GothamBold
end

tab1Btn.MouseButton1Click:Connect(function() selectTab(tabContainer1, tab1Btn) end)
tab2Btn.MouseButton1Click:Connect(function() selectTab(tabContainer2, tab2Btn) end)
tab3Btn.MouseButton1Click:Connect(function() selectTab(tabContainer3, tab3Btn) end)
tab4Btn.MouseButton1Click:Connect(function() selectTab(tabContainer4, tab4Btn) end)

local function createOptionRow(parentContainer, text, customWidget)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 42)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    row.BorderSizePixel = 0
    row.Parent = parentContainer
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = row

    if customWidget then
        customWidget.Position = UDim2.new(1, -115, 0.5, -15)
        customWidget.Parent = row
    end
    return row
end

-- ==========================================
-- ITENS DA ABA 1 (INÍCIO)
-- ==========================================
local function createInfoCard(parent, title, value)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 42)
    card.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    card.BorderSizePixel = 0
    card.Parent = parent
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local lblTitle = Instance.new("TextLabel")
    lblTitle.Size = UDim2.new(0, 120, 1, 0)
    lblTitle.Position = UDim2.new(0, 15, 0, 0)
    lblTitle.Text = title
    lblTitle.TextColor3 = Color3.fromRGB(180, 180, 210)
    lblTitle.TextSize = 13
    lblTitle.Font = Enum.Font.GothamMedium
    lblTitle.TextXAlignment = Enum.TextXAlignment.Left
    lblTitle.BackgroundTransparency = 1
    lblTitle.Parent = card

    local lblValue = Instance.new("TextLabel")
    lblValue.Size = UDim2.new(1, -140, 1, 0)
    lblValue.Position = UDim2.new(0, 130, 0, 0)
    lblValue.Text = value
    lblValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    lblValue.TextSize = 13
    lblValue.Font = Enum.Font.GothamBold
    lblValue.TextXAlignment = Enum.TextXAlignment.Right
    lblValue.BackgroundTransparency = 1
    lblValue.Parent = card
end

createInfoCard(tabContainer1, "Nome do Hub", "RCL Script")
createInfoCard(tabContainer1, "Versão Atual", "v26.6")
createInfoCard(tabContainer1, "Criador / Dono", "Pelipe_404")
createInfoCard(tabContainer1, "Estado", "Ativo & Protegido")

-- ==========================================
-- ITENS DA ABA 2 (PLAYER)
-- ==========================================
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 100, 0, 30)
noclipToggle.Text = "OFF"
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.TextSize = 12
noclipToggle.Font = Enum.Font.GothamBold
noclipToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", noclipToggle).CornerRadius = UDim.new(0, 6)
createOptionRow(tabContainer2, "Atravessar Paredes (Noclip)", noclipToggle)

noclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipToggle.Text = noclipEnabled and "ON" or "OFF"
    noclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0, 100, 0, 30)
speedToggle.Text = "OFF"
speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedToggle.TextSize = 12
speedToggle.Font = Enum.Font.GothamBold
speedToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", speedToggle).CornerRadius = UDim.new(0, 6)
createOptionRow(tabContainer2, "Velocidade Customizada", speedToggle)

speedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedToggle.Text = speedEnabled and "ON" or "OFF"
    speedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = playerSpeed
    end
end)

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0, 100, 0, 30)
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.TextSize = 12
flyToggle.Font = Enum.Font.GothamBold
flyToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0, 6)
createOptionRow(tabContainer2, "Modo Voo (Fly)", flyToggle)

flyToggle.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyToggle.Text = flyEnabled and "ON" or "OFF"
    flyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)

    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character:FindFirstChild("Humanoid")

    if flyEnabled then
        bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = humanoidRootPart
        
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = humanoidRootPart.CFrame
        bg.Parent = humanoidRootPart
        
        if humanoid then humanoid.PlatformStand = true end
        
        task.spawn(function()
            while flyEnabled and character and humanoidRootPart and humanoidRootPart.Parent do
                local cam = workspace.CurrentCamera
                local moveDir = humanoid.MoveDirection
                if bv and bg then
                    bv.Velocity = (cam.CFrame.LookVector * (moveDir.Z * -flySpeed)) + 
                                  (cam.CFrame.RightVector * (moveDir.X * flySpeed)) + 
                                  Vector3.new(0, moveDir.Y * flySpeed, 0)
                    bg.CFrame = cam.CFrame
                end
                task.wait()
            end
        end)
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
    end
end)

-- ==========================================
-- ITENS DA ABA 3 (TELEPORTE)
-- ==========================================
local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0, 100, 0, 30)
spawnBtn.Text = "TELEPORTAR"
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.TextSize = 10
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)
createOptionRow(tabContainer3, "Ir para o Ponto de Spawn", spawnBtn)

spawnBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("SpawnLocation") then
                char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0, 100, 0, 30)
rejoinBtn.Text = "REENTRAR"
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.TextSize = 10
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 6)
createOptionRow(tabContainer3, "Reentrar no Servidor Atual", rejoinBtn)

rejoinBtn.MouseButton1Click:Connect(function()
    if #Players:GetPlayers() <= 1 then
        player:Kick("Reconectando...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, player)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
end)

-- ==========================================
-- ITENS DA ABA 4 (SCRIPTS)
-- ==========================================
local function addDirectScriptRow(posY, scriptName, loadstringUrl)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 45)
    row.Position = UDim2.new(0, 0, 0, posY)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    row.BorderSizePixel = 0
    row.Parent = tabContainer4
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -130, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Text = scriptName
    label.TextColor3 = Color3.fromRGB(230, 230, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = row

    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0, 100, 0, 30)
    execBtn.Position = UDim2.new(1, -110, 0.5, -15)
    execBtn.Text = "EXECUTAR"
    execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    execBtn.TextSize = 11
    execBtn.Font = Enum.Font.GothamBold
    execBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 70)
    execBtn.Parent = row
    Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 6)

    execBtn.MouseButton1Click:Connect(function()
        task.spawn(function()
            pcall(function()
                loadstring(game:HttpGet(loadstringUrl))()
            end)
        end)
    end)
end

addDirectScriptRow(0,   "Robin Hub",      "https://raw.githubusercontent.com/PhillipeScripts/RCL/main/RobinHub.lua")
addDirectScriptRow(53,  "Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
addDirectScriptRow(106, "TP Tool",        "https://raw.githubusercontent.com/jLn0nD/TP-Tool/main/tptool.lua")

-- Animação da Intro
task.spawn(function()
    barFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Exponential, 1.5, true)
    task.wait(1.8)
    introGui:Destroy()
    floatGui.Enabled = true
end)

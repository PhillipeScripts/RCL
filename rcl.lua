-- RCL Script Hub (Com Botão Flutuante Arrastável e Logo)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local noclipEnabled = false
local flyEnabled = false
local speedEnabled = false
local godModeEnabled = false

local flySpeed = 50
local playerSpeed = 16
local bv, bg

local protegido = gethui or function(v) return v end

if CoreGui:FindFirstChild("RCL_Script_Hub") then
    CoreGui:FindFirstChild("RCL_Script_Hub"):Destroy()
end
if CoreGui:FindFirstChild("RCL_FloatingButton") then
    CoreGui:FindFirstChild("RCL_FloatingButton"):Destroy()
end

-- ==========================================
-- BOTÃO FLUTUANTE ARRASTÁVEL (ABRE/FECHA)
-- ==========================================
local floatGui = Instance.new("ScreenGui")
floatGui.Name = "RCL_FloatingButton"
floatGui.Parent = protegido(CoreGui)
floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local floatBtn = Instance.new("ImageButton")
floatBtn.Size = UDim2.new(0, 50, 0, 50)
floatBtn.Position = UDim2.new(0, 50, 0.4, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
floatBtn.Image = "rbxassetid://82176801785735"
floatBtn.Active = true
floatBtn.Draggable = true -- Permite arrastar o botão livremente pelo ecrã
floatBtn.Parent = floatGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0) -- Deixa o botão totalmente redondo
floatCorner.Parent = floatBtn

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(80, 80, 120)
floatStroke.Thickness = 2
floatStroke.Parent = floatBtn

-- ==========================================
-- INTERFACE PRINCIPAL DO HUB
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RCL_Script_Hub"
screenGui.Parent = protegido(CoreGui)
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = false -- Começa fechado

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 540, 0, 360)
mainFrame.Position = UDim2.new(0.5, -270, 0.4, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 90)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- Evento para abrir/fechar ao clicar no botão flutuante (respeitando o arrastar)
local dragging = false
floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
floatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)
floatBtn.MouseButton1Click:Connect(function()
    if not dragging then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- Barra Lateral (Menu Esquerdo)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 170, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebar

-- Logo do ID fornecido (82176801785735)
local logoImage = Instance.new("ImageLabel")
logoImage.Size = UDim2.new(0, 36, 0, 36)
logoImage.Position = UDim2.new(0, 15, 0, 12)
logoImage.BackgroundTransparency = 1
logoImage.Image = "rbxassetid://82176801785735"
logoImage.Parent = sidebar

-- Nome do Hub: RCL Script
local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, -60, 0, 45)
logoLabel.Position = UDim2.new(0, 58, 0, 12)
logoLabel.Text = "RCL Script"
logoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
logoLabel.TextSize = 18
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextXAlignment = Enum.TextXAlignment.Left
logoLabel.BackgroundTransparency = 1
logoLabel.Parent = sidebar

local subLogo = Instance.new("TextLabel")
subLogo.Size = UDim2.new(1, -15, 0, 20)
subLogo.Position = UDim2.new(0, 15, 0, 54)
subLogo.Text = "Painel Oficial"
subLogo.TextColor3 = Color3.fromRGB(130, 130, 160)
subLogo.TextSize = 10
subLogo.Font = Enum.Font.Gotham
subLogo.TextXAlignment = Enum.TextXAlignment.Left
subLogo.BackgroundTransparency = 1
subLogo.Parent = sidebar

-- Botão de Fechar Hub (X) - Apenas esconde o menu e mantém o botão flutuante ativo
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -34, 0, 12)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 13
closeButton.Font = Enum.Font.GothamBold
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Painel de Conteúdo (Direita)
local contentArea = Instance.new("ScrollingFrame")
contentArea.Size = UDim2.new(1, -185, 1, -65)
contentArea.Position = UDim2.new(0, 180, 0, 55)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.CanvasSize = UDim2.new(0, 0, 0, 380)
contentArea.ScrollBarThickness = 4
contentArea.Parent = mainFrame

local uiLayout = Instance.new("UIListLayout")
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 8)
uiLayout.Parent = contentArea

-- Função para criar as linhas de opções
local function createOptionRow(text, customWidget)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 42)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    row.BorderSizePixel = 0
    row.Parent = contentArea

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 8)
    rowCorner.Parent = row

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

-- 1. Noclip (Toggle ON/OFF)
local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 100, 0, 30)
noclipToggle.Text = "OFF"
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.TextSize = 12
noclipToggle.Font = Enum.Font.GothamBold
noclipToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", noclipToggle).CornerRadius = UDim.new(0, 6)
createOptionRow("Atravessar Paredes (Noclip)", noclipToggle)

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

-- 2. Fly (Toggle ON/OFF)
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0, 100, 0, 30)
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.TextSize = 12
flyToggle.Font = Enum.Font.GothamBold
flyToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0, 6)
createOptionRow("Modo Voo (Fly)", flyToggle)

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

-- 3. Velocidade do Voo (Caixa 0-50)
local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Size = UDim2.new(0, 100, 0, 30)
flySpeedBox.Text = "50"
flySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedBox.TextSize = 12
flySpeedBox.Font = Enum.Font.GothamBold
flySpeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
flySpeedBox.ClearTextOnFocus = false
Instance.new("UICorner", flySpeedBox).CornerRadius = UDim.new(0, 6)
createOptionRow("Velocidade do Voo (0-50)", flySpeedBox)

flySpeedBox.FocusLost:Connect(function()
    local num = tonumber(flySpeedBox.Text)
    if num then
        flySpeed = math.clamp(num, 0, 50)
        flySpeedBox.Text = tostring(flySpeed)
    else
        flySpeedBox.Text = tostring(flySpeed)
    end
end)

-- 4. Velocidade do Player (Toggle ON/OFF)
local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0, 100, 0, 30)
speedToggle.Text = "OFF"
speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedToggle.TextSize = 12
speedToggle.Font = Enum.Font.GothamBold
speedToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", speedToggle).CornerRadius = UDim.new(0, 6)
createOptionRow("Velocidade do Player (WalkSpeed)", speedToggle)

speedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedToggle.Text = speedEnabled and "ON" or "OFF"
    speedToggle.BackgroundColor3 = speedEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
end)

-- 5. Caixa de Ajuste de Velocidade do Player
local playerSpeedBox = Instance.new("TextBox")
playerSpeedBox.Size = UDim2.new(0, 100, 0, 30)
playerSpeedBox.Text = "16"
playerSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
playerSpeedBox.TextSize = 12
playerSpeedBox.Font = Enum.Font.GothamBold
playerSpeedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
playerSpeedBox.ClearTextOnFocus = false
Instance.new("UICorner", playerSpeedBox).CornerRadius = UDim.new(0, 6)
createOptionRow("Ajustar Velocidade do Player", playerSpeedBox)

playerSpeedBox.FocusLost:Connect(function()
    local num = tonumber(playerSpeedBox.Text)
    if num then
        playerSpeed = math.clamp(num, 0, 200)
        playerSpeedBox.Text = tostring(playerSpeed)
    else
        playerSpeedBox.Text = tostring(playerSpeed)
    end
end)

RunService.RenderStepped:Connect(function()
    if speedEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = playerSpeed
    end
end)

-- 6. GOD Mode (Toggle ON/OFF)
local godModeToggle = Instance.new("TextButton")
godModeToggle.Size = UDim2.new(0, 100, 0, 30)
godModeToggle.Text = "OFF"
godModeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
godModeToggle.TextSize = 12
godModeToggle.Font = Enum.Font.GothamBold
godModeToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", godModeToggle).CornerRadius = UDim.new(0, 6)
createOptionRow("GOD Mode (Imortalidade)", godModeToggle)

godModeToggle.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    godModeToggle.Text = godModeEnabled and "ON" or "OFF"
    godModeToggle.BackgroundColor3 = godModeEnabled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(180, 40, 40)
    
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        if godModeEnabled then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
        else
            char.Humanoid.MaxHealth = 100
            char.Humanoid.Health = 100
        end
    end
end)

-- 7. TP para o Spawn (Botão de Ação)
local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0, 100, 0, 30)
spawnBtn.Text = "IR PARA SPAWN"
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.TextSize = 10
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)
createOptionRow("Teleportar para Ponto de Renascimento", spawnBtn)

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

-- 8. Rejoin com Script Ativado (Botão de Ação)
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0, 100, 0, 30)
rejoinBtn.Text = "REJOIN"
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.TextSize = 11
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 6)
createOptionRow("Reentrar no Servidor (Mantém Script)", rejoinBtn)

rejoinBtn.MouseButton1Click:Connect(function()
    if #Players:GetPlayers() <= 1 then
        player:Kick("Reconectando...")
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, player)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
end)

-- Robin Hub v6 para Delta Executor (Completo com Cores Personalizadas)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local noclipEnabled = false
local flyEnabled = false
local godModeEnabled = false
local killAuraEnabled = false
local infiniteJumpEnabled = false
local customSpeed = 16
local hubVisible = true
local isExpanded = true

local bv, bg
local protegido = gethui or function(v) return v end

-- Cores dos botões
local colorOff = Color3.fromRGB(160, 40, 40) -- Vermelho
local colorOn = Color3.fromRGB(46, 204, 113)  -- Verde

-- Remove interface antiga se já existir
if CoreGui:FindFirstChild("RobinHub_Delta") then
    CoreGui:FindFirstChild("RobinHub_Delta"):Destroy()
end

-- Criação da Interface Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobinHub_Delta"
screenGui.Parent = protegido(CoreGui)
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão Flutuante (Abre e Fecha o Hub na tela)
local toggleHubButton = Instance.new("TextButton")
toggleHubButton.Size = UDim2.new(0, 160, 0, 42)
toggleHubButton.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleHubButton.Text = "🦇 ROBIN HUB"
toggleHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHubButton.TextSize = 13
toggleHubButton.Font = Enum.Font.GothamBold
toggleHubButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleHubButton.Active = true
toggleHubButton.Draggable = true
toggleHubButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleHubButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(80, 80, 80)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleHubButton

-- Janela Principal (Painel Preto Grande e Expandido)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 460, 0, 570)
mainFrame.Position = UDim2.new(0.5, -230, 0.4, -285)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 18)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 60)
mainStroke.Thickness = 2.5
mainStroke.Parent = mainFrame

-- Barra Superior (Título + Capa de Anime)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 18)
topCorner.Parent = topBar

local coverFix = Instance.new("Frame")
coverFix.Size = UDim2.new(1, 0, 0, 15)
coverFix.Position = UDim2.new(0, 0, 1, -15)
coverFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
coverFix.BorderSizePixel = 0
coverFix.Parent = topBar

-- Foto / Ícone de Anime na Capa
local animeIcon = Instance.new("ImageLabel")
animeIcon.Size = UDim2.new(0, 40, 0, 40)
animeIcon.Position = UDim2.new(0, 10, 0.5, -20)
animeIcon.Image = "rbxassetid://6034229566"
animeIcon.BackgroundTransparency = 1
animeIcon.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -130, 1, 0)
titleLabel.Position = UDim2.new(0, 60, 0, 0)
titleLabel.Text = "🦇 ROBIN HUB v6"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = topBar

-- Botão de Redimensionar no Canto da Barra Superior ([ ])
local resizeButton = Instance.new("TextButton")
resizeButton.Size = UDim2.new(0, 32, 0, 32)
resizeButton.Position = UDim2.new(1, -80, 0.5, -16)
resizeButton.Text = "[ ]"
resizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeButton.TextSize = 13
resizeButton.Font = Enum.Font.GothamBold
resizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
resizeButton.Parent = topBar

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 8)
resizeCorner.Parent = resizeButton

-- Botão de Fechar (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -42, 0.5, -16)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Lógica do Botão de Redimensionar
resizeButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    if isExpanded then
        mainFrame.Size = UDim2.new(0, 460, 0, 570)
        resizeButton.Text = "[ ]"
    else
        mainFrame.Size = UDim2.new(0, 460, 0, 55)
        resizeButton.Text = "[+]"
    end
end)

-- Lógica para Abrir e Fechar o Hub Principal
toggleHubButton.MouseButton1Click:Connect(function()
    hubVisible = not hubVisible
    mainFrame.Visible = hubVisible
    if hubVisible then
        toggleHubButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        toggleHubButton.Text = "🦇 ROBIN HUB"
    else
        toggleHubButton.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        toggleHubButton.Text = "🔴 HUB FECHADO"
    end
end)

-- Posições para o Grid de botões (2 colunas)
local leftColX = UDim2.new(0, 20, 0, 68)
local rightColX = UDim2.new(0, 235, 0, 68)
local elementSize = UDim2.new(0, 205, 0, 40)

-- Botão 1: Voo ON/OFF
local flyButton = Instance.new("TextButton")
flyButton.Size = elementSize
flyButton.Position = leftColX
flyButton.Text = "VOO: OFF"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 13
flyButton.Font = Enum.Font.GothamBold
flyButton.BackgroundColor3 = colorOff
flyButton.Parent = mainFrame

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyButton

-- Botão 2: Noclip ON/OFF
local noclipButton = Instance.new("TextButton")
noclipButton.Size = elementSize
noclipButton.Position = rightColX
noclipButton.Text = "NOCLIP: OFF"
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.TextSize = 13
noclipButton.Font = Enum.Font.GothamBold
noclipButton.BackgroundColor3 = colorOff
noclipButton.Parent = mainFrame

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 10)
noclipCorner.Parent = noclipButton

-- Botão 3: God Mode ON/OFF
local godButton = Instance.new("TextButton")
godButton.Size = elementSize
godButton.Position = UDim2.new(0, 20, 0, 114)
godButton.Text = "GOD MODE: OFF"
godButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godButton.TextSize = 13
godButton.Font = Enum.Font.GothamBold
godButton.BackgroundColor3 = colorOff
godButton.Parent = mainFrame

local godCorner = Instance.new("UICorner")
godCorner.CornerRadius = UDim.new(0, 10)
godCorner.Parent = godButton

-- Botão 4: Kill Aura ON/OFF
local killAuraButton = Instance.new("TextButton")
killAuraButton.Size = elementSize
killAuraButton.Position = UDim2.new(0, 235, 0, 114)
killAuraButton.Text = "KILL AURA: OFF"
killAuraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
killAuraButton.TextSize = 13
killAuraButton.Font = Enum.Font.GothamBold
killAuraButton.BackgroundColor3 = colorOff
killAuraButton.Parent = mainFrame

local killCorner = Instance.new("UICorner")
killCorner.CornerRadius = UDim.new(0, 10)
killCorner.Parent = killAuraButton

-- Botão 5: Pulo Infinito ON/OFF
local infJumpButton = Instance.new("TextButton")
infJumpButton.Size = elementSize
infJumpButton.Position = UDim2.new(0, 20, 0, 160)
infJumpButton.Text = "PULO INFINITO: OFF"
infJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infJumpButton.TextSize = 13
infJumpButton.Font = Enum.Font.GothamBold
infJumpButton.BackgroundColor3 = colorOff
infJumpButton.Parent = mainFrame

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 10)
jumpCorner.Parent = infJumpButton

-- Botão 6: Pegar Arma/Espada/Equipamento
local getToolButton = Instance.new("TextButton")
getToolButton.Size = elementSize
getToolButton.Position = UDim2.new(0, 235, 0, 160)
getToolButton.Text = "⚔️ PEGAR EQUIPAMENTO"
getToolButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getToolButton.TextSize = 12
getToolButton.Font = Enum.Font.GothamBold
getToolButton.BackgroundColor3 = colorOff
getToolButton.Parent = mainFrame

local toolCorner = Instance.new("UICorner")
toolCorner.CornerRadius = UDim.new(0, 10)
toolCorner.Parent = getToolButton

-- Caixa de Texto: Velocidade (1 a 1000)
local speedBox = Instance.new("TextBox")
speedBox.Size = elementSize
speedBox.Position = UDim2.new(0, 20, 0, 206)
speedBox.Text = "50"
speedBox.PlaceholderText = "Vel (1-1000)"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 13
speedBox.Font = Enum.Font.GothamBold
speedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedBox.ClearTextOnFocus = false
speedBox.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 10)
speedCorner.Parent = speedBox

-- Botão 7: Ativar Velocidade
local speedButton = Instance.new("TextButton")
speedButton.Size = elementSize
speedButton.Position = UDim2.new(0, 235, 0, 206)
speedButton.Text = "ATIVAR VELOCIDADE"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.TextSize = 13
speedButton.Font = Enum.Font.GothamBold
speedButton.BackgroundColor3 = colorOff
speedButton.Parent = mainFrame

local speedBtnCorner = Instance.new("UICorner")
speedBtnCorner.CornerRadius = UDim.new(0, 10)
speedBtnCorner.Parent = speedButton

-- Botão 8: Desligar Velocidade (Volta ao normal = 16)
local offSpeedButton = Instance.new("TextButton")
offSpeedButton.Size = UDim2.new(0, 420, 0, 40)
offSpeedButton.Position = UDim2.new(0, 20, 0, 256)
offSpeedButton.Text = "DESLIGAR VELOCIDADE"
offSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
offSpeedButton.TextSize = 13
offSpeedButton.Font = Enum.Font.GothamBold
offSpeedButton.BackgroundColor3 = colorOff
offSpeedButton.Parent = mainFrame

local offSpeedCorner = Instance.new("UICorner")
offSpeedCorner.CornerRadius = UDim.new(0, 10)
offSpeedCorner.Parent = offSpeedButton

-- Rótulo de Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 420, 0, 35)
statusLabel.Position = UDim2.new(0, 20, 0, 306)
statusLabel.Text = "Status: Robin Hub v6 ativo."
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = mainFrame

-- Lógica da Velocidade
speedBox.FocusLost:Connect(function()
    local num = tonumber(speedBox.Text)
    if num then
        customSpeed = math.clamp(num, 1, 1000)
        speedBox.Text = tostring(customSpeed)
    else
        speedBox.Text = tostring(customSpeed)
    end
end)

speedButton.MouseButton1Click:Connect(function()
    local num = tonumber(speedBox.Text)
    if num then
        customSpeed = math.clamp(num, 1, 1000)
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = customSpeed
        speedButton.BackgroundColor3 = colorOn
        statusLabel.Text = "Velocidade ativada: " .. customSpeed
    else
        statusLabel.Text = "Personagem não encontrado!"
    end
end)

offSpeedButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        speedButton.BackgroundColor3 = colorOff
        statusLabel.Text = "Velocidade desligada (Padrão: 16)"
    else
        statusLabel.Text = "Personagem não encontrado!"
    end
end)

-- Lógica para Pegar Ferramenta / Arma / Espada no Mapa
getToolButton.MouseButton1Click:Connect(function()
    local found = false
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Parent ~= player.Character and not obj.Parent:IsA("Backpack") then
                obj.Parent = player.Backpack
                found = true
                statusLabel.Text = "Equipamento encontrado e coletado!"
                break
            end
        end
        if not found then
            statusLabel.Text = "Nenhuma ferramenta nova encontrada."
        end
    end)
end)

-- Lógica do Noclip
noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipButton.Text = "NOCLIP: ON"
        noclipButton.BackgroundColor3 = colorOn
    else
        noclipButton.Text = "NOCLIP: OFF"
        noclipButton.BackgroundColor3 = colorOff
    end
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

-- Lógica do Pulo Infinito
infJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        infJumpButton.Text = "PULO INFINITO: ON"
        infJumpButton.BackgroundColor3 = colorOn
        statusLabel.Text = "Pulo infinito ativado!"
    else
        infJumpButton.Text = "PULO INFINITO: OFF"
        infJumpButton.BackgroundColor3 = colorOff
        statusLabel.Text = "Pulo infinito desativado."
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Lógica do God Mode
godButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        godButton.Text = "GOD MODE: ON"
        godButton.BackgroundColor3 = colorOn
        statusLabel.Text = "God Mode ativado!"
    else
        godButton.Text = "GOD MODE: OFF"
        godButton.BackgroundColor3 = colorOff
        statusLabel.Text = "God Mode desativado."
    end
end)

RunService.Heartbeat:Connect(function()
    if godModeEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

-- Lógica do Kill Aura
killAuraButton.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    if killAuraEnabled then
        killAuraButton.Text = "KILL AURA: ON"
        killAuraButton.BackgroundColor3 = colorOn
        statusLabel.Text = "Kill Aura ativado!"
        
        task.spawn(function()
            while killAuraEnabled do
                task.wait(0.2)
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local myRoot = player.Character.HumanoidRootPart
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        
                        for _, otherPlayer in ipairs(Players:GetPlayers()) do
                            if otherPlayer ~= player and otherPlayer.Character then
                                local targetRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local targetHumanoid = otherPlayer.Character:FindFirstChild("Humanoid")
                                
                                if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                                    local distance = (myRoot.Position - targetRoot.Position).Magnitude
                                    if distance <= 20 then
                                        if tool then
                                            tool:Activate()
                                        end
                                        firetouchinterest(myRoot, targetRoot, 0)
                                        firetouchinterest(myRoot, targetRoot, 1)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    else
        killAuraButton.Text = "KILL AURA: OFF"
        killAuraButton.BackgroundColor3 = colorOff
        statusLabel.Text = "Kill Aura desativado."
    end
end)

-- Lógica do Voo
flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character:FindFirstChild("Humanoid")

    if flyEnabled then
        flyButton.Text = "VOO: ON"
        flyButton.BackgroundColor3 = colorOn
        
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
                local currentFlySpeed = tonumber(speedBox.Text) or 50
                if bv and bg then
                    bv.Velocity = (cam.CFrame.LookVector * (moveDir.Z * -currentFlySpeed)) + 
                                  (cam.CFrame.RightVector * (moveDir.X * currentFlySpeed)) + 
                                  Vector3.new(0, moveDir.Y * currentFlySpeed, 0)
                    bg.CFrame = cam.CFrame
                end
                task.wait()
            end
        end)
        statusLabel.Text = "Voo ativado!"
    else
        flyButton.Text = "VOO: OFF"
        flyButton.BackgroundColor3 = colorOff
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
        statusLabel.Text = "Voo desativado."
    end
end)

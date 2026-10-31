-- Robin Hub v13 (Com Contador de FPS para Delta Executor)
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
local antiPushEnabled = false
local customSpeed = 16
local hubVisible = true
local isExpanded = true

local bv, bg
local protegido = gethui or function(v) return v end

local colorOff = Color3.fromRGB(160, 40, 40) -- Vermelho
local colorOn = Color3.fromRGB(46, 204, 113)  -- Verde

-- Sistema Anti-Duplicado
if CoreGui:FindFirstChild("RobinHub_Delta") then
    CoreGui:FindFirstChild("RobinHub_Delta"):Destroy()
end
if player.PlayerGui:FindFirstChild("RobinHub_Delta") then
    player.PlayerGui:FindFirstChild("RobinHub_Delta"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobinHub_Delta"
local success = pcall(function()
    screenGui.Parent = protegido(CoreGui)
end)
if not success then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

-- Botão Flutuante Principal
local toggleHubButton = Instance.new("TextButton", screenGui)
toggleHubButton.Size = UDim2.new(0, 130, 0, 36)
toggleHubButton.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleHubButton.Text = "🦇 ROBIN HUB"
toggleHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleHubButton.TextSize = 12
toggleHubButton.Font = Enum.Font.GothamBold
toggleHubButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
toggleHubButton.Active = true
toggleHubButton.Draggable = true
Instance.new("UICorner", toggleHubButton).CornerRadius = UDim.new(0, 8)
local tStroke = Instance.new("UIStroke", toggleHubButton)
tStroke.Color = Color3.fromRGB(80, 80, 80)
tStroke.Thickness = 1.5

-- Janela Principal
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 380, 0, 480)
mainFrame.Position = UDim2.new(0.5, -190, 0.4, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)
local mStroke = Instance.new("UIStroke", mainFrame)
mStroke.Color = Color3.fromRGB(60, 60, 60)
mStroke.Thickness = 2

-- Barra Superior
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)

local coverFix = Instance.new("Frame", topBar)
coverFix.Size = UDim2.new(1, 0, 0, 10)
coverFix.Position = UDim2.new(0, 0, 1, -10)
coverFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
coverFix.BorderSizePixel = 0

local animeIcon = Instance.new("ImageLabel", topBar)
animeIcon.Size = UDim2.new(0, 28, 0, 28)
animeIcon.Position = UDim2.new(0, 8, 0.5, -14)
animeIcon.Image = "rbxassetid://6034229566"
animeIcon.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(1, -135, 1, 0)
titleLabel.Position = UDim2.new(0, 44, 0, 0)
titleLabel.Text = "🦇 ROBIN HUB"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.BackgroundTransparency = 1

-- Mostrador de FPS na Barra Superior
local fpsLabel = Instance.new("TextLabel", topBar)
fpsLabel.Size = UDim2.new(0, 45, 0, 26)
fpsLabel.Position = UDim2.new(1, -114, 0.5, -13)
fpsLabel.Text = "FPS: 60"
fpsLabel.TextColor3 = Color3.fromRGB(46, 204, 113)
fpsLabel.TextSize = 10
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Botão Minimizar ([ ])
local resizeButton = Instance.new("TextButton", topBar)
resizeButton.Size = UDim2.new(0, 26, 0, 26)
resizeButton.Position = UDim2.new(1, -66, 0.5, -13)
resizeButton.Text = "[ ]"
resizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resizeButton.TextSize = 11
resizeButton.Font = Enum.Font.GothamBold
resizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", resizeButton).CornerRadius = UDim.new(0, 6)

-- Botão Fechar (X)
local closeButton = Instance.new("TextButton", topBar)
closeButton.Size = UDim2.new(0, 26, 0, 26)
closeButton.Position = UDim2.new(1, -34, 0.5, -13)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 13
closeButton.Font = Enum.Font.GothamBold
closeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

resizeButton.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    if isExpanded then
        mainFrame.Size = UDim2.new(0, 380, 0, 480)
        resizeButton.Text = "[ ]"
    else
        mainFrame.Size = UDim2.new(0, 380, 0, 42)
        resizeButton.Text = "[+]"
    end
end)

toggleHubButton.MouseButton1Click:Connect(function()
    hubVisible = not hubVisible
    mainFrame.Visible = hubVisible
end)

-- Atualização em tempo real do FPS
local lastTick = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTick = tick()
    if currentTick - lastTick >= 1 then
        fpsLabel.Text = "FPS: " .. math.floor(frameCount / (currentTick - lastTick))
        frameCount = 0
        lastTick = currentTick
    end
end)

-- Grid de Botões
local leftColX = UDim2.new(0, 12, 0, 52)
local rightColX = UDim2.new(0, 196, 0, 52)
local elementSize = UDim2.new(0, 172, 0, 32)
local yStep = 38

local flyButton = Instance.new("TextButton", mainFrame)
flyButton.Size = elementSize; flyButton.Position = leftColX
flyButton.Text = "VOO: OFF"; flyButton.TextColor3 = Color3.fromRGB(255, 255, 255); flyButton.TextSize = 11; flyButton.Font = Enum.Font.GothamBold; flyButton.BackgroundColor3 = colorOff
Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0, 8)

local noclipButton = Instance.new("TextButton", mainFrame)
noclipButton.Size = elementSize; noclipButton.Position = rightColX
noclipButton.Text = "NOCLIP: OFF"; noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255); noclipButton.TextSize = 11; noclipButton.Font = Enum.Font.GothamBold; noclipButton.BackgroundColor3 = colorOff
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 8)

local godButton = Instance.new("TextButton", mainFrame)
godButton.Size = elementSize; godButton.Position = UDim2.new(0, 12, 0, 52 + yStep)
godButton.Text = "GOD MODE: OFF"; godButton.TextColor3 = Color3.fromRGB(255, 255, 255); godButton.TextSize = 11; godButton.Font = Enum.Font.GothamBold; godButton.BackgroundColor3 = colorOff
Instance.new("UICorner", godButton).CornerRadius = UDim.new(0, 8)

local killAuraButton = Instance.new("TextButton", mainFrame)
killAuraButton.Size = elementSize; killAuraButton.Position = UDim2.new(0, 196, 0, 52 + yStep)
killAuraButton.Text = "KILL AURA: OFF"; killAuraButton.TextColor3 = Color3.fromRGB(255, 255, 255); killAuraButton.TextSize = 11; killAuraButton.Font = Enum.Font.GothamBold; killAuraButton.BackgroundColor3 = colorOff
Instance.new("UICorner", killAuraButton).CornerRadius = UDim.new(0, 8)

local infJumpButton = Instance.new("TextButton", mainFrame)
infJumpButton.Size = elementSize; infJumpButton.Position = UDim2.new(0, 12, 0, 52 + (yStep * 2))
infJumpButton.Text = "PULO INFINITO: OFF"; infJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255); infJumpButton.TextSize = 11; infJumpButton.Font = Enum.Font.GothamBold; infJumpButton.BackgroundColor3 = colorOff
Instance.new("UICorner", infJumpButton).CornerRadius = UDim.new(0, 8)

local antiPushButton = Instance.new("TextButton", mainFrame)
antiPushButton.Size = elementSize; antiPushButton.Position = UDim2.new(0, 196, 0, 52 + (yStep * 2))
antiPushButton.Text = "ANTI-EMPURRÃO: OFF"; antiPushButton.TextColor3 = Color3.fromRGB(255, 255, 255); antiPushButton.TextSize = 10; antiPushButton.Font = Enum.Font.GothamBold; antiPushButton.BackgroundColor3 = colorOff
Instance.new("UICorner", antiPushButton).CornerRadius = UDim.new(0, 8)

local getToolButton = Instance.new("TextButton", mainFrame)
getToolButton.Size = elementSize; getToolButton.Position = UDim2.new(0, 12, 0, 52 + (yStep * 3))
getToolButton.Text = "⚔️ PEGAR EQUIP."; getToolButton.TextColor3 = Color3.fromRGB(255, 255, 255); getToolButton.TextSize = 11; getToolButton.Font = Enum.Font.GothamBold; getToolButton.BackgroundColor3 = colorOff
Instance.new("UICorner", getToolButton).CornerRadius = UDim.new(0, 8)

local speedBox = Instance.new("TextBox", mainFrame)
speedBox.Size = elementSize; speedBox.Position = UDim2.new(0, 196, 0, 52 + (yStep * 3))
speedBox.Text = "50"; speedBox.PlaceholderText = "Vel (1-1000)"; speedBox.TextColor3 = Color3.fromRGB(255, 255, 255); speedBox.TextSize = 11; speedBox.Font = Enum.Font.GothamBold; speedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25); speedBox.ClearTextOnFocus = false
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 8)

local speedButton = Instance.new("TextButton", mainFrame)
speedButton.Size = elementSize; speedButton.Position = UDim2.new(0, 12, 0, 52 + (yStep * 4))
speedButton.Text = "LIGAR VELOCIDADE"; speedButton.TextColor3 = Color3.fromRGB(255, 255, 255); speedButton.TextSize = 11; speedButton.Font = Enum.Font.GothamBold; speedButton.BackgroundColor3 = colorOff
Instance.new("UICorner", speedButton).CornerRadius = UDim.new(0, 8)

local offSpeedButton = Instance.new("TextButton", mainFrame)
offSpeedButton.Size = elementSize; offSpeedButton.Position = UDim2.new(0, 196, 0, 52 + (yStep * 4))
offSpeedButton.Text = "DESLIGAR VELOCIDADE"; offSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255); offSpeedButton.TextSize = 10; offSpeedButton.Font = Enum.Font.GothamBold; offSpeedButton.BackgroundColor3 = colorOff
Instance.new("UICorner", offSpeedButton).CornerRadius = UDim.new(0, 8)

local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(0, 356, 0, 25); statusLabel.Position = UDim2.new(0, 12, 0, 52 + (yStep * 5) + 4)
statusLabel.Text = "Status: Robin Hub v13 ativo."
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.BackgroundTransparency = 1

-- Lógica do Anti-Empurrão
antiPushButton.MouseButton1Click:Connect(function()
    antiPushEnabled = not antiPushEnabled
    antiPushButton.Text = antiPushEnabled and "ANTI-EMPURRÃO: ON" or "ANTI-EMPURRÃO: OFF"
    antiPushButton.BackgroundColor3 = antiPushEnabled and colorOn or colorOff
end)

RunService.Stepped:Connect(function()
    if antiPushEnabled and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                for _, otherPlayer in ipairs(Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character then
                        for _, otherPart in ipairs(otherPlayer.Character:GetDescendants()) do
                            if otherPart:IsA("BasePart") then
                                pcall(function()
                                    part.CanCollide = false
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Lógica de Velocidade
speedBox.FocusLost:Connect(function()
    local num = tonumber(speedBox.Text)
    if num then customSpeed = math.clamp(num, 1, 1000) end
end)

speedButton.MouseButton1Click:Connect(function()
    local num = tonumber(speedBox.Text)
    if num then customSpeed = math.clamp(num, 1, 1000) end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = customSpeed
        speedButton.BackgroundColor3 = colorOn
        statusLabel.Text = "Velocidade ativada: " .. customSpeed
    end
end)

offSpeedButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        speedButton.BackgroundColor3 = colorOff
        statusLabel.Text = "Velocidade desligada (Padrão: 16)"
    end
end)

-- Coletor de Armas
getToolButton.MouseButton1Click:Connect(function()
    pcall(function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Parent ~= player.Character and not obj.Parent:IsA("Backpack") then
                obj.Parent = player.Backpack
                getToolButton.BackgroundColor3 = colorOn
                statusLabel.Text = "Equipamento coletado!"
                task.delay(1, function() getToolButton.BackgroundColor3 = colorOff end)
                break
            end
        end
    end)
end)

-- Noclip
noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "NOCLIP: ON" or "NOCLIP: OFF"
    noclipButton.BackgroundColor3 = noclipEnabled and colorOn or colorOff
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

-- Pulo Infinito
infJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infJumpButton.Text = infiniteJumpEnabled and "PULO INFINITO: ON" or "PULO INFINITO: OFF"
    infJumpButton.BackgroundColor3 = infiniteJumpEnabled and colorOn or colorOff
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- God Mode
godButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    godButton.Text = godModeEnabled and "GOD MODE: ON" or "GOD MODE: OFF"
    godButton.BackgroundColor3 = godModeEnabled and colorOn or colorOff
end)

RunService.Heartbeat:Connect(function()
    if godModeEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end)

-- Kill Aura
killAuraButton.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    killAuraButton.Text = killAuraEnabled and "KILL AURA: ON" or "KILL AURA: OFF"
    killAuraButton.BackgroundColor3 = killAuraEnabled and colorOn or colorOff
    
    if killAuraEnabled then
        task.spawn(function()
            while killAuraEnabled do
                task.wait(0.2)
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local myRoot = player.Character.HumanoidRootPart
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= player and p.Character then
                                local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                                local tHum = p.Character:FindFirstChild("Humanoid")
                                if tRoot and tHum and tHum.Health > 0 then
                                    if (myRoot.Position - tRoot.Position).Magnitude <= 20 then
                                        if tool then tool:Activate() end
                                        firetouchinterest(myRoot, tRoot, 0)
                                        firetouchinterest(myRoot, tRoot, 1)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Voo (Fly) Corrigido, Fluido e Estável
flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    flyButton.Text = flyEnabled and "VOO: ON" or "VOO: OFF"
    flyButton.BackgroundColor3 = flyEnabled and colorOn or colorOff
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then 
        flyEnabled = false
        flyButton.Text = "VOO: OFF"
        flyButton.BackgroundColor3 = colorOff
        return 
    end
    
    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character:FindFirstChild("Humanoid")

    if flyEnabled then
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end

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
                local moveDir = humanoid and humanoid.MoveDirection or Vector3.new(0,0,0)
                local currentFlySpeed = tonumber(speedBox.Text) or 50
                
                if bv and bg and bv.Parent and bg.Parent then
                    if moveDir.Magnitude > 0 then
                        bv.Velocity = (cam.CFrame.LookVector * (moveDir.Z * currentFlySpeed)) + 
                                      (cam.CFrame.RightVector * (moveDir.X * currentFlySpeed)) + 
                                      Vector3.new(0, moveDir.Y * currentFlySpeed, 0)
                    else
                        bv.Velocity = Vector3.new(0, 0.1, 0)
                    end
                    bg.CFrame = cam.CFrame
                end
                task.wait()
            end
            
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if humanoid then humanoid.PlatformStand = false end
        end)
    else
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
    end
end)

-- Reseta o voo automaticamente se o jogador morrer
player.CharacterAdded:Connect(function(newChar)
    flyEnabled = false
    flyButton.Text = "VOO: OFF"
    flyButton.BackgroundColor3 = colorOff
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end)

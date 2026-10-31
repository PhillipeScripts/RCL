-- ==============================================================================
-- RCL SCRIPT v27.8 - ULTIMATE MOBILE STABLE EDITION
-- ==============================================================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

pcall(function()
    for _, v in ipairs({"RCL_FloatingButton", "RCL_Script_Hub", "RCL_IntroGui"}) do
        if CoreGui:FindFirstChild(v) then CoreGui[v]:Destroy() end
    end
end)

-- 1. INTRO
local introGui = Instance.new("ScreenGui", CoreGui)
introGui.Name = "RCL_IntroGui"
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local introFrame = Instance.new("Frame", introGui)
introFrame.Size = UDim2.new(0, 300, 0, 160)
introFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
introFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
introFrame.BorderSizePixel = 0
Instance.new("UICorner", introFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", introFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 20)
title.Text = "RCL Script v27.8"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

local barBg = Instance.new("Frame", introFrame)
barBg.Size = UDim2.new(0, 240, 0, 6)
barBg.Position = UDim2.new(0.5, -120, 0, 95)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
barBg.BorderSizePixel = 0
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- 2. PAINEL PRINCIPAL
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "RCL_Script_Hub"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Enabled = false

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 520, 0, 340)
main.Position = UDim2.new(0.5, -260, 0.4, -170)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 12)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() screenGui.Enabled = false end)

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)

local lLbl = Instance.new("TextLabel", sidebar)
lLbl.Size = UDim2.new(1, 0, 0, 45)
lLbl.Position = UDim2.new(0, 0, 0, 10)
lLbl.Text = "RCL Hub"
lLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lLbl.Font = Enum.Font.GothamBold
lLbl.TextSize = 16
lLbl.BackgroundTransparency = 1

-- Abas
local tabsList = {}
local function createTab()
    local c = Instance.new("ScrollingFrame", main)
    c.Size = UDim2.new(1, -165, 1, -55)
    c.Position = UDim2.new(0, 160, 0, 45)
    c.BackgroundTransparency = 1
    c.CanvasSize = UDim2.new(0, 0, 0, 300)
    c.ScrollBarThickness = 3
    c.Visible = false
    local l = Instance.new("UIListLayout", c)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, 6)
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
    b.Size = UDim2.new(1, -16, 0, 32)
    b.Position = UDim2.new(0, 8, 0, y)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(170, 170, 200)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

    b.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabsList) do t.Visible = false end
        targetTab.Visible = true
    end)
    return b
end

createTabBtn("Início", 65, t1)
createTabBtn("Player", 105, t2)
createTabBtn("Teleporte", 145, t3)
createTabBtn("Scripts", 185, t4)

-- Elementos das Abas
local function addRow(parent, text, widget)
    local r = Instance.new("Frame", parent)
    r.Size = UDim2.new(1, -10, 0, 38)
    r.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
    Instance.new("UICorner", r).CornerRadius = UDim.new(0, 6)
    local l = Instance.new("TextLabel", r)
    l.Size = UDim2.new(1, -110, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.Text = text
    l.TextColor3 = Color3.fromRGB(230, 230, 255)
    l.Font = Enum.Font.GothamMedium
    l.TextSize = 12
    l.BackgroundTransparency = 1
    l.TextXAlignment = Enum.TextXAlignment.Left
    if widget then
        widget.Position = UDim2.new(1, -100, 0.5, -14)
        widget.Parent = r
    end
end

-- Aba 1: Início
local iLbl = Instance.new("TextLabel", t1)
iLbl.Size = UDim2.new(1, -10, 0, 50)
iLbl.Text = "Bem-vindo ao RCL Script v27.8!\nCriador: Pelipe_404"
iLbl.TextColor3 = Color3.fromRGB(200, 200, 230)
iLbl.TextSize = 13
iLbl.Font = Enum.Font.Gotham
iLbl.BackgroundTransparency = 1

-- Aba 2: Player (Noclip & Fly)
local noclipOn, flyOn = false, false
local bv, bg

local function makeToggle(txt, parent, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 90, 0, 28)
    b.Text = "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    addRow(parent, txt, b)
    b.MouseButton1Click:Connect(function() cb(b) end)
    return b
end

makeToggle("Atravessar Paredes", t2, function(b)
    noclipOn = not noclipOn

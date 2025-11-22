-- Auto Buy para "Steal a Brainrot" - Creado por un scripter de élite
-- Características: Botón On/Off profesional, verificación de compra, detección automática de Brainrot.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables de configuración
local buyDelay = 0.1 -- Retraso en segundos entre cada intento de compra. Ajústalo si es demasiado rápido.

-- Estado del Auto Buy
local isAutoBuyEnabled = false
local currentTargetItem = nil

-- Función para encontrar los Brainrots en la pasarela
local function getBrainrots()
    local brainrots = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower() == "brainrot" and obj:FindFirstChildOfClass("ClickDetector") then
            table.insert(brainrots, obj)
        end
    end
    return brainrots
end

-- Función principal del Auto Buy
local function autoBuy()
    if not isAutoBuyEnabled then return end

    local brainrots = getBrainrots()
    if #brainrots == 0 then
        -- No se encontraron Brainrots, esperar y reintentar
        task.wait(1)
        autoBuy() -- Llamada recursiva para seguir intentando
        return
    end

    -- Seleccionar un Brainrot aleatorio
    local targetBrainrot = brainrots[math.random(1, #brainrots)]

    -- Guardar el Brainrot actual para verificar si cambia
    currentTargetItem = targetBrainrot

    -- Simular el clic en el detector
    fireclickdetector(targetBrainrot:FindFirstChildOfClass("ClickDetector"))

    -- Esperar un momento a que el servidor procese la compra
    task.wait(buyDelay)

    -- Bucle de compra continua
    while isAutoBuyEnabled and currentTargetItem == targetBrainrot do
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyItem"):InvokeServer()
        end)

        if success then
            -- Opcional: Imprimir el resultado del servidor para depuración
            -- print("Respuesta del servidor:", result)
            task.wait(buyDelay)
        else
            -- Hubo un error (probablemente porque el Brainrot ya no existe o se compró)
            -- print("Error al comprar, deteniendo el bucle para este Brainrot.")
            break -- Salir del bucle para que se detecte el nuevo Brainrot
        end
    end

    -- Si sigue activado, reiniciar el proceso para comprar el siguiente Brainrot
    if isAutoBuyEnabled then
        task.wait(0.2) -- Pequeña pausa antes de buscar el nuevo Brainrot
        autoBuy()
    end
end

-- === CREACIÓN DE LA INTERFAZ GRÁFICA (GUI) ===

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGui"
screenGui.Parent = playerGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 180, 0, 60)
mainFrame.Position = UDim2.new(0, 20, 0.5, -30) -- Posición en la izquierda, centrada verticalmente
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2

-- Hacer el GUI arrastrable
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Esquinas redondeadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Sombra
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Parent = mainFrame
shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, 3)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BorderSizePixel = 0
shadow.BackgroundTransparency = 0.85
shadow.ZIndex = mainFrame.ZIndex - 1

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

-- Título
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Auto Buy"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Center

-- Botón Toggle
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = mainFrame
toggleButton.Size = UDim2.new(0, 80, 0, 25)
toggleButton.Position = UDim2.new(0.5, -40, 0, 30)
toggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Rojo (OFF)
toggleButton.BorderSizePixel = 0
toggleButton.Font = Enum.Font.Gotham
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.AutoButtonColor = false

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = toggleButton

-- Animación del botón
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local colorTweenOn = TweenService:Create(toggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 220, 50)}) -- Verde (ON)
local colorTweenOff = TweenService:Create(toggleButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}) -- Rojo (OFF)

-- Función del botón Toggle
toggleButton.MouseButton1Click:Connect(function()
    isAutoBuyEnabled = not isAutoBuyEnabled

    if isAutoBuyEnabled then
        toggleButton.Text = "ON"
        colorTweenOn:Play()
        autoBuy() -- Iniciar el bucle de compra
    else
        toggleButton.Text = "OFF"
        colorTweenOff:Play()
        -- El bucle se detendrá solo porque la variable isAutoBuyEnabled es false
    end
end)

print("Script de Auto Buy para 'Steal a Brainrot' cargado correctamente.")

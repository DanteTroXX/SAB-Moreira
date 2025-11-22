-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ====== Crear UI ======
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 150, 0, 50)
Frame.Position = UDim2.new(0.05, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = Frame
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.Position = UDim2.new(0, 0, 0, 0)
ToggleButton.Text = "AutoBuy: OFF"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0

-- ====== Hacer draggable en PC y móvil ======
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                               startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    end
end)

-- ====== AutoBuy ======
local autoBuy = false

ToggleButton.MouseButton1Click:Connect(function()
    autoBuy = not autoBuy
    if autoBuy then
        ToggleButton.Text = "AutoBuy: ON"
        Frame.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
    else
        ToggleButton.Text = "AutoBuy: OFF"
        Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end
end)

-- ====== Función para activar los ProximityPrompts “buy” ======
local function tryActivateBuyPrompts()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            -- Verificá el texto del prompt para que sea el de “comprar” en tu juego
            local txt = obj.ActionText
            if txt and string.lower(txt):find("buy") or string.lower(txt):find("comprar") then
                if obj.Enabled then
                    -- Intentar activación
                    obj:InputHoldBegin()
                    obj:InputHoldEnd()
                end
            end
        end
    end
end

-- ====== Loop ======
RunService.Heartbeat:Connect(function()
    if autoBuy then
        tryActivateBuyPrompts()
    end
end)

--[[ 
===========================================
    AUTO BUY – TOGGLE BUTTON (NO REMOTES)
===========================================
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- =======================
-- CREAR UI DEL BOTÓN
-- =======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 120, 0, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.25, 0)
ToggleButton.Text = "AutoBuy: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.AutoButtonColor = true
ToggleButton.BorderSizePixel = 0
ToggleButton.BackgroundTransparency = 0.1
ToggleButton.ZIndex = 999999

-- Bordes redondos
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = ToggleButton

-- =======================
-- SISTEMA AUTO BUY
-- =======================
local autoBuy = false

local function toggleAutoBuy()
    autoBuy = not autoBuy

    if autoBuy then
        ToggleButton.Text = "AutoBuy: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleButton.Text = "AutoBuy: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end

ToggleButton.MouseButton1Click:Connect(toggleAutoBuy)

-- =======================
-- LOOP DE AUTOBUY RÁPIDO
-- =======================
RunService.RenderStepped:Connect(function()
    if autoBuy then
        -- Simula presionar la tecla E rápido
        UserInputService.InputBegan:Fire({
            KeyCode = Enum.KeyCode.E,
            UserInputType = Enum.UserInputType.Keyboard
        })

        UserInputService.InputEnded:Fire({
            KeyCode = Enum.KeyCode.E,
            UserInputType = Enum.UserInputType.Keyboard
        })
    end
end)

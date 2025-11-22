--========================================================--
--   AUTO BUY GLOBAL - UN SOLO SCRIPT - PC & MÓVIL        --
--========================================================--

-------------------------
-- CONFIGURACIÓN
-------------------------
local AUTO_SPEED = 0.1   -- cada cuántos segundos intenta comprar
local INTERACT_KEY = Enum.KeyCode.E  -- tecla de comprar

-------------------------
-- REFERENCIAS
-------------------------
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RUN = game:GetService("RunService")

local remoteBuy = RS:WaitForChild("BuyBrainrot") -- RemoteEvent

-------------------------
-- ESTADO
-------------------------
local AutoBuyEnabled = false
local ButtonDrag = false
local DragOffset = Vector2.new()

-------------------------
-- CREAR BOTÓN
-------------------------
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 160, 0, 60)
button.Position = UDim2.new(0.05, 0, 0.25, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 22
button.Text = "AutoBuy: OFF"
button.Font = Enum.Font.GothamBold
button.AutoButtonColor = true
button.BackgroundTransparency = 0.1
button.Parent = gui
button.Active = true
button.Draggable = false -- usaremos drag manual

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = button

-------------------------
-- ACTIVAR / DESACTIVAR
-------------------------
button.MouseButton1Click:Connect(function()
    AutoBuyEnabled = not AutoBuyEnabled

    if AutoBuyEnabled then
        button.Text = "AutoBuy: ON"
        button.BackgroundColor3 = Color3.fromRGB(60, 170, 80)
    else
        button.Text = "AutoBuy: OFF"
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-------------------------
-- DRAG (PC + MÓVIL)
-------------------------
button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then

        ButtonDrag = true
        DragOffset = input.Position - button.AbsolutePosition
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then

        ButtonDrag = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if ButtonDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or
                       input.UserInputType == Enum.UserInputType.Touch) then

        button.Position = UDim2.fromOffset(
            input.Position.X - DragOffset.X,
            input.Position.Y - DragOffset.Y
        )
    end
end)

-------------------------
-- AUTO BUY LOOP
-------------------------
RUN.Heartbeat:Connect(function()
    if AutoBuyEnabled then
        remoteBuy:FireServer("BUY_ALL") 
        task.wait(AUTO_SPEED)
    end
end)

-------------------------
-- DETECTAR TECLA "E"
-------------------------
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == INTERACT_KEY then
        if AutoBuyEnabled then
            remoteBuy:FireServer("BUY_ALL")
        end
    end
end)

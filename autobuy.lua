-- CONFIGURACIÓN ----------------------------
local brainrotsAComprar = {
    "Brainrot1",
    "Brainrot2",
    "Brainrot3",
    "Brainrot4"
}

local compraDelay = 0.05 -- 50ms entre compras
--------------------------------------------

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local BuyEvent = ReplicatedStorage:WaitForChild("Buy")

local autoBuyActivo = false

-- CREAR GUI -------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBuyGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.9, 0)
button.BackgroundColor3 = Color3.new(0, 1, 0)
button.TextColor3 = Color3.new(0, 0, 0)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.Text = "AutoBuy: OFF"
button.Parent = screenGui

local function actualizarBoton()
    if autoBuyActivo then
        button.Text = "AutoBuy: ON"
        button.BackgroundColor3 = Color3.new(1, 0.5, 0)
    else
        button.Text = "AutoBuy: OFF"
        button.BackgroundColor3 = Color3.new(0, 1, 0)
    end
end

button.MouseButton1Click:Connect(function()
    autoBuyActivo = not autoBuyActivo
    actualizarBoton()
end)

-- AUTO-BUY -------------------------------
task.spawn(function()
    while true do
        if autoBuyActivo then
            for _, brainrotName in ipairs(brainrotsAComprar) do
                pcall(function()
                    BuyEvent:FireServer(brainrotName)
                end)
                task.wait(0.01)
            end
        end
        task.wait(compraDelay)
    end
end)

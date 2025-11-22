-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI
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
ToggleButton.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = ToggleButton

-- Estado del auto-buy
local autoBuy = false
ToggleButton.MouseButton1Click:Connect(function()
	autoBuy = not autoBuy
	if autoBuy then
		ToggleButton.Text = "AutoBuy: ON"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	else
		ToggleButton.Text = "AutoBuy: OFF"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	end
end)

-- Función para activar ProximityPrompts
local function activatePrompts()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and obj.ActionText:lower():find("buy") then
			-- Solo activa si el prompt está habilitado
			if obj.Enabled then
				obj:InputHoldBegin()
				obj:InputHoldEnd()
			end
		end
	end
end

-- Loop de auto-buy
RunService.Heartbeat:Connect(function()
	if autoBuy then
		activatePrompts()
	end
end)

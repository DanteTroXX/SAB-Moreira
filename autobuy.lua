--========================================================--
--            AUTO BUY BUTTON - FINAL VERSION             --
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- RemoteEvent en ReplicatedStorage
local BuyEvent = ReplicatedStorage:WaitForChild("BuyBrainrot")

-- Configuración
local Brainrots = {

    ["Noobini Pizzanini"] = {price = 25, generation = 1, rarity = "Common"},
    ["Lirilì Larilà"] = {price = 250, generation = 3, rarity = "Common"},
    ["Tim Cheese"] = {price = 500, generation = 5, rarity = "Common"},
    ["Garama and Madundung"] = {price = 10000000000, generation = 50000000, rarity = "Secret"},
    ["Fluriflura"] = {price = 750, generation = 7, rarity = "Common"},
    ["Svinina Bombardino"] = {price = 1250, generation = 10, rarity = "Common"},
    ["Talpa Di Fero"] = {price = 1000, generation = 9, rarity = "Common"},
    ["Pipi Kiwi"] = {price = 1500, generation = 13, rarity = "Common"},
    ["Sigma Girl"] = {price = 3400000, generation = 1800, rarity = "Legendary"},
    ["Raccooni Jandelini"] = {price = 1350, generation = 12, rarity = "Common"},
    ["Trippi Troppi"] = {price = 2000, generation = 15, rarity = "Rare"},
    ["Tung Tung TungSahur"] = {price = 3000, generation = 25, rarity = "Rare"},
    ["Gangster Footera"] = {price = 4000, generation = 30, rarity = "Rare"},
    ["Boneca Ambalabu"] = {price = 5000, generation = 40, rarity = "Rare"},
    ["Ta Ta Ta Ta Sahur"] = {price = 7500, generation = 55, rarity = "Rare"},
    ["Tric Trac Baraboom"] = {price = 9000, generation = 65, rarity = "Rare"},
    ["Bandito Bobritto"] = {price = 4500, generation = 35, rarity = "Rare"},
    ["Cacto Hipopotamo"] = {price = 6500, generation = 50, rarity = "Rare"},
    ["Pipi Avocado"] = {price = 9500, generation = 70, rarity = "Rare"},
    ["Cappuccino Assassino"] = {price = 10000, generation = 75, rarity = "Epic"},
    ["Brr Brr Patapim"] = {price = 15000, generation = 100, rarity = "Epic"},
    ["Trulimero Trulicina"] = {price = 20000, generation = 125, rarity = "Epic"},
    ["Bananita Dolphinita"] = {price = 25000, generation = 150, rarity = "Epic"},
    ["Brri Brri Bicus Dicus Bombicus"] = {price = 30000, generation = 175, rarity = "Epic"},
    ["Bambini Crostini"] = {price = 22500, generation = 135, rarity = "Epic"},
    ["Perochello Lemonchello"] = {price = 27500, generation = 160, rarity = "Epic"},
    ["Avocadini Guffo"] = {price = 35000, generation = 225, rarity = "Epic"},
    ["Salamino Penguino"] = {price = 40000, generation = 250, rarity = "Epic"},
    ["Bandito Axolito"] = {price = 12500, generation = 90, rarity = "Epic"},
    ["Ti Ti Ti Sahur"] = {price = 37500, generation = 225, rarity = "Epic"},
    ["Penguino Cocosino"] = {price = 45000, generation = 300, rarity = "Epic"},
    ["Avocadini Antilopini"] = {price = 17500, generation = 115, rarity = "Epic"},
    ["Burbaloni Loliloli"] = {price = 35000, generation = 200, rarity = "Legendary"},
    ["Chimpanzini Bananini"] = {price = 50000, generation = 300, rarity = "Legendary"},
    ["Ballerina Cappuccina"] = {price = 100000, generation = 500, rarity = "Legendary"},
    ["Caramello Filtrello"] = {price = 255000, generation = 1050, rarity = "Legendary"},
    ["Chef Crabracadabra"] = {price = 150000, generation = 600, rarity = "Legendary"},
    ["Glorbo Fruttodrillo"] = {price = 200000, generation = 750, rarity = "Legendary"},
    ["Blueberrinni Octopusini"] = {price = 250000, generation = 1000, rarity = "Legendary"},
    ["Lionel Cactuseli"] = {price = 175000, generation = 650, rarity = "Legendary"},
    ["Pandaccini Bananini"] = {price = 300000, generation = 1250, rarity = "Legendary"},
    ["Strawberrelli Flamingelli"] = {price = 275000, generation = 1150, rarity = "Legendary"},
    ["Cocosini Mama"] = {price = 285000, generation = 1200, rarity = "Legendary"},
    ["Pi Pi Watermelon"] = {price = 315000, generation = 1300, rarity = "Legendary"},
    ["Sigma Boy"] = {price = 325000, generation = 1350, rarity = "Legendary"},
    ["Strawberry Elephant"] = {price = 500000000000, generation = 350000000, rarity = "OG"},
    ["Noo my examine"] = {price = 525000000, generation = 1700000, rarity = "Secret"},
    ["Yess my examine"] = {price = 130000000, generation = 575000, rarity = "Secret"},
    ["Spaghetti Tualetti"] = {price = 15000000000, generation = 60000000, rarity = "Secret"},
    ["Pipi Potato"] = {price = 265000, generation = 1100, rarity = "Legendary"},
    ["Steve"] = {price = 265000, generation = 1100, rarity = "Legendary"},
    ["Quivioli Ameleonni"] = {price = 225000, generation = 900, rarity = "Legendary"},
    ["Frigo Camelo"] = {price = 350000, generation = 1400, rarity = "Mythic"},
    ["Orangutini Ananassini"] = {price = 400000, generation = 1750, rarity = "Mythic"},
    ["Bombardiro Crocodilo"] = {price = 500000, generation = 2500, rarity = "Mythic"},
    ["Gorillo Subwoofero"] = {price = 2750000, generation = 7750, rarity = "Mythic"},
    ["Los Noobinis"] = {price = 4350000, generation = 12500, rarity = "Mythic"},
    ["Bombombini Gusini"] = {price = 1000000, generation = 5000, rarity = "Mythic"},
    ["Rhino Toasterino"] = {price = 450000, generation = 2150, rarity = "Mythic"},
    ["Cavallo Virtuoso"] = {price = 2500000, generation = 7500, rarity = "Mythic"},
    ["Spioniro Golubiro"] = {price = 750000, generation = 3500, rarity = "Mythic"},
    ["Zibra Zubra Zibralini"] = {price = 1500000, generation = 6000, rarity = "Mythic"},
    ["Tigrilini Watermelini"] = {price = 1750000, generation = 6500, rarity = "Mythic"},
    ["Gorillo Watermelondrillo"] = {price = 3000000, generation = 8000, rarity = "Mythic"},
    ["Avocadorilla"] = {price = 2000000, generation = 7000, rarity = "Mythic"},
    ["Ganganzelli Trulala"] = {price = 3750000, generation = 9000, rarity = "Mythic"},
    ["Tob Tobi Tobi"] = {price = 3250000, generation = 8500, rarity = "Mythic"},
    ["Te Te Te Sahur"] = {price = 4000000, generation = 9500, rarity = "Mythic"},
    ["Tracoducotulu Delapeladustuz"] = {price = 4250000, generation = 12000, rarity = "Mythic"},
    ["Lerulerulerule"] = {price = 3500000, generation = 8750, rarity = "Mythic"},
    ["Carloo"] = {price = 4500000, generation = 13500, rarity = "Mythic"},
    ["Carrotini Brainini"] = {price = 4750000, generation = 15000, rarity = "Mythic"},
    ["Cocofanto Elefanto"] = {price = 5000000, generation = 17500, rarity = "Brainrot God"},
    ["Cocofanto Dollari"] = {price = 10000000, generation = 97500, rarity = "Dolla"},
    ["Job Job Job Dollar"] = {price = 185000000, generation = 993500, rarity = "Dolla"},
    ["Brr es Teh DollarPum"] = {price = 95000000, generation = 53500, rarity = "Dolla"},
    ["Tralalero Tralala"] = {price = 10000000, generation = 50000, rarity = "Brainrot God"},
    ["Odin Din Din Dun"] = {price = 15000000, generation = 75000, rarity = "Brainrot God"},
    ["Belula Beluga"] = {price = 60000000, generation = 290000, rarity = "Brainrot God"},
    ["Girafa Celestre"] = {price = 7500000, generation = 20000, rarity = "Brainrot God"},
    ["Las Capuchinas"] = {price = 32500000, generation = 185000, rarity = "Brainrot God"},
    ["Trenostruzzo Turbo 3000"] = {price = 25000000, generation = 150000, rarity = "Brainrot God"},
    ["Matteo"] = {price = 10000000, generation = 50000, rarity = "Brainrot God"},
    ["Fragola La La La"] = {price = 125000000, generation = 450000, rarity = "Secret"},
    ["67"] = {price = 1250000000, generation = 7500000, rarity = "Secret"},
    ["La Karkerkar Combinasion"] = {price = 160000000, generation = 600000, rarity = "Secret"},
    ["Los Chicleteiras"] = {price = 1200000000, generation = 7000000, rarity = "Secret"},
    ["Chachechi"] = {price = 85000000, generation = 400000, rarity = "Secret"},
    ["Extinct Tralalero"] = {price = 125000000, generation = 450000, rarity = "Secret"},
    ["Extinct Ballerina"] = {price = 23500000, generation = 125000, rarity = "Brainrot God"},
    ["Extinct Matteo"] = {price = 140000000, generation = 625000, rarity = "Secret"},
    ["Las Sis"] = {price = 2500000000, generation = 17500000, rarity = "Secret"},
    ["La Extinct Grande"] = {price = 3250000000, generation = 23500000, rarity = "Secret"},
    ["La Sahur Combinasion"] = {price = 550000000, generation = 2000000, rarity = "Secret"},
    ["Malame Amarele"] = {price = 23500, generation = 140, rarity = "Epic"},
    ["Piccionetta Macchina"] = {price = 47000000, generation = 270000, rarity = "Brainrot God"},
    ["Tralaledon"] = {price = 3000000000, generation = 27500000, rarity = "Secret"},
    ["Los Bros"] = {price = 6000000000, generation = 37500000, rarity = "Secret"},
    ["Tigroligre Frutonni"] = {price = 14000000, generation = 60000, rarity = "Brainrot God"},
    ["Orcalero Orcala"] = {price = 25000000, generation = 100000, rarity = "Brainrot God"},
    ["Unclito Samito"] = {price = 20000000, generation = 75000, rarity = "Brainrot God"},
    ["Gattatino Nyanino"] = {price = 7500000, generation = 35000, rarity = "Brainrot God"},
    ["Espresso Signora"] = {price = 25000000, generation = 70000, rarity = "Brainrot God"},
    ["Ballerino Lololo"] = {price = 35000000, generation = 200000, rarity = "Brainrot God"},
    ["Piccione Macchina"] = {price = 40000000, generation = 225000, rarity = "Brainrot God"},
    ["Los Crocodillitos"] = {price = 12500000, generation = 55000, rarity = "Brainrot God"},
    ["Chihuanini Taconini"] = {price = 8500000, generation = 45000, rarity = "Brainrot God"},
    ["Gattito Tacoto"] = {price = 32500000, generation = 165000, rarity = "Brainrot God"},
    ["Los Nooo My Hotspotsitos"] = {price = 1000000000, generation = 5000000, rarity = "Secret"},
    ["Los Tipi Tacos"] = {price = 46000000, generation = 260000, rarity = "Brainrot God"},
    ["Tukanno Bananno"] = {price = 22500000, generation = 100000, rarity = "Brainrot God"},
    ["Trippi Troppi Troppa Trippa"] = {price = 30000000, generation = 175000, rarity = "Brainrot God"},
    ["Los Tungtungtungcitos"] = {price = 37500000, generation = 210000, rarity = "Brainrot God"},
    ["Agarrini la Palini"] = {price = 80000000, generation = 425000, rarity = "Brainrot God"},
    ["Bulbito Bandito Traktorito"] = {price = 35000000, generation = 205000, rarity = "Brainrot God"},
    ["DollarMini"] = {price = 35000000, generation = 205000, rarity = "Dolla"},
    ["Los Orcalitos"] = {price = 45000000, generation = 235000, rarity = "Brainrot God"},
    ["Tipi Topi Taco"] = {price = 20000000, generation = 75000, rarity = "Brainrot God"},
    ["Bombardini Tortinii"] = {price = 50000000, generation = 225000, rarity = "Brainrot God"},
    ["Tralalita Tralala"] = {price = 20000000, generation = 100000, rarity = "Brainrot God"},
    ["Urubini Flamenguini"] = {price = 30000000, generation = 150000, rarity = "Brainrot God"},
    ["Alessio"] = {price = 17500000, generation = 85000, rarity = "Brainrot God"},
    ["Pakrahmatmamat"] = {price = 37500000, generation = 215000, rarity = "Brainrot God"},
    ["Los Bombinitos"] = {price = 42500000, generation = 220000, rarity = "Brainrot God"},
    ["Brr es Teh Patipum"] = {price = 40000000, generation = 1472, rarity = "Brainrot God"},
    ["Tartaruga Cisterna"] = {price = 45000000, generation = 2500, rarity = "Brainrot God"},
    ["Cacasito Satalito"] = {price = 45000000, generation = 240000, rarity = "Brainrot God"},
    ["Mastodontico Telepiedone"] = {price = 47500000, generation = 275000, rarity = "Brainrot God"},
    ["Crabbo Limonetta"] = {price = 46000000, generation = 235000, rarity = "Brainrot God"},
    ["La Vacca Saturno Saturnita"] = {price = 50000000, generation = 300000, rarity = "Secret"},
    ["Trenostruzzo Turbo 4000"] = {price = 100000000, generation = 310000, rarity = "Secret"},
    ["Meowl"] = {price = 350000000000, generation = 275000000, rarity = "OG"},
    ["Frogato Pirato"] = {price = 39000, generation = 240, rarity = "Epic"},
    ["Pakrahmatmatina"] = {price = 40500000, generation = 225000, rarity = "Brainrot God"},
    ["Bambu Bambu Sahur"] = {price = 47500000, generation = 275000, rarity = "Brainrot God"},
    ["Krupuk Pagi Pagi"] = {price = 60000000, generation = 290000, rarity = "Brainrot God"},
    ["Boatito Auratito"] = {price = 115000000, generation = 525000, rarity = "Secret"},
    ["Horegini Boom"] = {price = 650000000, generation = 2700000, rarity = "Secret"},
    ["Rang Ring Bus"] = {price = 1100000000, generation = 6000000, rarity = "Secret"},
    ["La Grande Combinasion"] = {price = 100000000, generation = 10000000, rarity = "Secret"},
    ["Graipuss Medussi"] = {price = 250000000, generation = 1000000, rarity = "Secret"},
    ["Tacorita Bicicleta"] = {price = 2200000000, generation = 16500000, rarity = "Secret"},
    ["Nuclearo Dinossauro"] = {price = 2500000000, generation = 15000000, rarity = "Secret"},
    ["Money Money Puggy"] = {price = 2600000000, generation = 21000000, rarity = "Secret"},
    ["Chillin Chili"] = {price = 3000000000, generation = 350000000, rarity = "Secret"},
    ["Los Tacoritas"] = {price = 4000000000, generation = 32000000, rarity = "Secret"},
    ["Tang Tang Keletang"] = {price = 4500000000, generation = 33500000, rarity = "Secret"},
    ["Los Combinasionas"] = {price = 2000000000, generation = 15000000, rarity = "Secret"},
    ["Esok Sekolah"] = {price = 750000000, generation = 30000000, rarity = "Secret"},
    ["Los Mobilis"] = {price = 2700000000, generation = 22000000, rarity = "Secret"},
    ["Eviledon"] = {price = 3800000000, generation = 31500000, rarity = "Secret"},
    ["Spooky And Pumpky"] = {price = 25000000000, generation = 80000000, rarity = "Secret"},
    ["Los Spooky Combinasionas"] = {price = 3000000000, generation = 20000000, rarity = "Secret"},
    ["La Spooky Grande"] = {price = 2900000000, generation = 20000000, rarity = "Secret"},
    ["Tictac Sahur"] = {price = 6000000000, generation = 37500000, rarity = "Secret"},
    ["Mariachi Corazoni"] = {price = 1700000000, generation = 12500000, rarity = "Secret"},
    ["Chicleteira Bicicleteira"] = {price = 750000000, generation = 3500000, rarity = "Secret"},
    ["Burguro And Fryuro"] = {price = 75000000000, generation = 150000000, rarity = "Secret"},
    ["Ketupat Kepat"] = {price = 5000000000, generation = 35000000, rarity = "Secret"},
    ["Dragon Cannelloni"] = {price =200000000000, generation = 200000000, rarity = "Secret"},
    ["Capitano Moby"] = {price = 125000000000, generation = 160000000, rarity = "Secret"},
    ["La Taco Combinasion"] = {price = 5000000000, generation = 35000000, rarity = "Secret"},
    ["Chicleteirina Bicicleteirina"] = {price = 850000000, generation = 4000000, rarity = "Secret"},
    ["La Secret Combinasion"] = {price = 50000000000, generation = 125000000, rarity = "Secret"},
    ["Fragrama and Chocrama"] = {price = 40000000000, generation = 100000000, rarity = "Secret"},
    ["Los Spaghettis"] = {price = 20000000000, generation = 70000000, rarity = "Secret"},
    ["Los Puggies"] = {price = 3000000000, generation = 30000000, rarity = "Secret"},
    ["Pirulitoita Bicicleteira"] = {price = 600000000, generation = 2500000, rarity = "Secret"},
    ["Chipso And Queso"] = {price = 2500000000, generation = 25000000, rarity = "Secret"},
    ["Los 67"] = {price = 2700000000, generation = 22500000, rarity = "Secret"},
    ["Mieteteira Bicicleteira"] = {price = 2700000000, generation = 26000000, rarity = "Secret"}
    
}


local AUTO_COOLDOWN = 0.5 -- segundos entre compras

-- Estado
local AutoBuyEnabled = false
local lastBuy = 0

--=========================
-- CREAR UI
--=========================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoBuyGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 60)
Frame.Position = UDim2.new(0.05, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1,0,1,0)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Text = "AutoBuy: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 20
ToggleButton.Parent = Frame

--=========================
-- BOTÓN ON/OFF
--=========================
ToggleButton.MouseButton1Click:Connect(function()
    AutoBuyEnabled = not AutoBuyEnabled
    if AutoBuyEnabled then
        ToggleButton.Text = "AutoBuy: ON"
        Frame.BackgroundColor3 = Color3.fromRGB(30, 150, 30)
    else
        ToggleButton.Text = "AutoBuy: OFF"
        Frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    end
end)

--=========================
-- DRAG (PC + MÓVIL)
--=========================
local Dragging = false
local DragStart, StartPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if Dragging then
            local delta = input.Position - DragStart
            Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X,
                                       StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
        end
    end
end)

--=========================
-- LOOP AUTO BUY
--=========================
RunService.Heartbeat:Connect(function(deltaTime)
    if AutoBuyEnabled then
        lastBuy = lastBuy + deltaTime
        if lastBuy >= AUTO_COOLDOWN then
            lastBuy = 0
            for _, item in ipairs(Brainrots) do
                BuyEvent:FireServer(item)
            end
        end
    end
end)

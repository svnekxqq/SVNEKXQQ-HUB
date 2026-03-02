-- ========================
-- SERVICES & PLAYER
-- ========================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer

-- ========================
-- PORNHUB LOADING SCREEN
-- (runs BEFORE WindUI loads so GUI can't appear behind it)
-- ========================

local loadingDone = false

local sg = Instance.new("ScreenGui")
sg.Name = "PornHubLoader"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 9999
sg.Parent = Player:WaitForChild("PlayerGui")

-- full-screen invisible button that eats ALL clicks
local blocker = Instance.new("TextButton")
blocker.Size = UDim2.new(1, 0, 1, 0)
blocker.BackgroundTransparency = 1
blocker.BorderSizePixel = 0
blocker.Text = ""
blocker.AutoButtonColor = false
blocker.ZIndex = 1
blocker.Parent = sg

-- phone frame
local phone = Instance.new("Frame")
phone.Size = UDim2.new(0, 220, 0, 390)
phone.Position = UDim2.new(0.5, -110, 0.5, -195)
phone.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
phone.BorderSizePixel = 0
phone.ZIndex = 2
phone.Parent = sg

Instance.new("UICorner", phone).CornerRadius = UDim.new(0, 28)
local phoneStroke = Instance.new("UIStroke", phone)
phoneStroke.Color = Color3.fromRGB(55, 55, 55)
phoneStroke.Thickness = 2

-- notch
local notch = Instance.new("Frame", phone)
notch.Size = UDim2.new(0, 70, 0, 18)
notch.Position = UDim2.new(0.5, -35, 0, 10)
notch.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notch.BorderSizePixel = 0
notch.ZIndex = 4
Instance.new("UICorner", notch).CornerRadius = UDim.new(0, 10)

-- screen
local screen = Instance.new("Frame", phone)
screen.Size = UDim2.new(1, -8, 1, -8)
screen.Position = UDim2.new(0, 4, 0, 4)
screen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
screen.BorderSizePixel = 0
screen.ClipsDescendants = true
screen.ZIndex = 3
Instance.new("UICorner", screen).CornerRadius = UDim.new(0, 24)

-- GAYHUB text
local logo = Instance.new("TextLabel", screen)
logo.Size = UDim2.new(1, -20, 0, 50)
logo.Position = UDim2.new(0, 10, 0, 100)
logo.BackgroundTransparency = 1
logo.Text = "GAYHUB"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.TextSize = 32
logo.Font = Enum.Font.GothamBold
logo.TextXAlignment = Enum.TextXAlignment.Center
logo.ZIndex = 4

-- orange line
local accent = Instance.new("Frame", screen)
accent.Size = UDim2.new(0.7, 0, 0, 2)
accent.Position = UDim2.new(0.15, 0, 0, 154)
accent.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
accent.BorderSizePixel = 0
accent.ZIndex = 4
Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 2)

-- subtitle
local sub = Instance.new("TextLabel", screen)
sub.Size = UDim2.new(1, -20, 0, 30)
sub.Position = UDim2.new(0, 10, 0, 163)
sub.BackgroundTransparency = 1
sub.Text = "Loading Gay PornHub..."
sub.TextColor3 = Color3.fromRGB(140, 140, 140)
sub.TextSize = 11
sub.Font = Enum.Font.Gotham
sub.TextXAlignment = Enum.TextXAlignment.Center
sub.ZIndex = 4

-- bar background
local barBg = Instance.new("Frame", screen)
barBg.Size = UDim2.new(1, -30, 0, 8)
barBg.Position = UDim2.new(0, 15, 0, 205)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barBg.BorderSizePixel = 0
barBg.ZIndex = 4
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 4)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
bar.BorderSizePixel = 0
bar.ZIndex = 5
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)

-- percent label
local pct = Instance.new("TextLabel", screen)
pct.Size = UDim2.new(1, -30, 0, 20)
pct.Position = UDim2.new(0, 15, 0, 218)
pct.BackgroundTransparency = 1
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(255, 153, 0)
pct.TextSize = 11
pct.Font = Enum.Font.GothamBold
pct.TextXAlignment = Enum.TextXAlignment.Center
pct.ZIndex = 4

-- home indicator
local homeBar = Instance.new("Frame", screen)
homeBar.Size = UDim2.new(0, 60, 0, 4)
homeBar.Position = UDim2.new(0.5, -30, 1, -18)
homeBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
homeBar.BorderSizePixel = 0
homeBar.ZIndex = 4
Instance.new("UICorner", homeBar).CornerRadius = UDim.new(0, 2)

-- animate loading bar
local loadDuration = 3
local loadElapsed = 0
local loadConn
loadConn = RunService.Heartbeat:Connect(function(dt)
    loadElapsed = loadElapsed + dt
    local p = math.min(loadElapsed / loadDuration, 1)
    bar.Size = UDim2.new(p, 0, 1, 0)
    pct.Text = math.floor(p * 100) .. "%"

    if p >= 1 then
        loadConn:Disconnect()
        task.wait(0.1)
        -- smooth fade out
        for i = 1, 10 do
            local tr = i / 10
            phone.BackgroundTransparency = tr
            screen.BackgroundTransparency = tr
            notch.BackgroundTransparency = tr
            logo.TextTransparency = tr
            sub.TextTransparency = tr
            pct.TextTransparency = tr
            accent.BackgroundTransparency = tr
            bar.BackgroundTransparency = tr
            barBg.BackgroundTransparency = tr
            homeBar.BackgroundTransparency = tr
            phoneStroke.Transparency = tr
            task.wait(0.02)
        end
        sg:Destroy()
        loadingDone = true
    end
end)

-- ========================
-- WAIT FOR LOADING BEFORE WINDUI
-- ========================

local WindUI
task.spawn(function()
    WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

repeat task.wait(0.05) until loadingDone
repeat task.wait(0.05) until WindUI ~= nil

-- ========================
-- WINDUI SETUP
-- ========================

local Window = WindUI:CreateWindow({
    Title = "SVNEKXQQ HUB",
    Icon = "rbxassetid://122908851160756",
    Author = "by svnekxqq",
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "house",
    Locked = false,
})

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local DEFAULT_SPEED = 16

-- ========================
-- NOCLIP SYSTEM
-- ========================

local noclipEnabled = false
local noclipConnection = nil
local noclipKey = Enum.KeyCode.N

local function setNoclip(state)
    noclipEnabled = state
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        task.defer(function()
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end

-- ========================
-- FLY SYSTEM
-- ========================

local flyEnabled = false
local flyKey = Enum.KeyCode.F
local flyConnection = nil
local flyBodyVelocity = nil
local flyBodyGyro = nil
local FLY_SPEED = 50

local function cleanFlyObjects()
    if flyBodyVelocity then
        pcall(function() flyBodyVelocity:Destroy() end)
        flyBodyVelocity = nil
    end
    if flyBodyGyro then
        pcall(function() flyBodyGyro:Destroy() end)
        flyBodyGyro = nil
    end
end

local function setFly(state)
    flyEnabled = state
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    cleanFlyObjects()
    if Humanoid then
        Humanoid.PlatformStand = false
        Humanoid.AutoRotate = true
    end
    if not state then return end

    local rootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    flyBodyVelocity.Parent = rootPart

    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    flyBodyGyro.P = 1e4
    flyBodyGyro.D = 50
    flyBodyGyro.CFrame = rootPart.CFrame
    flyBodyGyro.Parent = rootPart

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled then
            flyConnection:Disconnect()
            flyConnection = nil
            cleanFlyObjects()
            if Humanoid then
                Humanoid.PlatformStand = false
                Humanoid.AutoRotate = true
            end
            return
        end
        local rp = Character and Character:FindFirstChild("HumanoidRootPart")
        if not rp then return end
        local camera = workspace.CurrentCamera
        if not camera then return end

        local moveDir = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end

        if flyBodyVelocity and flyBodyVelocity.Parent then flyBodyVelocity.Velocity = moveDir * FLY_SPEED end
        if flyBodyGyro and flyBodyGyro.Parent then flyBodyGyro.CFrame = camera.CFrame end
    end)
end

-- ========================
-- ESP SYSTEM
-- ========================

local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local espBoxes = {}

local function removeESP(player)
    if espBoxes[player] then
        for _, obj in pairs(espBoxes[player]) do pcall(function() obj:Destroy() end) end
        espBoxes[player] = nil
    end
end

local function createESP(player)
    if player == Player then return end
    removeESP(player)
    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = espColor
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    local char = player.Character
    if char then highlight.Parent = char end
    espBoxes[player] = { highlight = highlight }
    player.CharacterAdded:Connect(function(newChar)
        if espEnabled then highlight.Parent = newChar end
    end)
end

local function refreshESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            if espEnabled then createESP(player) else removeESP(player) end
        end
    end
end

local function updateESPColor()
    for _, player in ipairs(Players:GetPlayers()) do
        if espBoxes[player] and espBoxes[player].highlight then
            espBoxes[player].highlight.OutlineColor = espColor
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        player.CharacterAdded:Connect(function() task.wait(0.5) createESP(player) end)
    end
end)
Players.PlayerRemoving:Connect(function(player) removeESP(player) end)

-- ========================
-- ANTI-AFK SYSTEM
-- ========================

local antiAfkEnabled = false
local antiAfkThread = nil

local function setAntiAfk(state)
    antiAfkEnabled = state
    if antiAfkThread then
        task.cancel(antiAfkThread)
        antiAfkThread = nil
    end
    if not state then return end

    antiAfkThread = task.spawn(function()
        while antiAfkEnabled do
            task.wait(60)
            if not antiAfkEnabled then break end
            pcall(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.1)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
            pcall(function()
                local char = Player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then hum.Jump = true end
            end)
        end
    end)
end

-- ========================
-- BASEPLATE SYSTEM
-- ========================

local baseplateColor = Color3.fromRGB(0, 120, 255)
local baseplateInstance = nil

local function setBaseplate(state)
    if state then
        if baseplateInstance and baseplateInstance.Parent then return end

        -- Use the player's current ground Y as reference
        local groundY = 0
        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if root and hum then
            -- Bottom of the player's feet = root Y - half humanoid height
            groundY = root.Position.Y - (hum.HipHeight + 2)
        end

        local bp = Instance.new("Part")
        bp.Name = "CustomBaseplate"
        bp.Size = Vector3.new(4096, 1, 4096)
        bp.Position = Vector3.new(0, groundY, 0)
        bp.Anchored = true
        bp.Locked = true
        bp.CanCollide = true
        bp.Material = Enum.Material.Glass
        bp.Color = baseplateColor
        bp.Transparency = 0.5
        bp.CastShadow = false
        bp.Parent = workspace
        baseplateInstance = bp
    else
        if baseplateInstance then
            pcall(function() baseplateInstance:Destroy() end)
            baseplateInstance = nil
        end
    end
end

local function updateBaseplateColor(color)
    baseplateColor = color
    if baseplateInstance and baseplateInstance.Parent then
        baseplateInstance.Color = color
        baseplateInstance.Transparency = 0.5
    end
end

-- ========================
-- HELPER: show/hide WindUI element
-- ========================

local function setVisible(element, visible)
    if not element then return end
    local frame = rawget(element, "Frame") or rawget(element, "Container") or rawget(element, "Object")
    if frame and frame:IsA("GuiObject") then
        frame.Visible = visible
    else
        for _, v in pairs(element) do
            if typeof(v) == "Instance" and v:IsA("GuiObject") then
                v.Visible = visible
                break
            end
        end
    end
end

-- ========================
-- GUI TOGGLE & KEYBINDS
-- ========================

local guiToggleKey = Enum.KeyCode.RightShift
local noclipKey = Enum.KeyCode.N
local flyKey = Enum.KeyCode.F

-- Forward declare GUI elements used in keybind handler
local NoclipToggle, NoclipKeybind
local FlyToggle, FlyKeybind, FlySpeedSlider
local ESPColorpicker
local BaseplateColorpicker

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == noclipKey then
        noclipEnabled = not noclipEnabled
        NoclipToggle:Set(noclipEnabled)
        setNoclip(noclipEnabled)
        setVisible(NoclipKeybind, noclipEnabled)
    end
    if input.KeyCode == flyKey then
        flyEnabled = not flyEnabled
        FlyToggle:Set(flyEnabled)
        setFly(flyEnabled)
        setVisible(FlyKeybind, flyEnabled)
        setVisible(FlySpeedSlider, flyEnabled)
    end
end)

-- ========================
-- SECTION: Player
-- ========================

local PlayerSection = Tab:Section({ Title = "Player", Box = false, TextXAlignment = "Left", Opened = true })

local Slider = PlayerSection:Slider({
    Title = "WalkSpeed", Desc = "Player walk speed (max 700)", Step = 1,
    Value = { Min = 16, Max = 700, Default = 16 },
    Callback = function(value) if Humanoid then Humanoid.WalkSpeed = value end end
})

PlayerSection:Button({
    Title = "Reset WalkSpeed", Desc = "Reset to default speed (16)", Locked = false,
    Callback = function()
        if Humanoid then Humanoid.WalkSpeed = DEFAULT_SPEED Slider:Set(DEFAULT_SPEED) end
    end
})


NoclipToggle = PlayerSection:Toggle({
    Title = "Noclip", Desc = "Walk through walls", Icon = "ghost", Type = "Checkbox", Value = false,
    Callback = function(state) setNoclip(state) setVisible(NoclipKeybind, state) end
})

NoclipKeybind = PlayerSection:Keybind({
    Title = "Noclip Keybind", Desc = "Key to toggle noclip", Value = "N",
    Callback = function(v) noclipKey = Enum.KeyCode[v] end
})


FlyToggle = PlayerSection:Toggle({
    Title = "Fly", Desc = "Fly around (WASD)", Icon = "plane", Type = "Checkbox", Value = false,
    Callback = function(state) setFly(state) setVisible(FlyKeybind, state) setVisible(FlySpeedSlider, state) end
})

FlyKeybind = PlayerSection:Keybind({
    Title = "Fly Keybind", Desc = "Key to toggle fly", Value = "F",
    Callback = function(v) flyKey = Enum.KeyCode[v] end
})

FlySpeedSlider = PlayerSection:Slider({
    Title = "Fly Speed", Desc = "Flight speed (max 500)", Step = 1,
    Value = { Min = 10, Max = 500, Default = 50 },
    Callback = function(value) FLY_SPEED = value end
})


local ESPToggle = PlayerSection:Toggle({
    Title = "ESP", Desc = "Show player outlines through walls", Icon = "eye", Type = "Checkbox", Value = false,
    Callback = function(state) espEnabled = state refreshESP() setVisible(ESPColorpicker, state) end
})

ESPColorpicker = PlayerSection:Colorpicker({
    Title = "ESP Color", Desc = "Color of player outlines",
    Default = Color3.fromRGB(255, 0, 0), Transparency = 0, Locked = false,
    Callback = function(color) espColor = color updateESPColor() end
})


-- ANTIVOID
local antivoidEnabled = false
local antivoidConnection = nil
local antivoidLastSafePos = nil
local antivoidRescuing = false

local function findSafeGroundCFrame(fallbackCFrame)
    -- Raycast straight down from the saved safe position to find exact floor Y
    local origin = fallbackCFrame.Position + Vector3.new(0, 50, 0)
    local direction = Vector3.new(0, -200, 0)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    -- Exclude the player character
    local char = Player.Character
    if char then rayParams.FilterDescendantsInstances = {char} end

    local result = workspace:Raycast(origin, direction, rayParams)
    if result then
        -- Land 3 studs above the hit surface
        return CFrame.new(result.Position + Vector3.new(0, 3, 0))
    end
    return fallbackCFrame + Vector3.new(0, 5, 0)
end

local function setAntivoid(state)
    antivoidEnabled = state
    if antivoidConnection then
        antivoidConnection:Disconnect()
        antivoidConnection = nil
    end
    antivoidLastSafePos = nil
    antivoidRescuing = false
    if not state then return end

    antivoidConnection = RunService.Heartbeat:Connect(function()
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end

        -- Continuously save safe position when on solid ground
        if hum.FloorMaterial ~= Enum.Material.Air and hum.Health > 0 then
            antivoidLastSafePos = root.CFrame
            antivoidRescuing = false
        end

        -- Rescue when falling below -10 studs (early trigger)
        if root.Position.Y < -10 and not antivoidRescuing then
            antivoidRescuing = true

            local targetCFrame
            if antivoidLastSafePos then
                targetCFrame = findSafeGroundCFrame(antivoidLastSafePos)
            else
                local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
                targetCFrame = spawn and (spawn.CFrame + Vector3.new(0, 5, 0)) or CFrame.new(0, 10, 0)
            end

            -- Apply teleport + velocity kill for several frames
            task.spawn(function()
                for _ = 1, 8 do
                    if root and root.Parent then
                        root.AssemblyLinearVelocity = Vector3.zero
                        root.AssemblyAngularVelocity = Vector3.zero
                        root.CFrame = targetCFrame
                    end
                    task.wait()
                end
                antivoidRescuing = false
            end)
        end
    end)
end

PlayerSection:Toggle({
    Title = "Anti Void",
    Desc = "Prevents falling into the void",
    Icon = "shield",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) setAntivoid(state) end
})

-- ANTIFLING
local antiflingEnabled = false
local antiflingConnection = nil

local function setAntifling(state)
    antiflingEnabled = state
    if antiflingConnection then
        antiflingConnection:Disconnect()
        antiflingConnection = nil
    end
    if not state then
        local char = Player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        return
    end
    antiflingConnection = RunService.Stepped:Connect(function()
        local char = Player.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

PlayerSection:Toggle({
    Title = "Anti Fling",
    Desc = "Disables collision so nobody can fling you",
    Icon = "zap-off",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) setAntifling(state) end
})


-- ANTI-AFK TOGGLE (enabled by default)
local AntiAfkToggle = PlayerSection:Toggle({
    Title = "Anti AFK",
    Desc = "Prevents getting kicked after 20 minutes",
    Icon = "timer",
    Type = "Checkbox",
    Value = true,
    Callback = function(state) setAntiAfk(state) end
})

setAntiAfk(true)

task.defer(function()
    setVisible(NoclipKeybind, false)
    setVisible(FlyKeybind, false)
    setVisible(FlySpeedSlider, false)
    setVisible(ESPColorpicker, false)
    setVisible(BaseplateColorpicker, false)
end)

-- ========================
-- SECTION: Tools
-- ========================

local ToolsSection = Tab:Section({ Title = "Tools", Box = false, TextXAlignment = "Left", Opened = true })

ToolsSection:Button({
    Title = "Infinite Yield", Desc = "Open Infinite Yield exploit console", Icon = "terminal", Locked = false,
    Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end
})

-- ========================
-- SECTION: Others
-- ========================

local OthersSection = Tab:Section({ Title = "Others", Box = false, TextXAlignment = "Left", Opened = true })

OthersSection:Button({
    Title = "Emotes", Desc = "Open Emotes GUI", Locked = false,
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))() end
})


OthersSection:Toggle({
    Title = "Baseplate", Desc = "Spawns a giant baseplate below the map", Icon = "square", Type = "Checkbox", Value = false,
    Callback = function(state)
        setBaseplate(state)
        setVisible(BaseplateColorpicker, state)
    end
})

BaseplateColorpicker = OthersSection:Colorpicker({
    Title = "Baseplate Color", Desc = "Change the color of the baseplate",
    Default = Color3.fromRGB(0, 120, 255), Transparency = 0, Locked = false,
    Callback = function(color) updateBaseplateColor(color) end
})

-- ========================
-- RESPAWN
-- ========================

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    Humanoid.WalkSpeed = DEFAULT_SPEED
    Slider:Set(DEFAULT_SPEED)

    noclipEnabled = false NoclipToggle:Set(false) setVisible(NoclipKeybind, false)
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end

    flyEnabled = false FlyToggle:Set(false) setVisible(FlyKeybind, false) setVisible(FlySpeedSlider, false)
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    cleanFlyObjects()
    Humanoid.PlatformStand = false
    Humanoid.AutoRotate = true

    if antivoidConnection then antivoidConnection:Disconnect() antivoidConnection = nil end
    if antiflingConnection then antiflingConnection:Disconnect() antiflingConnection = nil end

    if antiAfkEnabled then
        if antiAfkThread then task.cancel(antiAfkThread) antiAfkThread = nil end
        setAntiAfk(true)
    end
end)

-- ========================
-- TAB: Settings
-- ========================

local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
local UISection = SettingsTab:Section({ Title = "Interface", Box = false, TextXAlignment = "Left", Opened = true })

UISection:Keybind({
    Title = "Toggle GUI", Desc = "Key to show/hide the GUI", Value = "RightShift",
    Callback = function(v)
        guiToggleKey = Enum.KeyCode[v]
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

UISection:Dropdown({
    Title = "Theme", Desc = "Change the GUI color theme",
    Values = {"Dark", "Light", "Midnight", "Ocean", "Rose"},
    Value = 1,
    Callback = function(value)
        pcall(function() WindUI:SetTheme(value) end)
    end
})


-- ========================
-- CONFIG SYSTEM
-- ========================

local HttpService = game:GetService("HttpService")
local CONFIG_FOLDER = "svnekxqq_hub"
if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end

local function getConfig()
    return {
        walkSpeed = Humanoid and Humanoid.WalkSpeed or DEFAULT_SPEED,
        noclip = noclipEnabled,
        noclipKey = tostring(noclipKey):gsub("Enum.KeyCode.", ""),
        fly = flyEnabled,
        flyKey = tostring(flyKey):gsub("Enum.KeyCode.", ""),
        flySpeed = FLY_SPEED,
        antiAfk = antiAfkEnabled,
    }
end

local function saveConfig(name)
    writefile(CONFIG_FOLDER .. "/" .. name .. ".json", HttpService:JSONEncode(getConfig()))
end

local function loadConfig(name)
    local path = CONFIG_FOLDER .. "/" .. name .. ".json"
    if not isfile(path) then return end
    local ok, decoded = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok or not decoded then return end
    if decoded.walkSpeed then Humanoid.WalkSpeed = decoded.walkSpeed Slider:Set(decoded.walkSpeed) end
    if decoded.noclip ~= nil then
        noclipEnabled = decoded.noclip NoclipToggle:Set(decoded.noclip) setNoclip(decoded.noclip) setVisible(NoclipKeybind, decoded.noclip)
    end
    if decoded.fly ~= nil then
        flyEnabled = decoded.fly FlyToggle:Set(decoded.fly) setFly(decoded.fly)
        setVisible(FlyKeybind, decoded.fly) setVisible(FlySpeedSlider, decoded.fly)
    end
    if decoded.flySpeed then FLY_SPEED = decoded.flySpeed FlySpeedSlider:Set(decoded.flySpeed) end
    if decoded.antiAfk ~= nil then
        AntiAfkToggle:Set(decoded.antiAfk) setAntiAfk(decoded.antiAfk)
    end
end

local function deleteConfig(name)
    local path = CONFIG_FOLDER .. "/" .. name .. ".json"
    if isfile(path) then delfile(path) end
end

local function getConfigList()
    local list = {}
    if isfolder(CONFIG_FOLDER) then
        for _, path in ipairs(listfiles(CONFIG_FOLDER)) do
            local name = path:match("([^/\\]+)%.json$")
            if name then table.insert(list, name) end
        end
    end
    return list
end

local ConfigSection = SettingsTab:Section({ Title = "Config", Box = false, TextXAlignment = "Left", Opened = true })

local configInputValue = "default"
local ConfigInput = ConfigSection:Input({
    Title = "Config Name", Desc = "Enter config name", Value = "default", Placeholder = "Enter name...",
    Callback = function(v) if v and v ~= "" then configInputValue = v end end
})

local selectedConfig = "default"
local function buildConfigList()
    local list = getConfigList()
    if #list == 0 then list = {"No configs"} end
    return list
end

local ConfigDropdown = ConfigSection:Dropdown({
    Title = "Select Config", Desc = "List of saved configs",
    Values = buildConfigList(), Value = 1,
    Callback = function(value)
        if value ~= "No configs" then
            selectedConfig = value configInputValue = value ConfigInput:Set(value)
        end
    end
})


local autoloadEnabled = false
ConfigSection:Toggle({
    Title = "Autoload", Desc = "Automatically load last config on start", Type = "Checkbox", Value = false,
    Callback = function(state)
        autoloadEnabled = state
        if state and selectedConfig ~= "default" and selectedConfig ~= "No configs" then
            saveConfig("_autoload_last")
        end
    end
})


ConfigSection:Button({ Title = "Refresh List", Desc = "Refresh the saved configs list", Locked = false,
    Callback = function() ConfigDropdown:Refresh(buildConfigList()) end })

ConfigSection:Button({ Title = "Save Config", Desc = "Save current settings", Locked = false,
    Callback = function()
        local name = configInputValue
        if name and name ~= "" and name ~= "No configs" then
            saveConfig(name)
            if autoloadEnabled then saveConfig("_autoload_last") end
            ConfigDropdown:Refresh(buildConfigList())
        end
    end })

ConfigSection:Button({ Title = "Load Config", Desc = "Load selected config", Locked = false,
    Callback = function() loadConfig(selectedConfig or configInputValue or "default") end })

ConfigSection:Button({ Title = "Delete Config", Desc = "Delete selected config", Locked = false,
    Callback = function()
        local name = selectedConfig or configInputValue or "default"
        deleteConfig(name)
        selectedConfig = "default" configInputValue = "default"
        ConfigDropdown:Refresh(buildConfigList())
    end })

if isfile(CONFIG_FOLDER .. "/_autoload_last.json") then
    pcall(function() loadConfig("_autoload_last") end)
end

-- ========================
-- SET TOGGLE KEY
-- (must be called LAST, after entire UI is built)
-- ========================

Window:SetToggleKey(Enum.KeyCode.RightShift)

-- ========================
-- SHUTDOWN ON GUI CLOSE (X button)
-- ========================

local function shutdownAll()
    -- Noclip off
    noclipEnabled = false
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    pcall(function()
        if Character then
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end)

    -- Fly off
    flyEnabled = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    cleanFlyObjects()
    if Humanoid then Humanoid.PlatformStand = false Humanoid.AutoRotate = true end

    -- ESP off
    espEnabled = false
    for _, player in ipairs(Players:GetPlayers()) do removeESP(player) end

    -- Anti AFK off
    antiAfkEnabled = false
    if antiAfkThread then task.cancel(antiAfkThread) antiAfkThread = nil end

    -- Anti Void off
    antivoidEnabled = false
    if antivoidConnection then antivoidConnection:Disconnect() antivoidConnection = nil end

    -- Anti Fling off
    antiflingEnabled = false
    if antiflingConnection then antiflingConnection:Disconnect() antiflingConnection = nil end
    pcall(function()
        if Character then
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end)

    -- Baseplate off
    if baseplateInstance then
        pcall(function() baseplateInstance:Destroy() end)
        baseplateInstance = nil
    end

    -- Reset walkspeed
    if Humanoid then Humanoid.WalkSpeed = DEFAULT_SPEED end
end

-- WindUI fires this event when the X close button is clicked
if Window.OnClose then
    Window.OnClose:Connect(shutdownAll)
elseif Window.Closed then
    Window.Closed:Connect(shutdownAll)
end
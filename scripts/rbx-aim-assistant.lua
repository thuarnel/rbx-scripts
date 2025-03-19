--!nocheck
--!nolint UnknownGlobal

--- made by thuarnel
--- @diagnostic disable: undefined-global

local env = type(getgenv) == 'function' and getgenv() or getfenv()

--- Closes an existing aim assistant instance. This function may not be available if the script has not been loaded previously.
--- @type function
local stop_aim_assistant = rawget(env, 'stop_aim_assistant')

if type(stop_aim_assistant) == 'function' then
    print('Stopping the previous instance of Aim Assistant...')
    pcall(stop_aim_assistant)
end

assert(type(env) == 'table', 'aim-assistant.lua: failed to get environment')

--- Appends a new value to the given table.
--- @type function
local insert = rawget(table, 'insert')

assert(type(insert) == 'function', 'aim-assistant.lua: failed to get insert')
assert(_VERSION == 'Luau', 'aim-assistant.lua: failed to get _VERSION')

local instances = {}
local connections = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    insert(connections, connection)
    return connection
end

local getserv = game.GetService
local sercach = {}
local fromser = function(self, i)
    local service = sercach[i]
    if not service then
        service = getserv(game, i)
        sercach[i] = service
    end
    return service
end
local service = setmetatable({}, { __index = fromser, __call = fromser })

local players = service("Players")
local coregui = service("CoreGui")

local ui = Instance.new("ScreenGui")
ui.Name = "Aim Assistant [2.1.0]"
ui.ResetOnSpawn = false
ui.Enabled = true
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
insert(instances, ui)

local ui_frame = Instance.new("Frame")
ui_frame.Name = "MainFrame"
ui_frame.AnchorPoint = Vector2.new(0.5, 0)
ui_frame.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
ui_frame.Position = UDim2.new(0.5, 0, 0, 10)
ui_frame.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
ui_frame.BorderSizePixel = 3
ui_frame.Size = UDim2.new(0, 300, 0, 140)
ui_frame.Parent = ui

local ui_topbar = Instance.new("Frame")
ui_topbar.Name = "TopBar"
ui_topbar.BackgroundColor3 = Color3.new(0.125, 0.125, 0.125)
ui_topbar.BorderColor3 = Color3.new(0.176, 0.176, 0.176)
ui_topbar.BorderSizePixel = 0
ui_topbar.Size = UDim2.new(1, 0, 0, 25)
ui_topbar.Parent = ui_frame

local topBarLabel = Instance.new("TextLabel")
topBarLabel.Name = "TopBarLabel"
topBarLabel.FontFace = Font.new(
    "rbxasset://fonts/families/GothamSSm.json",
    Enum.FontWeight.Medium,
    Enum.FontStyle.Normal
)
topBarLabel.TextColor3 = Color3.new(1, 1, 1)
topBarLabel.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
topBarLabel.Text = "Aim Assistant"
topBarLabel.AnchorPoint = Vector2.new(0.5, 0.5)
topBarLabel.BackgroundTransparency = 1
topBarLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
topBarLabel.BackgroundColor3 = Color3.new(1, 1, 1)
topBarLabel.TextSize = 20
topBarLabel.Size = UDim2.new(1, 0, 1, 0)
topBarLabel.Parent = ui_topbar

local ui_domainlabel = Instance.new("TextLabel")
ui_domainlabel.Name = "DomainLabel"
ui_domainlabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
ui_domainlabel.TextColor3 = Color3.new(1, 1, 1)
ui_domainlabel.TextTransparency = 0.8
ui_domainlabel.Text = "(c) 2025 thuarnel"
ui_domainlabel.BackgroundColor3 = Color3.new(1, 1, 1)
ui_domainlabel.AnchorPoint = Vector2.new(0.5, 1)
ui_domainlabel.BackgroundTransparency = 1
ui_domainlabel.Position = UDim2.new(0.5, 0, 1, -5)
ui_domainlabel.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_domainlabel.TextYAlignment = Enum.TextYAlignment.Bottom
ui_domainlabel.TextSize = 17
ui_domainlabel.Size = UDim2.new(0, 125, 0, 17)
ui_domainlabel.Parent = ui_frame

local ui_versionlabel = Instance.new("TextLabel")
ui_versionlabel.Name = "TextLabel"
ui_versionlabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
ui_versionlabel.TextColor3 = Color3.new(1, 1, 1)
ui_versionlabel.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_versionlabel.Text = "[2.1.0]"
ui_versionlabel.BackgroundColor3 = Color3.new(1, 1, 1)
ui_versionlabel.TextTransparency = 0.8
ui_versionlabel.AnchorPoint = Vector2.new(1, 0)
ui_versionlabel.Position = UDim2.new(1, 0, 0, 0)
ui_versionlabel.BackgroundTransparency = 1
ui_versionlabel.TextXAlignment = Enum.TextXAlignment.Right
ui_versionlabel.TextYAlignment = Enum.TextYAlignment.Bottom
ui_versionlabel.TextSize = 14
ui_versionlabel.Size = UDim2.new(0, 100, 0, 15)
ui_versionlabel.Parent = ui_frame

local ui_content = Instance.new("Frame")
ui_content.Name = "Content"
ui_content.BackgroundTransparency = 1
ui_content.Position = UDim2.new(0, 0, 0, 25)
ui_content.BackgroundColor3 = Color3.new(1, 1, 1)
ui_content.BorderColor3 = Color3.new(0.176, 0.176, 0.176)
ui_content.Size = UDim2.new(1, 0, 1, -25)
ui_content.Parent = ui_frame

local ui_aimcontroller = Instance.new("Frame")
ui_aimcontroller.Name = "AimbotController"
ui_aimcontroller.BackgroundTransparency = 1
ui_aimcontroller.Position = UDim2.new(0, 10, 0, 10)
ui_aimcontroller.BackgroundColor3 = Color3.new(1, 1, 1)
ui_aimcontroller.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_aimcontroller.Size = UDim2.new(0, 20, 0, 20)
ui_aimcontroller.Parent = ui_content

local imageButton = Instance.new("ImageButton")
imageButton.Name = "ImageButton"
imageButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
imageButton.ImageTransparency = 1
imageButton.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
imageButton.BackgroundColor3 = Color3.new(0.157, 0.157, 0.157)
imageButton.Size = UDim2.new(1, 0, 1, 0)
imageButton.Parent = ui_aimcontroller

local textLabel_2 = Instance.new("TextLabel")
textLabel_2.Name = "TextLabel"
textLabel_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
textLabel_2.TextColor3 = Color3.new(1, 1, 1)
textLabel_2.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_2.Text = "✓"
textLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel_2.BackgroundTransparency = 1
textLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
textLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_2.TextSize = 16
textLabel_2.Size = UDim2.new(1, -5, 1, -5)
textLabel_2.Parent = imageButton

local textLabel_3 = Instance.new("TextLabel")
textLabel_3.Name = "TextLabel"
textLabel_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
textLabel_3.TextColor3 = Color3.new(1, 1, 1)
textLabel_3.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_3.Text = "Aimbot"
textLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_3.BackgroundTransparency = 1
textLabel_3.Position = UDim2.new(1, 5, 0, 0)
textLabel_3.TextXAlignment = Enum.TextXAlignment.Left
textLabel_3.TextSize = 14
textLabel_3.Size = UDim2.new(0, 100, 1, 0)
textLabel_3.Parent = ui_aimcontroller

local ui_sencontroller = Instance.new("Frame")
ui_sencontroller.Name = "SensitivityController"
ui_sencontroller.Position = UDim2.new(0, 222, 0, 40)
ui_sencontroller.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
ui_sencontroller.BackgroundColor3 = Color3.new(0.157, 0.157, 0.157)
ui_sencontroller.Size = UDim2.new(0, 70, 0, 20)
ui_sencontroller.Parent = ui_content

local textLabel_4 = Instance.new("TextLabel")
textLabel_4.Name = "TextLabel"
textLabel_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
textLabel_4.TextColor3 = Color3.new(1, 1, 1)
textLabel_4.Text = "Sensitivity"
textLabel_4.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_4.BackgroundTransparency = 1
textLabel_4.TextXAlignment = Enum.TextXAlignment.Right
textLabel_4.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_4.Position = UDim2.new(-1, -40, 0, 0)
textLabel_4.TextSize = 14
textLabel_4.Size = UDim2.new(0, 100, 1, 0)
textLabel_4.Parent = ui_sencontroller

local textBox = Instance.new("TextBox")
textBox.Name = "TextBox"
textBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textBox.Text = ""
textBox.BackgroundTransparency = 1
textBox.BackgroundColor3 = Color3.new(1, 1, 1)
textBox.PlaceholderText = "0.2"
textBox.TextSize = 14
textBox.Size = UDim2.new(1, 0, 1, 0)
textBox.Parent = ui_sencontroller

local ui_fovcontroller = Instance.new("Frame")
ui_fovcontroller.Name = "FOVController"
ui_fovcontroller.Position = UDim2.new(0, 222, 0, 10)
ui_fovcontroller.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
ui_fovcontroller.BackgroundColor3 = Color3.new(0.157, 0.157, 0.157)
ui_fovcontroller.Size = UDim2.new(0, 70, 0, 20)
ui_fovcontroller.Parent = ui_content

local textLabel_5 = Instance.new("TextLabel")
textLabel_5.Name = "TextLabel"
textLabel_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
textLabel_5.TextColor3 = Color3.new(1, 1, 1)
textLabel_5.Text = "FOV"
textLabel_5.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_5.BackgroundTransparency = 1
textLabel_5.TextXAlignment = Enum.TextXAlignment.Right
textLabel_5.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_5.Position = UDim2.new(-1, -40, 0, 0)
textLabel_5.TextSize = 14
textLabel_5.Size = UDim2.new(0, 100, 1, 0)
textLabel_5.Parent = ui_fovcontroller

local textBox_2 = Instance.new("TextBox")
textBox_2.Name = "TextBox"
textBox_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
textBox_2.TextColor3 = Color3.new(1, 1, 1)
textBox_2.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textBox_2.Text = ""
textBox_2.BackgroundTransparency = 1
textBox_2.BackgroundColor3 = Color3.new(1, 1, 1)
textBox_2.PlaceholderText = "4"
textBox_2.TextSize = 14
textBox_2.Size = UDim2.new(1, 0, 1, 0)
textBox_2.Parent = ui_fovcontroller

local ui_ffacontroller = Instance.new("Frame")
ui_ffacontroller.Name = "FFAController"
ui_ffacontroller.BackgroundTransparency = 1
ui_ffacontroller.Position = UDim2.new(0, 10, 0, 70)
ui_ffacontroller.BackgroundColor3 = Color3.new(1, 1, 1)
ui_ffacontroller.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_ffacontroller.Size = UDim2.new(0, 20, 0, 20)
ui_ffacontroller.Parent = ui_content

local textLabel_6 = Instance.new("TextLabel")
textLabel_6.Name = "TextLabel"
textLabel_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
textLabel_6.TextColor3 = Color3.new(1, 1, 1)
textLabel_6.Text = "FFA"
textLabel_6.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_6.BackgroundTransparency = 1
textLabel_6.TextXAlignment = Enum.TextXAlignment.Left
textLabel_6.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_6.Position = UDim2.new(1, 5, 0, 0)
textLabel_6.TextSize = 14
textLabel_6.Size = UDim2.new(0, 100, 1, 0)
textLabel_6.Parent = ui_ffacontroller

local imageButton_2 = Instance.new("ImageButton")
imageButton_2.Name = "ImageButton"
imageButton_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
imageButton_2.ImageTransparency = 1
imageButton_2.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
imageButton_2.BackgroundColor3 = Color3.new(0.157, 0.157, 0.157)
imageButton_2.Size = UDim2.new(1, 0, 1, 0)
imageButton_2.Parent = ui_ffacontroller

local textLabel_7 = Instance.new("TextLabel")
textLabel_7.Name = "TextLabel"
textLabel_7.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
textLabel_7.TextColor3 = Color3.new(1, 1, 1)
textLabel_7.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_7.Text = "✓"
textLabel_7.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel_7.BackgroundTransparency = 1
textLabel_7.Position = UDim2.new(0.5, 0, 0.5, 0)
textLabel_7.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_7.TextSize = 16
textLabel_7.Size = UDim2.new(1, -5, 1, -5)
textLabel_7.Parent = imageButton_2

local ui_espcontroller = Instance.new("Frame")
ui_espcontroller.Name = "ESPController"
ui_espcontroller.BackgroundTransparency = 1
ui_espcontroller.Position = UDim2.new(0, 10, 0, 40)
ui_espcontroller.BackgroundColor3 = Color3.new(1, 1, 1)
ui_espcontroller.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_espcontroller.Size = UDim2.new(0, 20, 0, 20)
ui_espcontroller.Parent = ui_content

local imageButton_3 = Instance.new("ImageButton")
imageButton_3.Name = "ImageButton"
imageButton_3.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
imageButton_3.ImageTransparency = 1
imageButton_3.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
imageButton_3.BackgroundColor3 = Color3.new(0.157, 0.157, 0.157)
imageButton_3.Size = UDim2.new(1, 0, 1, 0)
imageButton_3.Parent = ui_espcontroller

local textLabel_8 = Instance.new("TextLabel")
textLabel_8.Name = "TextLabel"
textLabel_8.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
textLabel_8.TextColor3 = Color3.new(1, 1, 1)
textLabel_8.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_8.Text = "✓"
textLabel_8.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel_8.BackgroundTransparency = 1
textLabel_8.Position = UDim2.new(0.5, 0, 0.5, 0)
textLabel_8.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_8.TextSize = 16
textLabel_8.Size = UDim2.new(1, -5, 1, -5)
textLabel_8.Parent = imageButton_3

local textLabel_9 = Instance.new("TextLabel")
textLabel_9.Name = "TextLabel"
textLabel_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
textLabel_9.TextColor3 = Color3.new(1, 1, 1)
textLabel_9.Text = "ESP"
textLabel_9.BackgroundColor3 = Color3.new(1, 1, 1)
textLabel_9.BackgroundTransparency = 1
textLabel_9.TextXAlignment = Enum.TextXAlignment.Left
textLabel_9.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
textLabel_9.Position = UDim2.new(1, 5, 0, 0)
textLabel_9.TextSize = 14
textLabel_9.Size = UDim2.new(0, 100, 1, 0)
textLabel_9.Parent = ui_espcontroller

local ui_circle = Instance.new("Frame")
ui_circle.Name = "Circle"
ui_circle.AnchorPoint = Vector2.new(0.5, 0.5)
ui_circle.BackgroundTransparency = 0.9
ui_circle.Position = UDim2.new(0.5, 0, 0.5, 0)
ui_circle.BackgroundColor3 = Color3.new(0.125, 0.125, 0.125)
ui_circle.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
ui_circle.Size = UDim2.new(0, 200, 0, 200)
ui_circle.Parent = ui

local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundTransparency = 0.8
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.new()
frame.BorderSizePixel = 0
frame.Size = UDim2.new(0, 1, 1, 0)
frame.Parent = ui_circle

local frame_2 = Instance.new("Frame")
frame_2.Name = "Frame"
frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
frame_2.BackgroundTransparency = 0.8
frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
frame_2.BackgroundColor3 = Color3.new()
frame_2.BorderSizePixel = 0
frame_2.Size = UDim2.new(1, 0, 0, 1)
frame_2.Parent = ui_circle

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "ImageLabel"
imageLabel.BorderColor3 = Color3.new(0.106, 0.165, 0.208)
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.Image = "rbxassetid://7254289048"
imageLabel.BackgroundTransparency = 1
imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
imageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
imageLabel.ZIndex = 2
imageLabel.Size = UDim2.new(0, 200, 0, 200)
imageLabel.Parent = ui_circle

local stroke = Instance.new("UIStroke")
stroke.Name = "Stroke"
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.8
stroke.Color = Color3.new(0.125, 0.125, 0.125)
stroke.Thickness = 2
stroke.Parent = ui_circle

local frame_3 = Instance.new("Frame")
frame_3.Name = "Frame"
frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
frame_3.BackgroundColor3 = Color3.new()
frame_3.BackgroundTransparency = 0.8
frame_3.Position = UDim2.new(0.5, 0, 0.5, 0)
frame_3.Rotation = 315
frame_3.BorderSizePixel = 0
frame_3.Size = UDim2.new(0, 1, 0.5, 0)
frame_3.Parent = ui_circle

local frame_4 = Instance.new("Frame")
frame_4.Name = "Frame"
frame_4.AnchorPoint = Vector2.new(0.5, 0.5)
frame_4.BackgroundColor3 = Color3.new()
frame_4.BackgroundTransparency = 0.8
frame_4.Position = UDim2.new(0.5, 0, 0.5, 0)
frame_4.Rotation = 45
frame_4.BorderSizePixel = 0
frame_4.Size = UDim2.new(0, 1, 0.5, 0)
frame_4.Parent = ui_circle

local corner = Instance.new("UICorner")
corner.Name = "Corner"
corner.CornerRadius = UDim.new(0.5, 0)
corner.Parent = ui_circle 

ui.Enabled = true
ui.Parent = coregui
insert(instances, ui)

local esp = true
local ffa = true
local fov = 5
local sens = 0.4
local aimbot = true
local max_detection_range = 2048

local v2 = Vector2.new
local c3u = Color3.fromRGB

local rbxclass = game.IsA
local rbxchild = game.FindFirstChild
local rbxchildwait = game.WaitForChild
local rbxclasschild = game.FindFirstChildWhichIsA
local rbxdescendant = game.IsDescendantOf

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Blacklist
params.IgnoreWater = true

local function ray(origin, direction)
    return {
        origin = origin,
        direction = direction
    }
end

local function raycast(worldroot, rayobject, ignorelist)
    local origin, direction = rayobject.origin, rayobject.direction
    params.FilterDescendantsInstances = type(ignorelist) == 'table' and ignorelist or nil
    return worldroot:Raycast(origin, direction, params).Instance
end

local color_scheme = {}
color_scheme['nearest'] = c3u(0, 172, 255)
color_scheme['valid'] = c3u(38, 255, 99)
color_scheme['invalid'] = c3u(255, 37, 40)

local function spawn(f, ...)
    local args = { ... }
    local thread = coroutine.create(f)
    return coroutine.resume(thread, unpack(args))
end

local localplayer = players.LocalPlayer
local playermouse = localplayer:GetMouse()
local currentcamera = workspace.CurrentCamera

connect(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
    currentcamera = workspace.CurrentCamera
end)

local touch = Enum.UserInputType.Touch
local mousebutton1 = Enum.UserInputType.MouseButton1
local mousebutton2 = Enum.UserInputType.MouseButton2
local mousemovement = Enum.UserInputType.MouseMovement
local mousebutton1down = false
local mousebutton2down = false

local userinputservice = service("UserInputService")
local inputbegan = userinputservice.InputBegan
local inputended = userinputservice.InputEnded
local inputendstate = Enum.UserInputState.End

spawn(function()
    local dragging
    local draginput
    local dragstart
    local startpos

    local function update(input)
        local delta = input.Position - dragstart
        ui_frame.Position = UDim2.new(startpos.X.Scale, startpos.X.Offset + delta.X, startpos.Y.Scale,
            startpos.Y.Offset + delta.Y)
    end

    connect(ui_topbar.InputBegan, function(input)
        if input.UserInputType == mousebutton1 or input.UserInputType == touch then
            dragging = true
            dragstart = input.Position
            startpos = ui_frame.Position

            connect(input.Changed, function()
                if input.UserInputState == inputendstate then
                    dragging = false
                end
            end)
        end
    end)

    connect(ui_topbar.InputChanged, function(input)
        if input.UserInputType == mousemovement then
            draginput = input
        end
    end)

    connect(ui_frame.InputChanged, function(input)
        if input == draginput and dragging then
            update(input)
        end
    end)

    connect(ui_topbar.InputEnded, function(input)
        if input.UserInputType == mousebutton1 or input.UserInputType == touch then
            dragging = false
        end
    end)
end)

connect(rbxchildwait(ui_fovcontroller, 'TextBox').FocusLost, function(enter_pressed)
    if enter_pressed then
        local input = ui_fovcontroller.TextBox.Text
        local number = tonumber(input)
        if type(number) == 'number' then
            fov = number
            ui_fovcontroller.TextBox.Text = input
        end
    end
end)

connect(rbxchildwait(ui_sencontroller, 'TextBox').FocusLost, function(enter_pressed)
    if enter_pressed then
        local input = ui_sencontroller.TextBox.Text
        local number = tonumber(input)
        if type(number) == 'number' then
            sens = number
            ui_sencontroller.TextBox.Text = input
        end
    end
end)

local function can_track(player, character)
    if not esp then
        return false
    end
    if typeof(player) == 'Instance' and rbxclass(player, "Model") then
        character = player
        player = players:GetPlayerFromCharacter(character)
    end
    return player and player ~= localplayer and (ffa or player.Team ~= localplayer.Team)
end

local content = {}
local highlight = {}
highlight.__index = highlight

function highlight.new(player)
    if content[player] then
        return content[player]
    end
    local self = setmetatable({}, highlight)
    self.player = player
    local highlight = Instance.new("Highlight")
    highlight.Enabled = can_track(player)
    highlight.FillColor = color_scheme['invalid']
    highlight.OutlineColor = color_scheme['invalid']
    insert(instances, highlight)
    highlight.Parent = ui
    connect(player.CharacterAdded, function(character)
        self.character = character
        highlight.Adornee = character
        highlight.Enabled = can_track(player)
    end)
    if player.Character then
        self.character = player.Character
        highlight.Adornee = player.Character
        highlight.Enabled = can_track(player)
    end
    connect(player:GetPropertyChangedSignal("Team"), function()
        highlight.Enabled = can_track(player)
    end)
    self.highlight = highlight
    content[player] = self
    return self
end

function highlight:destroy()
    self.highlight:Destroy()
end

function highlight:valid()
    return can_track(self.player)
end

function highlight:color(color)
    self.highlight.FillColor = color
    self.highlight.OutlineColor = color
end

function highlight:enabled(enabled)
    self.highlight.Enabled = enabled
end

local function get_enemy_players()
    local enemy_players = {}
    for _, potential_enemy in pairs(players:GetPlayers()) do
        if potential_enemy ~= localplayer then
            if esp then
                local local_entry = content[potential_enemy]
                if not local_entry then
                    highlight.new(potential_enemy)
                    local_entry = content[potential_enemy]
                end
                local_entry:enabled(can_track(local_entry.player))
            end
            if (ffa or potential_enemy.Team ~= localplayer.Team) then
                insert(enemy_players, potential_enemy)
            end
        end
    end
    return enemy_players
end

local function get_enemy_characters()
    local enemy_characters = {}
	for _, enemy_player in pairs(get_enemy_players()) do
			local enemy_character = enemy_player.Character
			local enemy_humanoid = typeof(enemy_character) == 'Instance' and rbxclasschild(enemy_character, 'Humanoid')
			if (enemy_humanoid and enemy_humanoid.Health > 0) or not enemy_humanoid then
				insert(enemy_characters, enemy_character)
			end
		end
    return enemy_characters
end

local function get_nearest_character(current_target)
    local nearest_character, nearest_screenpoint
    local closest_distance = max_detection_range
    local camera_position = currentcamera.CFrame.Position
    for _, character in pairs(get_enemy_characters()) do
        local local_entry
        local local_color_selection = color_scheme['invalid']
        for _, entry in pairs(content) do
            if entry.character == character then
                local_entry = entry
                break
            end
        end
        local head = rbxchild(character, 'Head') or rbxchild(character, 'HumanoidRootPart')
        if typeof(head) == 'Instance' and rbxclass(head, 'BasePart') then
            local screen_position, on_screen = currentcamera:WorldToScreenPoint(head.Position)
            local screen_distance = (v2(playermouse.X, playermouse.Y) - v2(screen_position.X, screen_position.Y))
                .Magnitude
            if on_screen then
				local_entry:enabled(can_track(local_entry.player))
                local hit = raycast(
                    workspace,
                    ray(camera_position, (head.Position - camera_position).Unit * 2048),
                    { currentcamera, localplayer.Character }
                )
                if typeof(hit) == 'Instance' and rbxdescendant(hit, character) then
                    if screen_distance < closest_distance and screen_distance <= currentcamera.ViewportSize.X / (90 / fov) then
                        nearest_character = character
                        nearest_screenpoint = screen_position
                        closest_distance = screen_distance
                        local_color_selection = color_scheme['valid']
                    end
                end
            else
                local_entry:enabled(false)
            end
        end
        if current_target ~= nearest_character then
            local_entry:color(local_color_selection)
        end
    end
    return nearest_character, nearest_screenpoint
end

connect(inputbegan, function(input)
    if userinputservice:GetFocusedTextBox() then
        return
    end
    if input.UserInputType == mousebutton1 then
        mousebutton1down = true
    elseif input.UserInputType == mousebutton2 then
        mousebutton2down = true
    end
end)

connect(inputended, function(input)
    if userinputservice:GetFocusedTextBox() then
        return
    end
    if input.UserInputType == mousebutton1 then
        mousebutton1down = false
    elseif input.UserInputType == mousebutton2 then
        mousebutton2down = false
    end
end)

coroutine.resume(coroutine.create(function(dragging, drag_input, drag_start, start_position)
    local function update(input)
        local delta = input.Position - drag_start
        ui_frame.Position = UDim2.new(start_position.X.Scale, start_position.X.Offset + delta.X, start_position.Y.Scale,
            start_position.Y.Offset + delta.Y)
    end
    connect(ui_frame.InputBegan, function(input)
        if input.UserInputType == mousebutton1 or input.UserInputType == touch then
            dragging, drag_start, start_position = true, input.Position, ui_frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == ended then
                    dragging = false
                end
            end)
        end
    end)
    connect(ui_frame.InputChanged, function(input)
        if input.UserInputType == mousemovement or input.UserInputType == touch then
            drag_input = input
        end
    end)
    connect(userinputservice.InputChanged, function(input)
        if input == drag_input and dragging then
            update(input)
        end
    end)
    connect(ui_frame.InputEnded, function(input)
        if input.UserInputType == mousebutton1 or input.UserInputType == touch then
            dragging = false
        end
    end)
end))

local function load_player(player)
    if player ~= localplayer then
        highlight.new(player)
    end
end

for _, player in pairs(players:GetPlayers()) do
    load_player(player)
end

connect(players.PlayerAdded, load_player)

connect(players.PlayerRemoving, function(player)
    if player ~= localplayer then
        local entry = content[player]
        if entry then
            entry:destroy()
            content[player] = nil
        end
    end
end)

local function update_mouse()
    if currentcamera then
        local viewport_size = currentcamera.ViewportSize * 2
        local x, y = playermouse.X, playermouse.Y
        ui_circle.Position = UDim2.fromOffset(x, y)
        ui_circle.Size = UDim2.fromOffset(viewport_size.X / (90 / fov), viewport_size.X / (90 / fov))
    end
end

connect(playermouse.Move, update_mouse)
connect(userinputservice:GetPropertyChangedSignal("MouseBehavior"), update_mouse)

local current_target

local nearest_player
local nearest_character
local nearest_screenpoint

local last_time = 0
local frame_rate = 60
local frame_delta = 1 / frame_rate

--- Moves the mouse relative to its current position.
--- @type function
local mousemoverel = env.mousemoverel

local toggle_aimbot = function()
    aimbot = not aimbot
    ui_aimcontroller.ImageButton.TextLabel.Text = aimbot and '✓' or ''
    ui_circle.Visible = aimbot
end

local toggle_ffa = function()
    ffa = not ffa
    ui_ffacontroller.ImageButton.TextLabel.Text = ffa and '✓' or ''
    if esp then
        for _, entry in pairs(content) do
            entry:enabled(can_track(entry.player))
        end
    end
end

local toggle_esp = function()
    esp = not esp
    ui_espcontroller.ImageButton.TextLabel.Text = esp and '✓' or ''
    for _, entry in pairs(content) do
        entry:enabled(can_track(entry.player))
    end
end

connect(rbxchildwait(ui_ffacontroller, 'ImageButton').MouseButton1Up, function() toggle_ffa() end)
connect(rbxchildwait(ui_espcontroller, 'ImageButton').MouseButton1Up, function() toggle_esp() end)
connect(rbxchildwait(ui_aimcontroller, 'ImageButton').MouseButton1Up, function() toggle_aimbot() end)

local function on_lock_update(time, delta_time)
    current_target = nearest_character
    nearest_character, nearest_screenpoint = get_nearest_character(current_target)
    if aimbot and (mousebutton1down or mousebutton2down) and nearest_character and (time > last_time + frame_delta or delta_time > frame_delta) then
        last_time = time
        if esp then
            nearest_player = players:GetPlayerFromCharacter(nearest_character)
            if nearest_player then
                content[nearest_player]:color(color_scheme['nearest'])
            end
        end
        if typeof(nearest_screenpoint) == 'Vector3' then
            mousemoverel((nearest_screenpoint.X - playermouse.X) * sens, (nearest_screenpoint.Y - playermouse.Y) * sens)
            ui_circle.Position = UDim2.fromOffset(nearest_screenpoint.X, nearest_screenpoint.Y)
        end
    end
end

connect(service("RunService").Stepped, function(time, delta_time) on_lock_update(time, delta_time) end)

env.stop_aim_assistant = function()
    print('[AA] Stopping! ...')
    for _, connection in pairs(connections) do
        if typeof(connection) == 'RBXScriptConnection' and connection.Connected then
            pcall(connection.Disconnect, connection)
        end
    end
    for _, instance in pairs(instances) do
        if typeof(instance) == 'Instance' then
            pcall(instance.Destroy, instance)
        end
    end
    for _, entry in pairs(content) do
        if type(entry) == 'table' then
            pcall(entry.destroy, entry)
        end
    end
    content = nil
    connections = nil
    instances = nil
end

print('[AA] ✅ Aim Assistant has loaded successfully!')
--!nocheck
--!nolint UnknownGlobal
--!nolint LocalShadow

--- made by thuarnel
--- basic commands
--- 3/11/2025
--- @diagnostic disable: undefined-global

local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' then
    if type(env.stop_basic_commands) == 'function' then
        env.stop_basic_commands()
    end
else
    return error('No global environment')
end

local insert = table.insert
local concat = table.concat

local Players = game:GetService('Players');
local CoreGui = game:GetService('CoreGui');
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService');
local Lighting = game:GetService('Lighting');
local TeleportService = game:GetService('TeleportService');
local TweenService = game:GetService('TweenService');
local UserInputService = game:GetService('UserInputService');

local activeNotifications = {}

local function updateNotificationPositions()
    local baseY = 50
    local margin = 10
    local height = 100
    for i, notif in ipairs(activeNotifications) do
        local targetY = baseY + (height + margin) * (i - 1)
        notif.Main:TweenPosition(UDim2.new(1, -330, 0, targetY), "Out", "Sine", 0.5, true)
    end
end

local function send_notification(titletxt, text, displayTime)
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame", GUI)
    local title = Instance.new("TextLabel", Main)
    local message = Instance.new("TextLabel", Main)
    
    GUI.DisplayOrder = 999999
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
    GUI.Name = "NotificationOof"
    GUI.Parent = CoreGui

    Main.Name = "MainFrame"
    Main.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
    Main.BorderSizePixel = 0
    local baseY = 50
    local margin = 10
    local height = 100
    local notifIndex = #activeNotifications + 1
    local targetY = baseY + (height + margin) * (notifIndex - 1)
    Main.Position = UDim2.new(1, 5, 0, targetY)
    Main.Size = UDim2.new(0, 330, 0, height)

    title.BackgroundColor3 = Color3.new(0, 0, 0)
    title.BackgroundTransparency = 0.9
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 17
    
    message.BackgroundColor3 = Color3.new(0, 0, 0)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 16

    insert(activeNotifications, {GUI = GUI, Main = Main})
    Main:TweenPosition(UDim2.new(1, -330, 0, targetY), "Out", "Sine", 0.5, true)
    task.delay(displayTime, function()
        Main:TweenPosition(UDim2.new(1, 5, 0, targetY), "Out", "Sine", 0.5, true)
        task.delay(0.6, function()
            for i, notif in ipairs(activeNotifications) do
                if notif.GUI == GUI then
                    table.remove(activeNotifications, i)
                    break
                end
            end
            updateNotificationPositions()
            GUI:Destroy()
        end)
    end)
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    if typeof(signal) == 'RBXScriptSignal' and type(callback) == 'function' then
        local connection = signal:Connect(callback)
        insert(connections, connection)
        return connection
    end
    return nil
end

--[=[ PLAYER STUFF ]=]--

local camera = workspace.CurrentCamera

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
    camera = workspace.CurrentCamera
end)

local fpdh_changing = false
connect(workspace:GetPropertyChangedSignal('FallenPartsDestroyHeight'), function()
    if fpdh_changing then
        return
    end
    fpdh_changing = true
    workspace.FallenPartsDestroyHeight = 0 / 0
    fpdh_changing = false
end)

local player = Players.LocalPlayer
local character
local humanoid
local rootpart
local seatpart

local function new_character()
    character = player.Character
    humanoid = character and character:WaitForChild('Humanoid', 1) or character:FindFirstChildWhichIsA('Humanoid')
    rootpart = humanoid and humanoid.RootPart or character:WaitForChild('HumanoidRootPart', 1)

    if humanoid and humanoid:IsA('Humanoid') then
        seatpart = humanoid.SeatPart

        connect(humanoid.Seated, function()
            if humanoid then
                seatpart = humanoid.SeatPart
            end
        end)

        connect(humanoid.GettingUp, function()
            seatpart = nil
        end)
    end
end

pcall(new_character)
connect(player.CharacterAdded, new_character)

local function find_players_by_argument(arg)
    local lower_arg = arg:lower()

    if lower_arg == "random" then
        local plrs = Players:GetPlayers()
        return plrs[math.random(1, #plrs)]
    end

    if lower_arg == "all" then
        return Players:GetPlayers()
    end

    if lower_arg == "others" then
        local others = {}
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= player then
                table.insert(others, pl)
            end
        end
        return others
    end

    if lower_arg == "me" or lower_arg == "self" then
        return player
    end

    if lower_arg == "closest" then
        if not rootpart then return nil end
        local closest, closest_dist = nil, math.huge
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = pl.Character.HumanoidRootPart
                local dist = (hrp.Position - rootpart.Position).Magnitude
                if dist < closest_dist then
                    closest_dist = dist
                    closest = pl
                end
            end
        end
        return closest
    end

    if lower_arg == "farthest" then
        if not rootpart then return nil end
        local farthest, farthest_dist = nil, 0
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= player and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = pl.Character.HumanoidRootPart
                local dist = (hrp.Position - rootpart.Position).Magnitude
                if dist > farthest_dist then
                    farthest_dist = dist
                    farthest = pl
                end
            end
        end
        return farthest
    end

    local player_names = {}
    for name in string.gmatch(arg, "([^,]+)") do
        table.insert(player_names, name)
    end
    local matched_players = {}
    local function matches(pl, search_name)
        return pl.Name:lower():find(search_name:lower(), 1, true) ~= nil or 
               pl.DisplayName:lower():find(search_name:lower(), 1, true) ~= nil
    end
    for _, pl in ipairs(Players:GetPlayers()) do
        for _, name in ipairs(player_names) do
            if matches(pl, name) then
                table.insert(matched_players, pl)
                break
            end
        end
    end

    if #matched_players == 0 then
        return nil
    elseif #matched_players == 1 then
        return matched_players[1]
    else
        return matched_players
    end
end

--[=[ COMMAND SYS ]=]--

local cmds = { list = {} }

function cmds:new(commandNames, callback)
    if type(commandNames) == "table" then
        -- primary
        local primary = commandNames[1]
        self.list[primary] = callback
        -- aliases
        for i = 2, #commandNames do
            self.list[commandNames[i]] = callback
        end
    else
        self.list[commandNames] = callback
    end
end

function cmds:execute(str)
    local args = {}
    for word in string.gmatch(str, "%S+") do
        table.insert(args, word)
    end
    local command_name = table.remove(args, 1)
    local command = self.list[command_name]
    if command then
        print('[BC]: Executing command: \"' .. str .. '\"')
        if #args > 0 then
            command(table.unpack(args))
        else
            command()
        end
    else
        warn("command '" .. command_name .. "' not found")
    end
end

cmds:new('rejoin', function()
    if #Players:GetPlayers() <= 1 then
		player:Kick("\nRejoining...")
		task.wait()
		TeleportService:Teleport(placeid, player)
	else
		TeleportService:TeleportToPlaceInstance(placeid, jobid, player)
	end
end)

local circle_loop
local circle_target

local function break_circle()
    if typeof(circle_loop) == 'RBXScriptConnection' and circle_loop.Connected then
        circle_target = nil
        circle_loop:Disconnect()
    end
end

local circle_speed, circle_angle, circle_radius = 2, 0, 10
local back_pos

cmds:new('circle', function(target)
    break_circle()
    local target = find_players_by_argument(target)

    if typeof(target) == 'Instance' and target:IsA('Player') then
        local target_char = target.Character
        local target_hum = target_char and target_char:FindFirstChildWhichIsA('Humanoid')
        local target_root = target_hum and target_hum.RootPart
    
        if target_root then
            circle_target = target_root
    
            if rootpart then
                back_pos = rootpart.Position
            end

            circle_loop = connect(RunService.Heartbeat, function(dt)
                if typeof(target) ~= 'Instance' or not circle_target or not rootpart or seatpart then
                    return break_circle()
                end
                circle_angle += circle_speed * dt
                rootpart.CFrame = circle_target.CFrame * CFrame.new(math.cos(circle_angle) * circle_radius, 0, math.sin(circle_angle) * circle_radius)
            end)
        end
    end
end)

cmds:new('uncircle', break_circle)

cmds:new('circlespeed', function(value)
    circle_speed = tonumber(value) or circle_speed
end)

cmds:new('circleradius', function(value)
    circle_radius = tonumber(value) or circle_radius
end)

cmds:new('tppos', function(x, y, z)
    if typeof(rootpart) == 'Instance' and rootpart:IsA('BasePart') then
        local position = rootpart.Position

        local x = tonumber(x) or position.X
        local y = tonumber(y) or position.Y
        local z = tonumber(z) or position.Z

        rootpart.CFrame = CFrame.new(Vector3.new(x, y, z))
    end
end)

local noclipping
local function clip()
    if typeof(noclipping) == 'RBXScriptConnection' and noclipping.Connected then
        noclipping:Disconnect()
    end
end

cmds:new('clip', clip)
cmds:new('noclip', function()
    clip()
    noclipping = connect(RunService.Stepped, function()
        if typeof(character) == 'Instance' then
            for _, child in pairs(character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    child.CanCollide = false
                end
            end
        end
    end)
end)

local flying = false
local flyspeed = 1
local fly_input_begin, fly_input_ended

local function fly(seated)
    if typeof(rootpart) == 'Instance' and rootpart:IsA('BasePart') then
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local SPEED = 0
    
        local function FLY()
            flying = true

            local BG = Instance.new('BodyGyro')
            BG.P = 9e4
            BG.Parent = rootpart
            BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.CFrame = rootpart.CFrame

            local BV = Instance.new('BodyVelocity')
            BV.Velocity = Vector3.new(0, 0, 0)
            BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            BV.Parent = rootpart

            task.spawn(function()
                while flying do
                    if not seated and humanoid then
                        humanoid.PlatformStand = true
                    end

                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    
                    if typeof(camera) == 'Instance' and camera:IsA('Camera') and typeof(BV) == 'Instance' and BV:IsA('BodyVelocity') and typeof(BG) == 'Instance' and BG:IsA('BodyGyro') then
                        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                            BV.Velocity = ((camera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((camera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - camera.CFrame.Position)) * SPEED
                            lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                            BV.Velocity = ((camera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((camera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).Position) - camera.CFrame.Position)) * SPEED
                        else
                            BV.Velocity = Vector3.zero
                        end
                        BG.CFrame = camera.CFrame
                    end

                    RunService.Stepped:Wait()
                end

                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                
                if typeof(BG) == 'Instance' then
                    BG:Destroy()
                end

                if typeof(BV) == 'Instance' then
                    BV:Destroy()
                end
                
                if humanoid then
                    humanoid.PlatformStand = false
                end
            end)
        end
        
        fly_input_begin = connect(UserInputService.InputBegan, function(io, gpe)
            if gpe then
                return
            end

            local KEY = io.KeyCode.Name:lower()

            if KEY:lower() == 'w' then
                CONTROL.F = flyspeed
            elseif KEY:lower() == 's' then
                CONTROL.B = -flyspeed
            elseif KEY:lower() == 'a' then
                CONTROL.L = -flyspeed
            elseif KEY:lower() == 'd' then 
                CONTROL.R = flyspeed
            elseif KEY:lower() == 'e' then
                CONTROL.Q = flyspeed * 2
            elseif KEY:lower() == 'q' then
                CONTROL.E = -flyspeed * 2
            end
            
            if typeof(camera) == 'Instance' and camera:IsA('Camera') then
                camera.CameraType = Enum.CameraType.Track
            end
        end)

        fly_input_ended = connect(UserInputService.InputEnded, function(io)
            local KEY = io.KeyCode.Name:lower()

            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)
        
        FLY()
    end
end

local function unfly()
    flying = false
    if typeof(fly_input_begin) == 'RBXScriptConnection' and fly_input_begin.Connected then
        fly_input_begin:Disconnect()
    end
    if typeof(fly_input_ended) == 'RBXScriptConnection' and fly_input_ended.Connected then
        fly_input_ended:Disconnect()
    end
    if typeof(humanoid) == 'Instance' and humanoid:IsA('Humanoid') then
        humanoid.PlatformStand = false
    end
    if typeof(camera) == 'Instance' and camera:IsA('Camera') then
        camera.CameraType = Enum.CameraType.Custom
    end
end

cmds:new('fly', function()
    unfly()
    task.wait()
    if typeof(seatpart) == 'Instance' and seatpart:IsA('VehicleSeat') and seatpart.Anchored == false then
        fly(true)
    else
        fly(false)
    end
end)

cmds:new('unfly', function()
    unfly()
end)

cmds:new('flyspeed', function(speed)
    local x = tonumber(speed)
    if type(x) == 'number' then
        flyspeed = x
    end
end)

cmds:new('to', function(target)
    local target = find_players_by_argument(target)

    if typeof(target) == 'Instance' and target:IsA('Player') then
        local their_root = select(2, pcall(function()
            return target.Character:FindFirstChildWhichIsA('Humanoid').RootPart
        end))

        if rootpart and typeof(their_root) == 'Instance' then
            break_circle()
            task.wait()
            back_pos = rootpart.Position
            rootpart.CFrame = CFrame.new(their_root.Position)
        end
    end
end)

cmds:new({'ws', 'walkspeed'}, function(ws)
    local ws = tonumber(ws)
    if type(ws) == 'number' and humanoid then
        humanoid.WalkSpeed = ws
    end
end)

cmds:new({'jp', 'jumppower'}, function(jp)
    local jp = tonumber(jp)
    if type(jp) == 'number' and humanoid then
        humanoid.JumpPower = jp
    end
end)

cmds:new('back', function()
    if rootpart and typeof(back_pos) == 'Vector3' then
        break_circle()
        task.wait()
        local pos = rootpart.Position
        rootpart.CFrame = CFrame.new(back_pos)
        back_pos = pos
    end
end)

cmds:new('nofog', function()
    Lighting.FogStart = 1e6
    Lighting.FogEnd = 1e6
end)

local original_lighting = {
    Ambient = Lighting.Ambient,
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    ColorShift_Top = Lighting.ColorShift_Top,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
    ExposureCompensation = Lighting.ExposureCompensation,
    FogColor = Lighting.FogColor,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GeographicLatitude = Lighting.GeographicLatitude,
    GlobalShadows = Lighting.GlobalShadows,
    -- LightingStyle = Lighting.LightingStyle,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    -- PrioritizeLightingQuality = Lighting.PrioritizeLightingQuality,
    ShadowSoftness = Lighting.ShadowSoftness
}

local function restore_lighting()
    for i, v in pairs(original_lighting) do
        if type(i) == 'string' and v ~= nil then
            Lighting[i] = v
        end
    end
    task.wait(0.1)
    for i in pairs(original_lighting) do
        pcall(function()
            original_lighting[i] = Lighting[i]
        end)
    end
end

cmds:new({'restorelighting', 'rlighting'}, restore_lighting)

cmds:new({'fullbright', 'fb'}, function()
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.ExposureCompensation = 0
end)

cmds:new('brightness', function(brightness)
    Lighting.Brightness = tonumber(brightness) or 2
end)

cmds:new('tint', function(r, g, b)
    local r = tonumber(r) or 0
    local g = tonumber(g) or 0
    local b = tonumber(b) or 0

    if not colcor then
        colcor = Instance.new('ColorCorrectionEffect')
        colcor.Parent = Lighting
    end

    colcor.TintColor = Color3.fromRGB(r, g, b)
end)

cmds:new('age', function(target)
    local target = find_players_by_argument(target)

    if typeof(target) == 'Instance' and target:IsA('Player') then
        print('[BC]: AccountAge of ' .. target.DisplayName .. ' (@' .. target.Name .. '): ' .. target.AccountAge)
        send_notification('Account age for ' .. target.DisplayName, target.AccountAge, 4)
    elseif type(target) == 'table' then
        for _, v in pairs(target) do
            if typeof(v) == 'Instance' and v:IsA('Player') then
                print('[BC]: AccountAge of ' .. v.DisplayName .. ' (@' .. v.Name .. '): ' .. v.AccountAge)
            end
        end
        send_notification('AccountAge', 'Check the console for your bulk output.', 4)
    end
end)

local viewing
local viewer
local function unview()
    viewing = nil
    if typeof(viewer) == 'RBXScriptConnection' and viewer.Connected then
        viewer:Disconnect()
    end
    if camera and character then
        camera.CameraSubject = character
    end
end

cmds:new('view', function(target)
    unview()
    local target = find_players_by_argument(target)
    if typeof(target) == 'Instance' and target:IsA('Player') then
        viewing = target
        local char
        viewer = connect(RunService.Stepped, function()
            if not char then
                char = target.Character
            end
            if camera and camera.CameraSubject ~= char then
                camera.CameraSubject = char
            end
        end)
        send_notification('Viewing ' .. viewing.DisplayName, 'You are now viewing: ' .. viewing.Name, 4)
    end
end)

cmds:new('unview', unview)

cmds:new('notools', function()
    local backpack = player:FindFirstChildWhichIsA('Backpack')

    for _, v in pairs(backpack:GetChildren()) do
        if v:IsA('Tool') then
            v:Destroy()
        end
    end
end)

cmds:new('droptools', function()
    local backpack = player:FindFirstChildWhichIsA('Backpack')

    for _, v in pairs(backpack:GetChildren()) do
        if v:IsA('Tool') and v.CanBeDropped and character then
            v.Parent = character
            task.wait()
            v.Parent = workspace
        end
    end
end)

cmds:new('annabypasser', function()
    if not env.anna_bypasser_loaded then
        local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/AnnaRoblox/AnnaBypasser/refs/heads/main/AnnaBypasser.lua'))
        if type(str) == 'string' then
            local f = select(2, pcall(loadstring, str))
            if type(f) == 'function' then
                env.anna_bypasser_loaded = true
                local events = ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents')
                if events then
                    events.Parent = nil -- L watermark
                end
                coroutine.resume(coroutine.create(f))
                task.wait(3)
                if events then
                    events.Parent = ReplicatedStorage
                end
            end
        end
    else
        local anna_bypasser_gui = game:GetService('CoreGui'):WaitForChild('AnnaBypasser')
        local frame = anna_bypasser_gui and anna_bypasser_gui:FindFirstChildWhichIsA('Frame')        

        if frame then
            frame.AnchorPoint = Vector2.new(0.5, 0.5)
            frame.Position = UDim2.fromScale(0.5, 0.5)
        end
    end
end)

cmds:new('annabypassertweaks', function()
    if env.anna_bypasser_loaded then
        local anna_bypasser_gui = game:GetService('CoreGui'):WaitForChild('AnnaBypasser')

        if anna_bypasser_gui then
            for _, v in pairs(anna_bypasser_gui:GetDescendants()) do
                if v:IsA('TextBox') then
                    v.ClearTextOnFocus = false
                end
            end

            print('[BC]: Tweaked the AnnaBypasser GUI')
        end
    end
end)



--- if you're going to add a new type, be sure you add a way to unload it
local esp_variations = {
    beampacker = function()
        if not env.beampacker_esp_loaded then
            local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-beampacker-esp.lua'))
            if type(str) == 'string' then
                local f = select(2, pcall(loadstring, str))
                if type(f) == 'function' then
                    env.beampacker_esp_loaded = true
                    coroutine.resume(coroutine.create(f))
                end
            end
        end
    end,
    
    basic = function()
        if not env.thuarnel_basic_esp_loaded then
            local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-basic-esp.lua'))
            if type(str) == 'string' then
                local f = select(2, pcall(loadstring, str))
                if type(f) == 'function' then
                    env.thuarnel_basic_esp_loaded = true
                    coroutine.resume(coroutine.create(f))
                end
            end
        end
    end
}

local esp_types = {}

for t in pairs(esp_variations) do
    insert(esp_types, t)
end

cmds:new('esp', function(esp_type)
    if not type(esp_type) == 'string' then
        esp_type = 'basic'
    end
    if type(esp_variations[esp_type]) == 'function' then
        esp_variations[esp_type]()
    else
        send_notification('Invalid ESP Type', 'Type(s): ' .. concat(esp_types, ', '))
    end
end)

cmds:new('unesp', function()
    if type(env.stop_beampacker_esp) == 'function' then
        env.stop_beampacker_esp()
        env.beampacker_esp_loaded = false
    elseif type(env.stop_thuarnel_basic_esp) == 'function' then
        env.stop_thuarnel_basic_esp()
        env.thuarnel_basic_esp_loaded = false
    end
end)

cmds:new('aimassist', function()
    if not env.aim_assistant_loaded then
        local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-basic-esp.lua'))
        if type(str) == 'string' then
            local f = select(2, pcall(loadstring, str))
            if type(f) == 'function' then
                env.aim_assistant_loaded = true
                coroutine.resume(coroutine.create(f))
            end
        end
    end
end)

cmds:new('unaimassist', function()
    if type(env.stop_aim_assistant) == 'function' then
        env.stop_aim_assistant()
        env.aim_assistant_loaded = false
    end
end)

cmds:new('print', function(...)
    print(...)
end)

cmds:new('printunanchored', function()
    local unanchored = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA('BasePart') and v.Anchored ~= true then
            local char = v:FindFirstAncestorWhichIsA('Model')
            if char and Players:GetPlayerFromCharacter(char) then
                continue
            end
            insert(unanchored, v:GetFullName())
        end
    end
    print('[BC]: Found unanchored part(s): \n\t' .. table.concat(unanchored, '\n\t'))
end)

local flinging = false

cmds:new('fling', function()
    if flinging then
        return
    end
    cmds:execute('unwalkfling')
    if humanoid then
        connect(humanoid.Died, function()
            cmds:execute('unwalkfling')
        end)
    end
    cmds:execute('noclip')
    flinging = true
    repeat RunService.Heartbeat:Wait()
        local vel, movel = nil, 0.1
        if rootpart then
            vel = rootpart.AssemblyLinearVelocity
            rootpart.AssemblyLinearVelocity = vel * 10000 + Vector3.new(0, 10000, 0)
        end
        RunService.RenderStepped:Wait()
        if rootpart then
            rootpart.AssemblyLinearVelocity = vel
        end
        RunService.Stepped:Wait()
        if rootpart then
            rootpart.AssemblyLinearVelocity = vel + Vector3.new(0, movel, 0)
        end
        movel = movel * -1
    until flinging == false
end)

cmds:new('unfling', function()
    flinging = false
    cmds:execute('clip')
end)

cmds:new('fix', function()
    if game.PlaceId == 417267366 and not env.dollhouse_roleplay_fixed then
        while not game:IsLoaded() do
            task.wait(0)
        end
        Lighting.Brightness = 2
        Lighting.ExposureCompensation = 0
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA('Light') then
                v.Brightness /= 10
            end
        end
        env.dollhouse_roleplay_fixed = true
    end
end)

cmds:new('dex', function()
    if not env.dex_loaded then
        local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))
        if type(str) == 'string' then
            local f = select(2, pcall(loadstring, str))
            if type(f) == 'function' then
                env.dex_loaded = true
                coroutine.resume(coroutine.create(f))
            end
        end
    end
end)

cmds:new('stop', function()
    env.stop_basic_commands()
end)

--[=[ UI BELOW ]=]--

local ui = Instance.new('ScreenGui')
ui.ResetOnSpawn = false
ui.Parent = game:GetService('CoreGui')
insert(instances, ui)

local field = Instance.new('TextBox')
field.ClearTextOnFocus = false
field.PlaceholderText = ''
field.PlaceholderColor3 = Color3.new(0.75, 0.75, 0.75)
field.Text = ''
field.TextColor3 = Color3.new(1, 1, 1)
field.TextScaled = true
field.FontFace = Font.new('rbxasset://fonts/families/Inconsolata.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
field.BorderSizePixel = 1
field.BorderColor3 = Color3.fromRGB(48, 48, 48)
field.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
field.BackgroundTransparency = 1
field.TextTransparency = 1
field.Size = UDim2.fromScale(0.3, 0.05)
field.AnchorPoint = Vector2.new(0.5, 0.5)
field.Position = UDim2.fromScale(0.5, 0.5)
field.TextXAlignment = Enum.TextXAlignment.Left
field.ClipsDescendants = true
field.ZIndex = 9999

local prediction_label = Instance.new('TextLabel')
prediction_label.Size = field.Size
prediction_label.Position = field.Position
prediction_label.FontFace = field.FontFace
prediction_label.TextScaled = true
prediction_label.AnchorPoint = field.AnchorPoint
prediction_label.ClipsDescendants = true
prediction_label.TextXAlignment = Enum.TextXAlignment.Left
prediction_label.Text = ''
prediction_label.TextColor3 = Color3.new(1, 1, 1)
prediction_label.TextTransparency = 1
prediction_label.BackgroundTransparency = 1
prediction_label.ZIndex = field.ZIndex + 1
prediction_label.Parent = ui

local function levenshtein(s1, s2)
    local len1, len2 = #s1, #s2
    local matrix = {}

    for i = 0, len1 do matrix[i] = { [0] = i } end
    for j = 0, len2 do matrix[0][j] = j end

    for i = 1, len1 do
        for j = 1, len2 do
            local cost = (s1:sub(i, i) == s2:sub(j, j)) and 0 or 1
            matrix[i][j] = math.min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + cost)
        end
    end

    return matrix[len1][len2]
end

local top_command
local tabbed_in = false

local function index_contents(str)
    if str == "" then
        prediction_label.Text = ""
        top_command = nil
        return
    end

    local cmd, args = str:match("^(%S+)%s*(.*)")
    if args and args ~= "" then
        prediction_label.Text = ""
        top_command = nil
        return
    end

    local original_input = str
    local pattern_input = str:gsub('%W', '%%%1')

    local best_match, best_score
    for name in pairs(cmds.list) do
        local score = levenshtein(pattern_input:lower(), name:lower())

        if name:lower():find("^" .. pattern_input:lower()) then
            score = score - 3
        end

        if not best_score or score < best_score then
            best_match = name
            best_score = score
        end
    end

    prediction_label.Text = best_match or ""
    
    if best_match and best_match:lower() == original_input:lower() then
        top_command = nil
    else
        top_command = best_match
    end
end

field:GetPropertyChangedSignal("Text"):Connect(function()
	if field:IsFocused() then
		index_contents(field.Text)
	end
end)

local function on_focused()
    task.wait()
    if not tabbed_in then
        field.Text = ''
    end
    local tween = TweenService:Create(field, TweenInfo.new(0.3, Enum.EasingStyle.Sine), { BackgroundTransparency = 0, TextTransparency = 0 })
    tween:Play()
    tween = TweenService:Create(prediction_label, TweenInfo.new(0.3, Enum.EasingStyle.Sine), { TextTransparency = 0.5 })
    tween:Play()
end

local function on_focus_lost(enter_pressed)
    if tabbed_in then
        return
    end
    if enter_pressed then
        coroutine.resume(coroutine.create(cmds.execute), cmds, field.Text)
    end
    local tween = TweenService:Create(field, TweenInfo.new(0.3, Enum.EasingStyle.Sine), { BackgroundTransparency = 1, TextTransparency = 1 })
    tween.Completed:Connect(function(playbackState)
        if playbackState == Enum.PlaybackState.Completed then
            field.Visible = false
        end
    end)
    tween:Play()
    tween = TweenService:Create(prediction_label, TweenInfo.new(0.3, Enum.EasingStyle.Sine), { TextTransparency = 1 })
    tween:Play()
end

connect(field.Focused, on_focused)
connect(field.FocusLost, on_focus_lost)
connect(UserInputService.InputBegan, function(io, gpe)
    if gpe == false and io.KeyCode == Enum.KeyCode.Semicolon then
        field.Visible = true
        field:CaptureFocus()
    elseif field:IsFocused() and io.KeyCode == Enum.KeyCode.Tab then
        local text = field.Text:match("^%s*(.-)%s*$")
        local cmd, rest = text:match("^(%S+)%s*(.*)")
        if cmd and cmds.list[cmd] == nil then
            tabbed_in = true
            field:ReleaseFocus(false)
            task.wait()
            if type(top_command) == 'string' then
                field.Text = top_command
            end
            field:CaptureFocus()
            task.wait()
            tabbed_in = false
        end
    end
end)

field.Parent = ui

--[=[ END UI ]=]--

env.stop_basic_commands = function()
    for _, c in pairs(connections) do
        if typeof(c) == 'RBXScriptConnection' and c.Connected then
            c:Disconnect()
        end
    end
    for _, i in pairs(instances) do
        if typeof(i) == 'Instance' then
            i:Destroy()
        end
    end
end

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    print('[BC]: Mobile support is unavailable at this time.')
    env.stop_basic_commands()
end
--[=[
    thuarnel
    rbx-basic-esp
    3/13/2025
]=]--

--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_thuarnel_basic_esp) == 'function' then
    env.stop_thuarnel_basic_esp()
end

local trackself = false
local insert = table.insert
local instances = {}
local connections = {}

local function connect(signal, callback)
    if typeof(signal) == 'RBXScriptSignal' then
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end
end

--[=[ START SCRIPT ]=]--

local players = game:GetService('Players')
local coregui = game:GetService('CoreGui')
local runtime = game:GetService('RunService')

local camera = workspace.CurrentCamera
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
    camera = workspace.CurrentCamera
end)

local red, green = Color3.fromRGB(255, 37, 40), Color3.fromRGB(38, 255, 99)
local screengui = Instance.new('ScreenGui', coregui)
screengui.Name = 'thuarnelhlesp'
screengui.Enabled = true
screengui.ResetOnSpawn = false

local highlights = {}
local billboards = {}

local function new_player(player: Player)
    if typeof(player) == 'Instance' and player:IsA('Player') then
        local userid = player.UserId
        local highlight = highlights[userid]
        local billboard = billboards[userid]
        local label = typeof(billboard) == 'Instance' and billboard:FindFirstChildWhichIsA('TextLabel')

        pcall(function()
            highlights[highlight]:Destroy()
            highlights[highlight] = nil
        end)
        highlight = Instance.new('Highlight', screengui)
        highlight.Name = 'thuarnelhl_' .. tostring(userid)
        highlight.FillColor = red
        highlight.OutlineColor = red
        insert(instances, highlight)
        highlights[userid] = highlight

        pcall(function()
            billboards[billboard]:Destroy()
            billboards[billboard] = nil
        end)
        billboard = Instance.new('BillboardGui', coregui)
        billboard.Name = 'thuarnelesp_' .. tostring(userid)
        billboard.AlwaysOnTop = true
        insert(instances, billboard)
        billboards[billboard] = billboard

        label = Instance.new('TextLabel')
        label.Text = player.Name
        label.TextColor3 = Color3.new(1, 1, 1)
        label.BorderColor3 = red
        label.TextStrokeColor3 = Color3.new(red.R / 2, red.G / 2, red.B / 2)
        label.TextStrokeTransparency = 0.5
        label.BackgroundColor3 = Color3.new()
        label.BackgroundTransparency = 0.8
        label.BorderSizePixel = 1
        label.Size = UDim2.fromOffset(100, 25)
        label.AnchorPoint = Vector2.new(0.5, 1)
        label.Position = UDim2.fromScale(0.5, 0)
        label.Parent = billboard
        insert(instances, label)

        local function new_character(character)
            local humanoid = character and character:FindFirstChildWhichIsA('Humanoid')
            local rootpart = humanoid and humanoid.RootPart
            local connection = connections[userid]
    
            if typeof(connection) == 'RBXScriptConnection' and connection.Connected then
                connection:Disconnect()
            end
            
            connections[userid] = runtime.Stepped:Connect(function()
                if typeof(character) == 'Instance' then
                    highlight.Adornee = character
                    billboard.Adornee = character
                end

                if typeof(player) == 'Instance' and (player.Neutral or player.Team ~= localplayer.Team) and typeof(rootpart) == 'Instance' and rootpart:IsA('BasePart') then
                    local _, on_screen = camera:WorldToScreenPoint(rootpart.Position)
    
                    if on_screen then
                        local target = mouse.Target
                        local model = typeof(target) == 'Instance' and target:FindFirstAncestorWhichIsA('Model')
                        local extents_size = character:GetExtentsSize()
    
                        local top = camera:WorldToViewportPoint(rootpart.Position + Vector3.new(0, extents_size.Y / 2, 0))
                        local bottom = camera:WorldToViewportPoint(rootpart.Position - Vector3.new(0, extents_size.Y / 2, 0))
                        local left = camera:WorldToViewportPoint(rootpart.Position - Vector3.new(extents_size.X / 2, 0, 0))
                        local right = camera:WorldToViewportPoint(rootpart.Position + Vector3.new(extents_size.X / 2, 0, 0))
        
                        local pixelHeight = math.abs(top.Y - bottom.Y)
                        local pixelWidth = math.abs(right.X - left.X)
                        
                        billboard.Size = UDim2.fromOffset(pixelWidth, pixelHeight)
    
                        if model == character then
                            highlight.FillColor = green
                            highlight.OutlineColor = green
                            label.BorderColor3 = green
                            label.TextStrokeColor3 = Color3.new(green.R / 2, green.G / 2, green.B / 2)
                        else
                            highlight.FillColor = red
                            highlight.OutlineColor = red
                            label.BorderColor3 = red
                            label.TextStrokeColor3 = Color3.new(red.R / 2, red.G / 2, red.B / 2)
                        end
    
                        highlight.Enabled = true
                        billboard.Enabled = true

                        if not label.Visible then
                            label.Visible = true
                        end
                    else
                        highlight.Enabled = false
                        billboard.Enabled = false
                    end
                end
            end)
        end

        local character = player.Character
        if character then
            coroutine.wrap(new_character)(character)
        end

        connect(player.CharacterAdded, function()
            character = player.Character
            if character then
                coroutine.wrap(new_character)(character)
            end
        end)
    end
end

for _, v in pairs(players:GetPlayers()) do
    if trackself or v ~= localplayer then
        new_player(v)
    end
end

connect(players.PlayerAdded, function(v)
    if trackself or v ~= localplayer then
        new_player(v)
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_thuarnel_basic_esp = function()
    break_all_loops = true
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end

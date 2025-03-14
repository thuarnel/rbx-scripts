--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_basic_esp) == 'function' then
    env.stop_basic_esp()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    if typeof(signal) == 'RBXScriptSignal' then
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end
end

local players = game:GetService("Players")
local runtime = game:GetService("RunService")
local localplayer = players.LocalPlayer

local function getprimarypos()
    return localplayer.Character:GetPivot().Position
end

local function highlightPlayer(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:FindFirstChild('Head')

    if character then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 150, 0, 100)
        billboardGui.Adornee = head
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)

        local distanceText = Instance.new("TextLabel")
        distanceText.Size = UDim2.new(1, 0, 0.5, 0)
        distanceText.BackgroundTransparency = 1
        distanceText.TextColor3 = Color3.new(0, 0, 0)
        distanceText.TextScaled = true
        distanceText.Position = UDim2.new(0, 0, 0.5, 0)
        distanceText.Parent = billboardGui
        
        local nameText = Instance.new("TextLabel")
        nameText.Size = UDim2.new(1, 0, 0.5, 0)
        nameText.BackgroundTransparency = 1
        nameText.TextColor3 = Color3.new(0, 0, 0)
        nameText.TextScaled = true
        nameText.Text = player.Name
        nameText.Position = UDim2.new(0, 0, 0, 0)

        nameText.Parent = billboardGui
        highlight.Parent = billboardGui
        billboardGui.Parent = head
        
        connect(runtime.RenderStepped, function()
            if typeof(character.PrimaryPart) == 'Instance' and character.PrimaryPart:IsA('BasePart') then
                local primary_pos = select(2, pcall(getprimarypos))
                local distance = (primary_pos - character.PrimaryPart.Position).magnitude
                distanceText.Text = string.format("%.1f", distance)
            end
        end)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localplayer then
        coroutine.resume(coroutine.create(highlightPlayer), player)
    end
end

connect(Players.PlayerAdded, function(player)
    connect(player.CharacterAdded, highlightPlayer)
end)

env.stop_basic_esp = function()
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end
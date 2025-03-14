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

local insert = table.insert
local instances = {}
local connections = {}
local break_all_loops = false

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
local player = players.LocalPlayer
local mouse = player:GetMouse()

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
    camera = workspace.CurrentCamera
end)

local red, green = Color3.fromRGB(255, 37, 40), Color3.fromRGB(38, 255, 99)
local screengui = Instance.new('ScreenGui')
screengui.Name = ''
screengui.Enabled = true
screengui.ResetOnSpawn = false
screengui.Parent = coregui
local highlights = {}
local billboards = {}

local function new_character(player, character)
    if typeof(player) == 'Instance' and player:IsA('Player') and typeof(character) == 'Instance' and character:IsA('Model') then
        local highlight = highlights[player.UserId]
        local billboard = billboards[player.UserId]

        if not highlight then
            highlight = Instance.new('Highlight')
            highlight.Name = ''
            highlight.FillColor = red
            highlight.OutlineColor = red
            highlight.Parent = screengui
            highlights[player.UserId] = highlight
        end

        if not billboard then
            billboard = Instance.new('BillboardGui')
            billboard.Name = 'thuarnelesp_' .. tostring(player.UserId)
            billboard.Parent = coregui
            billboards[billboard] = billboard
        end

        local humanoid = character:FindFirstChildWhichIsA('Humanoid')
        local rootpart = humanoid and humanoid.RootPart

        connect(runtime.Stepped, function(elapsed_time, delta_time)
            if typeof(rootpart) == 'Instance' and rootpart:IsA('BasePart') then
                local _, on_screen = camera:WorldToScreenPoint(rootpart.Position)

                if on_screen then
                    local target = mouse.Target
                    local model = typeof(target) == 'Instance' and target:FindFirstAncestorWhichIsA('Model')

                    if model == character then
                        highlight.FillColor = green
                        highlight.OutlineColor = green
                    else
                        highlight.FillColor = red
                        highlight.OutlineColor = red
                    end

                    highlight.Adornee = character
                    billboard.Adornee = character
                end
            end
        end)
    end
end

local function new_player(player)
    if typeof(player) == 'Instance' and player:IsA('Player') then
        player.CharacterAdded:Connect(function(character)
            new_character(player, character)
        end)
        new_character(player, player.Character)
    end
end

for _, player in pairs(players:GetPlayers()) do
    new_player(player)
end

players.PlayerAdded:Connect(function(player)
    new_player(player)
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

--!nocheck
--!nolint UnknownGlobal

--- made by thuarnel
--- for grow your country
--- https://www.roblox.com/games/128017651370280
--- @diagnostic disable: undefined-global

local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_grow_country) == 'function' then
    env.stop_grow_country()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

--[=[ START SCRIPT ]=]--

local runtime = game:GetService('RunService')
local players = game:GetService('Players')

local player = players.LocalPlayer
local blobs = workspace:WaitForChild('Blobs')
local wait = task.wait

local function getrootpart()
    return player.Character.Humanoid.RootPart
end

connect(runtime.Stepped, function()
    local root = select(2, pcall(getrootpart))

    if root then
        local x = 0
        for _, blob in pairs(blobs:GetChildren()) do
            x += 1
            if x > 50 then
                break
            end
            blob.CFrame = CFrame.new(root.CFrame.Position)
        end
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_grow_country = function()
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end

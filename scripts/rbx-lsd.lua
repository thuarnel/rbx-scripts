--!nocheck
--!nolint UnknownGlobal

--- made by thuarnel
--- use in any game for free LSD
--- @diagnostic disable: undefined-global

local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_lsd) == 'function' then
    env.stop_lsd()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

--[=[ START SCRIPT ]=]--

local lighting = game:GetService('Lighting')
local runtime = game:GetService('RunService')

local cce = Instance.new('ColorCorrectionEffect')
cce.Contrast = 10
cce.Brightness = 0
cce.Parent = lighting
table.insert(instances, cce)

local x = 0

connect(runtime.Stepped, function()
    x = x + 1
    cce.Brightness = 0.25 * math.cos(x / 32)
    cce.TintColor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
end)

--[=[ END SCRIPT ]=]--

env.stop_lsd = function()
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end

--!nocheck
--!nolint UnknownGlobal

--[=[
    thuarnel
    rbx-vehicle-mod
    3/9/2025
]=]--

--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_vehicle_mod) == 'function' then
    env.stop_vehicle_mod()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    if typeof(signal) == 'RBXScriptSignal' then
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end
    return nil
end

--[=[ START SCRIPT ]=]--

local service = setmetatable({}, { __index = function(_, key) return game:GetService(key) end })

local players = service.Players
local runtime = service.RunService
local inputservice = service.UserInputService

local player = players.LocalPlayer
local character, humanoid, seatpart

local function getcharacter()
    character = player.Character
    return typeof(character) == 'Instance' and character:IsA('Model') and character
end

local function gethumanoid()
    local character = getcharacter()
    humanoid = character and character:FindFirstChildOfClass('Humanoid')
    return humanoid
end

local function getseatpart()
    local humanoid = gethumanoid()
    seatpart = humanoid and humanoid.SeatPart
    return seatpart
end

function get_value_from_fps(fps, value)
    return value * (60 / fps)
end

local last_update_time = 0
local fps_limit = 1 / 60
local frame_count = 0
local fps = 0

local multiplier_w = 0.025
local multiplier_s = 0.05

connect(runtime.Stepped, function(elapsed_time, delta_time)
    local current_time = tick()
    frame_count = frame_count + 1

    if current_time - last_update_time >= 1 then
        fps = frame_count
        frame_count = 0
        last_update_time = current_time
    end

    if current_time - last_update_time >= fps_limit then
        local seat = getseatpart()

        if not seat then
            return
        end

        local pressing_w = inputservice:IsKeyDown(Enum.KeyCode.W)
        local pressing_s = inputservice:IsKeyDown(Enum.KeyCode.S)
        local pressing_p = inputservice:IsKeyDown(Enum.KeyCode.P)

        if pressing_w then
            local mult = get_value_from_fps(fps, multiplier_w)
            seat.AssemblyLinearVelocity *= Vector3.new(1 + mult, 1, 1 + mult)
        elseif pressing_s then
            local mult = get_value_from_fps(fps, multiplier_s)
            seat.AssemblyLinearVelocity *= Vector3.new(1 - mult, 1, 1 - mult)
        elseif pressing_p then
            seat.AssemblyLinearVelocity *= Vector3.zero
        end

        last_update_time = current_time
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_vehicle_mod = function()
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end

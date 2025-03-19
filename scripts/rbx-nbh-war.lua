--!nocheck
--!nolint UnknownGlobal

--- made by thuarnel
--- for neighborhood war
--- https://www.roblox.com/games/13004241838
--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and type(env.stop_nbh_war) == 'function' then
    env.stop_nbh_war()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

--[=[ START SCRIPT ]=]--

local plrs = game:GetService('Players')
local teams = game:GetService('Teams')
local runtime = game:GetService('RunService')
local plr = plrs.LocalPlayer

local function get_character(p)
    return (p and p.Character) or plr.Character
end

local target_torso_size = Vector3.new(2, 2, 1)
local torso_tolerance = 0.001

local function is_within_tolerance(a, b, tolerance)
    return math.abs(a - b) <= tolerance
end

local function get_torso(p)
    local c = get_character(p)
    if c then
        local t = c:FindFirstChild('Torso')

        if t then
            return t
        end

        for _, v in pairs(c:GetChildren()) do
            if is_within_tolerance(v.Size.X, target_torso_size.X, torso_tolerance) and is_within_tolerance(v.Size.Y, target_torso_size.Y, torso_tolerance) and is_within_tolerance(t.Size.Z, target_torso_size.Z, torso_tolerance) then
                return v
            end
        end
    end
    return nil
end

local function get_team_from_brickcolor(brickcolor)
    for _, t: Team in pairs(teams:GetTeams()) do
        if t.TeamColor == brickcolor then
            return t
        end
    end
    return nil
end

connect(runtime.Stepped, function()
    for _, p: Player in pairs(plrs:GetPlayers()) do
        local t = get_torso(p)
        
        if t then
            local color = t.BrickColor :: BrickColor?
            if color then
                local team = get_team_from_brickcolor(color)

                if not team then
                    team = Instance.new('Team')
                    team.Name = color.Name
                    team.TeamColor = color
                    team.Parent = teams
                end
                
                p.Team = team
                p.TeamColor = color
            end
        end
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_nbh_war = function()
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    for _, i in ipairs(instances) do
        i:Destroy()
    end
end

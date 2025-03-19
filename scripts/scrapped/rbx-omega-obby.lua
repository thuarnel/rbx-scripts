--!nocheck
--!nolint UnknownGlobal

--- made by thuarnel
--- @diagnostic disable: undefined-global

local env = type(getgenv) == 'function' and getgenv()

if type(env) == 'table' and env.stop_omega_obby then
    env.stop_omega_obby()
end

local wait = task.wait
local twn = game:GetService('TweenService')
local plrs = game:GetService('Players')
local plr = plrs.LocalPlayer

local current_stage = tonumber(select(2, pcall(function() return plr.leaderstats.Stage.Value end)))
if type(current_stage) ~= 'number' then
    current_stage = 1
end
current_stage = math.max(current_stage, 1)

local break_all_loops = false

function env.stop_omega_obby()
    break_all_loops = true
end

local stage_parts_folder = workspace:WaitForChild('StageFolder')
local stages_obj = workspace:WaitForChild('Stages')
local stages = {}

for _, v in pairs(stages_obj:GetChildren()) do
    if v:IsA('Folder') and tonumber(v.Name) then
        stages[tonumber(v.Name)] = v
    end
end

local function getrootpart(plr)
    local char = plr.Character
    local hum = typeof(char) == 'Instance' and char:FindFirstChildWhichIsA('Humanoid')
    local root = hum and hum.RootPart
    return root
end

local function disable_touching()
    for _, v in pairs(stage_parts_folder:GetDescendants()) do
        if v:IsA('BasePart') then
            v.CanTouch = false
        end
    end
end

disable_touching()

for i = current_stage, #stages, 1 do
    if break_all_loops then
        break
    end

    if i % 50 == 0 then
        disable_touching()
    end

    local root = select(2, pcall(getrootpart, plr))

    local stage = stages[i]
    print('Going to stage #' .. i)
    local spawn = stage:FindFirstChild('Spawn')
    
    if spawn then
        local t = twn:Create(root, TweenInfo.new(0.5), {CFrame = spawn.CFrame})
        t:Play()
        t.Completed:Wait()
        wait()
        firetouchinterest(root, spawn, 1)
        wait()
        firetouchinterest(root, spawn, 0)
        wait()
    else
        print('No spawn found for stage #' .. i)
        break
    end
end

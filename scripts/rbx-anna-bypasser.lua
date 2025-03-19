--!nocheck
--!nolint UnknownGlobal

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local env = type(getgenv) == 'function' and getgenv()

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
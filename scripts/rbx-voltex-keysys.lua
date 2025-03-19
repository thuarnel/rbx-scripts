--!nocheck
--!nolint UnknownGlobal

--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env.stop_voltex_key_system) == 'function' then
	env.stop_voltex_key_system()
end

local wait = task.wait

local instances = {}
local connections = {}

local function connect(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(connections, connection)
	return connection
end

--- Sets the specified string argument towards the user clipboard.
--- @type function
local setclipboard = env.setclipboard

--[=[ BEGIN SCRIPT ]=]--

local key_ui = Instance.new("ScreenGui")
key_ui.Name = "key_ui"
key_ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Name = "frame"
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.new(0.0627, 0.0627, 0.0627)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BorderColor3 = Color3.new()
frame.BorderSizePixel = 0
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Parent = key_ui

local getkeybutton = Instance.new("TextButton")
getkeybutton.Name = "getkeybutton"
getkeybutton.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json")
getkeybutton.TextColor3 = Color3.new(1, 1, 1)
getkeybutton.Text = "get key (noob)"
getkeybutton.AnchorPoint = Vector2.new(0.5, 0)
getkeybutton.BackgroundColor3 = Color3.new(0.251, 0.251, 0.251)
getkeybutton.Position = UDim2.new(0.5, 0, 0.75, 0)
getkeybutton.BorderSizePixel = 0
getkeybutton.BorderColor3 = Color3.new()
getkeybutton.TextSize = 14
getkeybutton.Size = UDim2.new(0.4, 0, 0.1, 0)
getkeybutton.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Name = "stroke"
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.LineJoinMode = Enum.LineJoinMode.Miter
stroke.Color = Color3.new(0.502, 0.502, 0.502)
stroke.Parent = getkeybutton

local stroke_2 = Instance.new("UIStroke")
stroke_2.Name = "stroke"
stroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke_2.LineJoinMode = Enum.LineJoinMode.Miter
stroke_2.Color = Color3.new(0, 0.584, 1)
stroke_2.Thickness = 3
stroke_2.Parent = frame

local submitbutton = Instance.new("TextButton")
submitbutton.Name = "submitbutton"
submitbutton.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json")
submitbutton.TextColor3 = Color3.new(1, 1, 1)
submitbutton.Text = "submit"
submitbutton.AnchorPoint = Vector2.new(0.5, 0)
submitbutton.BackgroundColor3 = Color3.new(0.251, 0.251, 0.251)
submitbutton.Position = UDim2.new(0.5, 0, 0.55, 0)
submitbutton.BorderSizePixel = 0
submitbutton.BorderColor3 = Color3.new()
submitbutton.TextSize = 14
submitbutton.Size = UDim2.new(0.6, 0, 0.15, 0)
submitbutton.Parent = frame

local stroke_3 = Instance.new("UIStroke")
stroke_3.Name = "stroke"
stroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke_3.LineJoinMode = Enum.LineJoinMode.Miter
stroke_3.Color = Color3.new(0.502, 0.502, 0.502)
stroke_3.Parent = submitbutton

local field = Instance.new("TextBox")
field.Name = "field"
field.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json")
field.BackgroundColor3 = Color3.new(0.125, 0.125, 0.125)
field.TextColor3 = Color3.new(1, 1, 1)
field.BorderColor3 = Color3.new(0.125, 0.125, 0.125)
field.Text = ""
field.TextSize = 14
field.CursorPosition = -1
field.AnchorPoint = Vector2.new(0.5, 0)
field.BorderSizePixel = 0
field.TextWrapped = true
field.Position = UDim2.new(0.5, 0, 0.25, 0)
field.PlaceholderText = "input key"
field.TextScaled = true
field.Size = UDim2.new(1, -15, 0.25, 0)
field.Parent = frame

local stroke_4 = Instance.new("UIStroke")
stroke_4.Name = "stroke"
stroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke_4.LineJoinMode = Enum.LineJoinMode.Miter
stroke_4.Color = Color3.new(0.251, 0.251, 0.251)
stroke_4.Parent = field

local title = Instance.new("TextLabel")
title.Name = "title"
title.FontFace = Font.new("rbxasset://fonts/families/Sarpanch.json")
title.TextColor3 = Color3.new(0, 0.584, 1)
title.BorderColor3 = Color3.new()
title.Text = "key sys"
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BorderSizePixel = 0
title.BackgroundTransparency = 1
title.TextScaled = true
title.TextWrapped = true
title.TextSize = 14
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Parent = frame

key_ui.Parent = game:GetService('CoreGui')
local str = game:HttpGet('https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-placeholder-keyscript.lua') -- no script yet
local func = loadstring(str)

connect(submitbutton.MouseButton1Up, function()
    local key = field.Text:lower()
    local response = func(key)
    if response ~= true then
        title.Text = 'wrong key broski'
        wait(3)
        title.Text = 'key sys'
    else
        title.Text = 'omg key worked ok bye'
        wait(1)
        env.stop_voltex_key_system()
    end
end)

connect(getkeybutton.MouseButton1Up, function()
    if type(setclipboard) == 'function' then
        setclipboard('https://vtex.mysellauth.com/')
        title.Text = 'copied to clipboard (paste in your browser)'
    else
        title.Text = 'imagine not having setclipboard'
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_voltex_key_system = function()
	for _, c in ipairs(connections) do
		c:Disconnect()
	end
	for _, i in ipairs(instances) do
		i:Destroy()
	end
end
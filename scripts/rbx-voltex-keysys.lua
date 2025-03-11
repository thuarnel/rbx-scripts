--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env.stop_voltex_key_system) == 'function' then
	env.stop_voltex_key_system()
end

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

local players = game:GetService('Players')
local coregui = game:GetService('CoreGui')
local localplayer = players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", coregui)
table.insert(instances, ScreenGui)

local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner") 
local EnterKeyButton = Instance.new("TextButton")
local GetKeyButton = Instance.new("TextButton")
local BackButton = Instance.new("TextButton")
local TextBox = Instance.new("TextBox")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0.4, 0, 0.3, 0) 
Frame.Position = UDim2.new(0.3, 0, 0.35, 0) 
Frame.BackgroundColor3 = Color3.fromRGB(169, 169, 169)

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 10)

EnterKeyButton.Parent = Frame
EnterKeyButton.Size = UDim2.new(0.4, 0, 0.3, 0)
EnterKeyButton.Position = UDim2.new(0.05, 0, 0.35, 0) 
EnterKeyButton.Text = "Enter Key"
EnterKeyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
EnterKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterKeyButton.Visible = true  


GetKeyButton.Parent = Frame
GetKeyButton.Size = UDim2.new(0.4, 0, 0.3, 0)
GetKeyButton.Position = UDim2.new(0.55, 0, 0.35, 0) 
GetKeyButton.Text = "Get Key"
GetKeyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.Visible = true

BackButton.Parent = Frame
BackButton.Size = UDim2.new(0.2, 0, 0.2, 0)
BackButton.Position = UDim2.new(0, 0, 0, 0)
BackButton.Text = "Back"
BackButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.Visible = false 

EnterKeyButton.MouseButton1Click:Connect(function()
    EnterKeyButton.Visible = false
    GetKeyButton.Visible = false

    TextBox.Parent = Frame
    TextBox.Size = UDim2.new(0.8, 0, 0.3, 0)
    TextBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    TextBox.PlaceholderText = "Enter your key here"
    TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.Visible = true  

    BackButton.Visible = true

    local BackButton2 = Instance.new("TextButton")
    BackButton2.Parent = Frame
    BackButton2.Size = UDim2.new(0.2, 0, 0.2, 0)
    BackButton2.Position = UDim2.new(0, 0, 0, 0)
    BackButton2.Text = "Back"
    BackButton2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    BackButton2.TextColor3 = Color3.fromRGB(255, 255, 255)

    BackButton2.MouseButton1Click:Connect(function()
        TextBox.Visible = false
        BackButton2.Visible = false
        EnterKeyButton.Visible = true
        GetKeyButton.Visible = true
        BackButton.Visible = false
    end)
end)

GetKeyButton.MouseButton1Up:Connect(function()
    if type(setclipboard) == 'function' then
        setclipboard('i farted')
    else
        localplayer:Kick('if your exploit doesnt support setclipboard wtf u doin')
    end
end)

--[=[ END SCRIPT ]=]--

env.stop_voltex_key_system = function()
	stop_loops = true
	for _, c in ipairs(connections) do
		c:Disconnect()
	end
	for _, i in ipairs(instances) do
		i:Destroy()
	end
end
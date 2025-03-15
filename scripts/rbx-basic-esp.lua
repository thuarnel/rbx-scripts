--[=[
    thuarnel
    rbx-basic-esp
    3/14/2025
]=]--

local RunService = game:GetService('RunService')
local env = RunService:IsStudio() and {} or (type(getgenv) == 'function' and getgenv())

if type(env) == 'table' and type(env.stop_thuarnel_basic_esp) == 'function' then
	env.stop_thuarnel_basic_esp()
end

local instances: { [number]: Instance } = {}
local connections: { [number]: RBXScriptConnection } = {}

local function connect(signal: RBXScriptSignal?, callback: (...any) -> (...any)): RBXScriptConnection?
	if typeof(signal) == 'RBXScriptSignal' then
		local connection = signal:Connect(callback)
		table.insert(connections, connection)
		return connection
	end
	return nil
end

local Players = game:GetService('Players')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')

local insert = table.insert
local remove = table.remove
local find = table.find

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'ThuarnelESP'
ScreenGui.DisplayOrder = 1e7
ScreenGui.ResetOnSpawn = false
insert(instances, ScreenGui)
ScreenGui.Parent = CoreGui

-- local is_phantom_forces = game.PlaceId == 292439477
local red, green, blue = Color3.fromRGB(255, 37, 40), Color3.fromRGB(38, 255, 99), Color3.fromRGB(0, 172, 255)
local localplayer = Players.LocalPlayer
local mouse = localplayer:GetMouse()

local assignees = {}
local assigned = {}

local esp = {}
esp.__index = esp

local function is_position_on_viewport(position: Vector3)
    local currentcamera = workspace.CurrentCamera
    if typeof(currentcamera) == 'Instance' and currentcamera:IsA('Camera') and typeof(position) == 'Vector3' then
	    local _, onScreen = currentcamera:WorldToViewportPoint(position)
	    return onScreen
    end
    return false
end

local function is_position_obstructed(position: Vector3, parameters: RaycastParams?)
    if not is_position_on_viewport(position) then
        return false
    end
    local currentcamera = workspace.CurrentCamera
    if typeof(currentcamera) == 'Instance' and currentcamera:IsA('Camera') and typeof(position) == 'Vector3' then
	    local direction = (position - currentcamera.CFrame.Position).Unit * (position - currentcamera.CFrame.Position).Magnitude
	    local rayResult = workspace:Raycast(currentcamera.CFrame.Position, direction, parameters)
	    return rayResult ~= nil
    end
    return false
end

local function visibility_check(self, highlight: Highlight?, billboard: BillboardGui?, label: TextLabel?) 
    while true do
        local player: Player?, character: Model? = self:getassignment()
        if not player and not character then
            break
        end

        local name = (player and player.Name) or self.uniqueid

        if character then
            local humanoid = character:FindFirstChildWhichIsA('Humanoid')
            local rootpart = humanoid and humanoid.RootPart or character:FindFirstChild('HumanoidRootPart')

            if highlight and label then
                if not is_position_obstructed(rootpart) then
                    if typeof(mouse.Target) == 'Instance' and mouse.Target:IsDescendantOf(character) then
                        highlight.FillColor = blue
                        highlight.OutlineColor = blue
                        label.BorderColor3 = blue
                        label.TextStrokeColor3 = Color3.new(blue.R / 2, blue.G / 2, blue.B / 2)
                    else
                        highlight.FillColor = green
                        highlight.OutlineColor = green
                        label.BorderColor3 = green
                        label.TextStrokeColor3 = Color3.new(green.R / 2, green.G / 2, green.B / 2)
                    end
                else
                    highlight.FillColor = red
                    highlight.OutlineColor = red
                    label.BorderColor3 = red
                    label.TextStrokeColor3 = Color3.new(red.R / 2, red.G / 2, red.B / 2)
                end
            end

            if highlight then
                highlight.Adornee = character
            end
            if billboard then
                billboard.Adornee = character
            end
            if label then
                label.Text = name
            end
        end

        RunService.Stepped:Wait()
    end
end

function esp.new()
    local self = setmetatable({}, esp)
    self.player = nil :: Player?
    self.character = nil :: Model?
    self.objects = {} :: { [number]: Instance }
    self.uniqueid = HttpService:GenerateGUID(false) :: string
    local event = Instance.new('BindableEvent')
    event.Name = 'Changed'
    event.Parent = ScreenGui
    connect(event.Event, function(situation)
        -- Destroy previous ESP objects
        for _, object in pairs(self.objects) do
            if typeof(object) == 'Instance' then
                object:Destroy()
            end
        end
        self.objects = {}  -- clear out the table

        if situation == 'assigned' then
            local player, character = self:getassignment()
            if typeof(player) == 'Instance' and player:IsA('Player') and typeof(character) == 'Instance' and character:IsA('Model') then
                local highlight = Instance.new('Highlight', ScreenGui)
                highlight.Name = 'thuarnelhl_' .. self.uniqueid
                highlight.FillColor = red
                highlight.OutlineColor = red
                insert(self.objects, highlight)

                local billboard = Instance.new('BillboardGui', CoreGui)
                billboard.Name = 'thuarnelesp_' .. self.uniqueid
                billboard.AlwaysOnTop = true
                billboard.Adornee = character
                insert(instances, billboard)
                
                local label = Instance.new('TextLabel')
                label.Text = player.Name
                label.TextColor3 = Color3.new(1, 1, 1)
                label.BorderColor3 = red
                label.TextStrokeColor3 = Color3.new(red.R / 2, red.G / 2, red.B / 2)
                label.TextStrokeTransparency = 0.5
                label.BackgroundColor3 = Color3.new()
                label.BackgroundTransparency = 0.8
                label.BorderSizePixel = 1
                label.Size = UDim2.fromOffset(100, 25)
                label.AnchorPoint = Vector2.new(0.5, 1)
                label.Position = UDim2.fromScale(0.5, 0)
                label.Parent = billboard
                insert(self.objects, billboard)

                coroutine.resume(coroutine.create(visibility_check), self, highlight, billboard, label)
            end
        end
    end)
    self.event = event :: BindableEvent
    return self
end

-- Now the assignment method actually stores the player/character
function esp:assign(value: Instance)
    if typeof(value) == 'Instance' then
        if value:IsA('Player') then
            self.player = value
            self.character = value.Character
        elseif value:IsA('Model') then
            local player = Players:GetPlayerFromCharacter(value)
            if typeof(player) == 'Instance' and player:IsA('Player') then
                self.player = player
            end
            self.character = value
        end
    end
    return self.player, self.character
end

-- getassignment now just returns what was stored
function esp:getassignment(): (Player?, Model?)
    return self.player, self.character
end

-- Helper to check if a player is already assigned an ESP instance
local function isPlayerAssigned(player: Player): boolean
    for _, espInstance in ipairs(assigned) do
        if espInstance.player == player then
            return true
        end
    end
    return false
end

for i = 1, 31 do
    insert(assignees, esp.new())
end

connect(RunService.Stepped, function(elapsed_time: number, delta_time: number)
    for _, player in pairs(Players:GetPlayers()) do
        if not isPlayerAssigned(player) then
            for _, espInstance in pairs(assignees) do
                if type(espInstance) == 'table' and type(espInstance.assign) == 'function' then
                    espInstance:assign(player)
                    espInstance.event:Fire('assigned')
                    insert(assigned, espInstance)
                    local index = find(assignees, espInstance)
                    if index then
                        remove(assignees, index)
                    end
                    break
                end
            end
        end
    end

    for _, espInstance in pairs(assigned) do
        local character = select(2, espInstance:getassignment())
        if not character or not character.Parent then
            insert(assignees, espInstance)
            espInstance.event:Fire()
            local index = find(assigned, espInstance)
            if index then
                remove(assigned, index)
            end
        end
    end
end)

env.stop_thuarnel_basic_esp = function()
	for _, connection: RBXScriptConnection? in pairs(connections) do
		if typeof(connection) == 'RBXScriptConnection' and connection.Connected then
			connection:Disconnect()
		end
	end
	for _, instance: Instance? in pairs(instances) do
		if typeof(instance) == 'Instance' then
			instance:Destroy()
		end
	end
end
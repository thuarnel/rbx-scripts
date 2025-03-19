--!nocheck
--!nolint UnknownGlobal

--[=[
	Script created by thuarnel

    rbx-basic-esp
    3/14/2025

	Features:
        - General ESP
        - Phantom Forces support
        - Open Source! (You're welcome)

	Contact:
		- Discord: thuarnel
		- Discord Server: https://discord.gg/wat
]=]

local RunService = game:GetService('RunService')
local env = RunService:IsStudio() and {} or (type(getgenv) == 'function' and getgenv())

if type(env) == 'table' and type(env.stop_thuarnel_basic_esp) == 'function' then
    -- print('[BE]: ❌ Stopping previous instance of thuarnel\'s Basic ESP...')
	env.stop_thuarnel_basic_esp()
end

-- print('[BE]: Starting new instance of thuarnel\'s Basic ESP...')

local breakloops: boolean = false
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

local is_phantom_forces = game.PlaceId == 292439477

local red, green, blue = Color3.fromRGB(255, 37, 40), Color3.fromRGB(38, 255, 99), Color3.fromRGB(0, 172, 255)
local localplayer = Players.LocalPlayer
local mouse = localplayer:GetMouse()

local assignees = {}
local assigned = {}

local currentcamera = workspace.CurrentCamera

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
    currentcamera = workspace.CurrentCamera
end)

local esp = {}
esp.__index = esp

local function is_position_on_viewport(position: Vector3)
    if not currentcamera then
        warn("Camera is nil")
        return false
    end

    local screenPosition, onScreen = currentcamera:WorldToViewportPoint(position)
    local viewportSize = currentcamera.ViewportSize
    local x, y = screenPosition.X, screenPosition.Y
    local isWithinBounds = x >= 0 and x <= viewportSize.X and y >= 0 and y <= viewportSize.Y

    return onScreen and isWithinBounds
end

local default_parameters = RaycastParams.new()
default_parameters.FilterDescendantsInstances = { currentcamera }
default_parameters.FilterType = Enum.RaycastFilterType.Exclude
default_parameters.IgnoreWater = true

local function is_position_obstructed(position: Vector3, parameters: RaycastParams, ...)
    if not currentcamera then return false end

    local newFilter = parameters.FilterDescendantsInstances and {unpack(parameters.FilterDescendantsInstances)} or {}

    for _, v in pairs({...}) do
        if typeof(v) == 'Instance' then
            table.insert(newFilter, v)
        end
    end

    local newParams = RaycastParams.new()
    newParams.FilterDescendantsInstances = newFilter
    newParams.FilterType = parameters.FilterType
    newParams.IgnoreWater = parameters.IgnoreWater

    if is_position_on_viewport(position) then
        local direction = (position - currentcamera.CFrame.Position)
        local raycast_result = workspace:Raycast(currentcamera.CFrame.Position, direction, newParams)
        return raycast_result ~= nil
    end

    return false
end

local sleeves = nil
local ghosts = Color3.fromRGB(231, 183, 88)
local phantoms = Color3.fromRGB(155, 182, 255)

local suit_ghosts = {
	['rbxassetid://5558971297'] = true,
	['rbxassetid://5614184140'] = true
}

local suit_phantoms = {
	['rbxassetid://5614184106'] = true,
	['rbxassetid://5558971356'] = true
}

workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function(...: any)
    if not find(default_parameters.FilterDescendantsInstances, currentcamera) then
        insert(default_parameters.FilterDescendantsInstances, currentcamera)
    end
    currentcamera = workspace.CurrentCamera
end)

local function is_target_character(target, esp)
    if typeof(target) == 'Instance' then
        return 
            (typeof(esp.character) == 'Instance' and (target == esp.character or target:IsDescendantOf(esp.character))) or
            (typeof(esp.rootpart) == 'Instance' and target == esp.rootpart)
    end
    return false
end

local function visibility_check(self, highlight: Highlight?, billboard: BillboardGui?, label: TextLabel?) 
    while true do
        if breakloops then
            break
        end

        local player, character, rootpart = self:getassignment()
        local name = (player and player.Name) or self.uniqueid

        if not is_phantom_forces and character and not rootpart then
            local humanoid = character:FindFirstChildWhichIsA('Humanoid')
            rootpart = humanoid and humanoid.RootPart or character:FindFirstChild('HumanoidRootPart')
            self.rootpart = rootpart
        elseif is_phantom_forces and rootpart and (not character or not character:IsDescendantOf(workspace)) then
            if typeof(sleeves) ~= 'Instance' or not sleeves:IsDescendantOf(currentcamera) then
                sleeves = currentcamera:FindFirstChild('Sleeves', true)
            end

            if (not character or not character:IsDescendantOf(workspace)) then
                local rayOrigin = rootpart.Position + Vector3.new(0, 3, 0)
                local rayDirection = Vector3.new(0, -6, 0)
                
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = { workspace:FindFirstChild('Map') }
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                
                if result then
                    local hitPart = result.Instance
                    local hitModel = hitPart:FindFirstAncestorWhichIsA('Model')
                    local playersFolder = hitPart:FindFirstAncestor('Players')
                    if playersFolder and hitModel then
                        character = hitModel
                        self.character = character
                    end
                end
            end
        end

        local is_friendly = false

        if is_phantom_forces and character then
            local my_team, their_team
            
            if sleeves then
                local texture = sleeves:FindFirstChildWhichIsA('Texture', true)
                if texture and texture:IsA('Texture') then
                    if texture.Color3 == ghosts then
                        my_team = 'ghosts'
                    elseif texture.Color3 == phantoms then
                        my_team = 'phantoms'
                    end
                end
            end
            
			if character then
				local texture = character:FindFirstChildWhichIsA('Texture', true)
				if texture then
					if suit_ghosts[texture.Texture] then
						their_team = 'ghosts'
					elseif suit_phantoms[texture.Texture] then
						their_team = 'phantoms'
					end
                end
            end

            is_friendly = my_team and my_team == their_team
        elseif not is_phantom_forces and typeof(player) == 'Instance' and player:IsA('Player') then
            local my_team = localplayer.Team
            local their_team = player.Team
            
            if typeof(my_team) == 'Instance' and my_team == their_team then
                is_friendly = false
            end
        end

        if highlight and label then
            if rootpart and not is_position_obstructed(rootpart.Position, default_parameters, rootpart, character) then
                local tgt = mouse.Target
                if typeof(tgt) == 'Instance' and is_target_character(tgt, esp) then
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
            highlight.Enabled = not is_friendly
            highlight.Adornee = character or rootpart
        end

        if billboard then
            -- billboard.Enabled = not is_friendly -- disabled for now
            billboard.Adornee = character or rootpart
        end

        if label then
            label.Text = name
        end

        task.wait(0.1)
    end
end

function esp.new()
    local self = setmetatable({}, esp)
    self.player = nil :: Player?
    self.character = nil :: Model?
    self.rootpart = nil :: BasePart?
    self.objects = {} :: { [number]: Instance }
    self.uniqueid = HttpService:GenerateGUID(false):sub(1, 10) :: string
    local event = Instance.new('BindableEvent')
    event.Name = 'Changed'
    event.Parent = ScreenGui
    connect(event.Event, function(situation)
        for _, object in pairs(self.objects) do
            if typeof(object) == 'Instance' then
                object:Destroy()
            end
        end
        self.objects = {}

        if situation == 'assigned' then
            local player, character, rootpart = self:getassignment()
            if (player and character) or rootpart then
                local highlight = Instance.new('Highlight', ScreenGui)
                highlight.Name = 'thuarnelhl_' .. self.uniqueid
                highlight.FillColor = red
                highlight.OutlineColor = red
                insert(self.objects, highlight)

                local billboard = Instance.new('BillboardGui', CoreGui)
                billboard.Name = 'thuarnelesp_' .. self.uniqueid
                billboard.ClipsDescendants = false
                billboard.AlwaysOnTop = true
                billboard.Enabled = false
                insert(instances, billboard)
                
                local label = Instance.new('TextLabel')
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
                label.ClipsDescendants = false
                label.Parent = billboard
                insert(self.objects, billboard)

                self.thread = coroutine.create(visibility_check)
                coroutine.resume(self.thread, self, highlight, billboard, label)
            end
        elseif situation == 'removed' then
            if type(self.thread) == 'thread' then
                coroutine.close(self.thread)
            end
        end
    end)
    self.event = event :: BindableEvent
    insert(instances, event)
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
        elseif value:IsA('BasePart') and is_phantom_forces then
            self.rootpart = value
        end
    end
    return self.player, self.character
end

function esp:getassignment(): (Player?, Model?, BasePart?)
    return self.player, self.character, self.rootpart
end

local function isPlayerAssigned(player: Player): boolean
    if player == localplayer then
        return true
    end
    for _, espInstance in ipairs(assigned) do
        if espInstance.player == player then
            return true
        end
    end
    return false
end

local function isRootAssigned(rootpart: BasePart): boolean
    for _, espInstance in ipairs(assigned) do
        if espInstance.rootpart == rootpart then
            return true
        end
    end
    return false
end

for i = 1, 31 do
    insert(assignees, esp.new())
end

local roots = is_phantom_forces and workspace:WaitForChild('Roots', 5)

local lastUpdate = 0
connect(RunService.Stepped, function()
    if tick() - lastUpdate < 0.2 then return end
    if is_phantom_forces and typeof(roots) == 'Instance' then
        for _, rootpart in pairs(roots:GetChildren()) do
            if not isRootAssigned(rootpart) then
                for _, espInstance in pairs(assignees) do
                    if type(espInstance) == 'table' and type(espInstance.assign) == 'function' then
                        espInstance:assign(rootpart)
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
    else
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
    end

    for _, espInstance in pairs(assigned) do
        local _, character, rootpart = espInstance:getassignment()
        if is_phantom_forces then
            if not rootpart or not rootpart.Parent then
                insert(assignees, espInstance)
                espInstance.event:Fire()
                local index = find(assigned, espInstance)
                if index then
                    remove(assigned, index)
                end
            end
        else
            if not character or not character.Parent then
                insert(assignees, espInstance)
                espInstance.event:Fire()
                local index = find(assigned, espInstance)
                if index then
                    remove(assigned, index)
                end
            end
        end
    end
end)

-- print('[BE]: ✅ Started new instance of thuarnel\'s Basic ESP!')

env.stop_thuarnel_basic_esp = function()
    breakloops = true
    
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

    instances = {}
    connections = {}

    for _, espInstance in pairs(assigned) do
        if espInstance and typeof(espInstance) == 'table' then
            espInstance.player = nil
            espInstance.character = nil
            espInstance.rootpart = nil
            espInstance.objects = {}
            espInstance.event:Fire('removed')

            for _, object in pairs(espInstance.objects) do
                if typeof(object) == 'Instance' then
                    object:Destroy()
                end
            end

            espInstance.objects = {}
        end
    end

    assigned = {}
    assignees = {}
    sleeves = nil
end

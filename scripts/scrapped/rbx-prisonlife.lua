local env = type(getgenv) == 'function' and getgenv()

if type(env) ~= 'table' then
    return
end

if type(env.stop_prisonlife_cmds) == 'function' then
    env.stop_prisonlife_cmds()
end

local clear = table.clear
local insert = table.insert
local instances = {}
local connections = {}

local function connect(signal, callback)
    if typeof(signal) == 'RBXScriptSignal' and type(callback) == 'function' then
        local connection = signal:Connect(callback)
        insert(connections, connection)
        return connection
    end
end

local players = game:GetService('Players')
local lighting = game:GetService('Lighting')
local repstore = game:GetService('ReplicatedStorage')
local tpservice = game:GetService('TeleportService')
local runtime = game:GetService('RunService')
local coregui = game:GetService('CoreGui')
local startergui = game:GetService('StarterGui')
local teams = game:GetService('Teams')
local uis = game:GetService('UserInputService')

local player = players.LocalPlayer
local mouse = player:GetMouse()
local character
local humanoid
local rootpart
local seatpart

local remotes = workspace:WaitForChild('Remote')
local item_handler = remotes:WaitForChild('ItemHandler')
local team_event = remotes:WaitForChild('TeamEvent')

local prison_halls = workspace:FindFirstChild('Prison_Halls')
local prison_cellblock = workspace:FindFirstChild('Prison_Cellblock')

local function new_character()
    character = character
    humanoid = character and (character:WaitForChild('Humanoid', 1) or character:FindFirstChildWhichIsA('Humanoid'))
    rootpart = humanoid and humanoid.RootPart or character:WaitForChild('HumanoidRootPart', 1)

    if humanoid and humanoid:IsA('Humanoid') then
        seatpart = humanoid.SeatPart

        connect(humanoid.Seated, function()
            if humanoid then
                seatpart = humanoid.SeatPart
            end
        end)

        connect(humanoid.GettingUp, function()
            seatpart = nil
        end)
    end
end

pcall(new_character)
connect(player.CharacterAdded, new_character)

local camera = workspace.CurrentCamera

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
    camera = workspace.CurrentCamera
end)

local prefix = '-'

local CmdGui = Instance.new("ScreenGui")
insert(instances, CmdGui)
local Background = Instance.new("Frame")
local CmdName = Instance.new("TextLabel")
local FindCmd = Instance.new("TextBox")
local CmdHandler = Instance.new("ScrollingFrame")
local CmdText = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local Background2 = Instance.new("Frame")
local Label = Instance.new("TextLabel")
local Execute = Instance.new("TextBox")
local Minimum = Instance.new("TextButton")
local Close = Instance.new("TextButton")

CmdGui.Name = "CmdGui"
CmdGui.Parent = coregui
CmdGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Background.Name = "Background"
Background.Parent = CmdGui
Background.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background.BorderSizePixel = 0
Background.Position = UDim2.new(0.368556708, 0, 0.11490047, 0)
Background.Size = UDim2.new(0, 350, 0, 350)
Background.Active = true
Background.Draggable = true

CmdName.Name = "CmdName"
CmdName.Parent = Background
CmdName.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CmdName.BorderSizePixel = 0
CmdName.Size = UDim2.new(0, 350, 0, 25)
CmdName.Font = Enum.Font.GothamBlack
CmdName.Text = "Commands"
CmdName.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdName.TextScaled = true
CmdName.TextSize = 14.000
CmdName.TextWrapped = true

FindCmd.Name = "FindCmd"
FindCmd.Parent = Background
FindCmd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FindCmd.BorderColor3 = Color3.fromRGB(0, 255, 0)
FindCmd.BorderSizePixel = 0
FindCmd.Position = UDim2.new(0.0714285746, 0, 0.0702347234, 0)
FindCmd.Size = UDim2.new(0, 300, 0, 20)
FindCmd.Font = Enum.Font.SourceSans
FindCmd.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
FindCmd.PlaceholderText = "Search For string_matches"
FindCmd.Text = ""
FindCmd.TextColor3 = Color3.fromRGB(255, 255, 255)
FindCmd.TextSize = 14.000
FindCmd.TextWrapped = true

CmdHandler.Name = "CmdHandler"
CmdHandler.Parent = Background
CmdHandler.Active = true
CmdHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CmdHandler.BackgroundTransparency = 1.000
CmdHandler.BorderSizePixel = 0
CmdHandler.AutomaticCanvasSize = "Y"
CmdHandler.Position = UDim2.new(0.0714285746, 0, 0.142857149, 0)
CmdHandler.Size = UDim2.new(0, 300, 0, 290)
CmdHandler.ScrollBarThickness = 2

CmdText.Name = "CmdText"
CmdText.Parent = nil
CmdText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CmdText.BackgroundTransparency = 1.000
CmdText.BorderSizePixel = 0
CmdText.Size = UDim2.new(0, 300, 0, 25)
CmdText.Font = Enum.Font.SourceSans
CmdText.Text = "Text"
CmdText.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdText.TextScaled = true
CmdText.TextSize = 14.000
CmdText.TextWrapped = true

UIListLayout.Parent = CmdHandler
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Minimum.Name = "Minimum"
Minimum.Parent = Background
Minimum.BackgroundColor3 = Color3.fromRGB(117, 117, 117)
Minimum.BorderSizePixel = 0
Minimum.Position = UDim2.new(0.842857122, 0, 0.00571428565, 0)
Minimum.Size = UDim2.new(0, 20, 0, 20)
Minimum.Font = Enum.Font.SourceSans
Minimum.Text = ""
Minimum.TextColor3 = Color3.fromRGB(255, 255, 255)
Minimum.TextSize = 14.000

connect(Minimum.MouseButton1Click, function()
	if Background.BackgroundTransparency == 0 then
		Background.BackgroundTransparency = 1
		Background.Size = UDim2.new(0, 350, 0, 25)
		FindCmd.Visible = false
		CmdHandler.Visible = false
	elseif Background.BackgroundTransparency == 1 then
		Background.BackgroundTransparency = 0
		Background.Size = UDim2.new(0, 350, 0, 350)
		FindCmd.Visible = true
		CmdHandler.Visible = true
	end
end)

Close.Name = "Close"
Close.Parent = Background
Close.BackgroundColor3 = Color3.fromRGB(155, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.928571403, 0, 0.00571428565, 0)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Font = Enum.Font.SourceSans
Close.Text = ""
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000
connect(Close.MouseButton1Click, function()
	Background.Visible = false
end)

-- New

Background2.Name = "Background"
Background2.Parent = CmdGui
Background2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background2.BorderSizePixel = 0
Background2.Position = UDim2.new(0.012, 0, 0.807, 0)
Background2.Size = UDim2.new(0, 250, 0, 80)
Background2.Active = true
Background2.Draggable = true

Label.Name = "Label"
Label.Parent = Background2
Label.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Label.BorderSizePixel = 0
Label.Position = UDim2.new(0, 0, 0, 0)
Label.Size = UDim2.new(0, 250, 0, 25)
Label.Font = Enum.Font.GothamBlack
Label.Text = "Execute Bar"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.TextSize = 14.000
Label.TextWrapped = true

Execute.Name = "Execute"
Execute.Parent = Background2
Execute.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Execute.BorderColor3 = Color3.fromRGB(0, 255, 0)
Execute.Position = UDim2.new(0.097, 0, 0.436, 0)
Execute.Size = UDim2.new(0, 200, 0, 30)
Execute.Font = Enum.Font.SourceSans
Execute.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
Execute.PlaceholderText = "Press " .. prefix .. " To Enter"
Execute.Text = ""
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextSize = 14.000
Execute.TextWrapped = true
local version = '4.3'

local Slient = true
local ScriptDisabled = false
local LoopBeam = {}
local LoopKill = {}
local LoopTase = {}
local Admin = {}
local Watching = nil
local States = {}
local BuyGamepass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(tonumber((player.CharacterAppearance):split('=')[#((player.CharacterAppearance):split('='))]), 96651)

local function player_from_str(String)
	if not String then return end
	local Yes = {}
	for _, Player in ipairs(players:GetPlayers()) do
		if string.lower(Player.Name):match(string.lower(String)) or string.lower(Player.DisplayName):match(string.lower(String)) then
			table.insert(Yes, Player)
		end
	end
    if #Yes > 0 then
		return Yes[1]
	elseif #Yes < 1 then
		return nil
	end
end

local function GetPos()
	return rootpart.CFrame
end

local function GetCamPos()
	return workspace.CurrentCamera.CFrame
end

local function GetTeam()
	return player.TeamColor.Name
end

function Goto(Player, Distance)
	local Distance = Distance or CFrame.new(0, 0, 0)
	rootpart.CFrame = Player.Character.HumanoidRootPart.CFrame * Distance
end

function Chat(Message)
	repstore.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Message, "All")
end

local function Kill(target)
    local char = target.Character
    local hum = char and char:FindFirstChildWhichIsA('Humanoid')
    local ff = char and char:FindFirstChildWhichIsA('ForceField')

    if ff then
        return
    end

    if hum and char:IsDescendantOf(workspace) then
        item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)

		local MyTeam = GetTeam()
		if target.TeamColor.Name == player.TeamColor.Name then
			local savedcf = GetPos()
			local savedcamcf = GetCamPos()
			load_character:InvokeServer(nil, BrickColor.random().Name)
			rootpart.CFrame = savedcf
			camera.CFrame = savedcamcf
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
		end

		local Gun = character:FindFirstChild("Remington 870") or player.Backpack:FindFirstChild("Remington 870")

		local FireEvent = {
			[1] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [2] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [3] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [4] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [5] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [6] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [7] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}, [8] = {
				["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
				["Distance"] = 0, 
				["Cframe"] = CFrame.new(), 
				["Hit"] = workspace[Player.Name].Head
			}
		}

		repstore.ShootEvent:FireServer(FireEvent, Gun)
		Gun.Parent = character
		character["Remington 870"]:Destroy()
    end
end

local function tase(target)
    local backpack = assert(player:FindFirstChildWhichIsA('Backpack'), 'Missing backpack.')
    local taser = backpack:FindFirstChild('Taser') or (character and character:FindFirstChild('Taser'))

    if player and typeof(player.Team) == 'Instance' and player.Team.Name == 'Guards' and typeof(target) == 'Instance' and target:IsA('Player') and typeof(taser) == 'Instance' and taser:IsA('Tool') and rootpart then
        local t_char = target.Character

        if typeof(t_char) == 'Instance' and t_char:IsDescendantOf(workspace) then
            repstore.ShootEvent:FireServer({{
                ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
                ["Distance"] = 0, 
                ["Cframe"] = CFrame.new(), 
                ["Hit"] = t_char:FindFirstChild('Torso') or t_char:FindFirstChildWhichIsA('BasePart')
            }}, taser)
        end
    end
end

local function Teleport(_, position)
    if rootpart then
        rootpart.CFrame = CFrame.new(position)
    end
end

function ArrestEvent(Player, Time)
	for i = 1,Time do
		workspace.Remote.arrest:InvokeServer(Player.Character.Head)
	end
end

function Arrest(Player, Time)
	local Time = Time or 1
	if Player.TeamColor.Name == "Really red" then
		local LPCHAR = workspace:FindFirstChild(player.Name)
		local LPHRP = LPCHAR and LPCHAR:FindFirstChild("HumanoidRootPart")
		local PLRCHAR = workspace:FindFirstChild(Player.Name)
		local PLRHRP = PLRCHAR and PLRCHAR:FindFirstChild("HumanoidRootPart")
		if LPCHAR and LPHRP and PLRCHAR and PLRHRP then 
			local savedcframe = LPHRP.CFrame
			repeat
				LPHRP.CFrame = PLRHRP.CFrame * CFrame.new(0, 0, 1.3)
				local TARGET = {PLRCHAR:FindFirstChild("Head")}
				for i = 1,Time do
					workspace.Remote.arrest:InvokeServer(unpack(TARGET))
				end
			until PLRCHAR.Head:FindFirstChild("handcuffedGui")
			PLRCHAR.Humanoid.Sit = false
			LPHRP.CFrame = savedcframe
		end
	end
end

local function CreateBeam(Player, Distance, Position)
	if Player then
		pcall(function()
			local Backpack = player:FindFirstChildWhichIsA('Backpack')
			local Character = character
			local Gun = Backpack:FindFirstChild("Remington 870") or Character:FindFirstChild("Remington 870")
			if not Gun then
				item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			end
			Gun = Backpack:FindFirstChild("Remington 870") or Character:FindFirstChild("Remington 870")
			local Head = Player.Character.Head
			if Head and Player and Character and Backpack and Gun and Distance and Position then
				repstore.ShootEvent:FireServer({
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head}
				}, Gun)
			end
			Gun.Parent = character
			character:FindFirstChild("Remington 870"):Destroy()
		end)
	end
end

local function CreatLageBeam(Player, Distance, Position)
	if Player then
		pcall(function()
			local Backpack = player:FindFirstChildWhichIsA('Backpack')
			local Character = character
			local Gun = Backpack:FindFirstChild("M9") or Character:FindFirstChild("M9")
			if not Gun then
				item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
			end
			Gun = Backpack:FindFirstChild("M9") or Character:FindFirstChild("M9")
			local Head = Player.Character.Head
			if Head and Player and Character and Backpack and Gun and Distance and Position then
				repstore.ShootEvent:FireServer({
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head},
					{["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),["Distance"] = Distance,["Cframe"] = Position,["Hit"] = Head}
				}, Gun)
			end
		end)
	end
end

local function Beam(Player, Distance, Time)
	if typeof(Player) == 'Instance' and Player:IsA('Player') and type(Distance) == 'number' then
		local username = Player.Name
        runtime:BindToRenderStep(username, math.huge, function()
			coroutine.wrap(function()
				CreateBeam(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
		end)
        if type(Time) == 'number' then
            return task.delay(Time, function()
                runtime:UnbindFromRenderStep(username)
            end)
        end
	end
end

local function LagBeam(Player, Distance, Time)
	if typeof(Player) == 'Instance' and Player:IsA('Player') and type(Distance) == 'number' then
		local username = Player.Name
        runtime:BindToRenderStep(username, math.huge, function()
			coroutine.wrap(function()
				CreateBeam(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
			coroutine.wrap(function()
				CreatLageBeam(Player, Distance, Player.Character.HumanoidRootPart.CFrame)
			end)()
		end)
		if type(Time) == 'number' then
            task.delay(Time, function()
                pcall(function()
                    runtime:UnbindFromRenderStep(username)
                end)
            end)
        end
	end
end

local function GetPlayerPart(Player)
	if not Player then return elseif Player:FindFirstChild("HumanoidRootPart") then
		return Player.HumanoidRootPart
	elseif Player:FindFirstChild("Torso") then
		return Player.Torso
	end
end

local Mouse = player:GetMouse()

local function Loadstring(Https)
	if not Https then return end
	loadstring(game:HttpGet((Https), true))()
end

local function string_matches(cmd)
    return Arg1 ~= nil and prefix ~= nil and Arg1 == prefix .. cmd
end

local function PrefixCommand(Cmd)
	return Arg1 == "!"..Cmd
end

local Walls = {
	prison_halls.walls,
	prison_halls.roof,
	prison_halls.outlines,
	prison_halls.lights,
	prison_halls.accent,
	prison_halls.glass,
	prison_cellblock.b_front,
	prison_cellblock.doors,
	prison_cellblock.c_tables,
	prison_cellblock.a_front,
	prison_cellblock.b_outerwall,
	prison_cellblock.c_wall,
	prison_cellblock.b_wall,
	prison_cellblock.c_hallwall,
	prison_cellblock.a_outerwall,
	prison_cellblock.b_ramp,
	prison_cellblock.a_ramp,
	prison_cellblock.a_walls,
	prison_cellblock.Cells_B,
	prison_cellblock.Cells_A,
	prison_cellblock.c_corner,
	prison_cellblock.Wedge,
	prison_cellblock.a_ceiling,
	prison_cellblock.b_ceiling,
	workspace.City_buildings,
	workspace.Prison_OuterWall,
	workspace.Prison_Fences,
	workspace.Prison_Guard_Outpost,
	workspace.Prison_Cafeteria.building,
	workspace.Prison_Cafeteria.glass,
	workspace.Prison_Cafeteria.oven,
	workspace.Prison_Cafeteria.shelves,
	workspace.Prison_Cafeteria.vents,
	workspace.Prison_Cafeteria.accents,
	workspace.Prison_Cafeteria["vending machine"],
	workspace.Prison_Cafeteria.Prison_table1,
	workspace.Prison_Cafeteria.counter,
	workspace.Prison_Cafeteria.boxes,
	workspace.Prison_Cafeteria["trash bins"]
}

-- Helper to split a message into words
local function splitMessage(message)
    local args = {}
    for word in message:gmatch("%S+") do
        table.insert(args, word)
    end
    return args
end

local states = {}
local commands = {
    beam = {
        description = 'Shoot a beam towards a player.',
        aliases = {},
        func = function(args)
            local target = player_from_str(args[1])
            if target then
                Beam(target, math.huge, 7)
            end
        end
    },
    killall = {
        description = 'Does exactly that. Kills everyone.',
        aliases = {},
        func = function(args)
            if states.killall == true then
                return
            end
            states.killall = true
            print('Killing everyone!')
            for _, target in pairs(players:GetPlayers()) do
                if target ~= player then
                    local t_humanoid = select(2, pcall(function()
                        return target.Character:FindFirstChildWhichIsA('Humanoid')
                    end))
                   
                    local t_root = typeof(t_humanoid) == 'Instance' and t_humanoid.RootPart 
                    local melee_event = repstore:FindFirstChild('meleeEvent')
                    
                    if t_root and rootpart and typeof(melee_event) == 'Instance' and melee_event:IsA('RemoteEvent') then
                        while t_humanoid.Health > 0 do
                            rootpart.CFrame = CFrame.new(t_root.Position)
                            task.wait(0.5)
                            melee_event:FireServer(target)
                        end
                    end
                end
            end
            print('An attempt to kill everyone was completed.')
            states.killall = false
        end
    }
}

local function getCommand(cmdName)
    for name, data in pairs(commands) do
        if name:lower() == cmdName:lower() then
            return data.func
        end
        for _, alias in ipairs(data.aliases) do
            if alias:lower() == cmdName:lower() then
                return data.func
            end
        end
    end
    return nil
end

local function AdminPlayerChatted(message)
    if ScriptDisabled then return end

    local args = splitMessage(message)
    if #args == 0 then return end

    -- Assume the first word is the command.
    local cmd = table.remove(args, 1)
    local commandFunc = getCommand(cmd)
    if commandFunc then
        commandFunc(args)
    else
        print("Unknown command:", cmd)
    end
end

connect(player.Chatted, AdminPlayerChatted)

local last_time = 0
local interval = 1 / 10

connect(runtime.Stepped, function(elapsed_time, delta_time)
    last_time = last_time + delta_time
    if last_time >= interval then
        last_time = last_time - interval
        for i,v in pairs(LoopBeam) do
            pcall(function()
                if v and v.Player and v.Player.Character and v.Player.Character.Head and v.Player.Character.HumanoidRootPart then
                    Beam(v.Player, math.huge, 1)
                end
            end)
        end
        for i,v in pairs(LoopKill) do
            pcall(function()
                if v.Player and v.Player.Character and v.Player.Character.Head and v.Player.Character.Humanoid.Health ~= 0 then
                    Kill(v.Player)
                end
            end)
        end
        if States.Kill_Aura then
            for i,v in pairs(players:GetPlayers()) do
                pcall(function()
                    if v ~= player then
                        local Distance = (v.Character:FindFirstChildOfClass("Part").Position - character:FindFirstChildOfClass("Part").Position).magnitude
                        if Distance <= 10 then
                            for i = 1,25 do
                                repstore.meleeEvent:FireServer(v)
                            end
                        end
                    end
                end)
            end
        end
    end
end)

local function CheckPermissions(Player)
	connect(Player.Chatted, function(Message)
		if Admin[Player.UserId] then
			AdminPlayerChatted(Message, Player)
		end
	end)
end

connect(players.PlayerRemoving, function(Player)
	if States.Notify then
		startergui:SetCore("SendNotification", {
			Title = "Game",
			Text = Player.DisplayName.." Rage Quit",
			Icon = players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352)
		})
	end
end)

connect(players.PlayerAdded, function(Player)
	if States.Notify then
		startergui:SetCore("SendNotification", {
			Title = "Game",
			Text = Player.DisplayName.." Joined",
			Icon = players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352)
		})
	end
	CheckPermissions(Player)
end)

for i, v in pairs(players:GetPlayers()) do
	if v ~= player then
		CheckPermissions(v)
	end
end

local cmdlist = {}

for i, v in pairs(commands) do
    if type(v) == 'table' and v.description and (v.example or i) then
        insert(cmdlist, tostring(v.example or i) .. ' | ' .. tostring(v.description))
    end
end

for _, v in pairs(cmdlist) do
	local clone = CmdText:Clone()
	clone.Text = v
	clone.Name = 'COMMANDS'
	clone.Parent = CmdHandler
end

connect(FindCmd.Changed, function()
	if FindCmd.Text ~= "" then
		for i,v in pairs(CmdHandler:GetChildren()) do
			if v:IsA("TextLabel") then
				if not string.lower(v.Text):match(string.lower(FindCmd.Text)) then
					v.Parent = Background
					v.Visible = false
				end
			end
		end
		for i,v in pairs(Background:GetChildren()) do
			if v.Name == "COMMANDS" then
				if string.lower(v.Text):match(string.lower(FindCmd.Text)) then
					v.Parent = CmdHandler
					v.Visible = true
				end
			end
		end
	elseif FindCmd.Text == "" and (#CmdHandler:GetChildren()-1) ~= #cmdlist  then
		for i,v in pairs(CmdHandler:GetChildren()) do
			if v:IsA("TextLabel") then
				v:Destroy()
			end
		end
		for i,v in pairs(Background:GetChildren()) do
			if v.Name == "COMMANDS" then
				v:Destroy()
			end
		end
		for i,v in pairs(cmdlist) do
			local clone = CmdText:Clone()
			clone.Text = v
			clone.Name = "COMMANDS"
			clone.Parent = CmdHandler
		end
	end
end)

connect(uis.InputBegan, function(io, gpe)
    if not gpe and io.KeyCode == Enum.KeyCode.Minus then
        Execute:CaptureFocus()
        task.wait()
        Execute.Text = ''
    end
end)

connect(Execute.FocusLost, function(enter_pressed)
    if enter_pressed == true then
        AdminPlayerChatted(Execute.Text)
        Execute.Text = ''
    end
end)

function env.stop_prisonlife_cmds()
    if typeof(CmdGui) == 'Instance' then
        CmdGui:Destroy()
    end
    pcall(clear, States)
    pcall(clear, LoopKill)
    pcall(clear, LoopTase)
    pcall(clear, Admin)
    ScriptDisabled = true
    for i, v in pairs(lighting:GetChildren()) do
        if not v:IsA('PostEffect') then
            v.Parent = workspace
        end
    end
	for _, c in ipairs(connections) do
		c:Disconnect()
	end
	for _, i in ipairs(instances) do
		i:Destroy()
	end
end
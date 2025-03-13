--- unknown author
--- modified by thuarnel

local a = false;
if a then
    getfenv().getfenv = function()
        return setmetatable({}, {
            __index = function() return function() return true end end
        })
    end
end
local b = game:GetService('HttpService');
local c = game:GetService('Players');
local d = game:GetService('UserInputService');
local e = game:GetService('RunService');
local f = game:GetService('TweenService');
local g = {
    TabWidth = 160,
    Size = {580, 460},
    Theme = "VSC Dark High Contrast",
    Acrylic = false,
    Transparency = true,
    MinimizeKey = "RightShift",
    ShowNotifications = true,
    ShowWarnings = true,
    RenderingMode = "RenderStepped",
    AutoImport = true
}
local h = {}
function h:ImportSettings()
    pcall(function()
        if not a and getfenv().isfile and getfenv().readfile and
            getfenv().isfile("UISettings.ttwizz") and
            getfenv().readfile("UISettings.ttwizz") then
            for a, b in next,
                        b:JSONDecode(getfenv().readfile("UISettings.ttwizz")) do
                g[a] = b
            end
        end
    end)
end
function h:ExportSettings()
    pcall(function()
        if not a and getfenv().isfile and getfenv().readfile and
            getfenv().writefile then
            getfenv().writefile("UISettings.ttwizz", b:JSONEncode(g))
        end
    end)
end
h:ImportSettings()
g.__LAST_RUN__ = os.date()
h:ExportSettings()
local i = {}
function i:PackColour(a)
    return typeof(a) == "Color3" and
               {R = a.R * 255, G = a.G * 255, B = a.B * 255} or typeof(a) ==
               "table" and a or {R = 255, G = 255, B = 255}
end
function i:UnpackColour(a)
    return
        typeof(a) == "table" and Color3.fromRGB(a.R, a.G, a.B) or typeof(a) ==
            "Color3" and a or Color3.fromRGB(255, 255, 255)
end
local j = {}
pcall(function()
    if not a and getfenv().isfile and getfenv().readfile and
        getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and
        getfenv().readfile(string.format("%s.ttwizz", game.GameId)) and
        g.AutoImport then
        j = b:JSONDecode(getfenv().readfile(
                             string.format("%s.ttwizz", game.GameId)))
        for a, b in next, j do
            if a == "FoVColour" or a == "NameESPOutlineColour" or a ==
                "ESPColour" then j[a] = i:UnpackColour(b) end
        end
    end
end)
local k = {}
k.Aimbot = j["Aimbot"] or false;
k.OnePressAimingMode = j["OnePressAimingMode"] or false;
k.AimKey = j["AimKey"] or "RMB"
k.AimMode = j["AimMode"] or "Camera"
k.SilentAimMethods = j["SilentAimMethods"] or
                         {"Mouse.Hit / Mouse.Target", "GetMouseLocation"}
k.SilentAimChance = j["SilentAimChance"] or 100;
k.OffAimbotAfterKill = j["OffAimbotAfterKill"] or false;
k.AimPartDropdownValues = j["AimPartDropdownValues"] or
                              {"Head", "HumanoidRootPart"}
k.AimPart = j["AimPart"] or "HumanoidRootPart"
k.RandomAimPart = j["RandomAimPart"] or false;
k.UseOffset = j["UseOffset"] or false;
k.OffsetType = j["OffsetType"] or "Static"
k.StaticOffsetIncrement = j["StaticOffsetIncrement"] or 10;
k.DynamicOffsetIncrement = j["DynamicOffsetIncrement"] or 10;
k.AutoOffset = j["AutoOffset"] or false;
k.MaxAutoOffset = j["MaxAutoOffset"] or 50;
k.UseSensitivity = j["UseSensitivity"] or false;
k.Sensitivity = j["Sensitivity"] or 50;
k.UseNoise = j["UseNoise"] or false;
k.NoiseFrequency = j["NoiseFrequency"] or 50;
k.SpinBot = j["SpinBot"] or false;
k.OnePressSpinningMode = j["OnePressSpinningMode"] or false;
k.SpinKey = j["SpinKey"] or "Q"
k.SpinBotVelocity = j["SpinBotVelocity"] or 50;
k.SpinPartDropdownValues = j["SpinPartDropdownValues"] or
                               {"Head", "HumanoidRootPart"}
k.SpinPart = j["SpinPart"] or "HumanoidRootPart"
k.RandomSpinPart = j["RandomSpinPart"] or false;
k.TriggerBot = j["TriggerBot"] or false;
k.OnePressTriggeringMode = j["OnePressTriggeringMode"] or false;
k.SmartTriggerBot = j["SmartTriggerBot"] or false;
k.TriggerKey = j["TriggerKey"] or "E"
k.TriggerBotChance = j["TriggerBotChance"] or 100;
k.AliveCheck = j["AliveCheck"] or false;
k.GodCheck = j["GodCheck"] or false;
k.TeamCheck = j["TeamCheck"] or false;
k.FriendCheck = j["FriendCheck"] or false;
k.FollowCheck = j["FollowCheck"] or false;
k.VerifiedBadgeCheck = j["VerifiedBadgeCheck"] or false;
k.WallCheck = j["WallCheck"] or false;
k.WaterCheck = j["WaterCheck"] or false;
k.FoVCheck = j["FoVCheck"] or false;
k.FoVRadius = j["FoVRadius"] or 100;
k.MagnitudeCheck = j["MagnitudeCheck"] or false;
k.TriggerMagnitude = j["TriggerMagnitude"] or 500;
k.TransparencyCheck = j["TransparencyCheck"] or false;
k.IgnoredTransparency = j["IgnoredTransparency"] or 0.5;
k.WhitelistedGroupCheck = j["WhitelistedGroupCheck"] or false;
k.WhitelistedGroup = j["WhitelistedGroup"] or 0;
k.BlacklistedGroupCheck = j["BlacklistedGroupCheck"] or false;
k.BlacklistedGroup = j["BlacklistedGroup"] or 0;
k.IgnoredPlayersCheck = j["IgnoredPlayersCheck"] or false;
k.IgnoredPlayersDropdownValues = j["IgnoredPlayersDropdownValues"] or {}
k.IgnoredPlayers = j["IgnoredPlayers"] or {}
k.TargetPlayersCheck = j["TargetPlayersCheck"] or false;
k.TargetPlayersDropdownValues = j["TargetPlayersDropdownValues"] or {}
k.TargetPlayers = j["TargetPlayers"] or {}
k.PremiumCheck = j["PremiumCheck"] or false;
k.FoV = j["FoV"] or false;
k.FoVKey = j["FoVKey"] or "R"
k.FoVThickness = j["FoVThickness"] or 2;
k.FoVOpacity = j["FoVOpacity"] or 0.8;
k.FoVFilled = j["FoVFilled"] or false;
k.FoVColour = j["FoVColour"] or Color3.fromRGB(255, 255, 255)
k.SmartESP = j["SmartESP"] or false;
k.ESPKey = j["ESPKey"] or "T"
k.ESPBox = j["ESPBox"] or false;
k.ESPBoxFilled = j["ESPBoxFilled"] or false;
k.NameESP = j["NameESP"] or false;
k.NameESPFont = j["NameESPFont"] or "Monospace"
k.NameESPSize = j["NameESPSize"] or 16;
k.NameESPOutlineColour = j["NameESPOutlineColour"] or Color3.fromRGB(0, 0, 0)
k.HealthESP = j["HealthESP"] or false;
k.MagnitudeESP = j["MagnitudeESP"] or false;
k.TracerESP = j["TracerESP"] or false;
k.ESPThickness = j["ESPThickness"] or 2;
k.ESPOpacity = j["ESPOpacity"] or 0.8;
k.ESPColour = j["ESPColour"] or Color3.fromRGB(255, 255, 255)
k.ESPUseTeamColour = j["ESPUseTeamColour"] or false;
k.RainbowVisuals = j["RainbowVisuals"] or false;
k.RainbowDelay = j["RainbowDelay"] or 5;
local j = c.LocalPlayer;
local l = j:GetMouse()
local m = d.KeyboardEnabled and d.MouseEnabled;
local n = {
    "🎅%s❄️", "☃️%s🏂", "🌷%s☘️", "🌺%s🎀", "🐝%s🌼",
    "🌈%s😎", "🌞%s🏖️", "☀️%s💐", "🌦%s🍁", "🎃%s💀",
    "🍂%s☕", "🎄%s🎁"
}
local o = {
    "💫PREMIUM💫", "✨PREMIUM✨", "🌟PREMIUM🌟", "⭐PREMIUM⭐",
    "🤩PREMIUM🤩"
}
local function p(a)
    if typeof(a) == "string" and #a > 0 then
        for b, b in next, c:GetPlayers() do
            if string.sub(string.lower(b.Name), 1, #string.lower(a)) ==
                string.lower(a) then return b.Name end
        end
    end
    return ""
end
local p = ""
local q = nil;
local r = false;
local s = true;
local t = os.clock()
local u = false;
local v = nil;
local w = nil;
local x = d.MouseDeltaSensitivity;
local y = false;
local z = false;
local A = false;
local B = false;
do
    if typeof(script) == "Instance" and script:FindFirstChild("Fluent") and
        script:FindFirstChild("Fluent"):IsA("ModuleScript") then
        q = require(script:FindFirstChild("Fluent"))
    else
        local a, c = pcall(function()
            return game:HttpGet("https://twix.cyou/Fluent.txt", true)
        end)
        if a and typeof(c) == "string" and string.find(c, "dawid") then
            q = getfenv().loadstring(c)()
            if q.Premium then
                return getfenv().loadstring(game:HttpGet(
                                                "https://twix.cyou/Aimbot.txt",
                                                true))()
            end
            local a, c = pcall(function()
                return game:HttpGet("https://twix.cyou/AimbotStatus.json", true)
            end)
            if a and typeof(c) == "string" and pcall(b.JSONDecode, b, c) and
                typeof(b:JSONDecode(c).message) == "string" then
                p = b:JSONDecode(c).message
            end
        else
            return
        end
    end
end
local C;
C = d:GetPropertyChangedSignal("MouseDeltaSensitivity"):Connect(function()
    if not q then
        C:Disconnect()
    elseif not u or not a and
        (getfenv().mousemoverel and m and k.AimMode == "Mouse" or
            getfenv().hookmetamethod and getfenv().newcclosure and
            getfenv().checkcaller and getfenv().getnamecallmethod and k.AimMode ==
            "Silent") then
        x = d.MouseDeltaSensitivity
    end
end)
do
    local c = q:CreateWindow({
        Title = string.format("%s <b><i>%s</i></b>", string.format(
                                  n[os.date("*t").month], "Open Aimbot"),
                              #p > 0 and p or "🔥FREE🔥"),
        SubTitle = "@xeno_executor",
        TabWidth = g.TabWidth,
        Size = UDim2.fromOffset(table.unpack(g.Size)),
        Theme = g.Theme,
        Acrylic = g.Acrylic,
        MinimizeKey = g.MinimizeKey
    })
    local d = {Aimbot = c:AddTab({Title = "Aimbot", Icon = "crosshair"})}
    c:SelectTab(1)
    local e = d.Aimbot:AddSection("Aimbot")
    local f = e:AddToggle("Aimbot", {
        Title = "Aimbot",
        Description = "Toggles the Aimbot",
        Default = k.Aimbot
    })
    f:OnChanged(function(a)
        k.Aimbot = a;
        if not m then u = a end
    end)
    if m then
        local a = e:AddToggle("OnePressAimingMode", {
            Title = "One-Press Mode",
            Description = "Uses the One-Press Mode instead of the Holding Mode",
            Default = k.OnePressAimingMode
        })
        a:OnChanged(function(a) k.OnePressAimingMode = a end)
        local a = e:AddKeybind("AimKey", {
            Title = "Aim Key",
            Description = "Changes the Aim Key",
            Default = k.AimKey,
            ChangedCallback = function(a) k.AimKey = a end
        })
        k.AimKey = a.Value ~= "RMB" and Enum.KeyCode[a.Value] or
                       Enum.UserInputType.MouseButton2
    end
    local f = e:AddDropdown("AimMode", {
        Title = "Aim Mode",
        Description = "Changes the Aim Mode",
        Values = {"Camera"},
        Default = k.AimMode,
        Callback = function(a) k.AimMode = a end
    })
    if getfenv().mousemoverel and m then
        table.insert(f.Values, "Mouse")
        f:BuildDropdownList()
    else
        r = true
    end
    if getfenv().hookmetamethod and getfenv().newcclosure and
        getfenv().checkcaller and getfenv().getnamecallmethod then
        table.insert(f.Values, "Silent")
        f:BuildDropdownList()
        local a = e:AddDropdown("SilentAimMethods", {
            Title = "Silent Aim Methods",
            Description = "Sets the Silent Aim Methods",
            Values = {
                "Mouse.Hit / Mouse.Target", "GetMouseLocation", "Raycast",
                "FindPartOnRay", "FindPartOnRayWithIgnoreList",
                "FindPartOnRayWithWhitelist"
            },
            Multi = true,
            Default = k.SilentAimMethods
        })
        a:OnChanged(function(a)
            k.SilentAimMethods = {}
            for a, b in next, a do
                if typeof(a) == "string" then
                    table.insert(k.SilentAimMethods, a)
                end
            end
        end)
        e:AddSlider("SilentAimChance", {
            Title = "Silent Aim Chance",
            Description = "Changes the Hit Chance for Silent Aim",
            Default = k.SilentAimChance,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(a) k.SilentAimChance = a end
        })
    else
        r = true
    end
    local f = e:AddToggle("OffAimbotAfterKill", {
        Title = "Off After Kill",
        Description = "Disables the Aiming Mode after killing a Target",
        Default = k.OffAimbotAfterKill
    })
    f:OnChanged(function(a) k.OffAimbotAfterKill = a end)
    local f = e:AddDropdown("AimPart", {
        Title = "Aim Part",
        Description = "Changes the Aim Part",
        Values = k.AimPartDropdownValues,
        Default = k.AimPart,
        Callback = function(a) k.AimPart = a end
    })
    local j = e:AddToggle("RandomAimPart", {
        Title = "Random Aim Part",
        Description = "Selects every second a Random Aim Part from Dropdown",
        Default = k.RandomAimPart
    })
    j:OnChanged(function(a) k.RandomAimPart = a end)
    e:AddInput("AddAimPart", {
        Title = "Add Aim Part",
        Description = "After typing, press Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(a)
            if #a > 0 and not table.find(k.AimPartDropdownValues, a) then
                table.insert(k.AimPartDropdownValues, a)
                f:SetValue(a)
            end
        end
    })
    e:AddInput("RemoveAimPart", {
        Title = "Remove Aim Part",
        Description = "After typing, press Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(a)
            if #a > 0 and table.find(k.AimPartDropdownValues, a) then
                if k.AimPart == a then f:SetValue(nil) end
                table.remove(k.AimPartDropdownValues,
                             table.find(k.AimPartDropdownValues, a))
                f:SetValues(k.AimPartDropdownValues)
            end
        end
    })
    e:AddButton({
        Title = "Clear All Items",
        Description = "Removes All Elements",
        Callback = function()
            local a = #k.AimPartDropdownValues;
            f:SetValue(nil)
            k.AimPartDropdownValues = {}
            f:SetValues(k.AimPartDropdownValues)
            c:Dialog({
                Title = string.format(n[os.date("*t").month], "Open Aimbot"),
                Content = a == 0 and "Nothing has been cleared!" or a == 1 and
                    "1 Item has been cleared!" or
                    string.format("%s Items have been cleared!", a),
                Buttons = {{Title = "Confirm"}}
            })
        end
    })
    local e = d.Aimbot:AddSection("Aim Offset")
    local f = e:AddToggle("UseOffset", {
        Title = "Use Offset",
        Description = "Toggles the Offset",
        Default = k.UseOffset
    })
    f:OnChanged(function(a) k.UseOffset = a end)
    e:AddDropdown("OffsetType", {
        Title = "Offset Type",
        Description = "Changes the Offset Type",
        Values = {"Static", "Dynamic", "Static & Dynamic"},
        Default = k.OffsetType,
        Callback = function(a) k.OffsetType = a end
    })
    e:AddSlider("StaticOffsetIncrement", {
        Title = "Static Offset Increment",
        Description = "Changes the Static Offset Increment",
        Default = k.StaticOffsetIncrement,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(a) k.StaticOffsetIncrement = a end
    })
    e:AddSlider("DynamicOffsetIncrement", {
        Title = "Dynamic Offset Increment",
        Description = "Changes the Dynamic Offset Increment",
        Default = k.DynamicOffsetIncrement,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(a) k.DynamicOffsetIncrement = a end
    })
    local f = e:AddToggle("AutoOffset", {
        Title = "Auto Offset",
        Description = "Toggles the Auto Offset",
        Default = k.AutoOffset
    })
    f:OnChanged(function(a) k.AutoOffset = a end)
    e:AddSlider("MaxAutoOffset", {
        Title = "Max Auto Offset",
        Description = "Changes the Max Auto Offset",
        Default = k.MaxAutoOffset,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(a) k.MaxAutoOffset = a end
    })
    local e = d.Aimbot:AddSection("Sensitivity & Noise")
    local f = e:AddToggle("UseSensitivity", {
        Title = "Use Sensitivity",
        Description = "Toggles the Sensitivity",
        Default = k.UseSensitivity
    })
    f:OnChanged(function(a) k.UseSensitivity = a end)
    e:AddSlider("Sensitivity", {
        Title = "Sensitivity",
        Description = "Smoothes out the Mouse / Camera Movements when Aiming",
        Default = k.Sensitivity,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(a) k.Sensitivity = a end
    })
    local f = e:AddToggle("UseNoise", {
        Title = "Use Noise",
        Description = "Toggles the Camera Shaking when Aiming",
        Default = k.UseNoise
    })
    f:OnChanged(function(a) k.UseNoise = a end)
    e:AddSlider("NoiseFrequency", {
        Title = "Noise Frequency",
        Description = "Changes the Noise Frequency",
        Default = k.NoiseFrequency,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(a) k.NoiseFrequency = a end
    })
    if a or getfenv().Drawing and getfenv().Drawing.new then
        d.Visuals = c:AddTab({Title = "Visuals", Icon = "box"})
        local a = d.Visuals:AddSection("FoV")
        local b = a:AddToggle("FoV", {
            Title = "FoV",
            Description = "Graphically Displays the FoV Radius",
            Default = k.FoV
        })
        b:OnChanged(function(a)
            k.FoV = a;
            if not m then A = a end
        end)
        if m then
            local a = a:AddKeybind("FoVKey", {
                Title = "FoV Key",
                Description = "Changes the FoV Key",
                Default = k.FoVKey,
                ChangedCallback = function(a) k.FoVKey = a end
            })
            k.FoVKey = a.Value ~= "RMB" and Enum.KeyCode[a.Value] or
                           Enum.UserInputType.MouseButton2
        end
        a:AddSlider("FoVThickness", {
            Title = "FoV Thickness",
            Description = "Changes the FoV Thickness",
            Default = k.FoVThickness,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(a) k.FoVThickness = a end
        })
        a:AddSlider("FoVOpacity", {
            Title = "FoV Opacity",
            Description = "Changes the FoV Opacity",
            Default = k.FoVOpacity,
            Min = 0.1,
            Max = 1,
            Rounding = 1,
            Callback = function(a) k.FoVOpacity = a end
        })
        local b = a:AddToggle("FoVFilled", {
            Title = "FoV Filled",
            Description = "Makes the FoV Filled",
            Default = k.FoVFilled
        })
        b:OnChanged(function(a) k.FoVFilled = a end)
        a:AddColorpicker("FoVColour", {
            Title = "FoV Colour",
            Description = "Changes the FoV Colour",
            Default = k.FoVColour,
            Callback = function(a) k.FoVColour = a end
        })
        local a = d.Visuals:AddSection("ESP")
        local b = a:AddToggle("SmartESP", {
            Title = "Smart ESP",
            Description = "Does not ESP the Whitelisted Players",
            Default = k.SmartESP
        })
        b:OnChanged(function(a) k.SmartESP = a end)
        if m then
            local a = a:AddKeybind("ESPKey", {
                Title = "ESP Key",
                Description = "Changes the ESP Key",
                Default = k.ESPKey,
                ChangedCallback = function(a) k.ESPKey = a end
            })
            k.ESPKey = a.Value ~= "RMB" and Enum.KeyCode[a.Value] or
                           Enum.UserInputType.MouseButton2
        end
        local b = a:AddToggle("ESPBox", {
            Title = "ESP Box",
            Description = "Creates the ESP Box around the Players",
            Default = k.ESPBox
        })
        b:OnChanged(function(a)
            k.ESPBox = a;
            if not m then
                if a then
                    B = true
                elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
                    not k.MagnitudeESP and not k.TracerESP then
                    B = false
                end
            end
        end)
        local b = a:AddToggle("ESPBoxFilled", {
            Title = "ESP Box Filled",
            Description = "Makes the ESP Box Filled",
            Default = k.ESPBoxFilled
        })
        b:OnChanged(function(a) k.ESPBoxFilled = a end)
        local b = a:AddToggle("NameESP", {
            Title = "Name ESP",
            Description = "Creates the Name ESP above the Players",
            Default = k.NameESP
        })
        b:OnChanged(function(a)
            k.NameESP = a;
            if not m then
                if a then
                    B = true
                elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
                    not k.MagnitudeESP and not k.TracerESP then
                    B = false
                end
            end
        end)
        a:AddDropdown("NameESPFont", {
            Title = "Name ESP Font",
            Description = "Changes the Name ESP Font",
            Values = {"UI", "System", "Plex", "Monospace"},
            Default = k.NameESPFont,
            Callback = function(a) k.NameESPFont = a end
        })
        a:AddSlider("NameESPSize", {
            Title = "Name ESP Size",
            Description = "Changes the Name ESP Size",
            Default = k.NameESPSize,
            Min = 8,
            Max = 28,
            Rounding = 1,
            Callback = function(a) k.NameESPSize = a end
        })
        a:AddColorpicker("NameESPOutlineColour", {
            Title = "Name ESP Outline",
            Description = "Changes the Name ESP Outline Colour",
            Default = k.NameESPOutlineColour,
            Callback = function(a) k.NameESPOutlineColour = a end
        })
        local b = a:AddToggle("HealthESP", {
            Title = "Health ESP",
            Description = "Creates the Health ESP in the ESP Box",
            Default = k.HealthESP
        })
        b:OnChanged(function(a)
            k.HealthESP = a;
            if not m then
                if a then
                    B = true
                elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
                    not k.MagnitudeESP and not k.TracerESP then
                    B = false
                end
            end
        end)
        local b = a:AddToggle("MagnitudeESP", {
            Title = "Magnitude ESP",
            Description = "Creates the Magnitude ESP in the ESP Box",
            Default = k.MagnitudeESP
        })
        b:OnChanged(function(a)
            k.MagnitudeESP = a;
            if not m then
                if a then
                    B = true
                elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
                    not k.MagnitudeESP and not k.TracerESP then
                    B = false
                end
            end
        end)
        local b = a:AddToggle("TracerESP", {
            Title = "Tracer ESP",
            Description = "Creates the Tracer ESP in the direction of the Players",
            Default = k.TracerESP
        })
        b:OnChanged(function(a)
            k.TracerESP = a;
            if not m then
                if a then
                    B = true
                elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
                    not k.MagnitudeESP and not k.TracerESP then
                    B = false
                end
            end
        end)
        a:AddSlider("ESPThickness", {
            Title = "ESP Thickness",
            Description = "Changes the ESP Thickness",
            Default = k.ESPThickness,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(a) k.ESPThickness = a end
        })
        a:AddSlider("ESPOpacity", {
            Title = "ESP Opacity",
            Description = "Changes the ESP Opacity",
            Default = k.ESPOpacity,
            Min = 0.1,
            Max = 1,
            Rounding = 1,
            Callback = function(a) k.ESPOpacity = a end
        })
        a:AddColorpicker("ESPColour", {
            Title = "ESP Colour",
            Description = "Changes the ESP Colour",
            Default = k.ESPColour,
            Callback = function(a) k.ESPColour = a end
        })
        local a = a:AddToggle("ESPUseTeamColour", {
            Title = "Use Team Colour",
            Description = "Makes the ESP Colour match the Target Player Team",
            Default = k.ESPUseTeamColour
        })
        a:OnChanged(function(a) k.ESPUseTeamColour = a end)
        local a = d.Visuals:AddSection("Visuals")
        local b = a:AddToggle("RainbowVisuals", {
            Title = "Rainbow Visuals",
            Description = "Makes the Visuals Rainbow",
            Default = k.RainbowVisuals
        })
        b:OnChanged(function(a) k.RainbowVisuals = a end)
        a:AddSlider("RainbowDelay", {
            Title = "Rainbow Delay",
            Description = "Changes the Rainbow Delay",
            Default = k.RainbowDelay,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(a) k.RainbowDelay = a end
        })
    else
        r = true
    end
    d.Settings = c:AddTab({Title = "Settings", Icon = "settings"})
    local e = d.Settings:AddSection("UI")
    e:AddDropdown("Theme", {
        Title = "Theme",
        Description = "Changes the UI Theme",
        Values = q.Themes,
        Default = q.Theme,
        Callback = function(a)
            q:SetTheme(a)
            g.Theme = a;
            h:ExportSettings()
        end
    })
    if q.UseAcrylic then
        e:AddToggle("Acrylic", {
            Title = "Acrylic",
            Description = "Blurred Background requires Graphic Quality >= 8",
            Default = q.Acrylic,
            Callback = function(a)
                if not a or not g.ShowWarnings then
                    q:ToggleAcrylic(a)
                elseif g.ShowWarnings then
                    c:Dialog({
                        Title = "Warning",
                        Content = "This Option can be detected! Activate it anyway?",
                        Buttons = {
                            {
                                Title = "Confirm",
                                Callback = function()
                                    q:ToggleAcrylic(a)
                                end
                            }, {
                                Title = "Cancel",
                                Callback = function()
                                    q.Options.Acrylic:SetValue(false)
                                end
                            }
                        }
                    })
                end
            end
        })
    end
    e:AddToggle("Transparency", {
        Title = "Transparency",
        Description = "Makes the UI Transparent",
        Default = g.Transparency,
        Callback = function(a)
            q:ToggleTransparency(a)
            g.Transparency = a;
            h:ExportSettings()
        end
    })
    if m then
        e:AddKeybind("MinimizeKey", {
            Title = "Minimize Key",
            Description = "Changes the Minimize Key",
            Default = q.MinimizeKey,
            ChangedCallback = function()
                g.MinimizeKey = q.Options.MinimizeKey.Value;
                h:ExportSettings()
            end
        })
        q.MinimizeKeybind = q.Options.MinimizeKey
    end
    local e = d.Settings:AddSection("Notifications & Warnings")
    local f = e:AddToggle("ShowNotifications", {
        Title = "Show Notifications",
        Description = "Toggles the Notifications Show",
        Default = g.ShowNotifications
    })
    f:OnChanged(function(a)
        q.ShowNotifications = a;
        g.ShowNotifications = a;
        h:ExportSettings()
    end)
    local e = e:AddToggle("ShowWarnings", {
        Title = "Show Warnings",
        Description = "Toggles the Security Warnings Show",
        Default = g.ShowWarnings
    })
    e:OnChanged(function(a)
        g.ShowWarnings = a;
        h:ExportSettings()
    end)
    local e = d.Settings:AddSection("Performance")
    e:AddParagraph({
        Title = "NOTE",
        Content = "Heartbeat fires every frame, after the physics simulation has completed. RenderStepped fires every frame, prior to the frame being rendered. Stepped fires every frame, prior to the physics simulation."
    })
    e:AddDropdown("RenderingMode", {
        Title = "Rendering Mode",
        Description = "Changes the Rendering Mode",
        Values = {"Heartbeat", "RenderStepped", "Stepped"},
        Default = g.RenderingMode,
        Callback = function(a)
            g.RenderingMode = a;
            h:ExportSettings()
            c:Dialog({
                Title = string.format(n[os.date("*t").month], "Open Aimbot"),
                Content = "Changes will take effect after the Restart!",
                Buttons = {{Title = "Confirm"}}
            })
        end
    })
    if getfenv().isfile and getfenv().readfile and getfenv().writefile and
        getfenv().delfile then
        local a = d.Settings:AddSection("Configuration Manager")
        local d = a:AddToggle("AutoImport", {
            Title = "Auto Import",
            Description = "Toggles the Auto Import",
            Default = g.AutoImport
        })
        d:OnChanged(function(a)
            g.AutoImport = a;
            h:ExportSettings()
        end)
        a:AddParagraph({
            Title = string.format("Manager for %s", game.Name),
            Content = string.format("Universe ID is %s", game.GameId)
        })
        a:AddButton({
            Title = "Import Configuration File",
            Description = "Loads the Game Configuration File",
            Callback = function()
                xpcall(function()
                    if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and
                        getfenv().readfile(
                            string.format("%s.ttwizz", game.GameId)) then
                        local a = b:JSONDecode(
                                      getfenv().readfile(string.format(
                                                             "%s.ttwizz",
                                                             game.GameId)))
                        for a, b in next, a do
                            if a == "AimKey" or a == "SpinKey" or a ==
                                "TriggerKey" or a == "FoVKey" or a == "ESPKey" then
                                q.Options[a]:SetValue(b)
                                k[a] = b ~= "RMB" and Enum.KeyCode[b] or
                                           Enum.UserInputType.MouseButton2
                            elseif a == "AimPart" or a == "SpinPart" or
                                typeof(k[a]) == "table" then
                                k[a] = b
                            elseif a == "FoVColour" or a ==
                                "NameESPOutlineColour" or a == "ESPColour" then
                                q.Options[a]:SetValueRGB(i:UnpackColour(b))
                            elseif k[a] ~= nil and q.Options[a] then
                                q.Options[a]:SetValue(b)
                            end
                        end
                        for a, b in next, q.Options do
                            if b.Type == "Dropdown" then
                                if a == "SilentAimMethods" then
                                    local a = {}
                                    for b, b in next, k.SilentAimMethods do
                                        a[b] = true
                                    end
                                    b:SetValue(a)
                                elseif a == "AimPart" then
                                    b:SetValues(k.AimPartDropdownValues)
                                    b:SetValue(k.AimPart)
                                elseif a == "SpinPart" then
                                    b:SetValues(k.SpinPartDropdownValues)
                                    b:SetValue(k.SpinPart)
                                elseif a == "IgnoredPlayers" then
                                    b:SetValues(k.IgnoredPlayersDropdownValues)
                                    local a = {}
                                    for b, b in next, k.IgnoredPlayers do
                                        a[b] = true
                                    end
                                    b:SetValue(a)
                                elseif a == "TargetPlayers" then
                                    b:SetValues(k.TargetPlayersDropdownValues)
                                    local a = {}
                                    for b, b in next, k.TargetPlayers do
                                        a[b] = true
                                    end
                                    b:SetValue(a)
                                end
                            end
                        end
                        c:Dialog({
                            Title = "Configuration Manager",
                            Content = string.format(
                                "Configuration File %s.ttwizz has been successfully loaded!",
                                game.GameId),
                            Buttons = {{Title = "Confirm"}}
                        })
                    else
                        c:Dialog({
                            Title = "Configuration Manager",
                            Content = string.format(
                                "Configuration File %s.ttwizz could not be found!",
                                game.GameId),
                            Buttons = {{Title = "Confirm"}}
                        })
                    end
                end, function()
                    c:Dialog({
                        Title = "Configuration Manager",
                        Content = string.format(
                            "An Error occurred when loading the Configuration File %s.ttwizz",
                            game.GameId),
                        Buttons = {{Title = "Confirm"}}
                    })
                end)
            end
        })
        a:AddButton({
            Title = "Export Configuration File",
            Description = "Overwrites the Game Configuration File",
            Callback = function()
                xpcall(function()
                    local a = {__LAST_UPDATED__ = os.date()}
                    for b, c in next, k do
                        if b == "AimKey" or b == "SpinKey" or b == "TriggerKey" or
                            b == "FoVKey" or b == "ESPKey" then
                            a[b] = q.Options[b].Value
                        elseif b == "FoVColour" or b == "NameESPOutlineColour" or
                            b == "ESPColour" then
                            a[b] = i:PackColour(c)
                        else
                            a[b] = c
                        end
                    end
                    a = b:JSONEncode(a)
                    getfenv().writefile(string.format("%s.ttwizz", game.GameId),
                                        a)
                    c:Dialog({
                        Title = "Configuration Manager",
                        Content = string.format(
                            "Configuration File %s.ttwizz has been successfully overwritten!",
                            game.GameId),
                        Buttons = {{Title = "Confirm"}}
                    })
                end, function()
                    c:Dialog({
                        Title = "Configuration Manager",
                        Content = string.format(
                            "An Error occurred when overwriting the Configuration File %s.ttwizz",
                            game.GameId),
                        Buttons = {{Title = "Confirm"}}
                    })
                end)
            end
        })
        a:AddButton({
            Title = "Delete Configuration File",
            Description = "Removes the Game Configuration File",
            Callback = function()
                if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) then
                    getfenv().delfile(string.format("%s.ttwizz", game.GameId))
                    c:Dialog({
                        Title = "Configuration Manager",
                        Content = string.format(
                            "Configuration File %s.ttwizz has been successfully removed!",
                            game.GameId),
                        Buttons = {{Title = "Confirm"}}
                    })
                else
                    c:Dialog({
                        Title = "Configuration Manager",
                        Content = string.format(
                            "Configuration File %s.ttwizz could not be found!",
                            game.GameId),
                        Buttons = {{Title = "Confirm"}}
                    })
                end
            end
        })
    else
        r = true
    end
    local b = d.Settings:AddSection("Discord & Wiki")
    if getfenv().setclipboard then
        b:AddButton({
            Title = "Copy Invite Link",
            Description = "Paste it into the Browser Tab",
            Callback = function()
                getfenv().setclipboard("https://twix.cyou/pix")
                c:Dialog({
                    Title = string.format(n[os.date("*t").month], "Open Aimbot"),
                    Content = "Invite Link has been copied to the Clipboard!",
                    Buttons = {{Title = "Confirm"}}
                })
            end
        })
        b:AddButton({
            Title = "Copy Wiki Link",
            Description = "Paste it into the Browser Tab",
            Callback = function()
                getfenv().setclipboard("https://moderka.org/Open-Aimbot")
                c:Dialog({
                    Title = string.format(n[os.date("*t").month], "Open Aimbot"),
                    Content = "Wiki Link has been copied to the Clipboard!",
                    Buttons = {{Title = "Confirm"}}
                })
            end
        })
    else
        b:AddParagraph({
            Title = "https://twix.cyou/pix",
            Content = "Paste it into the Browser Tab"
        })
        b:AddParagraph({
            Title = "https://moderka.org/Open-Aimbot",
            Content = "Paste it into the Browser Tab"
        })
    end
    if g.ShowWarnings then
        if a then
            c:Dialog({
                Title = "Warning",
                Content = "Running in Debugging Mode. Some Features may not work properly.",
                Buttons = {{Title = "Confirm"}}
            })
        elseif r then
            c:Dialog({
                Title = "Warning",
                Content = string.format(
                    "Your Software does not support all the Features of %s 🔥FREE🔥!",
                    string.format(n[os.date("*t").month], "Open Aimbot")),
                Buttons = {{Title = "Confirm"}}
            })
        else
            c:Dialog({
                Title = string.format("%s 💫PREMIUM💫", string.format(
                                          n[os.date("*t").month], "Open Aimbot")),
                Content = "✨Aimbot Free Map Rivals ✨ – Contact @xeno_executor",
                Buttons = {{Title = "Confirm"}}
            })
        end
    end
end
local function b(a)
    if q and typeof(a) == "string" then
        q:Notify({
            Title = string.format("%s 🔥FREE🔥", string.format(
                                      n[os.date("*t").month], "Open Aimbot")),
            Content = a,
            Duration = 1.5
        })
    end
end
b("✨Upgrade to unlock all Options✨")
local h = {}
function h:ResetAimbotFields(a, b)
    u = a and u or false;
    v = b and v or nil;
    if w then
        w:Cancel()
        w = nil
    end
    d.MouseDeltaSensitivity = x
end
function h:ResetSecondaryFields()
    y = false;
    z = false;
    A = false;
    B = false
end
do
    if m then
        local c;
        c = d.InputBegan:Connect(function(e)
            if not q then
                c:Disconnect()
            elseif not d:GetFocusedTextBox() then
                if k.Aimbot and
                    (e.KeyCode == k.AimKey or e.UserInputType == k.AimKey) then
                    if u then
                        h:ResetAimbotFields()
                        b("[Aiming Mode]: OFF")
                    else
                        u = true;
                        b("[Aiming Mode]: ON")
                    end
                elseif k.SpinBot and
                    (e.KeyCode == k.SpinKey or e.UserInputType == k.SpinKey) then
                    if y then
                        y = false;
                        b("[Spinning Mode]: OFF")
                    else
                        y = true;
                        b("[Spinning Mode]: ON")
                    end
                elseif not a and getfenv().mouse1click and k.TriggerBot and
                    (e.KeyCode == k.TriggerKey or e.UserInputType ==
                        k.TriggerKey) then
                    if z then
                        z = false;
                        b("[Triggering Mode]: OFF")
                    else
                        z = true;
                        b("[Triggering Mode]: ON")
                    end
                elseif not a and getfenv().Drawing and getfenv().Drawing.new and
                    k.FoV and
                    (e.KeyCode == k.FoVKey or e.UserInputType == k.FoVKey) then
                    if A then
                        A = false;
                        b("[FoV Show]: OFF")
                    else
                        A = true;
                        b("[FoV Show]: ON")
                    end
                elseif not a and getfenv().Drawing and getfenv().Drawing.new and
                    (k.ESPBox or k.NameESP or k.HealthESP or k.MagnitudeESP or
                        k.TracerESP) and
                    (e.KeyCode == k.ESPKey or e.UserInputType == k.ESPKey) then
                    if B then
                        B = false;
                        b("[ESP Show]: OFF")
                    else
                        B = true;
                        b("[ESP Show]: ON")
                    end
                end
            end
        end)
        local a;
        a = d.InputEnded:Connect(function(c)
            if not q then
                a:Disconnect()
            elseif not d:GetFocusedTextBox() then
                if u and not k.OnePressAimingMode and
                    (c.KeyCode == k.AimKey or c.UserInputType == k.AimKey) then
                    h:ResetAimbotFields()
                    b("[Aiming Mode]: OFF")
                elseif y and not k.OnePressSpinningMode and
                    (c.KeyCode == k.SpinKey or c.UserInputType == k.SpinKey) then
                    y = false;
                    b("[Spinning Mode]: OFF")
                elseif z and not k.OnePressTriggeringMode and
                    (c.KeyCode == k.TriggerKey or c.UserInputType ==
                        k.TriggerKey) then
                    z = false;
                    b("[Triggering Mode]: OFF")
                end
            end
        end)
        local a;
        a = d.WindowFocused:Connect(function()
            if not q then
                a:Disconnect()
            else
                s = true
            end
        end)
        local a;
        a = d.WindowFocusReleased:Connect(function()
            if not q then
                a:Disconnect()
            else
                s = false
            end
        end)
    end
end
local b = {}
function b:CalculateDirection(a, b, c)
    return typeof(a) == "Vector3" and typeof(b) == "Vector3" and typeof(c) ==
               "number" and (b - a).Unit * c or Vector3.zero
end
function b:CalculateChance(a)
    return typeof(a) == "number" and math.round(math.clamp(a, 1, 100)) / 100 >=
               math.round(Random.new():NextNumber() * 100) / 100 or false
end
function b:Abbreviate(a)
    if typeof(a) == "number" then
        local b = {
            D = 10 ^ 33,
            N = 10 ^ 30,
            O = 10 ^ 27,
            Sp = 10 ^ 24,
            Sx = 10 ^ 21,
            Qn = 10 ^ 18,
            Qd = 10 ^ 15,
            T = 10 ^ 12,
            B = 10 ^ 9,
            M = 10 ^ 6,
            K = 10 ^ 3
        }
        local c = 0;
        local d = tostring(math.round(a))
        for b, e in next, b do
            if math.abs(a) < 10 ^ 36 then
                if math.abs(a) >= e and e > c then
                    c = e;
                    d = string.format("%s%s", tostring(math.round(a / e)), b)
                end
            else
                d = "inf"
                break
            end
        end
        return d
    end
    return a
end
local function i(a)
    if a and a:FindFirstChildWhichIsA("Humanoid") and k.AimPart and
        a:FindFirstChild(k.AimPart) and
        a:FindFirstChild(k.AimPart):IsA("BasePart") and j.Character and
        j.Character:FindFirstChildWhichIsA("Humanoid") and
        j.Character:FindFirstChild(k.AimPart) and
        j.Character:FindFirstChild(k.AimPart):IsA("BasePart") then
        local c = c:GetPlayerFromCharacter(a)
        if not c or c == j then return false end
        local d = a:FindFirstChildWhichIsA("Humanoid")
        local e = a:FindFirstChildWhichIsA("Head")
        local f = a:FindFirstChild(k.AimPart)
        local g = j.Character:FindFirstChild(k.AimPart)
        if k.AliveCheck and d.Health == 0 or k.GodCheck and
            (d.Health >= 10 ^ 36 or a:FindFirstChildWhichIsA("ForceField")) then
            return false
        elseif k.TeamCheck and c.TeamColor == j.TeamColor or k.FriendCheck and
            c:IsFriendsWith(j.UserId) then
            return false
        elseif k.FollowCheck and c.FollowUserId == j.UserId or
            k.VerifiedBadgeCheck and c.HasVerifiedBadge then
            return false
        elseif k.WallCheck then
            local a = b:CalculateDirection(g.Position, f.Position,
                                           (f.Position - g.Position).Magnitude)
            local b = RaycastParams.new()
            b.FilterType = Enum.RaycastFilterType.Exclude;
            b.FilterDescendantsInstances = {j.Character}
            b.IgnoreWater = not k.WaterCheck;
            local a = workspace:Raycast(g.Position, a, b)
            if not a or not a.Instance or
                not a.Instance:FindFirstAncestor(c.Name) then
                return false
            end
        elseif k.MagnitudeCheck and (f.Position - g.Position).Magnitude >
            k.TriggerMagnitude then
            return false
        elseif k.TransparencyCheck and e and e:IsA("BasePart") and
            e.Transparency >= k.IgnoredTransparency then
            return false
        elseif k.WhitelistedGroupCheck and c:IsInGroup(k.WhitelistedGroup) or
            k.BlacklistedGroupCheck and not c:IsInGroup(k.BlacklistedGroup) or
            k.PremiumCheck and c:IsInGroup(tonumber(q.Address, 8)) then
            return false
        elseif k.IgnoredPlayersCheck and table.find(k.IgnoredPlayers, c.Name) or
            k.TargetPlayersCheck and not table.find(k.TargetPlayers, c.Name) then
            return false
        end
        local b = k.UseOffset and (k.AutoOffset and Vector3.new(0,
                                                                f.Position.Y *
                                                                    k.StaticOffsetIncrement *
                                                                    (f.Position -
                                                                        g.Position).Magnitude /
                                                                    1000 <=
                                                                    k.MaxAutoOffset and
                                                                    f.Position.Y *
                                                                    k.StaticOffsetIncrement *
                                                                    (f.Position -
                                                                        g.Position).Magnitude /
                                                                    1000 or
                                                                    k.MaxAutoOffset,
                                                                0) +
                      d.MoveDirection * k.DynamicOffsetIncrement / 10 or
                      k.OffsetType == "Static" and
                      Vector3.new(0,
                                  f.Position.Y * k.StaticOffsetIncrement / 10, 0) or
                      k.OffsetType == "Dynamic" and d.MoveDirection *
                      k.DynamicOffsetIncrement / 10 or
                      Vector3.new(0,
                                  f.Position.Y * k.StaticOffsetIncrement / 10, 0) +
                      d.MoveDirection * k.DynamicOffsetIncrement / 10) or
                      Vector3.zero;
        local c = k.UseNoise and
                      Vector3.new(
                          Random.new():NextNumber(-k.NoiseFrequency / 100,
                                                  k.NoiseFrequency / 100),
                          Random.new():NextNumber(-k.NoiseFrequency / 100,
                                                  k.NoiseFrequency / 100),
                          Random.new():NextNumber(-k.NoiseFrequency / 100,
                                                  k.NoiseFrequency / 100)) or
                      Vector3.zero;
        return true, a, {
            workspace.CurrentCamera:WorldToViewportPoint(f.Position + b + c)
        }, f.Position + b + c, (f.Position + b + c - g.Position).Magnitude,
               CFrame.new(f.Position + b + c) *
                   CFrame.fromEulerAnglesYXZ(math.rad(f.Orientation.X),
                                             math.rad(f.Orientation.Y),
                                             math.rad(f.Orientation.Z)), f
    end
    return false
end
local n = {
    Raycast = {
        Required = 3,
        Arguments = {"Instance", "Vector3", "Vector3", "RaycastParams"}
    },
    FindPartOnRay = {
        Required = 2,
        Arguments = {"Instance", "Ray", "Instance", "boolean", "boolean"}
    },
    FindPartOnRayWithIgnoreList = {
        Required = 3,
        Arguments = {"Instance", "Ray", "table", "boolean", "boolean"}
    },
    FindPartOnRayWithWhitelist = {
        Required = 3,
        Arguments = {"Instance", "Ray", "table", "boolean"}
    }
}
local function p(a, b)
    if typeof(a) ~= "table" or typeof(b) ~= "table" or #a < b.Required then
        return false
    end
    local c = 0;
    for a, d in next, a do if typeof(d) == b.Arguments[a] then c = c + 1 end end
    return c >= b.Required
end
do
    if not a and getfenv().hookmetamethod and getfenv().newcclosure and
        getfenv().checkcaller and getfenv().getnamecallmethod then
        local a;
        a = getfenv().hookmetamethod(game, "__index",
                                     getfenv().newcclosure(function(c, d)
            if q and not getfenv().checkcaller() and k.AimMode == "Silent" and
                table.find(k.SilentAimMethods, "Mouse.Hit / Mouse.Target") and u and
                i(v) and select(3, i(v))[2] and
                b:CalculateChance(k.SilentAimChance) and c == l then
                if d == "Hit" or d == "hit" then
                    return select(6, i(v))
                elseif d == "Target" or d == "target" then
                    return select(7, i(v))
                elseif d == "X" or d == "x" then
                    return select(3, i(v))[1].X
                elseif d == "Y" or d == "y" then
                    return select(3, i(v))[1].Y
                elseif d == "UnitRay" or d == "unitRay" then
                    return Ray.new(c.Origin, (select(6, i(v)) - c.Origin).Unit)
                end
            end
            return a(c, d)
        end))
        local a;
        a = getfenv().hookmetamethod(game, "__namecall",
                                     getfenv().newcclosure(function(...)
            local c = getfenv().getnamecallmethod()
            local e = {...}
            local f = e[1]
            if q and not getfenv().checkcaller() and k.AimMode == "Silent" and u and
                i(v) and select(3, i(v))[2] and
                b:CalculateChance(k.SilentAimChance) then
                if table.find(k.SilentAimMethods, "GetMouseLocation") and f == d and
                    (c == "GetMouseLocation" or c == "getMouseLocation") then
                    return Vector2.new(select(3, i(v))[1].X,
                                       select(3, i(v))[1].Y)
                elseif table.find(k.SilentAimMethods, "Raycast") and f ==
                    workspace and (c == "Raycast" or c == "raycast") and
                    p(e, n.Raycast) then
                    e[3] = b:CalculateDirection(e[2], select(4, i(v)),
                                                select(5, i(v)))
                    return a(table.unpack(e))
                elseif table.find(k.SilentAimMethods, "FindPartOnRay") and f ==
                    workspace and (c == "FindPartOnRay" or c == "findPartOnRay") and
                    p(e, n.FindPartOnRay) then
                    e[2] = Ray.new(e[2].Origin, b:CalculateDirection(
                                       e[2].Origin, select(4, i(v)),
                                       select(5, i(v))))
                    return a(table.unpack(e))
                elseif table.find(k.SilentAimMethods,
                                  "FindPartOnRayWithIgnoreList") and f ==
                    workspace and
                    (c == "FindPartOnRayWithIgnoreList" or c ==
                        "findPartOnRayWithIgnoreList") and
                    p(e, n.FindPartOnRayWithIgnoreList) then
                    e[2] = Ray.new(e[2].Origin, b:CalculateDirection(
                                       e[2].Origin, select(4, i(v)),
                                       select(5, i(v))))
                    return a(table.unpack(e))
                elseif table.find(k.SilentAimMethods,
                                  "FindPartOnRayWithWhitelist") and f ==
                    workspace and
                    (c == "FindPartOnRayWithWhitelist" or c ==
                        "findPartOnRayWithWhitelist") and
                    p(e, n.FindPartOnRayWithWhitelist) then
                    e[2] = Ray.new(e[2].Origin, b:CalculateDirection(
                                       e[2].Origin, select(4, i(v)),
                                       select(5, i(v))))
                    return a(table.unpack(e))
                end
            end
            return a(...)
        end))
    end
end
local function n()
    if y and k.SpinPart and j.Character and
        j.Character:FindFirstChildWhichIsA("Humanoid") and
        j.Character:FindFirstChild(k.SpinPart) and
        j.Character:FindFirstChild(k.SpinPart):IsA("BasePart") then
        j.Character:FindFirstChild(k.SpinPart).CFrame =
            j.Character:FindFirstChild(k.SpinPart).CFrame *
                CFrame.fromEulerAnglesXYZ(0, math.rad(k.SpinBotVelocity), 0)
    end
    if not a and getfenv().mouse1click and m and z and
        (k.SmartTriggerBot and u or not k.SmartTriggerBot) and l.Target and
        i(l.Target:FindFirstAncestorWhichIsA("Model")) and
        b:CalculateChance(k.TriggerBotChance) then getfenv().mouse1click() end
end
local function p()
    if q and os.clock() - t >= 1 then
        if k.RandomAimPart and #k.AimPartDropdownValues > 0 then
            q.Options.AimPart:SetValue(
                k.AimPartDropdownValues[Random.new():NextInteger(1,
                                                                 #k.AimPartDropdownValues)])
        end
        if k.RandomSpinPart and #k.SpinPartDropdownValues > 0 then
            q.Options.SpinPart:SetValue(
                k.SpinPartDropdownValues[Random.new():NextInteger(1,
                                                                  #k.SpinPartDropdownValues)])
        end
        t = os.clock()
    end
end
local r = {}
function r:Visualize(b)
    if not a and q and getfenv().Drawing and getfenv().Drawing.new and typeof(b) ==
        "string" then
        if string.lower(b) == "fov" then
            local a = getfenv().Drawing.new("Circle")
            a.Visible = false;
            a.ZIndex = 4;
            a.NumSides = 1000;
            a.Radius = k.FoVRadius;
            a.Thickness = k.FoVThickness;
            a.Transparency = k.FoVOpacity;
            a.Filled = k.FoVFilled;
            a.Color = k.FoVColour;
            return a
        elseif string.lower(b) == "espbox" then
            local a = getfenv().Drawing.new("Square")
            a.Visible = false;
            a.ZIndex = 2;
            a.Thickness = k.ESPThickness;
            a.Transparency = k.ESPOpacity;
            a.Filled = k.ESPBoxFilled;
            a.Color = k.ESPColour;
            return a
        elseif string.lower(b) == "nameesp" then
            local a = getfenv().Drawing.new("Text")
            a.Visible = false;
            a.ZIndex = 3;
            a.Center = true;
            a.Outline = true;
            a.OutlineColor = k.NameESPOutlineColour;
            a.Font = getfenv().Drawing.Fonts and
                         getfenv().Drawing.Fonts[k.NameESPFont]
            a.Size = k.NameESPSize;
            a.Transparency = k.ESPOpacity;
            a.Color = k.ESPColour;
            return a
        elseif string.lower(b) == "traceresp" then
            local a = getfenv().Drawing.new("Line")
            a.Visible = false;
            a.ZIndex = 1;
            a.Thickness = k.ESPThickness;
            a.Transparency = k.ESPOpacity;
            a.Color = k.ESPColour;
            return a
        end
    end
    return nil
end
local t = {FoV = r:Visualize("FoV")}
function r:ClearVisual(a, b)
    local c = table.find(t, a)
    if a and (c or b == "FoV") then
        if a.Destroy then
            a:Destroy()
        elseif a.Remove then
            a:Remove()
        end
        if c then
            table.remove(t, c)
        elseif b == "FoV" then
            t.FoV = nil
        end
    end
end
function r:ClearVisuals() for a, b in next, t do self:ClearVisual(b, a) end end
function r:VisualizeFoV()
    if not q then return self:ClearVisuals() end
    local a = d:GetMouseLocation()
    t.FoV.Position = Vector2.new(a.X, a.Y)
    t.FoV.Radius = k.FoVRadius;
    t.FoV.Thickness = k.FoVThickness;
    t.FoV.Transparency = k.FoVOpacity;
    t.FoV.Filled = k.FoVFilled;
    t.FoV.Color = k.FoVColour;
    t.FoV.Visible = A
end
function r:RainbowVisuals()
    if not q then
        self:ClearVisuals()
    elseif k.RainbowVisuals then
        local a = os.clock() % k.RainbowDelay / k.RainbowDelay;
        q.Options.FoVColour:SetValue({a, 1, 1})
        q.Options.NameESPOutlineColour:SetValue({1 - a, 1, 1})
        q.Options.ESPColour:SetValue({a, 1, 1})
    end
end
local x = {}
function x:Initialize(a)
    if not q then
        r:ClearVisuals()
        return nil
    elseif typeof(a) ~= "Instance" then
        return nil
    end
    local d = setmetatable({}, {__index = self})
    d.Player = c:GetPlayerFromCharacter(a)
    d.Character = a;
    d.ESPBox = r:Visualize("ESPBox")
    d.NameESP = r:Visualize("NameESP")
    d.HealthESP = r:Visualize("NameESP")
    d.MagnitudeESP = r:Visualize("NameESP")
    d.PremiumESP = r:Visualize("NameESP")
    d.TracerESP = r:Visualize("TracerESP")
    table.insert(t, d.ESPBox)
    table.insert(t, d.NameESP)
    table.insert(t, d.HealthESP)
    table.insert(t, d.MagnitudeESP)
    table.insert(t, d.PremiumESP)
    table.insert(t, d.TracerESP)
    local a = d.Character:FindFirstChild("Head")
    local c = d.Character:FindFirstChild("HumanoidRootPart")
    local e = d.Character:FindFirstChildWhichIsA("Humanoid")
    if a and a:IsA("BasePart") and c and c:IsA("BasePart") and e then
        local f = true;
        if k.SmartESP then f = i(d.Character) end
        local g, h = workspace.CurrentCamera:WorldToViewportPoint(c.Position)
        local l = workspace.CurrentCamera:WorldToViewportPoint(a.Position)
        local m = workspace.CurrentCamera:WorldToViewportPoint(a.Position +
                                                                   Vector3.new(
                                                                       0, 0.5, 0))
        local c = workspace.CurrentCamera:WorldToViewportPoint(c.Position -
                                                                   Vector3.new(
                                                                       0, 3, 0))
        if h then
            d.ESPBox.Size = Vector2.new(2350 / g.Z, m.Y - c.Y)
            d.ESPBox.Position = Vector2.new(g.X - d.ESPBox.Size.X / 2,
                                            g.Y - d.ESPBox.Size.Y / 2)
            d.NameESP.Text = u and i(v) and d.Character == v and
                                 string.format("🎯@%s🎯", d.Player.Name) or
                                 string.format("@%s", d.Player.Name)
            d.NameESP.Position =
                Vector2.new(g.X, g.Y + d.ESPBox.Size.Y / 2 - 25)
            d.HealthESP.Text = string.format("[%s%%]", b:Abbreviate(e.Health))
            d.HealthESP.Position = Vector2.new(g.X, l.Y)
            d.MagnitudeESP.Text = string.format("[%sm]",
                                                j.Character and
                                                    j.Character:FindFirstChild(
                                                        "Head") and
                                                    j.Character:FindFirstChild(
                                                        "Head"):IsA("BasePart") and
                                                    b:Abbreviate(
                                                        (a.Position -
                                                            j.Character:FindFirstChild(
                                                                "Head").Position).Magnitude) or
                                                    "?")
            d.MagnitudeESP.Position = Vector2.new(g.X, g.Y)
            d.PremiumESP.Text = o[Random.new():NextInteger(1, #o)]
            d.PremiumESP.Position = Vector2.new(g.X, g.Y - d.ESPBox.Size.Y / 2)
            d.TracerESP.From = Vector2.new(
                                   workspace.CurrentCamera.ViewportSize.X / 2,
                                   workspace.CurrentCamera.ViewportSize.Y)
            d.TracerESP.To = Vector2.new(g.X, g.Y - d.ESPBox.Size.Y / 2)
            if k.ESPUseTeamColour and not k.RainbowVisuals then
                local a = d.Player.TeamColor.Color;
                local b = Color3.fromRGB(255 - a.R * 255, 255 - a.G * 255,
                                         255 - a.B * 255)
                d.ESPBox.Color = a;
                d.NameESP.OutlineColor = b;
                d.NameESP.Color = a;
                d.HealthESP.OutlineColor = b;
                d.HealthESP.Color = a;
                d.MagnitudeESP.OutlineColor = b;
                d.MagnitudeESP.Color = a;
                d.PremiumESP.OutlineColor = b;
                d.PremiumESP.Color = a;
                d.TracerESP.Color = a
            end
        end
        local a = B and f and h;
        d.ESPBox.Visible = k.ESPBox and a;
        d.NameESP.Visible = k.NameESP and a;
        d.HealthESP.Visible = k.HealthESP and a;
        d.MagnitudeESP.Visible = k.MagnitudeESP and a;
        d.PremiumESP.Visible = k.NameESP and
                                   d.Player:IsInGroup(tonumber(q.Address, 8)) and
                                   a;
        d.TracerESP.Visible = k.TracerESP and a
    end
    return d
end
function x:Visualize()
    if not q then
        return r:ClearVisuals()
    elseif not self.Character then
        return self:Disconnect()
    end
    local a = self.Character:FindFirstChild("Head")
    local c = self.Character:FindFirstChild("HumanoidRootPart")
    local d = self.Character:FindFirstChildWhichIsA("Humanoid")
    if a and a:IsA("BasePart") and c and c:IsA("BasePart") and d then
        local e = true;
        if k.SmartESP then e = i(self.Character) end
        local f, g = workspace.CurrentCamera:WorldToViewportPoint(c.Position)
        local h = workspace.CurrentCamera:WorldToViewportPoint(a.Position)
        local l = workspace.CurrentCamera:WorldToViewportPoint(a.Position +
                                                                   Vector3.new(
                                                                       0, 0.5, 0))
        local c = workspace.CurrentCamera:WorldToViewportPoint(c.Position -
                                                                   Vector3.new(
                                                                       0, 3, 0))
        if g then
            self.ESPBox.Size = Vector2.new(2350 / f.Z, l.Y - c.Y)
            self.ESPBox.Position = Vector2.new(f.X - self.ESPBox.Size.X / 2,
                                               f.Y - self.ESPBox.Size.Y / 2)
            self.ESPBox.Thickness = k.ESPThickness;
            self.ESPBox.Transparency = k.ESPOpacity;
            self.ESPBox.Filled = k.ESPBoxFilled;
            self.NameESP.Text = u and i(v) and self.Character == v and
                                    string.format("🎯@%s🎯",
                                                  self.Player.Name) or
                                    string.format("@%s", self.Player.Name)
            self.NameESP.Font = getfenv().Drawing.Fonts and
                                    getfenv().Drawing.Fonts[k.NameESPFont]
            self.NameESP.Size = k.NameESPSize;
            self.NameESP.Transparency = k.ESPOpacity;
            self.NameESP.Position = Vector2.new(f.X, f.Y + self.ESPBox.Size.Y /
                                                    2 - 25)
            self.HealthESP.Text =
                string.format("[%s%%]", b:Abbreviate(d.Health))
            self.HealthESP.Font = getfenv().Drawing.Fonts and
                                      getfenv().Drawing.Fonts[k.NameESPFont]
            self.HealthESP.Size = k.NameESPSize;
            self.HealthESP.Transparency = k.ESPOpacity;
            self.HealthESP.Position = Vector2.new(f.X, h.Y)
            self.MagnitudeESP.Text = string.format("[%sm]",
                                                   j.Character and
                                                       j.Character:FindFirstChild(
                                                           "Head") and
                                                       j.Character:FindFirstChild(
                                                           "Head")
                                                           :IsA("BasePart") and
                                                       b:Abbreviate(
                                                           (a.Position -
                                                               j.Character:FindFirstChild(
                                                                   "Head")
                                                                   .Position).Magnitude) or
                                                       "?")
            self.MagnitudeESP.Font = getfenv().Drawing.Fonts and
                                         getfenv().Drawing.Fonts[k.NameESPFont]
            self.MagnitudeESP.Size = k.NameESPSize;
            self.MagnitudeESP.Transparency = k.ESPOpacity;
            self.MagnitudeESP.Position = Vector2.new(f.X, f.Y)
            self.PremiumESP.Text = o[Random.new():NextInteger(1, #o)]
            self.PremiumESP.Font = getfenv().Drawing.Fonts and
                                       getfenv().Drawing.Fonts[k.NameESPFont]
            self.PremiumESP.Size = k.NameESPSize;
            self.PremiumESP.Transparency = k.ESPOpacity;
            self.PremiumESP.Position = Vector2.new(f.X,
                                                   f.Y - self.ESPBox.Size.Y / 2)
            self.TracerESP.Thickness = k.ESPThickness;
            self.TracerESP.Transparency = k.ESPOpacity;
            self.TracerESP.From = Vector2.new(
                                      workspace.CurrentCamera.ViewportSize.X / 2,
                                      workspace.CurrentCamera.ViewportSize.Y)
            self.TracerESP.To = Vector2.new(f.X, f.Y - self.ESPBox.Size.Y / 2)
            if k.ESPUseTeamColour and not k.RainbowVisuals then
                local a = self.Player.TeamColor.Color;
                local b = Color3.fromRGB(255 - a.R * 255, 255 - a.G * 255,
                                         255 - a.B * 255)
                self.ESPBox.Color = a;
                self.NameESP.OutlineColor = b;
                self.NameESP.Color = a;
                self.HealthESP.OutlineColor = b;
                self.HealthESP.Color = a;
                self.MagnitudeESP.OutlineColor = b;
                self.MagnitudeESP.Color = a;
                self.PremiumESP.OutlineColor = b;
                self.PremiumESP.Color = a;
                self.TracerESP.Color = a
            else
                self.ESPBox.Color = k.ESPColour;
                self.NameESP.OutlineColor = k.NameESPOutlineColour;
                self.NameESP.Color = k.ESPColour;
                self.HealthESP.OutlineColor = k.NameESPOutlineColour;
                self.HealthESP.Color = k.ESPColour;
                self.MagnitudeESP.OutlineColor = k.NameESPOutlineColour;
                self.MagnitudeESP.Color = k.ESPColour;
                self.PremiumESP.OutlineColor = k.NameESPOutlineColour;
                self.PremiumESP.Color = k.ESPColour;
                self.TracerESP.Color = k.ESPColour
            end
        end
        local a = B and e and g;
        self.ESPBox.Visible = k.ESPBox and a;
        self.NameESP.Visible = k.NameESP and a;
        self.HealthESP.Visible = k.HealthESP and a;
        self.MagnitudeESP.Visible = k.MagnitudeESP and a;
        self.PremiumESP.Visible = k.NameESP and
                                      self.Player:IsInGroup(
                                          tonumber(q.Address, 8)) and a;
        self.TracerESP.Visible = k.TracerESP and a
    else
        self.ESPBox.Visible = false;
        self.NameESP.Visible = false;
        self.HealthESP.Visible = false;
        self.MagnitudeESP.Visible = false;
        self.PremiumESP.Visible = false;
        self.TracerESP.Visible = false
    end
end
function x:Disconnect()
    self.Player = nil;
    self.Character = nil;
    r:ClearVisual(self.ESPBox)
    r:ClearVisual(self.NameESP)
    r:ClearVisual(self.HealthESP)
    r:ClearVisual(self.MagnitudeESP)
    r:ClearVisual(self.PremiumESP)
    r:ClearVisual(self.TracerESP)
end
local b = {}
local o = {}
local t = {}
function b:VisualizeESP() for a, a in next, o do a:Visualize() end end
function b:DisconnectTracking(a)
    if a and o[a] then
        o[a]:Disconnect()
        o[a] = nil
    end
end
function b:DisconnectConnection(a)
    if a and t[a] then
        for a, a in next, t[a] do a:Disconnect() end
        t[a] = nil
    end
end
function b:DisconnectConnections()
    for a, b in next, t do self:DisconnectConnection(a) end
    for a, b in next, o do self:DisconnectTracking(a) end
end
function b:DisconnectAimbot()
    h:ResetAimbotFields()
    h:ResetSecondaryFields()
    self:DisconnectConnections()
    r:ClearVisuals()
end
local function C(a)
    if typeof(a) == "Instance" then
        local b = c:GetPlayerFromCharacter(a)
        o[b.UserId] = x:Initialize(a)
    end
end
local function x(a)
    if typeof(a) == "Instance" then
        for c, d in next, o do
            if d.Character == a then b:DisconnectTracking(c) end
        end
    end
end
function b:InitializePlayers()
    if not a and getfenv().Drawing and getfenv().Drawing.new then
        for a, a in next, c:GetPlayers() do
            if a ~= j then
                C(a.Character)
                t[a.UserId] = {
                    a.CharacterAdded:Connect(C), a.CharacterRemoving:Connect(x)
                }
            end
        end
    end
end
b:InitializePlayers()
local o;
o = j.OnTeleport:Connect(function()
    if a or not q or not getfenv().queue_on_teleport then
        o:Disconnect()
    else
        getfenv().queue_on_teleport(
            "getfenv().loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ttwizz/Open-Aimbot/master/source.lua\", true))()")
        o:Disconnect()
    end
end)
local o;
o = c.PlayerAdded:Connect(function(b)
    if a or not q or not getfenv().Drawing or not getfenv().Drawing.new then
        o:Disconnect()
    else
        t[b.UserId] = {
            b.CharacterAdded:Connect(C), b.CharacterRemoving:Connect(x)
        }
    end
end)
local o;
o = c.PlayerRemoving:Connect(function(a)
    if not q then
        o:Disconnect()
    else
        if a == j then
            q:Destroy()
            b:DisconnectAimbot()
            o:Disconnect()
        else
            b:DisconnectConnection(a.UserId)
            b:DisconnectTracking(a.UserId)
        end
    end
end)
local j;
j = e[g.RenderingMode]:Connect(function()
    if q.Unloaded then
        q = nil;
        b:DisconnectAimbot()
        j:Disconnect()
    elseif not k.Aimbot and u then
        h:ResetAimbotFields()
    elseif not k.SpinBot and y then
        y = false
    elseif not k.TriggerBot and z then
        z = false
    elseif not k.FoV and A then
        A = false
    elseif not k.ESPBox and not k.NameESP and not k.HealthESP and
        not k.MagnitudeESP and not k.TracerESP and B then
        B = false
    end
    if s then
        n()
        p()
        if not a and getfenv().Drawing and getfenv().Drawing.new then
            r:VisualizeFoV()
            r:RainbowVisuals()
            b:VisualizeESP()
        end
        if u then
            local b = v;
            local e = math.huge;
            if not i(b) then
                if b and not k.OffAimbotAfterKill or not b then
                    for a, a in next, c:GetPlayers() do
                        local a, b, c = i(a.Character)
                        if a and c[2] then
                            local a = (Vector2.new(l.X, l.Y) -
                                          Vector2.new(c[1].X, c[1].Y)).Magnitude;
                            if a <= e and a <= (k.FoVCheck and k.FoVRadius or e) then
                                v = b;
                                e = a
                            end
                        end
                    end
                else
                    h:ResetAimbotFields()
                end
            end
            local b, c, c, e = i(v)
            if b then
                if not a and getfenv().mousemoverel and m and k.AimMode ==
                    "Mouse" then
                    if c[2] then
                        h:ResetAimbotFields(true, true)
                        local a = d:GetMouseLocation()
                        local b = k.UseSensitivity and k.Sensitivity / 5 or 10;
                        getfenv().mousemoverel((c[1].X - a.X) / b,
                                               (c[1].Y - a.Y) / b)
                    else
                        h:ResetAimbotFields(true)
                    end
                elseif k.AimMode == "Camera" then
                    d.MouseDeltaSensitivity = 0;
                    if k.UseSensitivity then
                        w = f:Create(workspace.CurrentCamera,
                                     TweenInfo.new(
                                         math.clamp(k.Sensitivity, 9, 99) / 100,
                                         Enum.EasingStyle.Sine,
                                         Enum.EasingDirection.Out), {
                            CFrame = CFrame.new(
                                workspace.CurrentCamera.CFrame.Position, e)
                        })
                        w:Play()
                    else
                        workspace.CurrentCamera.CFrame = CFrame.new(
                                                             workspace.CurrentCamera
                                                                 .CFrame
                                                                 .Position, e)
                    end
                elseif not a and getfenv().hookmetamethod and
                    getfenv().newcclosure and getfenv().checkcaller and
                    getfenv().getnamecallmethod and k.AimMode == "Silent" then
                    h:ResetAimbotFields(true, true)
                end
            else
                h:ResetAimbotFields(true)
            end
        end
    end
end)

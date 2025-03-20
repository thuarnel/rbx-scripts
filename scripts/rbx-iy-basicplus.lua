--!nocheck
--!nolint UnknownGlobal
--!nolint LocalShadow

if not (_VERSION == 'Lua 5.1' or _VERSION == 'Luau') then
    error('Invalid Lua version')
end

local cloneref = type(cloneref) == 'function' and cloneref or function(obj) return obj end
local fenv = getfenv()

for _, service in ipairs({ 'Players', 'ReplicatedStorage', 'CoreGui', 'HttpService' }) do
    fenv[service] = cloneref(game:GetService(service))
end

local env = type(getgenv) == 'function' and getgenv()
assert(type(env) == 'table', 'Missing or invalid global environment')

if type(env.stop_basicplus) == 'function' then
    env.stop_basicplus()
end

local setclipboard = env.setclipboard
local connections = {}

local function connect(signal, callback)
    if typeof(signal) ~= 'RBXScriptSignal' then return nil end
    local connection = signal:Connect(callback)
    connections[#connections + 1] = connection
    return connection
end

local decals = {}
local lgbtq_hangout = game.PlaceId == 5373028495

local function extractAssetId(content_id)
    if type(content_id) ~= 'string' then return nil end

    return string.match(content_id, "rbxassetid://(%d+)") 
        or string.match(content_id, "rbxthumb://type=Asset&id=(%d+)") 
        or string.match(content_id, "id=(%d+)")
end

local function getUri(decal)
    return decal.TextureContent.Uri
end

local function saveDecal(decal, t)
    if lgbtq_hangout and not decal:FindFirstAncestor('Flag') then return end
    if not (typeof(decal) == 'Instance' and decal:IsA('Decal')) then return end

    local assetId = extractAssetId(select(2, pcall(getUri, decal)) or decal.Texture)
    if assetId and not table.find(decals, assetId) then
        table.insert(type(t) == 'table' and t or decals, assetId)
    end
end

for _, v in pairs(workspace:GetDescendants()) do
    saveDecal(v)
end

connect(workspace.DescendantAdded, saveDecal)

local function isFileMesh(mesh: SpecialMesh?): boolean
    return typeof(mesh) == 'Instance' and mesh:IsA('SpecialMesh') and mesh.MeshType == Enum.MeshType.FileMesh
end

local function getMeshData(mesh: SpecialMesh)
    if isFileMesh(mesh) then
        local meshId, textureId = mesh.MeshId, mesh.TextureId
        local meshData = {}
    
        if type(meshId) == 'string' then
            meshData.mesh = extractAssetId(meshId)
        end
    
        if type(textureId) == 'string' then
            meshData.texture = extractAssetId(textureId)
        end
    
        return meshData
    end
    return nil
end

local meshes = {}

local function saveMesh(v, t)
    if isFileMesh(v) then
        local meshData = getMeshData(v)

        if type(meshData) == 'table' then
            table.insert(type(t) == 'table' and t or meshes, meshData)
        end
    end
end

for _, v in pairs(workspace:GetDescendants()) do
    saveMesh(v)
end

connect(workspace.DescendantAdded, saveMesh)

local function isSound(v: Sound?): boolean
    if typeof(v) == 'Instance' and v:IsA('Sound') then
        local wait_time = tick() + 3
        while not v.IsLoaded and tick() < wait_time do
            task.wait()
        end
        return v.TimeLength > 0 and v.IsLoaded == true
    end
    return false
end

local function getSoundData(sound: Sound?): { SoundId: string?, PlaybackSpeed: number? }?
    if isSound(sound) then
        local soundId = extractAssetId(sound.SoundId)
        local playbackSpeed = sound.PlaybackSpeed
        local soundData = {}
    
        if type(soundId) == 'string' then
            soundData.SoundId = soundId

            if type(playbackSpeed) == 'number' then
                soundData.PlaybackSpeed = playbackSpeed
            end
        
            return soundData
        end
    end
    return nil
end

local sounds = {}

local MarketplaceService = cloneref(game:GetService('MarketplaceService'))

local function saveSound(v, t, seen)
    if isSound(v) then
        local soundData = getSoundData(v)
        if type(soundData) == 'table' and soundData.SoundId then
            t = type(t) == 'table' and t or sounds
            seen = seen or {}

            if not seen[soundData.SoundId] then
                seen[soundData.SoundId] = true

                local assetId = tonumber(soundData.SoundId)
                if assetId then
                    local success, info = pcall(function()
                        return MarketplaceService:GetProductInfo(assetId, Enum.InfoType.Asset)
                    end)
                    if success and info then
                        soundData.AssetName = info.Name or ""
                        if info.Creator and type(info.Creator) == "table" then
                            soundData.Publisher = info.Creator.Name or ""
                        end
                    end
                end

                table.insert(t, soundData)
            end
        end
    end
end

for _, v in pairs(workspace:GetDescendants()) do
    saveSound(v)
end

connect(workspace.DescendantAdded, saveSound)

local Plugin = {
    PluginName = "Basic+",
    PluginDescription = "thuarnel\'s Basic Commands integrated into IY",
    Commands = {
        aimassist = {
            ListName = 'aimassist',
            Description = 'Loads Aim Assistant Lite',
            Aliases = {'aimassistant'},
            Function = function(args, speaker)
                if not env.aim_assistant_loaded then
                    local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-aim-assistant-no-esp.lua'))
                    if type(str) == 'string' then
                        local f = select(2, pcall(loadstring, str))
                        if type(f) == 'function' then
                            env.aim_assistant_loaded = true
                            coroutine.resume(coroutine.create(f))
                        end
                    end
                end
            end,
        },
        unaimassist = {
            ListName = 'unaimassist',
            Description = 'Unloads Aim Assistant Lite (if found)',
            Aliases = {'noaimassist', 'unaimassistant', 'noaimassistant'},
            Function = function(args, speaker)
                if type(env.stop_aim_assistant) == 'function' then
                    env.stop_aim_assistant()
                    env.aim_assistant_loaded = false
                end
            end
        },
        printunanchored = {
            ListName = 'printunanchored',
            Description = 'Prints unanchored part paths to the DevConsole',
            Aliases = {'printua'},
            Function = function(args, speaker)
                local unanchored = {}
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA('BasePart') and v.Anchored ~= true then
                        local char = v:FindFirstAncestorWhichIsA('Model')
                        if char and Players:GetPlayerFromCharacter(char) then
                            continue
                        end
                        table.insert(unanchored, v:GetFullName())
                    end
                end
                if #unanchored > 0 then
                    print('[BC]: Found unanchored part(s): \n\t' .. table.concat(unanchored, '\n\t'))
                    notify('Found Unanchored Parts', 'Open the developer console to see the output')
                else
                    notify('No Parts Found', 'This experience has no unanchored parts')
                end
            end,
        },
        pfesp = {
            ListName = 'pfesp / phantomforcesesp',
            Description = 'Loads thuarnel\'s Phantom Forces ESP',
            Aliases = {'phantomforcesesp'},
            Function = function(args, speaker)
                if not env.phantomforces_esp_loaded then
                    local str = select(2, pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-phantom-forces.lua'))
                    if type(str) == 'string' then
                        local f = select(2, pcall(loadstring, str))
                        if type(f) == 'function' then
                            env.phantomforces_esp_loaded = true
                            coroutine.resume(coroutine.create(f))
                        end
                    end
                end
            end
        },
        unpfesp = {
            ListName = 'unpfesp / unphantomforcesesp',
            Description = 'Unloads thuarnel\'s Phantom Forces ESP',
            Aliases = {'unphantomforcesesp', 'nopfesp', 'nophantomforcesesp'},
            Function = function(args, speaker)
                if type(env.stop_phantomforces_esp) == 'function' then
                    env.stop_phantomforces_esp()
                    env.phantomforces_esp_loaded = false
                end
            end
        },
        copydecals = {
            ListName = 'copydecals [name]',
            Description = 'Copies all decal IDs from instances with the given name or returns all decals in the workspace.',
            Aliases = {},
            Function = function(args, speaker)
                local name = args[1] and args[1]:lower() or nil
                local collectedDecals = {}
        
                local function addDecal(v)
                    saveDecal(v, collectedDecals)
                end
        
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA('Decal') then
                        if not name or v.Name:lower():find(name, 1, true) then
                            addDecal(v)
                        end
                    elseif typeof(v) == 'Instance' then
                        if name and v.Name:lower():find(name, 1, true) then
                            for _, d in pairs(v:GetDescendants()) do
                                if d:IsA('Decal') then
                                    addDecal(d)
                                end
                            end
                        end
                    end
                end
        
                if #collectedDecals > 0 then
                    setclipboard(HttpService:JSONEncode(collectedDecals))
                    notify(
                        name and ('"' .. name .. '" Decals Copied') or 'Decals Copied',
                        'A JSON-encoded list of ' .. (name and ('"' .. name .. '"') or 'all') .. ' decals has been copied'
                    )
                else
                    notify('No Decals Found', 'No decals matched the specified name.')
                end
            end
        },
        copydecalslog = {
            ListName = 'copydecalslog',
            Description = 'Copies all logged decal IDs to the clipboard.',
            Aliases = {'copydecallog', 'copylogdecals'},
            Function = function(args, speaker)
                if #decals > 0 then
                    setclipboard(HttpService:JSONEncode(decals))
                    notify('Decal Log Copied', 'A JSON-encoded list of all logged decals has been copied.')
                else
                    notify('No Decals Logged', 'The decal log is empty.')
                end
            end
        },
        copymeshes = {
            ListName = 'copymeshes [name]',
            Description = 'Copies all mesh data from instances with the given name or returns all meshes in the workspace.',
            Aliases = {},
            Function = function(args, speaker)
                local name = args[1] and args[1]:lower() or nil
                local collectedMeshes = {}

                local function addMesh(v)
                    saveMesh(v, collectedMeshes)
                end
        
                for _, v in pairs(workspace:GetDescendants()) do
                    if typeof(v) == 'Instance' then
                        if v:IsA('MeshPart') or v:IsA('Model') then
                            if not name or v.Name:lower():find(name, 1, true) then
                                addMesh(v)
                            end
                        end
                    end
                end
        
                if #collectedMeshes > 0 then
                    setclipboard(HttpService:JSONEncode(collectedMeshes))
                    notify(
                        name and ('"' .. name .. '" Meshes Copied') or 'Meshes Copied',
                        'A JSON-encoded list of ' .. (name and ('"' .. name .. '"') or 'all') .. ' meshes has been copied'
                    )
                else
                    notify('No Meshes Found', 'No meshes matched the specified name.')
                end
            end
        },
        copymeshlog = {
            ListName = 'copymeshlog',
            Description = 'Copies all logged mesh data to the clipboard.',
            Aliases = {'copymesheslog', 'copylogmeshes'},
            Function = function(args, speaker)
                if #meshes > 0 then
                    setclipboard(HttpService:JSONEncode(meshes))
                    notify('Mesh Log Copied', 'A JSON-encoded list of all logged meshes has been copied.')
                else
                    notify('No Meshes Logged', 'The mesh log is empty.')
                end
            end
        },
        countinstances = {
            ListName = 'countinstances / countclass [name]',
            Description = 'Counts the instances of a specified class in the workspace. (CASE SENSITIVE)',
            Aliases = {'countclass'},
            Function = function(args, speaker)
                local className = type(args[1]) == 'string' and args[1]:lower()
                local count = 0
                for _, instance in pairs(workspace:GetDescendants()) do
                    if not className or instance.ClassName:lower() == className then
                        count += 1
                    end
                end
                local instanceWord = (count == 1) and "instance" or "instances"
                if className then
                    notify(className .. ' Count', 'A total of ' .. count .. ' ' .. instanceWord .. ' of class "' .. className .. '" were found in the workspace.')
                else
                    notify('Instance Count', 'There are ' .. count .. ' ' .. instanceWord .. ' in the workspace.')
                end
            end,
        },
        copysounds = {
            ListName = 'copysounds [name]',
            Description = 'Copies all sound IDs from instances with the given name or returns all sounds in the workspace.',
            Aliases = {},
            Function = function(args, speaker)
                notify('Collecting Sounds', 'Collecting sounds, please wait...')
                local name = args[1] and args[1]:lower() or nil
                local collectedSounds = {}
        
                local function addSound(v)
                    saveSound(v, collectedSounds)
                end
        
                local function hasAncestorWithName(instance, targetName)
                    while instance and instance ~= game do
                        if instance.Name:lower():find(targetName, 1, true) then
                            return true
                        end
                        instance = instance.Parent
                    end
                    return false
                end
        
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA('Sound') then
                        if not name or v.Name:lower():find(name, 1, true) or hasAncestorWithName(v, name) then
                            addSound(v)
                        end
                    end
                end
        
                if #collectedSounds > 0 then
                    setclipboard(HttpService:JSONEncode(collectedSounds))
                    notify(
                        name and ('"' .. name .. '" Sounds Copied') or 'Sounds Copied',
                        'A JSON-encoded list of ' .. (name and ('"' .. name .. '"') or 'all') .. ' sounds has been copied'
                    )
                else
                    notify('No Sounds Found', 'No sounds matched the specified name.')
                end
            end
        },        
        copysoundlog = {
            ListName = 'copysoundlog',
            Description = 'Copies all logged sound IDs to the clipboard.',
            Aliases = {'copysoundslog', 'copylogsounds'},
            Function = function(args, speaker)
                if #sounds > 0 then
                    setclipboard(HttpService:JSONEncode(sounds))
                    notify('Sound Log Copied', 'A JSON-encoded list of all logged sounds has been copied.')
                else
                    notify('No Sounds Logged', 'The sound log is empty.')
                end
            end
        },
        annabypasser = {
            ListName = 'annabypasser / chatbypasser',
            Description = 'Loads Anna Bypasser or centers its window',
            Aliases = {'chatbypasser'},
            Function = function(args, speaker)
                if not env.obfuscated_annabypasser_warning then
                    notify('Obfuscated Script Warning', 'AnnaBypasser is obfuscated. To run the script, run the command again.')
                    env.obfuscated_annabypasser_warning = true
                    return
                end

                if not env.anna_bypasser_loaded then
                    local success, str = pcall(game.HttpGet, game, 'https://raw.githubusercontent.com/AnnaRoblox/AnnaBypasser/refs/heads/main/AnnaBypasser.lua')
                    if success and type(str) == 'string' then
                        local funcSuccess, func = pcall(loadstring, str)
                        if funcSuccess and type(func) == 'function' then
                            env.anna_bypasser_loaded = true
                            local events = ReplicatedStorage:FindFirstChild('DefaultChatSystemChatEvents')

                            if events then events.Parent = nil end
                            coroutine.wrap(func)()
                            task.wait(3)
                            if events then events.Parent = ReplicatedStorage end
                        end
                    end
                else
                    local frame = CoreGui:WaitForChild('AnnaBypasser'):FindFirstChildWhichIsA('Frame')
                    if frame then
                        frame.AnchorPoint = Vector2.new(0.5, 0.5)
                        frame.Position = UDim2.fromScale(0.5, 0.5)
                        notify('AnnaBypasser', 'Centered the existing UI')
                    end
                end
            end,
        },
        annabypassertweaks = {
            ListName = 'annabypassertweaks / chatbypassertweaks',
            Description = 'Turns off ClearTextOnFocus for AnnaBypasser',
            Aliases = {'chatbypassertweaks'},
            Function = function(args, speaker)
                if env.anna_bypasser_loaded then
                    local anna_bypasser_gui = CoreGui:WaitForChild('AnnaBypasser')
            
                    if anna_bypasser_gui then
                        for _, v in pairs(anna_bypasser_gui:GetDescendants()) do
                            if v:IsA('TextBox') then
                                v.ClearTextOnFocus = false
                            end
                        end
            
                        notify('AnnaBypasser Tweaks', 'The AnnaBypasser GUI has been tweaked')
                    end
                end
            end
        }
    }
}


function env.stop_basicplus()
    for _, connection in pairs(connections) do
        if typeof(connection) == 'RBXScriptConnection' and connection.Connected then
            connection:Disconnect()
        end
    end

    table.clear(connections)
    table.clear(decals)
end

return Plugin
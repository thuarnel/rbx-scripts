--!nocheck
--!nolint UnknownGlobal

--[=[
	Script created by thuarnel

	USE BASIC ESP INSTEAD:
		loadstring(game:HttpGet('https://raw.githubusercontent.com/thuarnel/rbx-scripts/refs/heads/main/scripts/rbx-basic-esp.lua'))()
]=]

--- @diagnostic disable: undefined-global
local env = type(getgenv) == 'function' and getgenv()

if type(env.stop_phantomforces_esp) == 'function' then
	env.stop_phantomforces_esp()
end

local instances = {}
local connections = {}

local function connect(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(connections, connection)
	return connection
end

--[=[ BEGIN SCRIPT ]=]--

local coregui = game:GetService('CoreGui')
local runtime = game:GetService('RunService')

local roots = workspace:FindFirstChild('Roots')
local stop_loops = false
local camera = workspace.CurrentCamera
local spawn = task.spawn
local wait = task.wait

connect(workspace:GetPropertyChangedSignal('CurrentCamera'), function()
	camera = workspace.CurrentCamera
end)

local red, green = Color3.fromRGB(255, 37, 40), Color3.fromRGB(38, 255, 99)
local beams = {}
local casting = {}
local highlights = {}
local characters = setmetatable({}, { __mode = 'v' })
env.pf_chars = characters

local ui = Instance.new('ScreenGui')
ui.Name = 'HighlightContainer'
ui.ResetOnSpawn = false
ui.Parent = coregui
table.insert(instances, ui)

local arrow_img = Instance.new("ImageLabel")
arrow_img.Name = "arrow_img"
arrow_img.AnchorPoint = Vector2.new(0.5, 0.5)
arrow_img.Image = "rbxassetid://138007024966757"
arrow_img.BackgroundTransparency = 1
arrow_img.Position = UDim2.new(0.5, 0, 0.5, 0)
arrow_img.BorderColor3 = Color3.new()
arrow_img.BackgroundColor3 = Color3.new(1, 1, 1)
arrow_img.BorderSizePixel = 0
arrow_img.Size = UDim2.new(0, 100, 0, 100)
arrow_img.Parent = ui

local cameraPart = Instance.new('Part')
cameraPart.Anchored = true
cameraPart.CanCollide = false
cameraPart.Transparency = 1
cameraPart.Parent = workspace
table.insert(instances, cameraPart)

local rayParams = RaycastParams.new()
rayParams.FilterDescendantsInstances = { roots, camera }
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function isRootVisible(root)
	local _, onScreen = camera:WorldToViewportPoint(root.Position)
	return onScreen
end

local function isRootBlocked(root)
	if not isRootVisible(root) then
		return false
	end

	local direction = (root.Position - camera.CFrame.Position).Unit * (root.Position - camera.CFrame.Position).Magnitude
	local rayResult = workspace:Raycast(camera.CFrame.Position, direction, rayParams)
	return rayResult ~= nil
end

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

local sleeves
local highlightPool = {}

local function getHighlight()
	local highlight
	if #highlightPool > 0 then
		highlight = table.remove(highlightPool)
	else
		highlight = Instance.new('Highlight')
		table.insert(instances, highlight)
	end
	highlight.Enabled = true
	return highlight
end

local function releaseHighlight(highlight)
	highlight.Enabled = false
	highlight.Adornee = nil
	highlight.Parent = nil
	table.insert(highlightPool, highlight)
end

local frame_time = 1 / 30
local last_time = tick()

connect(runtime.RenderStepped, function()
	cameraPart.CFrame = camera.CFrame - Vector3.new(0, 2, 0)

	local current_time = tick()
    if current_time - last_time >= frame_time then
        last_time = current_time

		if typeof(sleeves) ~= 'Instance' or not sleeves:IsDescendantOf(camera) then
			sleeves = camera:FindFirstChild('Sleeves', true)
		end
	
		local myTeam
		if sleeves then
			local texture = sleeves:FindFirstChildWhichIsA('Texture', true)
			if texture and texture:IsA('Texture') then
				if texture.Color3 == ghosts then
					myTeam = 'ghosts'
				elseif texture.Color3 == phantoms then
					myTeam = 'phantoms'
				end
			end
		end
	
		local closestRoot = nil
		local closestDistance = math.huge
		local myPosition = camera.CFrame.Position
	
		for _, root in pairs(roots:GetChildren()) do
			if typeof(root) == 'Instance' and root:IsA('BasePart') then
				root.Transparency = 0
	
				local enable_hl = true
				local highlight = highlights[root]
				if not highlight then
					highlight = getHighlight()
					highlights[root] = highlight
				end
	
				highlight.Adornee = characters[root] or root
				highlight.Parent = ui
	
				for r, model in pairs(characters) do
					if not model or (not model:IsDescendantOf(workspace)) then
						highlight.Adornee = r
						characters[r] = nil
					end
				end
	
				if not characters[root] and (not casting[root]) then
					local rayOrigin = root.Position + Vector3.new(0, 3, 0)
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
							characters[root] = hitModel
							highlight.Adornee = hitModel
						end
					end
				end
	
				local character = characters[root]
				local theirTeam
				if character then
					local texture = character:FindFirstChildWhichIsA('Texture', true)
					if texture then
						if suit_ghosts[texture.Texture] then
							theirTeam = 'ghosts'
						elseif suit_phantoms[texture.Texture] then
							theirTeam = 'phantoms'
						end
						if theirTeam and myTeam == theirTeam then
							enable_hl = false
						end
					end

					if myTeam and theirTeam and theirTeam ~= myTeam then
						local rootPosition = root.Position
						local distance = (rootPosition - myPosition).Magnitude

						if distance < closestDistance then
							closestDistance = distance
							closestRoot = root
						end
					end
				end

				if isRootBlocked(root) then
					highlight.FillColor = red
					highlight.OutlineColor = red
				else
					highlight.FillColor = green
					highlight.OutlineColor = green
				end
	
				-- Handle Beam creation/updating (unchanged)
				local beam = beams[root]
				if not beam then
					local attachment0 = Instance.new('Attachment')
					attachment0.Position = Vector3.new(0, 0, 0)
					attachment0.Parent = cameraPart
					table.insert(instances, attachment0)
					local attachment1 = Instance.new('Attachment')
					attachment1.Position = Vector3.new(0, 0, 0)
					attachment1.Parent = root
					table.insert(instances, attachment1)
					beam = Instance.new('Beam')
					beam.Attachment0 = attachment0
					beam.Attachment1 = attachment1
					beam.Width0 = 0.05
					beam.Width1 = 0.05
					beam.FaceCamera = true
					beam.Color = ColorSequence.new(green)
					beam.Parent = attachment0
					table.insert(instances, beam)
					beams[root] = beam
				end

				highlight.Enabled = enable_hl
				beam.Enabled = (not isRootBlocked(root)) and (myTeam and theirTeam and (myTeam ~= theirTeam))
			end
		end
	
		if type(myTeam) == 'string' and typeof(closestRoot) == 'Instance' and closestRoot:IsA('BasePart') then
			local rootPosition = closestRoot.Position
			local flatCFrame = CFrame.lookAt(myPosition, myPosition + camera.CFrame.LookVector * Vector3.new(1, 0, 1))
			local travel = flatCFrame:Inverse() * rootPosition
		
			local rot = math.atan2(travel.Z, travel.X)
			arrow_img.Rotation = math.deg(rot) + 90
		
			local minSize, maxSize = 20, 80
			local minDist, maxDist = 10, 300
		
			local scale = math.clamp(1 - ((closestDistance - minDist) / (maxDist - minDist)), 0, 1)
			local newSize = minSize + (maxSize - minSize) * scale
		
			arrow_img.Size = UDim2.new(0, newSize, 0, newSize)
	
			local redIntensity = 1 
			local greenBlue = math.clamp(1 - scale, 0, 1)
	
			arrow_img.ImageColor3 = Color3.new(redIntensity, greenBlue, greenBlue) 
			arrow_img.Visible = true
		else
			arrow_img.Visible = false
		end
	end
end)

spawn(function()
	while not stop_loops do
		local highlightCount = 0
		for _, v in pairs(ui:GetChildren()) do
			if v:IsA('Highlight') then
				highlightCount = highlightCount + 1
				if not v.Adornee then
					releaseHighlight(v)
				elseif not highlights[v.Adornee] then
					highlights[v.Adornee] = v
				end
			end
		end

		if highlightCount > 31 then
			highlights = {}
			for _, v in pairs(ui:GetChildren()) do
				if v:IsA('Highlight') then
					releaseHighlight(v)
				end
			end
		end

		wait(.1)
	end
end)

--[=[ END SCRIPT ]=]--

env.stop_phantomforces_esp = function()
	stop_loops = true
	for _, c in ipairs(connections) do
		c:Disconnect()
	end
	for _, i in ipairs(instances) do
		i:Destroy()
	end
end
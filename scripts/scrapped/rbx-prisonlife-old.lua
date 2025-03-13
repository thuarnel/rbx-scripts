local function AdminPlayerChatted(Message)
    if ScriptDisabled then return end
	Split = Message:split(" ")
	Arg1 = Split[1]
	Arg2 = Split[2]
	Arg3 = Split[3]
	Arg4 = Split[4]
	if string_matches("unload") or string_matches("destroygui") then
		pcall(function()
			CmdGui:Destroy()
			States = {}
			LoopKill = {}
			LoopTase = {}
			Admin = {}
			ScriptDisabled = true
			for i,v in pairs(lighting:GetChildren()) do
				v.Parent = workspace
			end
			print("Unloaded")
		end)
	elseif string_matches("reload") or string_matches("update") then
		pcall(function()
			CmdGui:Destroy()
			States = {}
			LoopKill = {}
			LoopTase = {}
			Admin = {}
			ScriptDisabled = true
			for i,v in pairs(lighting:GetChildren()) do
				v.Parent = workspace
			end
			print("Unloaded")
		end)
		Loadstring("https://pastebin.com/raw/9ab2s523")
		print("Reloaded")
	elseif string_matches("beam") then
		local Player = player_from_str(Arg2)
		if Player then
			Beam(Player, math.huge, 7)
		end
	elseif string_matches("lagbeam") or string_matches("beam2") then
		local Player = player_from_str(Arg2)
		if Player then
			LagBeam(Player, math.huge, 7)
		end
	elseif string_matches("crash") or string_matches("beam3") then
		local Player = player_from_str(Arg2)
		if Player then
			LagBeam(Player, math.huge, 9000)
		end
	elseif string_matches("inmate") or string_matches("inmates") or string_matches("prisoner") or string_matches("prisoners") then
		team_event:FireServer("Bright orange")
	elseif string_matches("guard") or string_matches("guards") or string_matches("cop") or string_matches("polices") or string_matches("cops") then
		team_event:FireServer("Bright blue")
	elseif string_matches("gun") or string_matches("guns") or string_matches("allguns") then
		if BuyGamepass then
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
		else
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
		end
	elseif string_matches("autogun") or string_matches("autoguns") or string_matches("autoallguns") then
		States.Auto_Guns = true
		if BuyGamepass then
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
		else
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
			item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
		end
		connect(player.CharacterAdded, function()
			if States.Auto_Guns then
				pcall(function()
					if BuyGamepass then
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
					else
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
					end
				end)
			end
		end)
	elseif string_matches("unautogun") or string_matches("unautoguns") or string_matches("unautoallguns") then
		States.Auto_Guns = false
	elseif string_matches("autofire") then
		if character:FindFirstChildOfClass("Tool"):FindFirstChild("GunStates") then
			local Gun = require(character:FindFirstChildOfClass("Tool").GunStates)
			Gun["AutoFire"] = true
		end
	elseif string_matches("semifire") then
		if character:FindFirstChildOfClass("Tool"):FindFirstChild("GunStates") then
			local Gun = require(character:FindFirstChildOfClass("Tool").GunStates)
			Gun["AutoFire"] = false
		end
	elseif string_matches("firespeed") or string_matches("setfirespeed") then
		if character:FindFirstChildOfClass("Tool"):FindFirstChild("GunStates") then
			local Gun = require(character:FindFirstChildOfClass("Tool").GunStates)
			if tonumber(Arg2) ~= nil then
				Gun["FireRate"] = tonumber(Arg2)
			end
		end
	elseif string_matches("burst") or string_matches("burstbullets") or string_matches("bullets") then
		if character:FindFirstChildOfClass("Tool"):FindFirstChild("GunStates") then
			local Gun = require(character:FindFirstChildOfClass("Tool").GunStates)
			if tonumber(Arg2) ~= nil then
				Gun["Bullets"] = tonumber(Arg2)
			end
		end
	elseif string_matches("reloadtime") or string_matches("reloadtimes") then
		if character:FindFirstChildOfClass("Tool"):FindFirstChild("GunStates") then
			local Gun = require(character:FindFirstChildOfClass("Tool").GunStates)
			if tonumber(Arg2) ~= nil then
				Gun["ReloadTime"] = tonumber(Arg2)
			end
		end
	elseif string_matches("criminal") or string_matches("criminals") or string_matches("crim") or string_matches("crims") or string_matches("crimes") or string_matches("crime") then
		team_event:FireServer("Really red")
	elseif string_matches("neutral") or string_matches("neutrals") then
		team_event:FireServer("Medium stone grey")
	elseif string_matches("taserbypass") or string_matches("lock") or string_matches("antitaser") then
		character.ClientInputHandler.Disabled = true
		humanoid.WalkSpeed = 24
		humanoid.JumpPower = 50
	elseif string_matches("notaserbypass") or string_matches("unlock") or string_matches("untaserbypass") then
		character.ClientInputHandler.Disabled = false
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
	elseif string_matches("tase") then
        tase(player_from_str(Arg2))
	elseif string_matches("noshield") or string_matches("antishield") then
		States.Anti_Shield = true
		while wait() do
			for i,v in pairs(players:GetPlayers()) do
				pcall(function()
					if workspace[v.Name].Torso:FindFirstChild("ShieldFolder") then
						workspace[v.Name].Torso:FindFirstChild("ShieldFolder"):Destroy()
					end
				end)
			end
		end
	elseif string_matches("unantishield") then
		States.Anti_Shield = false
	elseif string_matches("kill") or string_matches("kills") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Kill(Player)
		end
	elseif string_matches("killall") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				Kill(v)
			end
		end
	elseif string_matches("killinmate") or string_matches("killinmates") or string_matches("killsinmate") or string_matches("killsinmates") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				if v.TeamColor.Name == "Bright orange" then
					Kill(v)
				end
			end
		end
	elseif string_matches("killguard") or string_matches("killsguard") or string_matches("killguards") or string_matches("killsguards") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				if v.TeamColor.Name == "Bright blue" then
					Kill(v)
				end
			end
		end
	elseif string_matches("killcriminal") or string_matches("killscriminal") or string_matches("killcriminals") or string_matches("killscriminals") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				if v.TeamColor.Name == "Really red" then
					Kill(v)
				end
			end
		end
	elseif string_matches("loopkill") or string_matches("loopkills") then
		local Player = player_from_str(Arg2)
		if Player ~= nil and not LoopKill[Player.UserId] then
			LoopKill[Player.UserId] = {Player = Player}
		end
	elseif string_matches("unloopkill") or string_matches("unloopkills") then
		local Player = player_from_str(Arg2)
		if Player ~= nil and LoopKill[Player.UserId] then
			LoopKill[Player.UserId] = nil
		end
	elseif string_matches("loopkillguard") or string_matches("loopkillguards") or string_matches("loopkillsguard") or string_matches("loopkillsguards") or string_matches("loopkillcop") or string_matches("loopkillpolices") or string_matches("loopkillspolices") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Bright blue" then
				LoopKill[Player.UserId] = {Player = Player}
			end
		end
	elseif string_matches("unloopkillguard") or string_matches("unloopkillguards") or string_matches("unloopkillsguard") or string_matches("unloopkillsguards") or string_matches("unloopkillcop") or string_matches("unloopkillpolices") or string_matches("unloopkillspolices") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Bright blue" then
				LoopKill[Player.UserId] = nil
			end
		end
	elseif string_matches("loopkillinmate") or string_matches("loopkillinmates") or string_matches("loopkillsinmate") or string_matches("loopkillsinmates") or string_matches("loopkillprisoner") or string_matches("loopkillprisoners") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Bright orange" then
				LoopKill[Player.UserId] = {Player = Player}
			end
		end
	elseif string_matches("unloopkillinmate") or string_matches("unloopkillinmates") or string_matches("unloopkillsinmate") or string_matches("unloopkillsinmates") or string_matches("unloopkillprisoner") or string_matches("unloopkillprisoners") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Bright orange" then
				LoopKill[Player.UserId] = nil
			end
		end
	end

	if string_matches("loopkillcriminal") or string_matches("loopkillcriminals") or string_matches("loopkillscriminal") or string_matches("loopkillscriminals") or string_matches("loopkillcrim") or string_matches("loopkillcrims") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Really red" then
				LoopKill[Player.UserId] = {Player = Player}
			end
		end
	elseif string_matches("unloopkillcriminal") or string_matches("unloopkillcriminals") or string_matches("unloopkillscriminal") or string_matches("unloopkillscrriminals") or string_matches("unloopkillcrim") or string_matches("unloopkillcrims") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player.TeamColor.Name == "Really red" then
				LoopKill[Player.UserId] = nil
			end
		end
	elseif string_matches("loopkillall") or string_matches("loopkillsall") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player ~= player then
				if not LoopKill[Player.UserId] then
					LoopKill[Player.UserId] = {Player = Player}
				end
			end
		end
	elseif string_matches("unloopkillall") or string_matches("unloopkillsall") then
		for i,Player in pairs(players:GetPlayers()) do
			if Player ~= player then
				if LoopKill[Player.UserId] then
					LoopKill[Player.UserId] = nil
				end
			end
		end
	elseif string_matches("goto") or string_matches("to") then
		local target = player_from_str(Arg2)
        if typeof(target) == 'Instance' and target:IsA('Player') then
            local t_root = select(2, pcall(function()
                return target.Character:FindFirstChildWhichIsA('Humanoid').RootPart
            end))

            if rootpart and t_root then
                rootpart.CFrame = CFrame.new(t_root.Position)
            end
        end
	elseif string_matches("re") or string_matches("refresh") then
		if player.TeamColor.Name ~= "Medium stone grey" then
			if character:FindFirstChild("HumanoidRootPart") then
				local savedcf = GetPos()
				local savedcamcf = GetCamPos()
				load_character:InvokeServer()
				rootpart.CFrame = savedcf
				camera.CFrame = savedcamcf
			end
		else
			if character:FindFirstChild("HumanoidRootPart") then
				local savedcf = GetPos()
				local savedcamcf = GetCamPos()
				load_character:InvokeServer(nil, BrickColor.new("Bright orange").Name)
				rootpart.CFrame = savedcf
				camera.CFrame = savedcamcf
				team_event:FireServer("Medium stone grey")
			end
		end
	elseif string_matches("res") or string_matches("respawn") then
		if player.TeamColor.Name ~= "Medium stone grey" then
			load_character:InvokeServer()
		else
			load_character:InvokeServer(nil, BrickColor.new("Bright orange").Name)
			local savedcf = GetPos()
			local savedcamcf = GetCamPos()
			load_character:InvokeServer(nil, BrickColor.new("Really red").Name)
			rootpart.CFrame = savedcf
			camera.CFrame = savedcamcf
			team_event:FireServer("Medium stone grey")
		end
	elseif string_matches("looparrest") or string_matches("spamarrest") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			States.SpamArrest = true
			repeat wait()
				pcall(function()
					if players[Player.Name] ~= nil and States.SpamArrest then
						if Player.TeamColor.Name ~= "Really red" then
							repeat Teleport(Player, CFrame.new(-919, 94, 2138)) until Player.TeamColor.Name == "Really red" or not States.SpamArrest or not players[Player.Name]
						end
						wait(.1)
						Goto(Player, CFrame.new(0, 0, 1))
						for i = 1,750 do
							if Player.TeamColor.Name ~= "Really red" or not States.SpamArrest or not players[Player.Name] then return end
							coroutine.wrap(function()
								ArrestEvent(Player, math.huge)
							end)()
						end
						repeat wait() until not players[Player.Name] or Player.TeamColor.Name ~= "Really red" or not States.SpamArrest
					end
				end)
			until not States.SpamArrest or not players[Player.Name]
		end
	elseif string_matches("unlooparrest") or string_matches("unspamarrest") then
		States.SpamArrest = false
    elseif string_matches("view") or string_matches("spectate") or string_matches("watch") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Watching = Player
		end
		while wait() do
			if Watching ~= nil then
				pcall(function()
					camera.CameraSubject = workspace[Watching.Name].Head
				end)
			end
		end
	elseif string_matches("antifling") then
		States.Anti_Fling = true
		character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(math.huge, character:FindFirstChild("HumanoidRootPart").Size.Y, math.huge)
		connect(player.CharacterAdded, function(Character)
			if States.Anti_Fling then
				pcall(function()
					character:FindFirstChild("HumanoidRootPart").Size = Vector3.new(math.huge, character:FindFirstChild("HumanoidRootPart").Size.Y, math.huge)
				end)
			end
		end)
	elseif string_matches("noclip") or string_matches("noclips") then
		States.Noclips = true
		connect(runtime.Stepped, function()
			if States.Noclips then
				pcall(function()
					character:FindFirstChild("Head").CanCollide = false
					character:FindFirstChild("Torso").CanCollide = false
				end)
			end
		end)
	elseif string_matches("clip") or string_matches("clips") then
		States.Noclips = false
    elseif string_matches("unantifling") then
		States.Anti_Fling = false
	elseif string_matches("antivest") or string_matches("anticrash") then
		States.Anti_Crash = true
		while wait() do
			if States.Anti_Crash then
				for i,v in pairs(players:GetPlayers()) do
					pcall(function()
						v.Character.vest:Destroy()
					end)
				end
			end
		end
	elseif string_matches("unantivest") or string_matches("unanticrash") then
		States.Anti_Crash = false
	elseif string_matches("superpunch") or string_matches("onepunch") then
		local MeleeEvent = repstore:FindFirstChild("meleeEvent")
		local Mouse = player:GetMouse()
		local Punch = false
		local Cooldown = false
		States.SuperPunch = true

		local function Punch()
			if not States.Fast_Punch then
				Cooldown = true
				local Part = Instance.new("Part", character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if players:FindFirstChild(Touch.Parent.Name) then
						local plr = players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= player.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.9)
				Cooldown = false
				Part:Destroy()
			else
				Cooldown = true
				local Part = Instance.new("Part", character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if players:FindFirstChild(Touch.Parent.Name) then
						local plr = players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= player.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.1)
				Cooldown = false
				Part:Destroy()
			end
		end
		
        connect(Mouse.KeyDown, function(Key)
			if not Cooldown and States.SuperPunch then
				if Key:lower() == "f" then
					Punch()
				end				
			end
		end)
	elseif string_matches("normalpunch") or string_matches("oldpunch") or string_matches("nosuperpunch") or string_matches("stoponepunch") or string_matches("unonepunch") or string_matches("unsuperpunch") then
		States.SuperPunch = false
    elseif string_matches("superknife") then
		local Knife = player.Backpack:FindFirstChild("Crude Knife") or character:FindFirstChild("Crude Knife")
		if not Knife then
			item_handler:InvokeServer(workspace["Prison_ITEMS"].single["Crude Knife"].ITEMPICKUP)
		end
		wait()
		Knife = player.Backpack:FindFirstChild("Crude Knife") or character:FindFirstChild("Crude Knife")
		if Knife then
			local Cooldown = false
			local Hitting = false
			local Hitted = false
			Knife.Equipped:Connect(function()
				Knife.Activated:Connect(function()
					if not Cooldown then
						Cooldown = true
						Hitting = true
						for i,v in pairs(Knife:GetChildren()) do
							if v:IsA("Part") then
								v.Touched:Connect(function(Hit)
									if Hit and Hit.Parent ~= player and not Hitted and Hitting then
										Hitted = true
										for i = 1,25 do
											repstore.meleeEvent:FireServer(players[Hit.Parent.Name])
										end
									end
								end)
							end
						end
						wait(0.5)
						Cooldown = false
						Hitting = false
						Hitted = false
					end
				end)
			end)
		end
	elseif string_matches("unview") or string_matches("unspectate") or string_matches("stopwatch") or string_matches("unwatch") then
		Watching = nil
		camera.CameraSubject = character.Head
    elseif string_matches("antivoid") or string_matches("antifell") then
		States.Anti_Void = true
		while wait() do
			if States.Anti_Void then
				pcall(function()
					if rootpart.Position.Y < 1 then
						rootpart.CFrame = CFrame.new(888, 100, 2388)
					end
				end)
			end
		end
	elseif string_matches("unantivoid") or string_matches("unantifell") then
		States.Anti_Void = false
    elseif string_matches("bring") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Teleport(player_from_str(Arg2), rootpart.CFrame)
		end
	elseif string_matches("void") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Teleport(Player, CFrame.new(999999, 999999, 999999))
		end
	elseif string_matches("killaura") then
		States.Kill_Aura = true
	elseif string_matches("nokillaura") or string_matches("unkillaura") then
		States.Kill_Aura = false
	elseif string_matches("auto") or string_matches("autore") or string_matches("autorefresh") then
		States.Auto_Refresh = true
		while wait() do
			if States.Auto_Refresh == true then
				pcall(function()
					if humanoid.Health < 1 then
						if player.TeamColor.Name ~= "Medium stone grey" then
							if character:FindFirstChild("HumanoidRootPart") then
								local savedcf = GetPos()
								local savedcamcf = GetCamPos()
								load_character:InvokeServer()
								rootpart.CFrame = savedcf
								camera.CFrame = savedcamcf
							end
						else
							if character:FindFirstChild("HumanoidRootPart") then
								local savedcf = GetPos()
								local savedcamcf = GetCamPos()
								load_character:InvokeServer(nil, BrickColor.new("Bright orange").Name)
								rootpart.CFrame = savedcf
								camera.CFrame = savedcamcf
								team_event:FireServer("Medium stone grey")
							end
						end
					end
				end)
			end
		end
	elseif string_matches("unauto") or string_matches("auntore") or string_matches("unautorefresh") then
		States.Auto_Refresh = false
	elseif string_matches("prefix") or string_matches("newprefix") or string_matches("changeprefix") then
		local NewPrefix = Arg2
		if NewPrefix ~= nil then
			prefix = NewPrefix
			Execute.PlaceholderText = "Press "..prefix.." To Enter"
		end
	elseif string_matches("speed") or string_matches("walkspeed") or string_matches("setspeed") or string_matches("setwalkspeed") then
		local WalkSpeed = tonumber(Arg2)
		if WalkSpeed ~= nil then
			humanoid.WalkSpeed = WalkSpeed
		end
	elseif string_matches("jumppower") or string_matches("jumphigh") or string_matches("setjumppower") then
		local JumpPower = tonumber(Arg2)
		if JumpPower ~= nil then
			humanoid.JumpPower = JumpPower
		end
	elseif string_matches("hipheight") or string_matches("sethipheight") then
		local HipHeight = tonumber(Arg2)
		if HipHeight ~= nil then
			humanoid.HipHeight = HipHeight
		end
	elseif string_matches("lagserver") or string_matches("disconnect") then
		States.Lag_Server = true
		while wait() do
			if States.Lag_Server then
				coroutine.wrap(function()
					pcall(function()
						item_handler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)

						local Gun = player.Backpack["Remington 870"] or character["Remington 870"]

						local args = {
							[1] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [2] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [3] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [4] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [5] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [6] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [7] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}, [8] = {
								["RayObject"] = Ray.new(Vector3.new(), Vector3.new()), 
								["Distance"] = 0, 
								["Cframe"] = CFrame.new(), 
								["Hit"] = workspace[player.Name].Head
							}
						}

						repstore.ShootEvent:FireServer(args, Gun)
					end)
				end)()
			end
		end
	elseif string_matches("unlagserver") or string_matches("stopdisconnect") or string_matches("undisconnect") then
		States.Lag_Server = false
	elseif string_matches("gravity") or string_matches("setgravity") then
		local Gravity = tonumber(Arg2)
		if Gravity ~= nil then
			workspace.Gravity = Gravity
		end
	elseif string_matches("makecrim") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Teleport(Player, CFrame.new(-919, 96, 2138))
		end
	elseif string_matches("resetgravity") or string_matches("regravity") then
		workspace.Gravity = 196.2
	elseif string_matches("resethipheight") or string_matches("rehipheight") then
		humanoid.HipHeight = 0
	elseif string_matches("resetspeed") or string_matches("respeed") then
		humanoid.WalkSpeed = 16
	elseif string_matches("resetjumppower") or string_matches("rejumppower") then
		humanoid.JumpPower = 50
	elseif string_matches("rejoin") or string_matches("rj") then
        if #players:GetPlayers() <= 1 then
            player:Kick("\nRejoining...")
            wait()
            tpservice:Teleport(game.PlaceId, Players.LocalPlayer)
        else
            tpservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end
	elseif string_matches("nodoors") or string_matches("deletedoors") then
		if workspace:FindFirstChild("Doors") then
			workspace.Doors.Parent = lighting
		end
	elseif string_matches("doors") or string_matches("restoredoors") then
		if lighting:FindFirstChild("Doors") then
			lighting.Doors.Parent = workspace
		end
	elseif string_matches("nowalls") or string_matches("deletedoors") then
		pcall(function()
			for i,v in pairs(Walls) do
				v.Parent = lighting
			end
		end)
	elseif string_matches("walls") or string_matches("restorewalls") then
		pcall(function()
			for i,v in pairs(lighting:GetChildren()) do
				if v.Name ~= "Doors" then
					v.Parent = workspace
				end
			end
		end)
	elseif string_matches("god") or string_matches("godmode") then
		States.God_Mode = true
		while wait() do
			if States.God_Mode then
				humanoid.Name = 1
				local l = character["1"]:Clone()
				l.Parent = character
				l.Name = "Humanoid"
				character.Animate.Disabled = true
				wait()
				character.Animate.Disabled = false
				character["1"]:Destroy()
				workspace.CurrentCamera.CameraSubject = character
				wait(5)
				local savedcf = GetPos()
				local savedcamcf = GetCamPos()
				local savedteam = GetTeam()
				load_character:InvokeServer(nil, BrickColor.new(savedteam).Name)
				camera.CFrame = savedcamcf
				rootpart.CFrame = savedcf
			end
		end
	elseif string_matches("ungod") or string_matches("ungodmode") then
		States.God_Mode = false
	elseif string_matches("arrest") or string_matches("handcuffs") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			Arrest(Player, tonumber(Arg3))
		end
	elseif string_matches("arrestall") or string_matches("arrestother") or string_matches("arrestothers") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				if v.TeamColor.Name == "Really red" then
					Arrest(v, 30)
				end
			end
		end
	elseif string_matches("opengate") then
		item_handler:InvokeServer(workspace.Prison_ITEMS.buttons["Prison Gate"]["Prison Gate"])
	elseif string_matches("getpos") then
		print("Humanoid Root Part Position :")
		print(rootpart.Position)
		print("Camera CFrame :")
		print(camera.CFrame)
	elseif string_matches("saveposition") or string_matches("savepos") then
		States.SavedCFrame = GetPos()
	elseif string_matches("loadposition") or string_matches("loadpos") then
		rootpart.CFrame = States.SavedCFrame
	elseif string_matches("spamchat") then
		States.SpamChat = true
		if tonumber(Arg2) ~= nil then
			States.Spam_Wait = tonumber(Arg2)
		else
			States.Spam_Wait = 1
		end
		while wait() do
			if States.SpamChat then
				local MessagesToChat = {
					"I'm your dad",
					"I'm your mom",
					"I'm a god and I'm your dad",
					"__________",
					"OMG",
					"OML",
					"BEPP BOP BEEP BEEP BOP",
					" ",
					"I'm magic guy because i pressed W,A,S and D on my keyboard and my character can be walked wow, I'M THE REAL MAGIC GUY!",
					"I'M THE MOST PRO IN HERE",
					"I'M A PRO IN THIS SERVER ALL OF YOU ARE NOOB!",
					"LOL XD LOL XD LOL XD",
					"Read my chat",
					"Can you die while you are died?",
					"You know what, I'm a god",
					"WOW",
					"wow",
					"\\(￣︶￣*\\))"
				}

				while true do
					wait(States.Spam_Wait)
					if States.SpamChat then
						pcall(function()
							Chat(MessagesToChat[math.random(1, #MessagesToChat)])
						end)
					end
				end
			end
		end
	elseif string_matches("unspamchat") then
		States.SpamChat = false
	elseif string_matches("loopbring") then
		local Player = player_from_str(Arg2)
		if Player ~= nil then
			States.PlayerToLoopBring = Player
			States.LoopBring = true
			repeat wait()
				pcall(function()
					if States.LoopBring and players[States.PlayerToLoopBring.Name] then
						local savedcf = GetPos()
						Teleport(States.PlayerToLoopBring, GetPos())
						rootpart.CFrame = savedcf
					end
				end)
			until States.LoopBring == false
		end
	elseif string_matches("unloopbring") then
		States.LoopBring = false
		States.PlayerToLoopBring = nil
	elseif string_matches("admin") or string_matches("giveadmin") then
		local Player = player_from_str(Arg2)
		if Player ~= nil and not Admin[Player.UserId] then
			Admin[Player.UserId] = {Player = Player}
			Chat("/w "..Player.Name.." You've got admin permissions! Type "..prefix.."cmds or "..prefix.."cmd to see all commands")
		end
	elseif string_matches("unadmin") or string_matches("removeadmin") then
		local Player = player_from_str(Arg2)
		if Player ~= nil and Admin[Player.UserId] then
			Admin[Player.UserId] = nil
			Chat("/w "..Player.Name.." You have been removed admin permissions")
		end
	elseif string_matches("baseballbat") or string_matches("bat") then
		local LocalPlayer = player
		local Character = LocalPlayer.Character
		local Backpack = LocalPlayer.Backpack
		local Humanoid = Character.Humanoid
		if not Backpack:FindFirstChild("Bat") and not Backpack:FindFirstChild("Bat") then
			local BaseBallBat = Instance.new("Tool", Backpack)
			local Handle = Instance.new("Part", BaseBallBat)
			BaseBallBat.GripPos = Vector3.new(0, -1.15, 0)
			BaseBallBat.Name = "Bat"
			Handle.Name = "Handle"
			Handle.Size = Vector3.new(0.4, 5, 0.4)
			local Animation =Instance.new("Animation", BaseBallBat)
			Animation.AnimationId = "rbxassetid://218504594"
			local Track = Humanoid:LoadAnimation(Animation)
			local Cooldown = false
			local Attacked = false
			local Attacking = false
			BaseBallBat.Equipped:Connect(function()
				BaseBallBat.Activated:Connect(function()
					if not Cooldown then
						Cooldown = true
						Attacking = true
						Track:Play()
						Handle.Touched:Connect(function(Hit)
							if Hit.Parent and Hit.Parent ~= player and not Attacked and Attacking then
								Attacked = true
								for i = 1,15 do
									repstore.meleeEvent:FireServer(players[Hit.Parent.Name])
								end
							end
						end)
						wait(0.25)
						Cooldown = false
						Attacked = false
						Attacking = false
					end
				end)
			end)
		end
	elseif string_matches("test") then
		local savedcf = GetPos()
		local CrimPad = workspace["Criminals Spawn"].SpawnLocation
		local padcf = CrimPad.CFrame
		load_character:InvokeServer(nil, BrickColor.new("Really red").Name)
		rootpart.CFrame = CrimPad.CFrame
		wait()
		CrimPad.CFrame = GetPos()
		CrimPad.CanCollide = false
		CrimPad.Transparency = 1.000
		CrimPad.Anchored = true 
		pcall(function()
			for i,v in pairs(teams.Inmates:GetPlayers()) do
				if v ~= player then
					CrimPad.CFrame = v.Character.HumanoidRootPart.CFrame
				end
			end
			for i,v in pairs(teams.Guards:GetPlayers()) do
				if v ~= player then
					CrimPad.CFrame = v.Character.HumanoidRootPart.CFrame
				end
			end
		end)
		load_character:InvokeServer()
		CrimPad.Transparency = 0.000
		CrimPad.CFrame = padcf
		rootpart.CFrame = savedcf
	elseif string_matches("nexus") then
		rootpart.CFrame = CFrame.new(888, 100, 2388)
	elseif string_matches("cafe") then
		rootpart.CFrame = CFrame.new(877, 100, 2256)
	elseif string_matches("backnexus") then
		rootpart.CFrame = CFrame.new(982, 100, 2334)
	elseif string_matches("crimbase") or string_matches("criminalbase") then
		rootpart.CFrame = CFrame.new(943, 95, 2055)
	elseif string_matches("armory") then
		rootpart.CFrame = CFrame.new(789, 100, 2260)
	elseif string_matches("lunchroom") then
		rootpart.CFrame = CFrame.new(905, 100, 2226)
	elseif string_matches("gate") then
		rootpart.CFrame = CFrame.new(505, 103, 2250)
	elseif string_matches("tower") then
		rootpart.CFrame = CFrame.new(822, 131, 2588)
	elseif string_matches("gatetower") then
		rootpart.CFrame = CFrame.new(502, 126, 2306)
	elseif string_matches("sewer") then
		rootpart.CFrame = CFrame.new(916, 79, 2311)
	elseif string_matches("makecrimall") then
		local savedcf = GetPos()
		local CrimPad = workspace["Criminals Spawn"].SpawnLocation
		local padcf = CrimPad.CFrame
		load_character:InvokeServer(nil, BrickColor.new("Really red").Name)
		rootpart.CFrame = CrimPad.CFrame
		wait()
		CrimPad.CFrame = GetPos()
		CrimPad.CanCollide = false
		CrimPad.Transparency = 1.000
		CrimPad.Anchored = true
		repeat wait() 
			pcall(function()
				for i,v in pairs(teams.Inmates:GetPlayers()) do
					if v ~= player then
						Teleport(v, CrimPad.CFrame)
					end
				end
				for i,v in pairs(teams.Guards:GetPlayers()) do
					if v ~= player then
						Teleport(v, CrimPad.CFrame)
					end
				end
			end)
		until #teams.Criminals:GetPlayers() == (#players:GetPlayers()-#teams.Neutral:GetPlayers())
		load_character:InvokeServer()
		CrimPad.Transparency = 0.000
		CrimPad.CFrame = padcf
		rootpart.CFrame = savedcf
	elseif string_matches("bringall") then
		for i,v in pairs(players:GetPlayers()) do
			if v ~= player then
				Teleport(v, GetPos())
			end
		end
	elseif string_matches("notify") then
		States.Notify = true
	elseif string_matches("nonotify") then
		States.Notify = false
	elseif PrefixCommand("getprefix") then
		print("prefix : "..prefix)
	elseif string_matches("cmd") or string_matches("cmds") then
		if Background.Visible == true then
			Background.Visible = false
		else
			Background.Visible = true
		end
	end
end
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

local MAPS = {
	{ Name = "Da Hood Map", ID = "7212858074" },
	{ Name = "Amazing Da Hood School", ID = "97539347768833" },
	{ Name = "Giant MacDonalds", ID = "111318713256221" },
	{ Name = "Small Cafe", ID = "5365756549" },
	{ Name = "Area 51 Facility", ID = "18704686298" },
	{ Name = "Islamic Mosque", ID = "119285829326643" },
	{ Name = "Da Hood Bank", ID = "9711149464" },
}

local selectedMapID = MAPS[1].ID
local clickToPlace = false

local SG = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame = Instance.new("Frame", SG)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.644, 0, 0.269, 0)
Frame.Size = UDim2.new(0, 200, 0, 290)
Frame.ZIndex = 1

local dragging, dragInput, dragStart, startPos
Frame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging, dragStart, startPos = true, i.Position, Frame.Position
		i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
	end
end)
Frame.InputChanged:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dragInput = i end
end)
UIS.InputChanged:Connect(function(i)
	if i == dragInput and dragging then
		TweenService:Create(Frame, TweenInfo.new(0.25), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position - dragStart).X, startPos.Y.Scale, startPos.Y.Offset + (i.Position - dragStart).Y)}):Play()
	end
end)

local TextLabel = Instance.new("TextLabel", Frame)
TextLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel.Size = UDim2.new(0, 200, 0, 28)
TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
TextLabel.Text = "f3x gui"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 18
TextLabel.ZIndex = 1

local subLabel = Instance.new("TextLabel", TextLabel)
subLabel.BackgroundTransparency = 1
subLabel.Position = UDim2.new(0, 4, 0, 0)
subLabel.Size = UDim2.new(0, 100, 0, 10)
subLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
subLabel.Text = "by criminalsafety"
subLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
subLabel.TextSize = 8
subLabel.TextXAlignment = Enum.TextXAlignment.Left
subLabel.ZIndex = 2

local function makeBtn(name, text, pos, size, scaled)
	local b = Instance.new("TextButton", TextLabel)
	b.Name = name
	b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	b.Position = pos
	b.Size = size
	b.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	b.Text = text
	b.TextColor3 = Color3.fromRGB(220, 220, 220)
	b.TextSize = scaled and 0 or 16
	b.TextScaled = scaled or false
	b.ZIndex = 1
	return b
end

local TextButton = makeBtn("TextButton", "Skybox", UDim2.new(0.52, 0, 1.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_2 = makeBtn("TextButton_2", "Decal", UDim2.new(0.06, 0, 1.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_3 = makeBtn("TextButton_3", "Particle", UDim2.new(0.06, 0, 2.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_4 = makeBtn("TextButton_4", "Hint", UDim2.new(0.52, 0, 2.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_5 = makeBtn("TextButton_5", "Message", UDim2.new(0.06, 0, 3.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_6 = makeBtn("TextButton_6", "UnAnchor", UDim2.new(0.52, 0, 3.25, 0), UDim2.new(0, 88, 0, 24), true)
local TextButton_7 = makeBtn("TextButton_7", "Disco", UDim2.new(0.06, 0, 4.25, 0), UDim2.new(0, 88, 0, 24))
local TextButton_8 = makeBtn("TextButton_8", "Fire All", UDim2.new(0.52, 0, 4.25, 0), UDim2.new(0, 88, 0, 24), true)
local TextButton_9 = makeBtn("TextButton_9", "Avatar All", UDim2.new(0.06, 0, 5.25, 0), UDim2.new(0, 88, 0, 24), true)
local TextButton_10 = makeBtn("TextButton_10", "Reset", UDim2.new(0.52, 0, 5.25, 0), UDim2.new(0, 88, 0, 24), true)

local TextBox = Instance.new("TextBox", TextLabel)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.Position = UDim2.new(0.06, 0, 6.35, 0)
TextBox.Size = UDim2.new(0, 120, 0, 24)
TextBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
TextBox.PlaceholderText = "Text..."
TextBox.Text = "criminalsafety"
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 13
TextBox.ZIndex = 1

local BillboardBtn = makeBtn("BillboardBtn", "Billboard", UDim2.new(0.68, 0, 6.35, 0), UDim2.new(0, 56, 0, 24), true)
local MapToggleBtn = makeBtn("MapToggleBtn", "Map Loader", UDim2.new(0.06, 0, 7.45, 0), UDim2.new(0, 180, 0, 24), true)

local ReBtn = makeBtn("ReBtn", "re", UDim2.new(0.48, 0, 0.15, 0), UDim2.new(0, 26, 0, 18), true)
local R6Btn = makeBtn("R6Btn", "r6", UDim2.new(0.62, 0, 0.15, 0), UDim2.new(0, 26, 0, 18), true)
local TextButton_12 = makeBtn("TextButton_12", "F3X", UDim2.new(0.76, 0, 0.15, 0), UDim2.new(0, 42, 0, 18), true)

-- MAP LOADER FRAME
local MapFrame = Instance.new("Frame", SG)
MapFrame.Size = UDim2.new(0, 200, 0, 160)
MapFrame.Position = UDim2.new(0.644, -210, 0.269, 0)
MapFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MapFrame.BorderSizePixel = 0
MapFrame.Visible = false
Instance.new("UIStroke", MapFrame).Color = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", MapFrame).CornerRadius = UDim.new(0, 4)

local MapTitle = Instance.new("TextLabel", MapFrame)
MapTitle.Size = UDim2.new(1, 0, 0, 26)
MapTitle.BackgroundTransparency = 1
MapTitle.Text = "Map Loader"
MapTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
MapTitle.Font = Enum.Font.GothamMedium
MapTitle.TextSize = 12

local DropBtn = Instance.new("TextButton", MapFrame)
DropBtn.Size = UDim2.new(1, -16, 0, 24)
DropBtn.Position = UDim2.new(0, 8, 0, 30)
DropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DropBtn.Text = MAPS[1].Name
DropBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
DropBtn.Font = Enum.Font.Gotham
DropBtn.TextSize = 11
Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 3)

local DropList = Instance.new("ScrollingFrame", MapFrame)
DropList.Size = UDim2.new(1, -16, 0, 0)
DropList.Position = UDim2.new(0, 8, 0, 56)
DropList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DropList.BorderSizePixel = 0
DropList.ClipsDescendants = true
DropList.ScrollBarThickness = 2
Instance.new("UIStroke", DropList).Color = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", DropList).CornerRadius = UDim.new(0, 3)

local UIList = Instance.new("UIListLayout", DropList)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

for i, mapData in ipairs(MAPS) do
	local opt = Instance.new("TextButton", DropList)
	opt.Size = UDim2.new(1, 0, 0, 24)
	opt.BackgroundTransparency = 1
	opt.Text = mapData.Name
	opt.TextColor3 = Color3.fromRGB(180, 180, 180)
	opt.Font = Enum.Font.Gotham
	opt.TextSize = 11
	opt.LayoutOrder = i
	
	opt.MouseButton1Click:Connect(function()
		selectedMapID = mapData.ID
		DropBtn.Text = mapData.Name
		TweenService:Create(DropList, TweenInfo.new(0.15), {Size = UDim2.new(1, -16, 0, 0)}):Play()
	end)
end

local isDropOpen = false
local ToggleBtn = Instance.new("TextButton", MapFrame)
local Status = Instance.new("TextLabel", MapFrame)
local SpawnBtn = Instance.new("TextButton", MapFrame)

local function updateMapLayout()
	local dropOffset = isDropOpen and 90 or 0
	DropList.Position = UDim2.new(0, 8, 0, 56)
	ToggleBtn.Position = UDim2.new(0, 8, 0, 58 + dropOffset)
	Status.Position = UDim2.new(0, 0, 0, 87 + dropOffset)
	SpawnBtn.Position = UDim2.new(0, 8, 0, 108 + dropOffset)
	MapFrame.Size = UDim2.new(0, 200, 0, 145 + dropOffset)
end

DropBtn.MouseButton1Click:Connect(function()
	isDropOpen = not isDropOpen
	local targetSize = isDropOpen and UDim2.new(1, -16, 0, 90) or UDim2.new(1, -16, 0, 0)
	TweenService:Create(DropList, TweenInfo.new(0.15), {Size = targetSize}):Play()
	updateMapLayout()
end)

ToggleBtn.Size = UDim2.new(1, -16, 0, 24)
ToggleBtn.Position = UDim2.new(0, 8, 0, 58)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleBtn.Text = "Click to Place: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.TextSize = 11
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 3)

ToggleBtn.MouseButton1Click:Connect(function()
	clickToPlace = not clickToPlace
	if clickToPlace then
		ToggleBtn.Text = "Click to Place: ON"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 90, 60)
		ToggleBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
	else
		ToggleBtn.Text = "Click to Place: OFF"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		ToggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
	end
end)

Status.Size = UDim2.new(1, 0, 0, 18)
Status.Position = UDim2.new(0, 0, 0, 87)
Status.BackgroundTransparency = 1
Status.Text = "Ready"
Status.TextColor3 = Color3.fromRGB(140, 140, 140)
Status.Font = Enum.Font.Gotham
Status.TextSize = 10

SpawnBtn.Size = UDim2.new(1, -16, 0, 28)
SpawnBtn.Position = UDim2.new(0, 8, 0, 108)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
SpawnBtn.Text = "Load Map"
SpawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnBtn.Font = Enum.Font.GothamMedium
SpawnBtn.TextSize = 11
Instance.new("UICorner", SpawnBtn).CornerRadius = UDim.new(0, 3)

MapToggleBtn.MouseButton1Click:Connect(function()
	MapFrame.Visible = not MapFrame.Visible
end)

local function getRemote()
	for _, v in ipairs(player:GetDescendants()) do if v.Name == "SyncAPI" then return v.Parent.SyncAPI.ServerEndpoint end end
	for _, v in ipairs(RS:GetDescendants()) do if v.Name == "SyncAPI" then return v.Parent.SyncAPI.ServerEndpoint end end
	for _, v in ipairs(workspace:GetDescendants()) do if v.Name == "SyncAPI" then return v.Parent.SyncAPI.ServerEndpoint end end
end

local function inv(args) local r = getRemote() if r then r:InvokeServer(unpack(args)) end end

local function MapPartType(part)
	if part:IsA("WedgePart") then return "Wedge" end
	if part:IsA("CornerWedgePart") then return "Corner" end
	if part:IsA("TrussPart") then return "Truss" end
	if part:IsA("Part") then
		if part.Shape == Enum.PartType.Ball then return "Sphere" end
		if part.Shape == Enum.PartType.Cylinder then return "Cylinder" end
	end
	return "Normal"
end

SpawnBtn.MouseButton1Click:Connect(function()
	local endpoint = getRemote()
	if not endpoint then
		Status.Text = "F3X tool required"
		Status.TextColor3 = Color3.fromRGB(220, 80, 80)
		return
	end

	Status.Text = "Cleaning workspace..."
	Status.TextColor3 = Color3.fromRGB(220, 160, 60)

	task.spawn(function()
		local partsToRemove = {}
		for _, v in ipairs(workspace:GetChildren()) do
			local nameLower = v.Name:lower()
			local isProtected = nameLower:find("base") or nameLower:find("plate") or nameLower:find("floor") or nameLower:find("ground") or nameLower:find("spawn")
			if v:IsA("BasePart") and ((v.Size.X > 80 and v.Size.Z > 80) or v.Size.Y < 3) then
				isProtected = true
			end
			if v ~= workspace.Terrain and not v:IsA("Camera") and not Players:GetPlayerFromCharacter(v) and not isProtected and not v:IsA("SpawnLocation") then
				table.insert(partsToRemove, v)
			end
		end

		if #partsToRemove > 0 then
			for i = 1, #partsToRemove, 50 do
				local chunk = {}
				for j = i, math.min(i + 49, #partsToRemove) do
					table.insert(chunk, partsToRemove[j])
				end
				pcall(function()
					endpoint:InvokeServer("SetLocked", chunk, false)
					endpoint:InvokeServer("Remove", chunk)
				end)
				for _, v in ipairs(chunk) do pcall(function() v:Destroy() end) end
			end
		end

		Status.Text = "Loading map assets..."

		local success, raw = pcall(function() return game:GetObjects("rbxassetid://" .. selectedMapID) end)
		if not success or not raw or #raw == 0 then
			Status.Text = "Failed to load asset"
			Status.TextColor3 = Color3.fromRGB(220, 80, 80)
			return
		end

		local rootObject = raw[1]
		local partsToImport = {}
		if rootObject:IsA("BasePart") then table.insert(partsToImport, rootObject) end
		for _, desc in ipairs(rootObject:GetDescendants()) do
			if desc:IsA("BasePart") then table.insert(partsToImport, desc) end
		end

		if #partsToImport == 0 then
			Status.Text = "No parts found"
			Status.TextColor3 = Color3.fromRGB(220, 80, 80)
			rootObject:Destroy()
			return
		end

		local targetPos = nil

		if clickToPlace then
			Status.Text = "Click anywhere to place"
			Status.TextColor3 = Color3.fromRGB(100, 180, 255)

			local clickedEvent = Instance.new("BindableEvent")
			local connection
			connection = UIS.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					task.wait(0.05)
					local mousePos = UIS:GetMouseLocation()
					local ray = Camera:ScreenPointToRay(mousePos.X, mousePos.Y)
					local raycastParams = RaycastParams.new()
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					if player.Character then
						raycastParams.FilterDescendantsInstances = {player.Character}
					end
					local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
					targetPos = result and result.Position or (ray.Origin + ray.Direction * 50)
					connection:Disconnect()
					clickedEvent:Fire()
				end
			end)
			clickedEvent.Event:Wait()
			clickedEvent:Destroy()
		else
			local char = player.Character
			local rootPart = char and char:FindFirstChild("HumanoidRootPart")
			if rootPart then
				local raycastParams = RaycastParams.new()
				raycastParams.FilterType = Enum.RaycastFilterType.Exclude
				raycastParams.FilterDescendantsInstances = {char}
				local result = workspace:Raycast(rootPart.Position, Vector3.new(0, -100, 0), raycastParams)
				targetPos = result and result.Position or (rootPart.Position - Vector3.new(0, 3, 0))
			else
				targetPos = Vector3.new(0, 0, 0)
			end
		end

		local pivot = rootObject:IsA("Model") and rootObject:GetPivot() or (rootObject:IsA("BasePart") and rootObject.CFrame or partsToImport[1].CFrame)
		local lowestY = math.huge
		for _, part in ipairs(partsToImport) do
			local relCf = pivot:ToObjectSpace(part.CFrame)
			local bottomY = relCf.Position.Y - (part.Size.Y / 2)
			if bottomY < lowestY then lowestY = bottomY end
		end

		local adjustedSpawnCf = CFrame.new(targetPos.X, targetPos.Y - lowestY, targetPos.Z) * (pivot - pivot.Position)

		Status.Text = "Spawning parts..."
		Status.TextColor3 = Color3.fromRGB(100, 200, 100)

		for i = 1, #partsToImport, 50 do
			local bindable = Instance.new("BindableEvent")
			local running = 0

			for idx = i, math.min(i + 49, #partsToImport) do
				running = running + 1
				task.spawn(function()
					local part = partsToImport[idx]
					local targetCFrame = adjustedSpawnCf * pivot:ToObjectSpace(part.CFrame)
					local ok, createdPart = pcall(function()
						return endpoint:InvokeServer("CreatePart", MapPartType(part), targetCFrame, workspace)
					end)

					if ok and createdPart then
						pcall(function()
							endpoint:InvokeServer("SyncResize", {{Part = createdPart, Size = part.Size, CFrame = targetCFrame}})
							endpoint:InvokeServer("SyncColor", {{Part = createdPart, Color = part.Color, UnionColoring = false}})
							endpoint:InvokeServer("SyncMaterial", {{Part = createdPart, Material = part.Material}})
							endpoint:InvokeServer("SyncAnchor", {{Part = createdPart, Anchored = part.Anchored}})
							endpoint:InvokeServer("SyncTransparency", {{Part = createdPart, Transparency = part.Transparency}})

							local mesh = part:FindFirstChildOfClass("SpecialMesh")
							if mesh then
								pcall(function()
									endpoint:InvokeServer("SyncMesh", {{
										Part = createdPart,
										MeshType = mesh.MeshType,
										MeshId = mesh.MeshId,
										TextureId = mesh.TextureId,
										Scale = mesh.Scale,
										Offset = mesh.Offset
									}})
								end)
							end

							for _, child in ipairs(part:GetChildren()) do
								if child:IsA("Decal") or child:IsA("Texture") or child:IsA("PointLight") or child:IsA("SurfaceLight") or child:IsA("SpotLight") then
									pcall(function() child:Clone().Parent = createdPart end)
								end
							end
						end)
					end
					running = running - 1
					if running == 0 then bindable:Fire() end
				end)
			end

			if running > 0 then bindable.Event:Wait() end
			bindable:Destroy()
		end

		Status.Text = "Completed"
		Status.TextColor3 = Color3.fromRGB(100, 200, 100)
		rootObject:Destroy()
	end)
end)

TextButton.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	
	for _, v in ipairs(workspace:GetDescendants()) do
		if v.Name == "Skybox" or (v:IsA("BasePart") and v:FindFirstChildWhichIsA("SpecialMesh") and v:FindFirstChildWhichIsA("SpecialMesh").MeshId == "rbxassetid://111891702759441") then
			inv({"Remove", {v}})
		end
	end
	
	local p = char.HumanoidRootPart.Position + Vector3.new(0, 20, 0)
	inv({"CreatePart", "Normal", CFrame.new(p), workspace})
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and (v.Position - p).Magnitude < 5 then
			inv({"SetName", {v}, "Skybox"})
			inv({"SyncAnchor", {{Part = v, Anchored = true}}})
			inv({"SyncCollision", {{Part = v, CanCollide = false}}})
			inv({"CreateMeshes", {{Part = v}}})
			inv({"SyncMesh", {{Part = v, MeshId = "rbxassetid://111891702759441", TextureId = "rbxassetid://4537616739", Scale = Vector3.new(7200, 7200, 7200)}}})
			inv({"SetLocked", {v}, true})
		end
	end
	if Lighting:FindFirstChild("Sky") then Lighting.Sky:Destroy() end
end)

TextButton_2.MouseButton1Click:Connect(function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Decal") or v:IsA("Texture") then
			inv({"Remove", {v}})
		end
	end

	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			task.spawn(function()
				inv({"SetLocked", {v}, false})
				for _, f in ipairs(Enum.NormalId:GetEnumItems()) do
					inv({"CreateTextures", {{Part = v, Face = f, TextureType = "Decal"}}})
					inv({"SyncTexture", {{Part = v, Face = f, TextureType = "Decal", Texture = "rbxassetid://4537616739"}}})
				end
			end)
		end
	end
end)

TextButton_3.MouseButton1Click:Connect(function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		if not char.HumanoidRootPart:FindFirstChildOfClass("Sparkles") then
			Instance.new("Sparkles", char.HumanoidRootPart)
		end
	end
end)

TextButton_4.MouseButton1Click:Connect(function()
	local h = Instance.new("Hint", workspace) h.Text = "hello, I'm criminalsafety" task.wait(3) h:Destroy()
end)

TextButton_5.MouseButton1Click:Connect(function()
	local m = Instance.new("Message", workspace) m.Text = "hello, I'm criminalsafety" task.wait(3) m:Destroy()
end)

TextButton_6.MouseButton1Click:Connect(function()
	for _, v in ipairs(workspace:GetDescendants()) do if v:IsA("BasePart") then inv({"SyncAnchor", {{Part = v, Anchored = false}}}) end end
end)

TextButton_7.MouseButton1Click:Connect(function()
	task.spawn(function()
		while true do
			local c = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
			for _, v in ipairs(workspace:GetDescendants()) do if v:IsA("BasePart") then inv({"SyncColor", {{Part = v, Color = c, UnionColoring = false}}}) end end
			task.wait(0.5)
		end
	end)
end)

TextButton_8.MouseButton1Click:Connect(function()
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and not v:FindFirstChildOfClass("Fire") then
			local f = Instance.new("Fire", v)
			f.Size = 25
			f.Heat = 15
		end
	end
end)

TextButton_9.MouseButton1Click:Connect(function()
	for _, p in ipairs(Players:GetPlayers()) do
		local char = p.Character
		if char then
			task.spawn(function()
				for _, child in ipairs(char:GetDescendants()) do
					if child:IsA("Clothing") or child:IsA("Accessory") or child:IsA("ShirtGraphic") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("CharacterMesh") or child:IsA("BodyHandleAccessory") then
						pcall(function()
							inv({"SetLocked", {child}, false})
							inv({"Remove", {child}})
						end)
						pcall(function() child:Destroy() end)
					end
				end
				
				local colorMap = {
					["Head"] = BrickColor.new("Bright yellow").Color,
					["Torso"] = BrickColor.new("Bright green").Color,
					["Left Arm"] = BrickColor.new("Bright yellow").Color,
					["Right Arm"] = BrickColor.new("Bright yellow").Color,
					["Left Leg"] = BrickColor.new("Medium blue").Color,
					["Right Leg"] = BrickColor.new("Medium blue").Color,
					["UpperTorso"] = BrickColor.new("Bright green").Color,
					["LowerTorso"] = BrickColor.new("Bright green").Color,
					["LeftUpperArm"] = BrickColor.new("Bright yellow").Color,
					["LeftLowerArm"] = BrickColor.new("Bright yellow").Color,
					["LeftHand"] = BrickColor.new("Bright yellow").Color,
					["RightUpperArm"] = BrickColor.new("Bright yellow").Color,
					["RightLowerArm"] = BrickColor.new("Bright yellow").Color,
					["RightHand"] = BrickColor.new("Bright yellow").Color,
					["LeftUpperLeg"] = BrickColor.new("Medium blue").Color,
					["LeftLowerLeg"] = BrickColor.new("Medium blue").Color,
					["LeftFoot"] = BrickColor.new("Medium blue").Color,
					["RightUpperLeg"] = BrickColor.new("Medium blue").Color,
					["RightLowerLeg"] = BrickColor.new("Medium blue").Color,
					["RightFoot"] = BrickColor.new("Medium blue").Color,
				}
				
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") and colorMap[part.Name] then
						pcall(function()
							inv({"SetLocked", {part}, false})
							inv({"SyncColor", {{Part = part, Color = colorMap[part.Name], UnionColoring = false}}})
						end)
					end
				end
			end)
		end
	end
end)

TextButton_10.MouseButton1Click:Connect(function()
	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("PostEffect") then
			v:Destroy()
		end
	end
	if not Lighting:FindFirstChildOfClass("Sky") then
		Instance.new("Sky", Lighting)
	end
	
	for _, v in ipairs(workspace:GetChildren()) do
		if v ~= workspace.Terrain and not v:IsA("Camera") and not Players:GetPlayerFromCharacter(v) then
			if v:IsA("BasePart") then
				local isBase = (v.Name:lower():find("base") or v.Size.X > 200 or v.Size.Z > 200)
				if not isBase then
					pcall(function() inv({"Remove", {v}}) end)
					v:Destroy()
				else
					for _, child in ipairs(v:GetDescendants()) do
						if child:IsA("Decal") or child:IsA("Texture") or child:IsA("Fire") or child:IsA("Smoke") or child:IsA("Sparkles") or child:IsA("ParticleEmitter") or child:IsA("SpecialMesh") then
							pcall(function() 
								inv({"SetLocked", {child}, false})
								inv({"Remove", {child}}) 
							end)
							child:Destroy()
						end
					end
				end
			else
				v:Destroy()
			end
		end
	end
	
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Character then
			for _, v in ipairs(p.Character:GetDescendants()) do
				if v:IsA("Fire") or v:IsA("Decal") or v:IsA("Texture") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") then
					pcall(function()
						inv({"SetLocked", {v}, false})
						inv({"Remove", {v}})
						v:Destroy()
					end)
				end
			end
		end
	end

	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Fire") or v:IsA("Decal") or v:IsA("Texture") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") or v.Name == "Skybox" then
			pcall(function() 
				inv({"SetLocked", {v}, false})
				inv({"Remove", {v}})
				v:Destroy() 
			end)
		end
	end
end)

BillboardBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char or not char:FindFirstChild("Head") then return end
	local text = TextBox.Text ~= "" and TextBox.Text or "criminalsafety"
	
	for _, v in ipairs(char.Head:GetChildren()) do
		if v.Name == "CriminalSafetyBillboard" then
			v:Destroy()
		end
	end
	
	local bg = Instance.new("BillboardGui", char.Head)
	bg.Name = "CriminalSafetyBillboard"
	bg.Size = UDim2.new(0, 200, 0, 50)
	bg.StudsOffset = Vector3.new(0, 2.5, 0)
	bg.AlwaysOnTop = true
	
	local tl = Instance.new("TextLabel", bg)
	tl.Size = UDim2.new(1, 0, 1, 0)
	tl.BackgroundTransparency = 1
	tl.Text = text
	tl.TextColor3 = Color3.fromRGB(255, 255, 255)
	tl.TextSize = 22
	tl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold)
end)

ReBtn.MouseButton1Click:Connect(function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
		local cf = char.HumanoidRootPart.CFrame
		char.Humanoid.Health = 0
		task.spawn(function()
			local newChar = player.CharacterAdded:Wait()
			local root = newChar:WaitForChild("HumanoidRootPart", 3)
			if root then
				task.wait(0.2)
				root.CFrame = cf
			end
		end)
	end
end)

R6Btn.MouseButton1Click:Connect(function()
	pcall(function()
		local desc = Players:GetHumanoidDescriptionFromUserId(player.UserId)
		desc.Head = 0
		desc.LeftArm = 0
		desc.RightArm = 0
		desc.LeftLeg = 0
		desc.RightLeg = 0
		desc.Torso = 0
		player.CharacterAppearanceId = player.UserId
		player:LoadCharacter()
	end)
end)

TextButton_12.MouseButton1Click:Connect(function()
	local t = RS:FindFirstChild("SyncTools") or workspace:FindFirstChild("SyncTools")
	if t then t:Clone().Parent = player.Backpack end
end)
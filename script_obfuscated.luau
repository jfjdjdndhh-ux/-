local scriptCode = [[
local TS, HS, Players, WS, RS = game:GetService("TeleportService"), game:GetService("HttpService"), game:GetService("Players"), game:GetService("Workspace"), game:GetService("RunService")
local lp, placeId, SEARCH_TIME = Players.LocalPlayer, game.PlaceId, 5
local queue = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
local blacklisted = {"rocket", "spin", "blade", "chop", "spring", "bomb", "smoke", "spike"}

local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name, gui.ResetOnSpawn = "FLGui", false

local frame = Instance.new("Frame", gui)
frame.Size, frame.Position, frame.BackgroundColor3, frame.BackgroundTransparency, frame.BorderSizePixel = UDim2.new(0, 270, 0, 48), UDim2.new(1, -285, 1, -60), Color3.new(0.04, 0.04, 0.04), 0.2, 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", frame)
stroke.Color, stroke.Thickness = Color3.new(1, 1, 1), 1.5

local label = Instance.new("TextLabel", frame)
label.Size, label.Position, label.BackgroundTransparency, label.TextColor3, label.TextSize, label.Font, label.TextXAlignment = UDim2.new(1, -20, 1, 0), UDim2.new(0, 10, 0, 0), 1, Color3.new(1, 1, 1), 13, Enum.Font.GothamBold, Enum.TextXAlignment.Left
label.Text = "Status: Initializing"

local function ui(txt, col)
    label.Text = txt
    if col then label.TextColor3, stroke.Color = col, col end
end

local function showPrompt(onHop, onStay)
    local pGui = Instance.new("ScreenGui", lp.PlayerGui)
    local f = Instance.new("Frame", pGui)
    f.Size, f.Position, f.BackgroundColor3, f.BorderSizePixel = UDim2.new(0, 380, 0, 140), UDim2.new(0.5, -190, 0.3, -70), Color3.new(0.06, 0.06, 0.06), 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", f).Color = Color3.new(1, 1, 1)

    local t = Instance.new("TextLabel", f)
    t.Size, t.Position, t.BackgroundTransparency, t.TextColor3, t.TextSize, t.Font, t.TextWrapped, t.Text = UDim2.new(1, -20, 0.5, 0), UDim2.new(0, 10, 0, 10), 1, Color3.new(1, 1, 1), 14, Enum.Font.GothamBold, true, "Target collected or gone.\nSelect action:"

    local function btn(pos, text, cb, bg, tc)
        local b = Instance.new("TextButton", f)
        b.Size, b.Position, b.BackgroundColor3, b.TextColor3, b.TextSize, b.Font, b.Text = UDim2.new(0.46, 0, 0.3, 0), pos, bg, tc, 13, Enum.Font.GothamBold, text
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        if bg == Color3.new(0.15, 0.15, 0.15) then Instance.new("UIStroke", b).Color = Color3.new(1, 1, 1) end
        b.MouseButton1Click:Connect(function() pGui:Destroy() cb() end)
    end
    btn(UDim2.new(0.04, 0, 0.6, 0), "Change Server", onHop, Color3.new(0.15, 0.15, 0.15), Color3.new(1, 1, 1))
    btn(UDim2.new(0.52, 0, 0.6, 0), "Stay Here", onStay, Color3.new(0.8, 0.8, 0.8), Color3.new(0, 0, 0))
end

local function getServers()
    local cur, servers = nil, {}
    for i = 1, 5 do
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100" .. (cur and "&cursor="..cur or "")
        local suc, res = pcall(function() return game:HttpGet(url) end)
        if suc then
            local ds, dec = pcall(function() return HS:JSONDecode(res) end)
            if ds and dec and dec.data then
                for _, s in ipairs(dec.data) do
                    if s.playing < (s.maxPlayers - 2) and s.id ~= game.JobId then table.insert(servers, s.id) end
                end
                cur = dec.nextPageCursor
                if not cur then break end
            end
        end
        task.wait(0.3)
    end
    return #servers > 0 and servers[math.random(1, #servers)] or nil
end

local function jump()
    ui("Finding server...", Color3.new(0.8, 0.8, 0.8))
    local id = getServers()
    if id then
        ui("Teleporting...", Color3.new(1, 1, 1))
        if queue then
            pcall(function()
                queue(scriptCode)
            end)
        end
        pcall(function() TS:TeleportToPlaceInstance(placeId, id, lp) end)
    else
        ui("Retrying...", Color3.new(0.6, 0.6, 0.6))
        task.wait(3)
        jump()
    end
end

local function getName(m)
    if m.Name == "Fruit" or m.Name == "Fruit " or m.Name == "" then
        for _, d in ipairs(m:GetDescendants()) do
            if d:IsA("ProximityPrompt") and d.ObjectText ~= "" then return d.ObjectText
            elseif d:IsA("Tool") then return d.Name end
        end
    end
    return m.Name
end

local function isTrash(name)
    for _, t in ipairs(blacklisted) do
        if string.find(name:lower(), t) then return true end
    end
    return false
end

local found, attach = false, nil

local function scan()
    found = false
    ui("Scanning world...", Color3.new(1, 1, 1))
    for _, obj in ipairs(WS:GetChildren()) do
        if obj.Name == "Fruit" or obj.Name == "Fruit " or string.find(obj.Name:lower(), "fruit") then
            local rName = getName(obj)
            if isTrash(rName) then
                ui("Trash skipped", Color3.new(0.4, 0.4, 0.4))
                task.wait(0.5)
                jump()
                return
            end
            attach(obj, rName)
            break
        end
    end
end

function attach(model, name)
    if model:FindFirstChild("Marker") then return end
    local h = model:FindFirstChild("Handle") or model:FindFirstChildWhichIsA("BasePart")
    if not h then return end
    found = true
    ui("Found: " .. name, Color3.new(1, 1, 1))

    local hl = Instance.new("Highlight", model)
    hl.Name, hl.FillColor, hl.OutlineColor, hl.FillTransparency, hl.DepthMode = "Marker", Color3.new(1, 1, 1), Color3.new(0, 0, 0), 0.4, Enum.HighlightDepthMode.AlwaysOnTop

    local att0, att1 = Instance.new("Attachment", h), Instance.new("Attachment", h)
    att1.Position = Vector3.new(0, 1000, 0)
    local beam = Instance.new("Beam", h)
    beam.Attachment0, beam.Attachment1, beam.Color, beam.Width0, beam.Width1 = att0, att1, ColorSequence.new(Color3.new(1, 1, 1)), 3, 3

    local bb = Instance.new("BillboardGui", model)
    bb.AlwaysOnTop, bb.Size, bb.StudsOffset, bb.Adornee = true, UDim2.new(0, 300, 0, 70), Vector3.new(0, 5, 0), h

    local txt = Instance.new("TextLabel", bb)
    txt.Size, txt.BackgroundTransparency, txt.TextColor3, txt.TextStrokeTransparency, txt.TextScaled, txt.Font = UDim2.new(1, 0, 1, 0), 1, Color3.new(1, 1, 1), 0, true, Enum.Font.GothamBold

    local conn
    conn = RS.RenderStepped:Connect(function()
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") and model.Parent then
            txt.Text = string.format("%s\n[%d m]", name, math.floor((char.HumanoidRootPart.Position - h.Position).Magnitude))
        else
            if conn then conn:Disconnect() end
        end
    end)

    model.AncestryChanged:Connect(function(_, p)
        if not p then
            if conn then conn:Disconnect() end
            ui("Target gone", Color3.new(0.6, 0.6, 0.6))
            showChoicePrompt(jump, scan)
        end
    end)
end

scan()

if not found then
    for i = SEARCH_TIME, 1, -1 do
        if found then break end
        ui(string.format("Scanning: %d s", i), Color3.new(0.8, 0.8, 0.8))
        task.wait(1)
    end
    if not found then jump() end
end
]]

loadstring(scriptCode)()

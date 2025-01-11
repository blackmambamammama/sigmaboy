-- Place this script in StarterPlayerScripts
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local highlightingEnabled = false
local displayEnabled = true
local outlines = {}
local billboards = {}

local function updateOutlines()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = outlines[player] or Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.OutlineTransparency = 0
            highlight.Parent = game.Workspace
            outlines[player] = highlight

            if displayEnabled then
                local billboard = billboards[player] or Instance.new("BillboardGui")
                billboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
                billboard.Size = UDim2.new(0, 150, 0, 40)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true

                local textLabel = billboard:FindFirstChild("UsernameLabel") or Instance.new("TextLabel")
                textLabel.Name = "UsernameLabel"
                textLabel.Text = string.format("%s\n%.1f studs", player.Name, (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.TextStrokeTransparency = 0.5
                textLabel.TextScaled = true
                textLabel.Parent = billboard

                billboard.Parent = game.Workspace
                billboards[player] = billboard
            else
                if billboards[player] then
                    billboards[player]:Destroy()
                    billboards[player] = nil
                end
            end
        end
    end

    for player, highlight in pairs(outlines) do
        if not Players:FindFirstChild(player.Name) then
            highlight:Destroy()
            outlines[player] = nil
        end
    end

    for player, billboard in pairs(billboards) do
        if not Players:FindFirstChild(player.Name) then
            billboard:Destroy()
            billboards[player] = nil
        end
    end
end

local connection
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F2 then
        highlightingEnabled = not highlightingEnabled

        if highlightingEnabled then
            connection = RunService.RenderStepped:Connect(updateOutlines)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end

            for _, highlight in pairs(outlines) do
                highlight:Destroy()
            end
            outlines = {}

            for _, billboard in pairs(billboards) do
                billboard:Destroy()
            end
            billboards = {}
        end
    end

    if input.KeyCode == Enum.KeyCode.F3 then
        displayEnabled = not displayEnabled

        if not displayEnabled then
            for _, billboard in pairs(billboards) do
                billboard:Destroy()
            end
            billboards = {}
        end
    end
end)

-- Aimlock Variables
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera
local activationRadius = 200
local maxDistance = 10000
local aimlockActivated = false
local holdingRightClick = false

local function isHeadVisible(targetHead)
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("Head") then return false end

    local ray = Ray.new(character.Head.Position, (targetHead.Position - character.Head.Position).Unit * maxDistance)
    local hitPart, _ = workspace:FindPartOnRay(ray, character)
    return hitPart and hitPart:IsDescendantOf(targetHead.Parent)
end

local function getClosestVisibleToCursor()
    local closestTarget = nil
    local closestDistance = math.huge

    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= localPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
            local head = otherPlayer.Character.Head
            local headScreenPosition, onScreen = camera:WorldToScreenPoint(head.Position)

            if onScreen and isHeadVisible(head) then
                local cursorPosition = Vector2.new(mouse.X, mouse.Y)
                local distanceToCursor = (Vector2.new(headScreenPosition.X, headScreenPosition.Y) - cursorPosition).Magnitude
                local distanceToPlayer = (localPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude

                if distanceToCursor < activationRadius and distanceToPlayer < maxDistance and distanceToCursor < closestDistance then
                    closestDistance = distanceToCursor
                    closestTarget = head
                end
            end
        end
    end

    return closestTarget
end

local function getPredictionOffset(targetHead, distance)
    local character = targetHead.Parent
    if not character then return Vector3.zero end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return Vector3.zero end

    local velocity = humanoidRootPart.Velocity
    local predictionFactor = math.clamp(distance / 1000, 0.05, 0.8) -- Adjust the divisor to scale subtlety (600 in this case)

    -- Subtle horizontal and vertical adjustments
    local horizontalOffset = velocity * predictionFactor * Vector3.new(0.2, 0, 0.2)
    local verticalOffset = Vector3.new(0, math.clamp(velocity.Y * predictionFactor * 0.05, -3, 3), 0) -- Reduced vertical influence

    return horizontalOffset + verticalOffset
end

local function assistFlick(targetHead)
    if targetHead and targetHead.Parent then
        local character = localPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end

        local humanoidRootPart = character.HumanoidRootPart
        local distance = (humanoidRootPart.Position - targetHead.Position).Magnitude
        local predictionOffset = getPredictionOffset(targetHead, distance)

        local targetPosition = targetHead.Position + Vector3.new(0, -0.5, 0) + predictionOffset
        local cameraDirection = (targetPosition - camera.CFrame.Position).Unit
        local flickStrength = 0.9

        camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, camera.CFrame.Position + cameraDirection), flickStrength)
    end
end

UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end

    if input.KeyCode == Enum.KeyCode.F1 then
        aimlockActivated = not aimlockActivated
        print("Aimlock Activated:", aimlockActivated)

        if not aimlockActivated then
            holdingRightClick = false
        end
    elseif aimlockActivated and input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingRightClick = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingRightClick = false
    end
end)

RunService.RenderStepped:Connect(function()
    if aimlockActivated and holdingRightClick then
        local target = getClosestVisibleToCursor()
        assistFlick(target)
    end
end)

-- Menu GUI with Drag-and-Drop
local menuOpen = false
local menuFrame = nil

local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SigmaGyatHub"
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.new(1, 0.84, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    title.Text = "Sigma Gyat Hub"
    title.TextColor3 = Color3.new(1, 0.84, 0)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 24
    title.Parent = frame

    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(1, -20, 1, -70)
    controls.Position = UDim2.new(0, 10, 0, 60)
    controls.BackgroundTransparency = 1
    controls.Parent = frame

    local controlList = Instance.new("UIListLayout")
    controlList.SortOrder = Enum.SortOrder.LayoutOrder
    controlList.Padding = UDim.new(0, 10)
    controlList.Parent = controls

    local bulletPoints = {
        "Toggle Highlighting: F2",
        "Toggle Display: F3",
        "Toggle Aimlock: F1",
        "Show/Hide Menu: F4",
        "Drag Menu: Click and Drag"
    }

    for _, text in ipairs(bulletPoints) do
        local controlText = Instance.new("TextLabel")
        controlText.Size = UDim2.new(1, 0, 0, 30)
        controlText.BackgroundTransparency = 1
        controlText.Text = "• " .. text
        controlText.TextColor3 = Color3.new(1, 1, 1)
        controlText.Font = Enum.Font.Gotham
        controlText.TextSize = 18
        controlText.TextXAlignment = Enum.TextXAlignment.Left
        controlText.Parent = controls
    end

    -- Drag-and-Drop Functionality
    local dragStart, startPos
    local dragging
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    menuFrame = frame
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F4 then
        menuOpen = not menuOpen
        if menuOpen then
            if not menuFrame then
                createMenu()
            else
                menuFrame.Visible = true
            end
        else
            if menuFrame then
                menuFrame.Visible = false
            end
        end
    end
end)

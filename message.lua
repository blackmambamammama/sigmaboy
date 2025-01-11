-- Place this script in StarterPlayerScripts
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local highlightingEnabled = false
local displayEnabled = true
local outlines = {} -- Store created highlight objects
local billboards = {} -- Store created billboard GUIs

-- Function to create or update outlines and billboards
local function updateOutlines()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Highlight setup
            local highlight = outlines[player] or Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.FillTransparency = 1
            highlight.OutlineColor = Color3.new(1, 1, 1) -- White outline
            highlight.OutlineTransparency = 0
            highlight.Parent = game.Workspace
            outlines[player] = highlight

            if displayEnabled then
                -- Billboard setup
                local billboard = billboards[player] or Instance.new("BillboardGui")
                billboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
                billboard.Size = UDim2.new(0, 150, 0, 40) -- Smaller text
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true

                -- TextLabel for username and distance
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

    -- Remove outlines and billboards for players no longer in the game
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

-- Toggle highlighting and display toggles
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

-- Variables
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local target = nil
local activationRadius = 200 -- Radius for aimlock
local aimlockActivated = false -- Tracks if aimlock is active (F1 toggles)
local holdingRightClick = false -- Tracks if the right mouse button is held

local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Function to check if a target's head is visible
local function isHeadVisible(targetHead)
    local character = player.Character
    if not character or not character:FindFirstChild("Head") then return false end

    local ray = Ray.new(character.Head.Position, (targetHead.Position - character.Head.Position).Unit * 500)
    local hitPart = workspace:FindPartOnRay(ray, character)

    return hitPart and hitPart:IsDescendantOf(targetHead.Parent)
end

-- Function to find the closest visible player within the activation radius
local function getClosestVisibleToCursor()
    local closestTarget = nil
    local closestDistance = math.huge

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
            local head = otherPlayer.Character.Head
            local headScreenPosition, onScreen = camera:WorldToScreenPoint(head.Position)

            if onScreen and isHeadVisible(head) then
                local cursorPosition = Vector2.new(mouse.X, mouse.Y)
                local distance = (Vector2.new(headScreenPosition.X, headScreenPosition.Y) - cursorPosition).magnitude

                if distance < activationRadius and distance < closestDistance then
                    closestDistance = distance
                    closestTarget = head
                end
            end
        end
    end

    return closestTarget
end

-- Function to assist the user's flick towards the target
local function assistFlick(targetHead)
    if targetHead and targetHead.Parent then
        local cameraDirection = (targetHead.Position - camera.CFrame.Position).Unit
        local flickStrength = 0.6 -- Stronger flick assist

        -- Adjust camera slightly toward the target
        camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, camera.CFrame.Position + cameraDirection), flickStrength)
    end
end

-- Key press and mouse event handling
userInputService.InputBegan:Connect(function(input, isProcessed)
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

userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingRightClick = false
    end
end)

-- RenderStepped: Trigger aimlock with flick assist when right click is held and aimlock is active
runService.RenderStepped:Connect(function()
    if aimlockActivated and holdingRightClick then
        target = getClosestVisibleToCursor()
        assistFlick(target)
    end
end)

-- Menu Variables
local menuOpen = false
local menuFrame = nil
local dragActive = false
local dragStart = nil
local startPos = nil

-- Create the Menu GUI
local function createMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SigmaGyatHub"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(1, -310, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(1, 0)
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    title.Text = "Sigma Gyat Hub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 20
    title.BorderSizePixel = 0
    title.Parent = frame

    local uiCornerTitle = Instance.new("UICorner")
    uiCornerTitle.CornerRadius = UDim.new(0, 10)
    uiCornerTitle.Parent = title

    local controls = Instance.new("Frame")
    controls.Name = "Controls"
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
        "Drag this Menu: Hold and Drag"
    }

    for _, text in ipairs(bulletPoints) do
        local controlText = Instance.new("TextLabel")
        controlText.Size = UDim2.new(1, 0, 0, 30)
        controlText.BackgroundTransparency = 1
        controlText.Text = "• " .. text
        controlText.TextColor3 = Color3.fromRGB(255, 255, 255)
        controlText.Font = Enum.Font.Gotham
        controlText.TextSize = 16
        controlText.TextXAlignment = Enum.TextXAlignment.Left
        controlText.Parent = controls
    end

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 215, 0) -- Gold accent
    uiStroke.Thickness = 2
    uiStroke.Parent = frame

    menuFrame = frame
end

-- Dragging Functionality
local function enableDragging(frame)
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragActive = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragActive = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragActive and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Keybind to Toggle Menu
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.F4 then
        menuOpen = not menuOpen

        if menuOpen then
            if not menuFrame then
                createMenu()
                enableDragging(menuFrame)
            end
            menuFrame.Visible = true
        else
            if menuFrame then
                menuFrame.Visible = false
            end
        end
    end
end)

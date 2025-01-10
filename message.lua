-- Variables
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local target = nil
local activationRadius = 200 -- Radius for aimlock
local aimlockActivated = false -- Tracks if aimlock is active (F1 toggles)
local holdingRightClick = false -- Tracks if the right mouse button is held
local highlightingEnabled = false -- Tracks if highlighting is enabled (F2 toggles)
local highlights = {} -- Tracks active highlights
local aimlockCircle = nil -- GUI for the circular outline
local controlsMenu = nil -- Controls menu GUI

local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

-- Function to create the circular outline for the aimlock area
local function createAimlockCircle()
    aimlockCircle = Instance.new("ScreenGui")
    aimlockCircle.Name = "AimlockCircle"
    aimlockCircle.Parent = player:WaitForChild("PlayerGui")

    local circle = Instance.new("Frame")
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
    circle.Size = UDim2.new(0, activationRadius * 2, 0, activationRadius * 2)
    circle.BackgroundTransparency = 1
    circle.BorderSizePixel = 2
    circle.BorderColor3 = Color3.fromRGB(255, 255, 255) -- White border for the circle
    circle.Visible = false
    circle.Parent = aimlockCircle

    return circle
end

local aimlockOutline = createAimlockCircle()

-- Function to toggle the aimlock circle
local function toggleAimlockCircle(state)
    if aimlockOutline then
        aimlockOutline.Visible = state
    end
end

-- Function to create the controls menu
local function createControlsMenu()
    controlsMenu = Instance.new("ScreenGui")
    controlsMenu.Name = "ControlsMenu"
    controlsMenu.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.2, 0, 0.2, 0)
    frame.Position = UDim2.new(0.8, 0, 0.05, 0) -- Top-right corner
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Visible = false
    frame.Parent = controlsMenu

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Sigma Gyat Hub"
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Parent = frame

    local instructions = Instance.new("TextLabel")
    instructions.Size = UDim2.new(1, 0, 0.8, 0)
    instructions.Position = UDim2.new(0, 0, 0.2, 0)
    instructions.BackgroundTransparency = 1
    instructions.Text = "Controls:\nF1: Toggle Aimlock\nF2: Toggle Highlights\nH: Show/Hide Menu\nRight-Click: Activate Flick Assist"
    instructions.Font = Enum.Font.Gotham
    instructions.TextScaled = true
    instructions.TextColor3 = Color3.fromRGB(255, 255, 255)
    instructions.TextWrapped = true
    instructions.Parent = frame

    return frame
end

local controlsFrame = createControlsMenu()

-- Function to toggle the controls menu
local function toggleControlsMenu(state)
    if controlsFrame then
        controlsFrame.Visible = state
    end
end

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

-- Function to create highlights for username and distance
local function createHighlight(character, playerTarget)
    if highlights[playerTarget] then return end

    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green fill
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White border
    highlight.Parent = character

    local head = character:FindFirstChild("Head")
    if not head then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(4, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = playerTarget.Name .. "\nDistance: Calculating..."
    textLabel.Parent = billboard

    highlights[playerTarget] = {
        highlight = highlight,
        billboard = billboard,
        textLabel = textLabel,
    }
end

-- Function to toggle all highlights
local function toggleHighlights()
    highlightingEnabled = not highlightingEnabled
    print("Highlighting Enabled:", highlightingEnabled)

    if highlightingEnabled then
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                createHighlight(otherPlayer.Character, otherPlayer)
            end
        end
    else
        for playerTarget, objects in pairs(highlights) do
            if objects.highlight then objects.highlight:Destroy() end
            if objects.billboard then objects.billboard:Destroy() end
        end
        highlights = {}
    end
end

-- Key press and mouse event handling
userInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end

    if input.KeyCode == Enum.KeyCode.F1 then
        aimlockActivated = not aimlockActivated
        print("Aimlock Activated:", aimlockActivated)
        toggleAimlockCircle(aimlockActivated)

        if not aimlockActivated then
            holdingRightClick = false
        end
    elseif input.KeyCode == Enum.KeyCode.F2 then
        toggleHighlights()
    elseif input.KeyCode == Enum.KeyCode.H then
        toggleControlsMenu(not controlsFrame.Visible)
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

    if highlightingEnabled then
        for playerTarget, objects in pairs(highlights) do
            if playerTarget.Character and playerTarget.Character:FindFirstChild("Head") then
                local head = playerTarget.Character.Head
                local distance = (head.Position - player.Character.Head.Position).Magnitude
                objects.textLabel.Text = playerTarget.Name .. "\nDistance: " .. string.format("%.1f", distance)
            end
        end
    end
end)

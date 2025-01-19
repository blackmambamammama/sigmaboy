--// Settings
local enables = {
    main = {
        silent = false,
        aimbot = false,
        currentname = nil,
        currenthitpart = "Head",
        fovradius = 0,
        playerinfo = false,
        highlighttarget = false,
        highlightcolor = Color3.fromRGB(255, 255, 255),
        prediction = false,
        bprediction = false
    },
    misc = {
        bhop = false,
        speed_hack = false,
        amongus = false,
        zoom = false,
        spin = false,
        spin_value = 0,
        water_float = false
    },
    debug = {
        enabled = false,
        speed = 1,
        color = Color3.fromRGB(255, 255, 255)
        },
    cursor = {
        Enabled = false,
        CustomPos = false,
        Position = Vector2.new(0, 0),
        Speed = 5,
        Radius = 25,
        Color = Color3.fromRGB(180, 50, 255),
        Thickness = 1.7,
        Outline = false,
        Resize = false,
        Gap = 10,
        TheGap = false,
        Text = {
            Logo = false,
            LogoColor = Color3.new(1, 1, 1),
            Name = false,
            NameColor = Color3.new(1, 1, 1),
            LogoFadingOffset = 0,
        },
    },
 }

 local GunTables = {
    AKM = "AKM",
    AKMN = "AKMN",
    AsVal = "AsVal",
    IZh12 = "IZh12",
    IZh81 = "IZh81",
    M4 = "M4",
    MK23 = "MK23",
    MP443 = "MP443",
    MP5SD = "MP5SD",
    Makarov = "Makarov",
    Mosin = "Mosin",
    PKM = "PKM",
    PPSH41 = "PPSH41",
    R700 = "R700",
    RPG7 = "RPG7",
    SKS = "SKS",
    SVD = "SVD",
    Saiga12 = "Saiga12",
    TFZ0 = "TFZ0",
    TFZ98S = "TFZ98S",
    TT33 = "TT33",
    VZ61 = "VZ61",
 }

 local skins = {
	["762x25MAG"] = "Nutcracker",
	["762x25Rnd71Mag"] = "Arctic",
	["762x25TTMAG"] = "Watergun",
	["762x39MAG"] = "DeltaAnime",
	["762x39Rnd75Mag"] = "Anton",
	["762x54Rnd10Mag"] = "Permafrost",
	["9x18vzMag"] = "GiftWrap",
	["9x19MP443MAG"] = "JollyRoger",
	["9x19MP5MAG"] = "Permafrost",
	["9x39Mag"] = "Shoreline",
	AKMN = "DeltaAnime",
	FrontAKMN = "DeltaAnime",
	HandleRK3AKMN = "DeltaAnime",
	PolymerStockAKMN = "DeltaAnime",
	HandleAKMN = "Valentine",
	TacticalFrontAKMN = "AnodizedRed",
	MuzzleBrakeAKM = "AnodizedRed",
	CombatGloves = "Anarchy",
	CamoShirt = "Anarchy",
	HandWraps = "SantaCommando",
	WastelandShirt = "SantaCommando",
	M4 = "Devil",
	Lighter = "EarlyAccess",
	GorkaShirt = "Wetsuit",
	GhillieTorso = "Arctic",
	AsVal = "Shoreline",
	F1 = "Pineapple",
	Makarov = "Serpant",
	Mosin = "SkullHunter",
	PPSH41 = "Nutcracker",
	SVD = "Permafrost",
	Saiga12 = "Valentine",
	TT33 = "Watergun",
	ZSh = "Woodland",
	MP5SD  = "Permafrost",
	MP443 = "Whiteout",
	IZh81 = "Watergun",
 }

 local utility = {}
 local functions = {} -- functions:name() to update or easier to find L
 --// Variables
 local workspace = game.Workspace
 local players = game:GetService("Players")
 local localplayer = players.LocalPlayer
 local mouse = localplayer:GetMouse()
 local camera = workspace.CurrentCamera
 local lighting = game:GetService("Lighting")
 local replicatestorage = game:GetService("ReplicatedStorage")
 local userinput = game:GetService("UserInputService")
 local runservice = game:GetService("RunService")
 local centerofscreen = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
 local os_clock = os.clock()
 local Sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")
 local realAmmoTypes = replicatestorage:FindFirstChild("realAmmoTypes") or replicatestorage:FindFirstChild("AmmoTypes") and replicatestorage:FindFirstChild("AmmoTypes"):Clone(); if realAmmoTypes then realAmmoTypes.Name = "realAmmoTypes" end
 local Snapline

 --// For ESP
 local Drawingnew = Drawing.new
 local Color3fromRGB = Color3.fromRGB
 local Vector3new = Vector3.new
 local Vector2new = Vector2.new
 local mathfloor = math.floor
 local mathceil = math.ceil

 --// Skybox
 if not Sky then Sky = Instance.new("Sky", lighting) end
 local value = "Standard"
 local SkyBoxes = {
     ["Standard"] = { ["SkyboxBk"] = Sky.SkyboxBk, ["SkyboxDn"] = Sky.SkyboxDn, ["SkyboxFt"] = Sky.SkyboxFt, ["SkyboxLf"] = Sky.SkyboxLf, ["SkyboxRt"] = Sky.SkyboxRt, ["SkyboxUp"] = Sky.SkyboxUp, },
     ["Among Us"] = { ["SkyboxBk"] = "rbxassetid://5752463190", ["SkyboxDn"] = "rbxassetid://5752463190", ["SkyboxFt"] = "rbxassetid://5752463190", ["SkyboxLf"] = "rbxassetid://5752463190", ["SkyboxRt"] = "rbxassetid://5752463190", ["SkyboxUp"] = "rbxassetid://5752463190" },
     ["Doge"] = { ["SkyboxBk"] = "rbxassetid://159713165", ["SkyboxDn"] = "rbxassetid://159713165", ["SkyboxFt"] = "rbxassetid://5752463190", ["SkyboxLf"] = "rbxassetid://5752463190", ["SkyboxRt"] = "rbxassetid://159713165", ["SkyboxUp"] = "rbxassetid://159713165" },
     ["Spongebob"] = { ["SkyboxBk"] = "rbxassetid://277099484", ["SkyboxDn"] = "rbxassetid://277099500", ["SkyboxFt"] = "rbxassetid://277099554", ["SkyboxLf"] = "rbxassetid://277099531", ["SkyboxRt"] = "rbxassetid://277099589", ["SkyboxUp"] = "rbxassetid://277101591" },
     ["Deep Space"] = { ["SkyboxBk"] = "rbxassetid://159248188", ["SkyboxDn"] = "rbxassetid://159248183", ["SkyboxFt"] = "rbxassetid://159248187", ["SkyboxLf"] = "rbxassetid://159248173", ["SkyboxRt"] = "rbxassetid://159248192", ["SkyboxUp"] = "rbxassetid://159248176" },
     ["Winter"] = { ["SkyboxBk"] = "rbxassetid://510645155", ["SkyboxDn"] = "rbxassetid://510645130", ["SkyboxFt"] = "rbxassetid://510645179", ["SkyboxLf"] = "rbxassetid://510645117", ["SkyboxRt"] = "rbxassetid://510645146", ["SkyboxUp"] = "rbxassetid://510645195" },
     ["Clouded Sky"] = { ["SkyboxBk"] = "rbxassetid://252760981", ["SkyboxDn"] = "rbxassetid://252763035", ["SkyboxFt"] = "rbxassetid://252761439", ["SkyboxLf"] = "rbxassetid://252760980", ["SkyboxRt"] = "rbxassetid://252760986", ["SkyboxUp"] = "rbxassetid://252762652" },
     --["test"] = {"SkyboxBk"="rbxassetid://","SkyboxDn"="rbxassetid://","SkyboxFt"="rbxassetid://","SkyboxLf"="rbxassetid://","SkyboxRt"="rbxassetid://","SkyboxUp"="rbxassetid://"},
 }
 --// Drawing
 function utility:new(type, properties)
    local object = Drawing.new(type)

    for i, v in pairs(properties) do
        object[i] = v
    end
    return object
end

 local esp = {
    players = {},
    objects = {},
    enabled = false,
    teamcheck = false,
    fontsize = 13,
    font = 3,
    maxdist = 0,
    settings = {
        name = {enabled = false, outline = true, displaynames = false, color = Color3fromRGB(255, 255, 255)},
        box = {enabled = false, outline = true, color = Color3fromRGB(255, 255, 255)},
        filledbox = {enabled = false, outline = true, transparency = 0.5, color = Color3fromRGB(255, 255, 255)},
        healthbar = {enabled = false, size = 3, outline = true},
        healthtext = {enabled = false, outline = true, color = Color3fromRGB(255, 255, 255)},
        distance = {enabled = false, outline = true, color = Color3fromRGB(255, 255, 255)},
        viewangle = {enabled = false, size = 10, color = Color3fromRGB(255, 255, 255)},
        weapon = {enabled = false, outline = true, color = Color3fromRGB(255, 255, 255)}
    },
    settings_chams = {
        enabled = false,
        teamcheck = false,
        outline = false,
        fill_color = Color3fromRGB(255, 255, 255),
        outline_color = Color3fromRGB(0, 0, 0), 
        fill_transparency = 0,
        outline_transparency = 0,
        autocolor = false,
        visible_Color = Color3fromRGB(0, 255, 0),
        invisible_Color = Color3fromRGB(255, 0, 0),
    },
    customsettings = {
        enabled = false,
        maxdist = 0,
        corpse = {enabled = false, outline = true, size = 10, color = Color3fromRGB(255, 255, 255)},
        ai = {enabled = false, outline = true, size = 10, color = Color3fromRGB(255, 255, 255)},
        corpsechams = {
            enabled = false,
            fill_color = Color3fromRGB(255, 255, 255),
            outline_color = Color3fromRGB(0, 0, 0),
            fill_transparency = 0,
            outline_transparency = 0,
            occluded = false
        },
        aichams = {
            enabled = false,
            fill_color = Color3fromRGB(255, 255, 255),
            outline_color = Color3fromRGB(0, 0, 0),
            fill_transparency = 0,
            outline_transparency = 0,
            occluded = false
        },
        corpsedistance = {enabled = false, color = Color3fromRGB(255, 255, 255)},
        aidistance = {enabled = false, color = Color3fromRGB(255, 255, 255)},
        aihealth = {enabled = false, color = Color3fromRGB(255, 255, 255)},
        extract = {enabled = false, outline = true, size = 10, color = Color3fromRGB(255, 255, 255)},
        extractdistance = {enabled = false, color = Color3fromRGB(255, 255, 255)}
    }
}

 --// Loadstrings
 local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BIvck/Skibidi/refs/heads/main/library.lua", true))()
--  local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/BIvck/Skibidi/refs/heads/main/esp.lua", true))()

 --// Tabs
 local tabs = {
    combat = library:addTab("Combat", "http://www.roblox.com/asset/?id=15178561786"),
    visuals = library:addTab("Visuals", "http://www.roblox.com/asset/?id=13321848320"),
    misc = library:addTab("Misc", "http://www.roblox.com/asset/?id=7347408509"),
    settings = library:addTab("Settings", "http://www.roblox.com/asset/?id=11956055886")
 }
   
 --// Fov Circle
 local Circle = Drawing.new("Circle")
    Circle.Filled = false
    Circle.Thickness = 1
    Circle.Color = Color3.new(0, 0, 0)
    Circle.Visible = false

 function functions:updateCircle()
    local pos
    if enables.cursor.CustomPos then
        pos = enables.cursor.Position
    else
        pos = Vector2.new(
            game.Players.LocalPlayer:GetMouse().X,
            game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y
        )
    end
    Circle.Position = pos
    local fovScalingFactor = 5 * math.tan(math.rad(camera.FieldOfView / 2))
    local radius = fovScalingFactor + enables.main.fovradius
    Circle.Radius = radius
 end

 --// Target Closest
 function functions:TargetPlayer()
    local Target = nil
    local Name = nil
    local Distance = math.huge
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localplayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local vector, onScreen = camera:WorldToViewportPoint(head.Position)
            local screenPoint = Vector2.new(vector.X, vector.Y)
            local distance = (screenPoint - camera.ViewportSize/2).Magnitude

            if onScreen and distance < enables.main.fovradius and distance < Distance then
                Distance = distance
                Target = player.Character[enables.main.currenthitpart]
                Name = player
            end
        end
        enables.main.currentname = Name
    end
    return Target
 end
 --// Visible Check!
 function functions:VisibleCheck(target)
    local cameraPos = camera.CFrame.Position
    local targetPos
    if target ~= nil and target.Character ~= nil then
        target = target.Character
        if target:FindFirstChild("Head") then
            local ignoreList = {}
            for _, child in ipairs(target:GetChildren()) do
                if child:IsA("Model") or child:IsA("Hat") or child:IsA("MeshPart") or child.Name == "HeadTopHitBox" or child.Name == "FaceHitBox" then
                    table.insert(ignoreList, child)
                end
            end
            table.insert(ignoreList, game.Players.LocalPlayer.Character)
            targetPos = target.Head.Position

            local start = cameraPos
            local goal = targetPos
            local ray = Ray.new(start, (goal - start).unit * (goal - start).magnitude)
            local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
            if hit then
                return false
            else
                return true
            end
        else
            return false
        end
    else
        return false
    end
 end

 local function castgun()
    if not localplayer.Character or not workspace.CurrentCamera:FindFirstChild("ViewModel") then return (camera.ViewportSize / 2) end
    if not workspace.Camera:FindFirstChild("ViewModel"):FindFirstChild("AimPart") then return (camera.ViewportSize / 2) end
    local from = workspace.Camera.ViewModel:FindFirstChild("AimPart")
    local ray = Ray.new(from.CFrame.p, (from.CFrame.LookVector).Unit * 1000)
    local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {localplayer.Character, camera})

    if part then
        local result = camera:WorldToViewportPoint(position)
        return Vector2.new(result.X, result.Y)
    else
        return (camera.ViewportSize / 2)
    end
end

--// Crosshair
 local lines = {}
-- // Drawings
 local outline = utility:new("Square", {
    Visible = true,
    Size = Vector2.new(4, 4),
    Color = Color3.fromRGB(0, 0, 0),
    Filled = true,
    ZIndex = 1,
    Transparency = 1,
 })
 --// Player Info
 local Target = utility:new("Text", {
    Font = 3,
    Size = 13,
    Color = Color3.new(1, 1, 1),
    Center = true,
    Outline = true,
    Position = Vector2.new(centerofscreen.X, (centerofscreen + Vector2.new(0, 55)).Y)
 })
 local Ad = utility:new("Text", {
    Font = 3,
    Size = 13,
    Color = Color3.new(0.952941, 0.356863, 0.874510),
    Transparency = 1,
    Text = "anti.solutions",
    Center = true,
    Outline = true,
    Position = Vector2.new(centerofscreen.X, (centerofscreen + Vector2.new(0, 40)).Y)

 })
 local Health = utility:new("Text", {
    Font = 3,
    Size = 13,
    Color = Color3.fromRGB(52, 235, 70),
    Center = true,
    Outline = true,
    Position = Vector2.new(centerofscreen.X, (centerofscreen + Vector2.new(0, 70)).Y)
 })
 local Meters = utility:new("Text", {
    Font = 3,
    Size = 13,
    Color = Color3.new(1, 1, 1),
    Center = true,
    Outline = true,
    Position = Vector2.new(centerofscreen.X, (centerofscreen + Vector2.new(0, 85)).Y)
 })
 local Visible = utility:new("Text", {
    Font = 3,
    Size = 13,
    Color = Color3.fromRGB(240, 142, 214),
    Center = true,
    Outline = true,
    Text = "Not Visible",
    Position = Vector2.new(centerofscreen.X, (centerofscreen + Vector2.new(0, 100)).Y)
 })
--
for i = 1, 4 do
    local line = utility:new("Line", {
        Visible = true,
        From = Vector2.new(200, 500),
        To = Vector2.new(200, 500),
        Color = enables.cursor.Color,
        Thickness = enables.cursor.Thickness,
        ZIndex = 2,
        Transparency = 1,
    })
    --
    local line_outline = utility:new("Line", {
        Visible = true,
        From = Vector2.new(200, 500),
        To = Vector2.new(200, 500),
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = enables.cursor.Thickness + 2.5,
        ZIndex = 1,
        Transparency = 1,
    })
    --
    lines[i] = { line, line_outline }
end
-- // Main
local angle = 0
local transp = 0
local reverse = false
local function setreverse(value)
    if reverse ~= value then
        reverse = value
    end
end
--
game:GetService("RunService").RenderStepped:connect(function()
    if enables.cursor.Enabled then
        local pos
        if enables.cursor.CustomPos then
            pos = enables.cursor.Position
        else
            pos = Vector2.new(
                game.Players.LocalPlayer:GetMouse().X,
                game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y
            )
        end
        angle = angle + (1 / (enables.cursor.Speed * 10))
        if transp <= 1.5 + enables.cursor.Text.LogoFadingOffset and not reverse then
            transp = transp + (1 / (enables.cursor.Speed * 10))
            if transp >= 1.5 + enables.cursor.Text.LogoFadingOffset then
                setreverse(true)
            end
        elseif reverse then
            transp = transp - (1 / (enables.cursor.Speed * 10))
            if transp <= 0 - enables.cursor.Text.LogoFadingOffset then
                setreverse(false)
            end
        end
        if angle >= 360 then
            angle = 0
        end
        --
        Ad.Position = Vector2.new(pos.X, (pos + Vector2.new(0, enables.cursor.Radius + 5)).Y)
        Ad.Transparency = transp
        Target.Position = Vector2.new(pos.X, (pos + Vector2.new(0, enables.cursor.Radius + 20)).Y)
        Health.Position = Vector2.new(pos.X, (pos + Vector2.new(0, enables.cursor.Radius + 35)).Y)
        Meters.Position = Vector2.new(pos.X, (pos + Vector2.new(0, enables.cursor.Radius + 50)).Y)
        Visible.Position = Vector2.new(pos.X, (pos + Vector2.new(0, enables.cursor.Radius + 65)).Y)
        --
        for index, line in pairs(lines) do
            index = index
            if enables.cursor.Resize then
                x = {
                    pos.X
                        + (
                            math.cos(angle + (index * (math.pi / 2)))
                            * (enables.cursor.Radius + ((enables.cursor.Radius * math.sin(angle)) / 9))
                        ),
                    pos.X
                        + (
                            math.cos(angle + (index * (math.pi / 2)))
                            * (
                                (enables.cursor.Radius - 20)
                                - (
                                    enables.cursor.TheGap
                                        and (((enables.cursor.Radius - 20) * math.cos(angle)) / 4)
                                    or (((enables.cursor.Radius - 20) * math.cos(angle)) - 4)
                                )
                            )
                        ),
                }
                y = {
                    pos.Y
                        + (
                            math.sin(angle + (index * (math.pi / 2)))
                            * (enables.cursor.Radius + ((enables.cursor.Radius * math.sin(angle)) / 9))
                        ),
                    pos.Y
                        + (
                            math.sin(angle + (index * (math.pi / 2)))
                            * (
                                (enables.cursor.Radius - 20)
                                - (
                                    enables.cursor.TheGap
                                        and (((enables.cursor.Radius - 20) * math.cos(angle)) / 4)
                                    or (((enables.cursor.Radius - 20) * math.cos(angle)) - 4)
                                )
                            )
                        ),
                }
            else
                x = {
                    pos.X + (math.cos(angle + (index * (math.pi / 2))) * enables.cursor.Radius),
                    pos.X
                        + (
                            math.cos(angle + (index * (math.pi / 2)))
                            * (
                                (enables.cursor.Radius - 20)
                                - (
                                    enables.cursor.TheGap
                                        and ((enables.cursor.Radius - 20) / enables.cursor.Gap)
                                    or ((enables.cursor.Radius - 20) - enables.cursor.Gap)
                                )
                            )
                        ),
                }
                y = {
                    pos.Y + (math.sin(angle + (index * (math.pi / 2))) * enables.cursor.Radius),
                    pos.Y
                        + (
                            math.sin(angle + (index * (math.pi / 2)))
                            * (
                                (enables.cursor.Radius - 20)
                                - (
                                    enables.cursor.TheGap
                                        and ((enables.cursor.Radius - 20) / enables.cursor.Gap)
                                    or ((enables.cursor.Radius - 20) - enables.cursor.Gap)
                                )
                            )
                        ),
                }
            end
            --
            line[1].Visible = true
            line[1].Color = enables.cursor.Color
            line[1].From = Vector2.new(x[2], y[2])
            line[1].To = Vector2.new(x[1], y[1])
            line[1].Thickness = enables.cursor.Thickness
            --
            line[2].Visible = enables.cursor.Outline
            line[2].From = Vector2.new(x[2], y[2])
            line[2].To = Vector2.new(x[1], y[1])
            line[2].Thickness = enables.cursor.Thickness + 2.5
        end
    else
        outline.Visible = false
        Ad.Visible = false        --
        for index, line in pairs(lines) do
            line[1].Visible = false
            line[2].Visible = false
        end
    end
    if enables.main.playerinfo and functions:TargetPlayer() then
        -- Advertisement
        Ad.Visible = enables.main.playerinfo
        -- Target
        Target.Text = "Target : "..enables.main.currentname.Name
        Target.Visible = enables.main.playerinfo
        -- Health
        Health.Text = "Health : "..tostring(math.floor(enables.main.currentname.Character.Humanoid.Health)).."/100"
        Health.Visible = enables.main.playerinfo
        -- Distance
        Meters.Text = "Distance : "..math.ceil((camera.CFrame.Position - functions:TargetPlayer().Position).Magnitude / 3.571).."m"
        Meters.Visible = enables.main.playerinfo
        -- Visible
        Visible.Visible = enables.main.playerinfo
        local check = functions:VisibleCheck(enables.main.currentname)
        if check == true then
            Visible.Text = "Visible"
            Visible.Color = Color3.fromRGB(52, 235, 70)
        else
            Visible.Text = "Not Visible"
            Visible.Color = Color3.fromRGB(235, 52, 52)
        end
    else
        Visible.Visible = false
        Ad.Visible = false
        Meters.Visible = false
        Health.Visible = false
        Target.Visible = false
    end
end)

 --// Combat
 local maintab = tabs.combat:createGroup('left', 'Aimbot')
 local maintab1 = tabs.combat:createGroup('center', 'Misc')
 local maintab2 = tabs.combat:createGroup('right', 'Gun Mods')

 --// Main aimbot/silentaim
 do -- Whoever got this script he's a nerd fuck that nigga
    maintab:addToggle({text = "silent aim", risky = true, callback = function(Value)
        enables.main.silent = Value
        functions:silentaim()
    end})
    maintab:addToggle({text = "prediction", callback = function(Value)
        enables.main.prediction = Value
    end})
    -- maintab:addToggle({text = "predict Y", callback = function(Value)
    --     enables.main.bprediction = Value
    -- end})
    -- maintab:addLabel({text = "don't use pred Y"})
    -- maintab:addLabel({text = "if ur using remove drop"})
    maintab:addList({text = "hitpart:",multiselect = false,values = {'Head','HumanoidRootPart'}, flag = "hitpart", callback = function(Value)
        enables.main.currenthitpart = Value
    end})
    maintab:addToggle({text = "player info", callback = function(Value)
        enables.main.playerinfo = Value
    end})
    maintab:addToggle({text = "snapline",flags = "snapline", callback = function()end}):addColorpicker({text = 'Color', ontop = true, flag = "snapline_color", color = Color3.new(1,0,0), callback = function()end})
    maintab:addDivider()
    maintab:addLabel({text = "Fov Circle"})
    maintab:addToggle({text = "enable", callback = function(Value)
        Circle.Visible = Value
    end}):addColorpicker({text = 'Color', ontop = true, flag = "circle_color", color = Color3.new(1,1,1), callback = function() Circle.Color = library.flags['circle_color'] end})
    maintab:addToggle({text = "fov filled", callback = function(Value)
        Circle.Filled = Value
    end})
    maintab:addSlider({text = "fov value:", min = 0, max = 500, suffix = "%", flag = "fov_value", float = 1, default = 0, callback = function(Value)
        enables.main.fovradius = Value
    end})
 end

 --// Misc
 do
    maintab1:addToggle({text = "viewmodel", flag = "viewmodel_toggle", callback = function()end})
    maintab1:addSlider({text = "x value:", min = -5, max = 5, suffix = "%", flag = "viewmodel_x", float = 0.1, default = 0, callback = function()end})
    maintab1:addSlider({text = "y value:", min = -5, max = 5, suffix = "%", flag = "viewmodel_y", float = 0.1, default = 0, callback = function()end})
    maintab1:addSlider({text = "z value:", min = -5, max = 5, suffix = "%", flag = "viewmodel_z", float = 0.1, default = 0, callback = function()end})
    maintab1:addDivider()
    maintab1:addToggle({text = "mainswitch", flag = "enable_chams", callback = function()end})
    maintab1:addToggle({text = "highlight chams", flag = "highlight_chams", callback = function()end}):addColorpicker({text = 'color', ontop = true, flag = "highlight_color", color = Color3.new(0,0,0), callback = function()end})
    maintab1:addToggle({text = "cloth chams", flag = "arm_chams", callback = function()end}):addColorpicker({text = 'color', ontop = true, flag = "arm_color", color = Color3.new(0,0,0), callback = function()end})
    maintab1:addToggle({text = "gun chams", flag = "gun_chams", callback = function()end}):addColorpicker({text = 'color', ontop = true, flag = "gun_color", color = Color3.new(0,0,0), callback = function()end})
    maintab1:addToggle({text = "arm chams", flag = "cloth_chams", callback = function()end}):addColorpicker({text = 'color', ontop = true, flag = "cloth_color", color = Color3.new(0,0,0), callback = function()end})
    maintab1:addDivider()
    maintab1:addList({text = "cloth material:",multiselect = false,values = {'ForceField', 'Neon', 'SmoothPlastic', 'Glass'}, flag = "arm_material", callback = function()end})
    maintab1:addList({text = "gun material:",multiselect = false,values = {'ForceField', 'Neon', 'SmoothPlastic', 'Glass'}, flag = "gun_material", callback = function()end})
    maintab1:addList({text = "arm material:",multiselect = false,values = {'ForceField', 'Neon', 'SmoothPlastic', 'Glass'}, flag = "cloth_material", callback = function()end})
    maintab1:addDivider()
    maintab1:addLabel({text = "tranparency"})
    maintab1:addSlider({text = "cloth value:", min = 0, max = 1, suffix = "%", flag = "trans_arm", float = 0.1, default = 0, callback = function()end})
    maintab1:addSlider({text = "gun value:", min = 0, max = 1, suffix = "%", flag = "trans_gun", float = 0.1, default = 0, callback = function()end})
    maintab1:addSlider({text = "arm value:", min = 0, max = 1, suffix = "%", flag = "trans_cloth", float = 0.1, default = 0, callback = function()end})

    maintab1:addToggle({text = "skin changer!", flag = "enable skins", callback = function()

        while library.flags['enable skins'] do task.wait(1)
            local DV2 = game.ReplicatedStorage.ViewModels:FindFirstChild("DV2")
            local Karambit = game.ReplicatedStorage.ViewModels:FindFirstChild("PlasmaNinjato")
            if DV2 and Karambit then
                DV2.Name = ("DV2real")
                Karambit.Name = ("DV2")
            end
			if replicatestorage:FindFirstChild("Players") and replicatestorage.Players:FindFirstChild(localplayer.Name) then
				local plr = replicatestorage.Players:FindFirstChild(localplayer.Name)
				for i,v in plr:GetDescendants() do
					if v:FindFirstChild("ItemProperties") and skins[v.Name] then
						v.ItemProperties:SetAttribute("Skin", skins[v.Name])
					end
				end
			end
        end
    end})
 end

 --// Gun Mods
 do
    maintab2:addToggle({text = "remove drop", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					v:SetAttribute("ProjectileDrop", 2)
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        v:SetAttribute("ProjectileDrop", realAmmo:GetAttribute("ProjectileDrop"))
                    end
                end
            end
		end
    end})
    maintab2:addToggle({text = "remove recoil", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					v:SetAttribute("RecoilStrength", 0)
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        v:SetAttribute("RecoilStrength", realAmmo:GetAttribute("RecoilStrength"))
                    end
                end
            end
		end
    end})
    maintab2:addToggle({text = "force tracer", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					v:SetAttribute("Tracer", true)
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        v:SetAttribute("Tracer", realAmmo:GetAttribute("Tracer"))
                    end
                end
            end
		end
    end})
    maintab2:addToggle({text = "drag", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					v:SetAttribute("Drag", 0)
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        v:SetAttribute("Drag", realAmmo:GetAttribute("Drag"))
                    end
                end
            end
		end
    end})
    maintab2:addToggle({text = "insta hit", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					v:SetAttribute("MuzzleVelocity", 2400)
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        v:SetAttribute("MuzzleVelocity", realAmmo:GetAttribute("MuzzleVelocity"))
                    end
                end
            end
		end
    end})
    maintab2:addToggle({text = "remove spread", callback = function(Value)
        if Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
				if v then
					if v:GetAttribute("AccuracyDeviation") then
						v:SetAttribute("AccuracyDeviation", 0)
					end
				end
			end
		elseif not Value and replicatestorage:FindFirstChild("AmmoTypes") then
			for i,v in ipairs(replicatestorage.AmmoTypes:GetChildren()) do
                if v then
                    local realAmmo = realAmmoTypes:FindFirstChild(v.Name)
                    if realAmmo then
                        if v:GetAttribute("AccuracyDeviation") then
                            v:SetAttribute("AccuracyDeviation", realAmmo:GetAttribute("AccuracyDeviation"))
                        end
                    end
                end
            end
		end
    end})
 end

 --// Crosshair
 local maintabgroup1 = tabs.combat:createGroup('right', 'Crosshair')
 do
    maintabgroup1:addToggle({text = "Enable", callback = function(first) enables.cursor.Enabled = first end}):addColorpicker({text = "Color", callback = function(x) enables.cursor.Color = x end})
    maintabgroup1:addToggle({text = "From Barrel", callback = function(first) enables.cursor.CustomPos = first end})
    maintabgroup1:addToggle({text = "Outline", callback = function(first) enables.cursor.Outline = first end})
    maintabgroup1:addToggle({text = "Resize", callback = function(first) enables.cursor.Resize = first end})
    maintabgroup1:addToggle({text = "Gap", callback = function(first) enables.cursor.TheGap = first end})
    maintabgroup1:addSlider({text = "Speed",flag = "cursor_speed",default = 3, min = -5, max = 0, suffix="", callback = function(State) enables.cursor.Speed = State end})
    maintabgroup1:addSlider({text = "Radius",flag = "radius_cur", default = 25, min = 0, max = 50, suffix="", callback = function(State) enables.cursor.Radius = State end})
    maintabgroup1:addSlider({text = "Thickness",flag = "thick_ness",default = 2, min = 0, max = 5,suffix ="", callback = function(State) enables.cursor.Thickness  = State end})
    maintabgroup1:addSlider({text = "Gap",flag = "aada",default = 5,min = 0, max = 50, suffix = "", callback = function(State) enables.cursor.Gap = State end})
 end
 --// Visual Function ESP
    esp.NewDrawing = function(type, properties)
        local newDrawing = Drawingnew(type)

        for i,v in next, properties or {} do
            newDrawing[i] = v
        end

        return newDrawing
    end

    esp.NewCham = function(properties)
        local newCham = Instance.new("Highlight", game.CoreGui)

        for i,v in next, properties or {} do
            newCham[i] = v
        end

        return newCham
    end

    esp.WallCheck = function(v)
        local ray = Ray.new(camera.CFrame.p, (v.Position - camera.CFrame.p).Unit * 300)
        local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {localplayer.Character, camera}, false, true)
        if part then
            local hum = part.Parent:FindFirstChildOfClass("Humanoid")
            if not hum then
                hum = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
            end
            if hum and v and hum.Parent == v.Parent then
                local Vector, Visible = camera:WorldToScreenPoint(v.Position)
                if Visible then
                    return true
                end
            end
        end
    end

    esp.TeamCheck = function(v)
        if localplayer.TeamColor == v.TeamColor then
            return false
        end

        return true
    end

    esp.GetEquippedTool = function(v)
        return (game:GetService("ReplicatedStorage").Players:FindFirstChild(v.Name).Status.GameplayVariables.EquippedTool.Value ~= nil and tostring(game:GetService("ReplicatedStorage").Players:FindFirstChild(v.Name).Status.GameplayVariables.EquippedTool.Value)) or "Hands"
    end

    esp.NewPlayer = function(v)
        esp.players[v] = {
            name = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
            filledbox = esp.NewDrawing("Square", {Color = Color3fromRGB(255, 255, 255), Thickness = 1, Filled = true}),
            boxOutline = esp.NewDrawing("Square", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
            box = esp.NewDrawing("Square", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
            healthBarOutline = esp.NewDrawing("Line", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
            healthBar = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
            healthText = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
            distance = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
            viewAngle = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
            weapon = esp.NewDrawing("Text", {Color = Color3fromRGB(255, 255, 255), Outline = true, Center = true, Size = 13, Font = 2}),
            cham = esp.NewCham({FillColor = esp.settings_chams.fill_color, OutlineColor = esp.settings_chams.outline_color, FillTransparency = esp.settings_chams.fill_transparency, OutlineTransparency = esp.settings_chams.outline_transparency})
        }
    end

    for _,v in ipairs(players:GetPlayers()) do
        if v ~= localplayer then
            esp.NewPlayer(v)
        end
    end

    players.ChildAdded:Connect(function(v)
        esp.NewPlayer(v)
    end)

    players.PlayerRemoving:Connect(function(v)
        for i2,v2 in pairs(esp.players[v]) do
            pcall(function()
                v2:Remove()
                v2:Destroy()
            end)
        end

        esp.players[v] = nil
    end)

    local ESP_Loop
    ESP_Loop = runservice.RenderStepped:Connect(function()
        for i,v in pairs(esp.players) do
            if i.Character and i.Character:FindFirstChild("Humanoid") and i.Character:FindFirstChild("HumanoidRootPart") and i.Character:FindFirstChild("Head") and i.Character:FindFirstChild("Humanoid").Health > 0 and (esp.maxdist == 0 or (i.Character.HumanoidRootPart.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude < esp.maxdist) then
                local hum = i.Character.Humanoid
                local hrp = i.Character.HumanoidRootPart
                local head = i.Character.Head

                local Vector, onScreen = camera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)
        
                local Size = (camera:WorldToViewportPoint(hrp.Position - Vector3new(0, 3, 0)).Y - camera:WorldToViewportPoint(hrp.Position + Vector3new(0, 2.6, 0)).Y) / 2
                local BoxSize = Vector2new(mathfloor(Size * 1.5), mathfloor(Size * 1.9))
                local BoxPos = Vector2new(mathfloor(Vector.X - Size * 1.5 / 2), mathfloor(Vector.Y - Size * 1.6 / 2))
        
                local BottomOffset = BoxSize.Y + BoxPos.Y + 1

                if onScreen and esp.settings_chams.enabled then
                    v.cham.Adornee = i.Character
                    v.cham.Enabled = esp.settings_chams.enabled
                    v.cham.OutlineTransparency = esp.settings_chams.outline and esp.settings_chams.outline_transparency or 1
                    v.cham.OutlineColor = esp.settings_chams.autocolor and esp.settings_chams.autocolor_outline and esp.WallCheck(i.Character.Head) and esp.settings_chams.visible_Color or esp.settings_chams.autocolor and esp.settings_chams.autocolor_outline and not esp.WallCheck(i.Character.Head) and esp.settings_chams.invisible_Color or esp.settings_chams.outline_color
                    v.cham.FillColor = esp.settings_chams.autocolor and esp.WallCheck(i.Character.Head) and esp.settings_chams.visible_Color or esp.settings_chams.autocolor and not esp.WallCheck(i.Character.Head) and esp.settings_chams.invisible_Color or esp.settings_chams.fill_color
                    v.cham.FillTransparency = esp.settings_chams.fill_transparency

                    if esp.settings_chams.teamcheck then
                        if not esp.TeamCheck(i) then
                            v.cham.Enabled = false
                        end
                    end
                else
                    v.cham.Enabled = false
                end

                if onScreen and esp.enabled then
                    if esp.settings.name.enabled then
                        v.name.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
                        v.name.Outline = esp.settings.name.outline
                        v.name.Color = esp.settings.name.color

                        v.name.Font = esp.font
                        v.name.Size = esp.fontsize

                        if esp.settings.name.displaynames then
                            v.name.Text = i.DisplayName
                        else
                            v.name.Text = i.Name
                        end

                        v.name.Visible = true
                    else
                        v.name.Visible = false
                    end

                    if esp.settings.distance.enabled and localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                        v.distance.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                        v.distance.Outline = esp.settings.distance.outline
                        v.distance.Text = "(" .. mathfloor((hrp.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude) .. ") meters"
                        v.distance.Color = esp.settings.distance.color
                        BottomOffset = BottomOffset + 15

                        v.distance.Font = esp.font
                        v.distance.Size = esp.fontsize

                        v.distance.Visible = true
                    else
                        v.distance.Visible = false
                    end

                    if esp.settings.filledbox.enabled then
                        v.filledbox.Size = BoxSize + Vector2.new(-2, -2)
                        v.filledbox.Position = BoxPos + Vector2.new(1, 1)
                        v.filledbox.Color = esp.settings.filledbox.color
                        v.filledbox.Transparency = esp.settings.filledbox.transparency
                        v.filledbox.Visible = true
                    else
                        v.filledbox.Visible = false
                    end

                    if esp.settings.box.enabled then
                        v.boxOutline.Size = BoxSize
                        v.boxOutline.Position = BoxPos
                        v.boxOutline.Visible = esp.settings.box.outline
        
                        v.box.Size = BoxSize
                        v.box.Position = BoxPos
                        v.box.Color = esp.settings.box.color
                        v.box.Visible = true
                    else
                        v.boxOutline.Visible = false
                        v.box.Visible = false
                    end

                    if esp.settings.healthbar.enabled then
                        v.healthBar.From = Vector2new((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
                        v.healthBar.To = Vector2new(v.healthBar.From.X, v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y)
                        v.healthBar.Color = Color3fromRGB(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
                        v.healthBar.Visible = true
                        v.healthBar.Thickness = esp.settings.healthbar.size

                        v.healthBarOutline.From = Vector2new(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
                        v.healthBarOutline.To = Vector2new(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) -1)
                        v.healthBarOutline.Visible = esp.settings.healthbar.outline
                        v.healthBarOutline.Thickness = esp.settings.healthbar.size + 2
                    else
                        v.healthBarOutline.Visible = false
                        v.healthBar.Visible = false
                    end

                    if esp.settings.healthtext.enabled then
                        v.healthText.Text = tostring(mathfloor(hum.Health))
                        v.healthText.Position = Vector2new((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) -1)
                        v.healthText.Color = Color3fromRGB(255 - 255 / (hum["MaxHealth"] / hum["Health"]), 255 / (hum["MaxHealth"] / hum["Health"]), 0)
                        v.healthText.Outline = esp.settings.healthtext.outline

                        v.healthText.Font = esp.font
                        v.healthText.Size = esp.fontsize

                        v.healthText.Visible = true
                    else
                        v.healthText.Visible = false
                    end

                    if esp.settings.viewangle.enabled and head and head.CFrame then
                        v.viewAngle.From = Vector2new(camera:worldToViewportPoint(head.CFrame.p).X, camera:worldToViewportPoint(head.CFrame.p).Y)
                        v.viewAngle.To = Vector2new(camera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * esp.settings.viewangle.size)).p).X, camera:worldToViewportPoint((head.CFrame + (head.CFrame.lookVector * esp.settings.viewangle.size)).p).Y)
                        v.viewAngle.Color = esp.settings.viewangle.color
                        v.viewAngle.Visible = true
                    else
                        v.viewAngle.Visible = false
                    end

                    if esp.settings.weapon.enabled then
                        v.weapon.Visible = true
                        v.weapon.Position = Vector2new(BoxSize.X + BoxPos.X + v.weapon.TextBounds.X / 2 + 3, BoxPos.Y - 3)
                        v.weapon.Outline = esp.settings.name.outline
                        v.weapon.Color = esp.settings.name.color

                        v.weapon.Font = esp.font
                        v.weapon.Size = esp.fontsize

                        v.weapon.Text = esp.GetEquippedTool(i)
                    else
                        v.weapon.Visible = false
                    end

                    if esp.teamcheck then
                        if esp.TeamCheck(i) then
                            v.name.Visible = esp.settings.name.enabled
                            v.box.Visible = esp.settings.box.enabled
                            v.filledbox.Visible = esp.settings.box.enabled
                            v.healthBar.Visible = esp.settings.healthbar.enabled
                            v.healthText.Visible = esp.settings.healthtext.enabled
                            v.distance.Visible = esp.settings.distance.enabled
                            v.viewAngle.Visible = esp.settings.viewangle.enabled
                            v.weapon.Visible = esp.settings.weapon.enabled
                        else
                            v.name.Visible = false
                            v.boxOutline.Visible = false
                            v.box.Visible = false
                            v.filledbox.Visible = false
                            v.healthBarOutline.Visible = false
                            v.healthBar.Visible = false
                            v.healthText.Visible = false
                            v.distance.Visible = false
                            v.viewAngle.Visible = false
                            v.weapon.Visible = false
                        end
                    end
                else
                    v.name.Visible = false
                    v.boxOutline.Visible = false
                    v.box.Visible = false
                    v.filledbox.Visible = false
                    v.healthBarOutline.Visible = false
                    v.healthBar.Visible = false
                    v.healthText.Visible = false
                    v.distance.Visible = false
                    v.viewAngle.Visible = false
                    v.weapon.Visible = false
                end
            else
                v.name.Visible = false
                v.boxOutline.Visible = false
                v.box.Visible = false
                v.filledbox.Visible = false
                v.healthBarOutline.Visible = false
                v.healthBar.Visible = false
                v.healthText.Visible = false
                v.distance.Visible = false
                v.viewAngle.Visible = false
                v.cham.Enabled = false
                v.weapon.Visible = false
            end
        end
    end)

    esp.Unload = function()
        ESP_Loop:Disconnect()
        ESP_Loop = nil
        
        for i,v in pairs(esp.players) do
            for i2, v2 in pairs(v) do
                if v2 == "cham" then
                    v2:Destroy()
                else
                    v2:Remove()
                end
            end
        end

        table.clear(esp)
        esp = nil
    end

    getgenv().esp = esp
 --// Visuals aka ESP
 local visualtabgroup = tabs.visuals:createGroup('left', 'Player')  
 do
    visualtabgroup:addToggle({text = "Enabled", flag = "esp_enabled", callback = function() esp.enabled = library.flags['esp_enabled'] end})
    visualtabgroup:addToggle({text = "Name", flag = "name_enabled", callback = function() esp.settings.name.enabled = library.flags['name_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "name_color", color = Color3.new(1,1,1), callback = function() esp.settings.name.color = library.flags['name_color'] end})
    visualtabgroup:addToggle({text = "Distance", flag = "distance_enabled", callback = function() esp.settings.distance.enabled = library.flags['distance_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "distance_color", color = Color3.new(1,1,1), callback = function() esp.settings.distance.color = library.flags['distance_color'] end})
    visualtabgroup:addToggle({text = "Weapon", flag = "weapon_enabled", callback = function() esp.settings.weapon.enabled = library.flags['weapon_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "weapon_color", color = Color3.new(1,1,1), callback = function() esp.settings.weapon.color = library.flags['weapon_color'] end})
    visualtabgroup:addToggle({text = "Health text", flag = "healtht_enabled", callback = function() esp.settings.healthtext.enabled = library.flags['healtht_enabled'] end})
    visualtabgroup:addToggle({text = "Health", flag = "health_enabled", callback = function() esp.settings.healthbar.enabled = library.flags['health_enabled'] end})
    visualtabgroup:addToggle({text = "Chams", flag = "chams_enabled", callback = function() esp.settings_chams.enabled = library.flags['chams_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "chams_color", color = Color3.new(1,1,1), callback = function() esp.settings_chams.fill_color = library.flags['chams_color'] end})
    visualtabgroup:addToggle({text = "Box", flag = "box_enabled", callback = function() esp.settings.box.enabled = library.flags['box_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "box_color", color = Color3.new(1,1,1), callback = function() esp.settings.box.color = library.flags['box_color'] end})
    visualtabgroup:addSlider({text = "Distance", min = 0, max = 10000, suffix = "m", float = 1, default = 5000, flag = "esp_distance",callback = function(Value)
        esp.maxdist = Value
    end})
 end
 --// Bot ESP
 repeat
    wait()
 until game:GetService("Workspace"):FindFirstChild("AiZones") and
    game:GetService("Workspace"):FindFirstChild("DroppedItems")

--Bot Esp
 function AddBotEsp(Path)
    local BotEsp = Drawing.new("Text")
    BotEsp.Visible = false
    BotEsp.Center = true
    BotEsp.Outline = true
    BotEsp.Font = 3
    BotEsp.Size = 10
    local BotEsp2 = Drawing.new("Text")
    BotEsp2.Visible = false
    BotEsp2.Center = true
    BotEsp2.Outline = true
    BotEsp2.Font = 3
    BotEsp2.Size = 10
    local BotEsp3 = Drawing.new("Text")
    BotEsp3.Visible = false
    BotEsp3.Center = true
    BotEsp3.Outline = true
    BotEsp3.Font = 3
    BotEsp3.Size = 10
    --local chamcham = esp.NewCham({FillColor = esp.customsettings.aichams.color, OutlineColor = Color3.new(0,0,0), FillTransparency = 0, OutlineTransparency = 1})
    local renderstepped
    renderstepped =
        game:GetService("RunService").RenderStepped:Connect(
        function()
            --[[if esp.customsettings.aichams.enabled then
                chamcham.Enabled = true
                if esp.customsettings.aichams.occluded then
                    chamcham.DepthMode = "Occluded"
                else
                    chamcham.DepthMode = "AlwaysOnTop"	
                end
                chamcham.FillColor = esp.customsettings.aichams.fill_color
                chamcham.OutlineColor = esp.customsettings.aichams.outline_color
                chamcham.OutlineTransparency = esp.customsettings.aichams.outline_transparency
                chamcham.FillTransparency = esp.customsettings.aichams.fill_transparency
            else
                chamcham.Enabled = false
            end]]
            if
                Path and (game:GetService("Workspace").AiZones:FindFirstChild(Path.Name, true)) and
                    Path:FindFirstChildOfClass("Humanoid") and
                    Path:FindFirstChildOfClass("Humanoid").Health > 0
             then
                --chamcham.Adornee = Path
                local meshpart = Path:FindFirstChildOfClass("MeshPart")
                if
                    esp.customsettings.enabled and esp.customsettings.ai.enabled and meshpart and
                        (esp.customsettings.maxdist == 0 or
                            (meshpart.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude <
                                esp.customsettings.maxdist)
                 then
                    BotEsp.Color = esp.customsettings.ai.color
                    BotEsp2.Color = esp.customsettings.aidistance.color
                    BotEsp3.Color = esp.customsettings.aihealth.color
                    BotEsp.Outline = esp.customsettings.ai.outline
                    BotEsp2.Outline = esp.customsettings.ai.outline
                    BotEsp3.Outline = esp.customsettings.ai.outline
                    BotEsp.Size = esp.customsettings.ai.size
                    BotEsp2.Size = esp.customsettings.ai.size
                    BotEsp3.Size = esp.customsettings.ai.size
                    local drop_pos, drop_onscreen =
                        game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(
                        Path:FindFirstChildOfClass("MeshPart").Position
                    )
                    if drop_onscreen then
                        BotEsp.Position = Vector2.new(drop_pos.X, drop_pos.Y)
                        BotEsp2.Position = Vector2.new(drop_pos.X, drop_pos.Y + esp.customsettings.ai.size)
                        BotEsp3.Position = Vector2.new(drop_pos.X, drop_pos.Y - esp.customsettings.ai.size)
                        BotEsp.Text = Path.Name
                        if esp.customsettings.aidistance.enabled then
                            if
                                game.Players.LocalPlayer.Character and
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                             then
                                BotEsp2.Text =
                                    math.round(
                                    (Path:FindFirstChildOfClass("MeshPart").Position -
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / 3
                                ) .. "m"
                            else
                                BotEsp2.Visible = false
                            end
                        else
                            BotEsp2.Visible = false
                        end
                        if esp.customsettings.aihealth.enabled then
                            BotEsp3.Text = tostring(math.round(Path:FindFirstChildOfClass("Humanoid").Health)) .. "%"
                            BotEsp3.Visible = true
                        else
                            BotEsp3.Visible = false
                        end
                        BotEsp.Visible = esp.customsettings.aidistance.enabled
                    else
                        BotEsp.Visible = false
                        BotEsp2.Visible = false
                        BotEsp3.Visible = false
                    end
                else
                    BotEsp.Visible = false
                    BotEsp2.Visible = false
                    BotEsp3.Visible = false
                end
            else
                BotEsp:Remove()
                BotEsp2:Remove()
                BotEsp3:Remove()
                --chamcham:Destroy()
                renderstepped:Disconnect()
            end
        end
    )
 end

 for i, v in pairs(game:GetService("Workspace").AiZones:GetDescendants()) do
    if v:FindFirstChild("Humanoid") then
        AddBotEsp(v)
    end
 end

 game:GetService("Workspace").AiZones.DescendantAdded:Connect(
    function(Child)
        wait(1)
        if Child:FindFirstChild("Humanoid") then
            AddBotEsp(Child)
        end
    end
)

--Corpse Esp
 function AddCorpseESP(Corpse)
    local CorpseEsp = Drawing.new("Text")
    CorpseEsp.Visible = false
    CorpseEsp.Center = true
    CorpseEsp.Outline = true
    CorpseEsp.Font = 3
    CorpseEsp.Size = 10
    local CorpseEsp2 = Drawing.new("Text")
    CorpseEsp2.Visible = false
    CorpseEsp2.Center = true
    CorpseEsp2.Outline = true
    CorpseEsp2.Font = 3
    CorpseEsp2.Size = 10
    --local chamcham = esp.NewCham({FillColor = esp.customsettings.corpsechams.color, OutlineColor = Color3.new(0,0,0), FillTransparency = 0, OutlineTransparency = 1})
    local renderstepped
    renderstepped =
        game:GetService("RunService").RenderStepped:Connect(
        function()
            --[[ if esp.customsettings.corpsechams.enabled then
                chamcham.Enabled = true
                if esp.customsettings.corpsechams.occluded then
                    chamcham.DepthMode = "Occluded"
                else
                    chamcham.DepthMode = "AlwaysOnTop"	
                end
                chamcham.FillColor = esp.customsettings.corpsechams.fill_color
                chamcham.OutlineColor = esp.customsettings.corpsechams.outline_color
                chamcham.OutlineTransparency = esp.customsettings.corpsechams.outline_transparency
                chamcham.FillTransparency = esp.customsettings.corpsechams.fill_transparency
            else
                chamcham.Enabled = false
            end]]
            if
                Corpse and workspace.DroppedItems:FindFirstChild(Corpse.Name) and
                    Corpse:FindFirstChildOfClass("Humanoid")
             then
                --chamcham.Adornee = Corpse
                local meshpart = Corpse:FindFirstChildOfClass("MeshPart")
                if
                    esp.customsettings.enabled and esp.customsettings.corpse.enabled and meshpart and
                        (esp.customsettings.maxdist == 0 or
                            (meshpart.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude <
                                esp.customsettings.maxdist)
                 then
                    CorpseEsp.Color = esp.customsettings.corpse.color
                    CorpseEsp2.Color = esp.customsettings.corpsedistance.color
                    CorpseEsp.Outline = esp.customsettings.corpse.outline
                    CorpseEsp2.Outline = esp.customsettings.corpse.outline
                    CorpseEsp.Size = esp.customsettings.corpse.size
                    CorpseEsp2.Size = esp.customsettings.corpse.size
                    local drop_pos, drop_onscreen =
                        game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(meshpart.Position)
                    if drop_onscreen then
                        CorpseEsp.Position = Vector2.new(drop_pos.X, drop_pos.Y)
                        CorpseEsp2.Position = Vector2.new(drop_pos.X, drop_pos.Y + esp.customsettings.corpse.size)
                        CorpseEsp.Text = Corpse.Name .. "'s " .. "corpse"
                        if esp.customsettings.corpsedistance.enabled then
                            if
                                game.Players.LocalPlayer.Character and
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                             then
                                CorpseEsp2.Text =
                                    math.round(
                                    (meshpart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude /
                                        3
                                ) .. "m"
                                CorpseEsp2.Visible = true
                            else
                                CorpseEsp2.Visible = false
                            end
                        end
                        CorpseEsp.Visible = esp.customsettings.corpsedistance.enabled
                    else
                        CorpseEsp.Visible = false
                        CorpseEsp2.Visible = false
                    end
                else
                    CorpseEsp.Visible = false
                    CorpseEsp2.Visible = false
                end
            else
                CorpseEsp.Visible = false
                CorpseEsp:Remove()
                CorpseEsp2:Remove()
                --chamcham:Destroy()
                renderstepped:Disconnect()
            end
        end
    )
 end

 for _, v in next, workspace.DroppedItems:GetChildren() do
    if v:FindFirstChildOfClass("Humanoid") then
        AddCorpseESP(v)
    end
 end

 workspace.DroppedItems.DescendantAdded:Connect(
    function(Child)
        wait(1)
        if Child:FindFirstChildOfClass("Humanoid") then
            AddCorpseESP(Child)
        end
    end
)

--Extract Esp
 function AddExtractEsp(Extract)
    local ExtractEsp = Drawing.new("Text")
    ExtractEsp.Visible = false
    ExtractEsp.Center = true
    ExtractEsp.Outline = true
    ExtractEsp.Font = 3
    ExtractEsp.Size = 10
    local ExtractEsp2 = Drawing.new("Text")
    ExtractEsp2.Visible = false
    ExtractEsp2.Center = true
    ExtractEsp2.Outline = true
    ExtractEsp2.Font = 3
    ExtractEsp2.Size = 10
    local renderstepped
    renderstepped =
        game:GetService("RunService").RenderStepped:Connect(
        function()
            if Extract then
                if
                    esp.customsettings.enabled and esp.customsettings.extract.enabled and
                        (esp.customsettings.maxdist == 0 or
                            (Extract.Position - localplayer.Character.HumanoidRootPart.Position).Magnitude <
                                esp.customsettings.maxdist)
                 then
                    ExtractEsp.Color = esp.customsettings.extract.color
                    ExtractEsp2.Color = esp.customsettings.extractdistance.color
                    ExtractEsp.Outline = esp.customsettings.extract.outline
                    ExtractEsp2.Outline = esp.customsettings.extract.outline
                    ExtractEsp.Size = esp.customsettings.extract.size
                    ExtractEsp2.Size = esp.customsettings.extract.size
                    local Extract_pos, Extract_onscreen =
                        game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(Extract.Position)
                    if Extract_onscreen then
                        ExtractEsp.Position = Vector2.new(Extract_pos.X, Extract_pos.Y)
                        ExtractEsp2.Position =
                            Vector2.new(Extract_pos.X, Extract_pos.Y + esp.customsettings.extract.size)
                        ExtractEsp.Text = "exit"
                        if esp.customsettings.extractdistance.enabled then
                            if
                                game.Players.LocalPlayer.Character and
                                    game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                             then
                                ExtractEsp2.Text =
                                    math.round(
                                    (Extract.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude /
                                        3
                                ) .. "m"
                                ExtractEsp2.Visible = true
                            else
                                ExtractEsp2.Visible = false
                            end
                        else
                            esp.customsettings.extractdistance.enabled = false
                        end
                        ExtractEsp.Visible = true
                    else
                        ExtractEsp.Visible = false
                        ExtractEsp2.Visible = false
                    end
                else
                    ExtractEsp.Visible = false
                    ExtractEsp2.Visible = false
                end
            else
                ExtractEsp:Remove()
                ExtractEsp2:Remove()
                renderstepped:Disconnect()
            end
        end
    )
 end
 if workspace.NoCollision:FindFirstChild("ExitLocations") then
    for _, v in next, workspace.NoCollision.ExitLocations:GetChildren() do
        AddExtractEsp(v)
    end

    workspace.NoCollision.ExitLocations.DescendantAdded:Connect(
        function(Child)
            wait(1)
            AddExtractEsp(Child)
        end
    )
 end


 local visualtabgroup2 = tabs.visuals:createGroup('center', 'Extra')
 do
    visualtabgroup2:addToggle({text = "Enabled", flag = "esp_enabled", callback = function() esp.customsettings.enabled = library.flags['esp_enabled'] end})
    visualtabgroup2:addToggle({text = "Corpse", flag = "corpse_enabled", callback = function() esp.customsettings.corpse.enabled = library.flags['corpse_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "corpse_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.corpse.enabled = library.flags['corpse_color'] end})
    visualtabgroup2:addToggle({text = "Corpse Distance", flag = "corpsedis_enabled", callback = function() esp.customsettings.corpsedistance.enabled = library.flags['corpsedis_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "corpsedis_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.corpsedistance.enabled = library.flags['corpsedis_color'] end})
    visualtabgroup2:addToggle({text = "Bot", flag = "bot_enabled", callback = function() esp.customsettings.ai.enabled = library.flags['bot_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "bot_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.ai.enabled = library.flags['bot_color'] end})
    visualtabgroup2:addToggle({text = "Bot Distance", flag = "botdis_enabled", callback = function() esp.customsettings.aidistance.enabled = library.flags['botdis_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "botdis_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.aidistance.enabled = library.flags['botdis_color'] end})
    visualtabgroup2:addToggle({text = "Bot Health", flag = "bothealth_enabled", callback = function() esp.customsettings.aihealth.enabled = library.flags['bothealth_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "bothealth_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.aihealth.enabled = library.flags['bothealth_color'] end})
    visualtabgroup2:addToggle({text = "Extract", flag = "ext_enabled", callback = function() esp.customsettings.extract.enabled = library.flags['ext_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "ext_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.extract.enabled = library.flags['ext_color'] end})
    visualtabgroup2:addToggle({text = "Extract Distance", flag = "extd_enabled", callback = function() esp.customsettings.extractdistance.enabled = library.flags['extd_enabled'] end}):addColorpicker({text = 'Color', ontop = true, flag = "extd_color", color = Color3.new(1,1,1), callback = function() esp.customsettings.extractdistance.enabled = library.flags['extd_color'] end})
    visualtabgroup2:addSlider({text = "Distance", min = 0, max = 10000, suffix = "m", float = 1, default = 5000, flag = "esp_distance",callback = function(Value)
        esp.customsettings.maxdist = Value
    end})
 end

 --// Miscellanous
 local misctabgroup = tabs.misc:createGroup('left', 'World')
 local misctabgroup1 = tabs.misc:createGroup('center', 'Local Player')
 local misctabgroup2 = tabs.misc:createGroup('right', 'IDK EXTRA?')

 do
 --// World
    misctabgroup:addToggle({text = "fullbright", callback = function(Value)
        if Value then
            lighting.Ambient = Color3.new(1, 1, 1)
            lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
            lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        else
            lighting.Ambient = Color3.new(0, 0, 0)
            lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
            lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        end
    end})
    misctabgroup:addToggle({text = "ambient",flags = "ambient", callback = function()
    end}):addColorpicker({text = 'Color', ontop = true, flag = "ambient_color", color = Color3.new(1,0,0), callback = function(Value)
    end})
    misctabgroup:addToggle({text = "remove visor", callback = function(Value)
        while Value do task.wait(0.1)
        local pg = localplayer.PlayerGui
            if pg and pg:FindFirstChild("MainGui") and pg.MainGui:FindFirstChild("MainFrame") and pg.MainGui.MainFrame:FindFirstChild("ScreenEffects") then
                for i,v in ipairs(localplayer.PlayerGui.MainGui.MainFrame.ScreenEffects:GetChildren()) do
                    if v:IsA("Frame") then
                        v.Visible = false
                    end
                end
            end
        end
    end})
    misctabgroup:addToggle({text = "remove grass", callback = function(Value)
        sethiddenproperty(Workspace.Terrain, "Decoration", not Value)
    end})
    misctabgroup:addToggle({text = "remove shadows", callback = function(Value)
        if Value then
            lighting.GlobalShadows = false
        else
            lighting.GlobalShadows = true
        end
    end})
    misctabgroup:addToggle({text = "remove fog", callback = function(Value)
        while Value do task.wait()
            lighting.Atmosphere.Density = 0
            lighting.Atmosphere.Offset = 0
        end
    end})
    misctabgroup:addToggle({text = "remove clouds", callback = function(Value)
        while Value do task.wait()
            game:GetService("Workspace").Terrain.Clouds.Density = 0
        end
    end})
    misctabgroup:addToggle({text = "remove trees/grass", callback = function(Value)
        if Value then
            while Value do task.wait(5)
                if not workspace:FindFirstChild("SpawnerZones") or not workspace.SpawnerZones:FindFirstChild("Foliage") then return end
                if Value == false then continue end
                for i,v in ipairs(workspace.SpawnerZones.Foliage:GetChildren()) do
                    for _,f in ipairs(v:GetChildren()) do
                        for _,s in ipairs(f:GetChildren()) do
                            if s:IsA("MeshPart") and s.Transparency == 0 then
                                if s.Color == Color3.fromRGB(163, 162, 165) then
                                    s.Transparency = 1
                                end
                            end 
                        end
                    end
                end
            end
        elseif not Value then
            if not workspace:FindFirstChild("SpawnerZones") or not workspace.SpawnerZones:FindFirstChild("Foliage") then return end
            for i,v in ipairs(workspace.SpawnerZones.Foliage:GetChildren()) do
                for _,f in ipairs(v:GetChildren()) do
                    for _,s in ipairs(f:GetChildren()) do
                        if s:IsA("MeshPart") then
                            if s.Color == Color3.fromRGB(163, 162, 165) and s.Transparency == 1 then
                                s.Transparency = 0
                            end
                        end 
                    end
                end
            end
        end
    end})
    misctabgroup:addToggle({text = "walk on water", callback = function(Value)
        if Value then
            local WaterWalk = workspace:FindFirstChild("WaterWalk") or Instance.new("Folder", workspace); WaterWalk.Name = "WaterWalk"
            local character = localplayer.Character or localplayer.CharacterAdded:Wait()
            local part = character:FindFirstChild("Head")
            local rayparams = RaycastParams.new()
            rayparams.FilterType = Enum.RaycastFilterType.Exclude
        
            rayparams.FilterDescendantsInstances = {character}
        
            if not Value then
                for i,v in pairs(WaterWalk:GetChildren()) do
                    if v then v:Destroy() end
                end
                return
            end
        
            while Value do task.wait(0.1)
                if not Value or not character then continue end
                if camera:FindFirstChild("ViewModel") then
                    rayparams.FilterDescendantsInstances = {character, camera.ViewModel}
                end
                local rayOrigin = part.Position + Vector3.new(0, 150, 0) + camera.CFrame.LookVector * 5
                local rayDirection = Vector3.new(0, -300, 0)
                local rayres = workspace:Raycast(rayOrigin, rayDirection, rayparams)
                if rayres and rayres.Material == Enum.Material.Water then
                    local platform = Instance.new("Part", WaterWalk) platform.Size = Vector3.new(500,1,500); platform.Anchored = true; platform.CanQuery = false; platform.CanTouch = false
                    platform.Position = rayres.Position; platform.Material = Enum.Material.ForceField
                    task.wait(1)
                end
            end
        end
    end})
    misctabgroup:addToggle({text = "clocktime",flags = "clocktime", callback = function()
    end})
    misctabgroup:addSlider({text = "clocktime value:", min = 0, max = 24, suffix = "x", flag = "clocktime_value", float = 0.1, default = 0, callback = function(Value)
    end})
    misctabgroup:addList({text = "skybox:",multiselect = false,values = { "Standard", "Among Us", "Doge", "Spongebob", "Deep Space", "Winter", "Clouded Sky" }, flag = "skybox", callback = function(Value)
        value = Value
    end})



    --// Local Player
    misctabgroup1:addToggle({text = "among us :)",risky = true, callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.UpdateTilt:FireServer(Value and 0/0 or 0)
    end})
    misctabgroup1:addToggle({text = "spin", risky = true, flag = 'spin_toggle', callback = function()end})
    misctabgroup1:addToggle({text = "walkspeed", risky = true, flag = 'walkspeed_toggle', callback = function()
        local hum = localplayer.Character and localplayer.Character:FindFirstChildWhichIsA("Humanoid")
            while library.flags['walkspeed_toggle'] do task.wait()
                local delta = runservice.Heartbeat:Wait()
                if hum.MoveDirection.Magnitude > 0 then
                localplayer.Character:TranslateBy(hum.MoveDirection * library.flags['walkspeed_value'] * delta * 10)
            end
        end
    end})
    misctabgroup1:addToggle({text = "bhop",risky = true, callback = function(Value)
		if Value then
			local function startBunnyHop()
				spawn(function()
					while Value do
						if localplayer.Character and localplayer.Character:FindFirstChildWhichIsA("Humanoid") then
							localplayer.Character.Humanoid:SetAttribute("JumpCooldown", 0)
						end
						task.wait(0.1)
					end
				end)
			end
			startBunnyHop()
		end
    end})
    misctabgroup1:addSlider({text = "spin value:", min = 0, max = 100, suffix = "x", flag = "spin_value", float = 0.1, default = 0, callback = function()end})
    misctabgroup1:addSlider({text = "walkspeed value:", min = 0, max = 2, suffix = "x", flag = "walkspeed_value", float = 0.1, default = 1, callback = function()
    end})
    --// Extra Shit idk
    misctabgroup2:addSlider({text = "fov value:", min = 0, max = 120, suffix = "x", flag = "fov value", float = 0.1, default = 90, callback = function()
        if replicatestorage.Players and replicatestorage.Players:FindFirstChild(localplayer.Name) and replicatestorage.Players:FindFirstChild(localplayer.Name).Settings then
            local settings = replicatestorage.Players:FindFirstChild(localplayer.Name).Settings
            settings.GameplaySettings:SetAttribute("DefaultFOV", library.flags['fov value'])
        end
    end})

    misctabgroup2:addSlider({text = "ads value:", min = 0, max = 30, suffix = "x", flag = "ads_value", float = 0.1, default = 5, callback = function(Value)
    end})
 end

 --// Spin
 local function ToYRotation(_CFrame)
	local _, Y, _ = _CFrame:ToOrientation()
	return CFrame.new(_CFrame.Position) * CFrame.Angles(0, Y, 0)
 end
 local OriginalAutoRotate = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Humanoid") and
 localplayer.Character:FindFirstChildOfClass("Humanoid").AutoRotate or true

 function functions:spin()
    camera = game:GetService("Workspace").CurrentCamera
	
	local SelfCharacter = localplayer.Character
	local SelfRootPart, SelfHumanoid = SelfCharacter and SelfCharacter:FindFirstChild("HumanoidRootPart"),
		SelfCharacter and SelfCharacter:FindFirstChildOfClass("Humanoid")
	if library.flags['spin_toggle'] then
		if SelfCharacter and SelfRootPart and SelfHumanoid then
			SelfHumanoid.AutoRotate = false
			local Angle = -math.atan2(camera.CFrame.LookVector.Z, camera.CFrame.LookVector.X) +
				tick() * library.flags['spin_value'] % 360
			SelfRootPart.CFrame = ToYRotation(CFrame.new(SelfRootPart.Position) * CFrame.Angles(0, Angle, 0))
		end
	else
		if SelfCharacter and SelfRootPart and SelfHumanoid then
			SelfHumanoid.AutoRotate = OriginalAutoRotate
		end
	end
 end

 --// Viewmodel Changer :/
 local function chams_pos(vm) -- pasted but cool idc, supports solara tho.
    if not vm then return end
    if library.flags["viewmodel_toggle"] then
    repeat task.wait() until vm.Name == "ViewModel"
    local HumanoidRootPart = vm:FindFirstChild("HumanoidRootPart")
    local Position = Vector3.new(library.flags["viewmodel_x"], library.flags["viewmodel_y"], library.flags["viewmodel_z"])
    local LeftArm = HumanoidRootPart:FindFirstChild("LeftUpperArm")
    local RightArm = HumanoidRootPart:FindFirstChild("RightUpperArm")
    local Item = HumanoidRootPart:FindFirstChild("ItemRoot")
    if LeftArm and RightArm and Item then
        LeftArm.C0 = LeftArm.C0 + Position
        RightArm.C0 = RightArm.C0 + Position
        Item.C0 = Item.C0 + Position
        end
    end
 end
 camera.ChildAdded:Connect(chams_pos)

 --// Prediction Function
 function functions:MovementPrediction(Origin, Destination, DestinationVelocity, ProjectileSpeed)
    local Distance = (Destination - Origin).Magnitude
    local TimeToHit = (Distance / ProjectileSpeed)
    local Predicted = Destination + DestinationVelocity * TimeToHit
    local Delta = (Predicted - Origin).Magnitude / ProjectileSpeed
    
    ProjectileSpeed = ProjectileSpeed - 0.013 * ProjectileSpeed ^ 2 * TimeToHit ^ 2
    TimeToHit += (Delta / ProjectileSpeed);

    local Actual = Destination + DestinationVelocity * TimeToHit
    return Actual
 end

 --// BulletDrop prediction
 function functions:Trajectory(Origin, Destination, ProjectileSpeed, ProjectileDrop)
    local Distance = (Destination - Origin).Magnitude
    local TimeToHit = (Distance / ProjectileSpeed)
    local ProperSpeed = ProjectileSpeed - 0.013 * ProjectileSpeed ^ 2 * TimeToHit ^ 2
    TimeToHit += (Distance / ProperSpeed)
    
    local DropTime = ProjectileDrop * TimeToHit ^ 2
    if tostring(DropTime):find("nan") or (Distance <= 100) then
        return 0 
    end
    return DropTime;
end

--// Silent aim
function functions:silentaim()
    if functions:TargetPlayer() and enables.main.silent then task.wait()
        if functions:TargetPlayer() and camera:FindFirstChild("ViewModel") then
            local MuzzleReal = nil
            local Status = game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name]:FindFirstChild("Status")
            if Status then
                local EquippedTool = Status.GameplayVariables.EquippedTool.Value
                if EquippedTool then
                    local GunName = game.ReplicatedStorage.Players[game.Players.LocalPlayer.Name].Inventory:FindFirstChild(tostring(EquippedTool))
                    if GunName then
                        local Gun = (GunName.Attachments:FindFirstChild("Magazine") and (GunName.Attachments:FindFirstChild("Magazine")):FindFirstChildOfClass("StringValue") and (((GunName.Attachments:FindFirstChild("Magazine")):FindFirstChildOfClass("StringValue")):FindFirstChild("ItemProperties")).LoadedAmmo) or GunName.ItemProperties:FindFirstChild("LoadedAmmo")
                        if Gun then
                            local IDK = Gun:FindFirstChild("1")
                            if IDK then
                                MuzzleReal = game.ReplicatedStorage.AmmoTypes[IDK:GetAttribute("AmmoType")]:GetAttribute("MuzzleVelocity")
                            end
                        end
                    end
                end
            end
            local Origin = camera.CFrame.p
            local Distination = functions:TargetPlayer().Position
            local Velocity = functions:TargetPlayer().Velocity
            local ViewModel = camera:FindFirstChild("ViewModel")
            local AimPart = ViewModel:FindFirstChild("AimPart")
            local AimPartCanted = ViewModel:FindFirstChild("AimPartCanted")
            local FakeCamera = ViewModel:FindFirstChild("FakeCamera")

            if AimPart --[[and AimPartCanted]] and FakeCamera then
                if enables.main.prediction then
                    Distination = functions:MovementPrediction(Origin, Distination, Velocity, MuzzleReal)
                end
                -- if enables.main.bprediction then
                --     Distination = Vector3.new(Distination.X, Distination.Y + functions:Trajectory(Origin, Distination, bulletSpeed, bulletDrop), Distination.Z);
                -- end
                AimPart.CFrame = CFrame.new(Origin, Distination)
                -- AimPartCanted.CFrame = CFrame.new(Origin, Distination)
            end
        end
    end
 end

 --// Arm & Gun Chams

 local function wrap(f) coroutine.resume(coroutine.create(f)) end
 wrap(function()
    while task.wait(0.1) do
        local View = game:GetService("Workspace").Camera:FindFirstChild("ViewModel")
        if View ~= nil and View and library.flags['enable_chams'] then
            local ItemView = View:FindFirstChild("Item")
            if ItemView and library.flags['gun_chams'] then -- gun
                for _,v in pairs(ItemView:GetDescendants()) do
                    if v.ClassName == "MeshPart" or v.ClassName == "Part" then 
                        if v.Transparency ~= 1 then
                            v.Transparency = (library.flags.trans_gun)
                        end
                        if v.ClassName == "Part" then
                            v.Material  = (library.flags['gun_material'])
                            v.Color     = (library.flags['gun_color'])
                        end
                        if v.ClassName == "MeshPart" then
                            v.Material  = (library.flags['gun_material'])
                            v.Color     = (library.flags['gun_color'])
            
                            if tostring(library.flags['gun_material']) == "ForceField" then
                                v.TextureID = "rbxassetid://9305457875"
                            else
                                v.TextureID = ""
                            end
                        end
                    end
                    if v:FindFirstChildOfClass("SurfaceAppearance") then
                        v.SurfaceAppearance:Destroy()
                        end
                    end
                end
                for _,v in pairs(View:GetChildren()) do
                    if library.flags['arm_chams'] then -- hands
                        if v.ClassName == "Model" or v.Name == "WastelandShirt" or v.Name == "CamoShirt" or v.Name == "CivilianShirt" or v.Name == "GhillieTorso" or v.Name == "GorkaShirt" then
                            if string.find(v.Name, "LL") or string.find(v.Name, "RL") then
                                v.Material = (library.flags['arm_material']) -- hands mat
                                v.Color = (library.flags['arm_color']) -- hands color
                                v.Transparency = library.flags.trans_arm
                                if tostring(library.flags['arm_material']) == "ForceField" then
                                    v.TextureID = "rbxassetid://9305457875"
                                else
                                    v.TextureID = ""
                                end
                    elseif v.ClassName == "Model" and v.Name ~= "Item" then
                        for i, v in pairs(v:GetChildren()) do
                            if v:FindFirstChildOfClass("SurfaceAppearance") then
                                v:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
                            end
                                v.Material = (library.flags['arm_material'])
                                v.Color = (library.flags['arm_color'])
                                v.Transparency = library.flags.trans_arm
                                if tostring(library.flags['arm_material']) == "ForceField" then
                                    v.TextureID = "rbxassetid://9305457875"
                                else
                                    v.TextureID = ""
                                end

                for _,v in pairs(View:GetChildren()) do
                    if library.flags['cloth_chams'] then -- hands
                        if v.ClassName == "MeshPart" then
                            if string.find(v.Name, "Hand") or string.find(v.Name, "Arm") then
                                v.Material = (library.flags['cloth_material']) -- hands mat
                                v.Color = (library.flags['cloth_color']) -- hands color
                                v.Transparency = library.flags.trans_cloth
                                if tostring(library.flags['cloth_material']) == "ForceField" then
                                    v.TextureID = "rbxassetid://9305457875"
                                else
                                    v.TextureID = ""
                                end
                            elseif v.ClassName == "Model" and v.Name ~= "Item" then
                                for i, v in pairs(v:GetChildren()) do
                                    v.Material = (library.flags['cloth_material'])
                                    v.Color = (library.flags['cloth_color'])
                                    v.Transparency = library.flags.trans_cloth
                                    if tostring(library.flags['cloth_material']) == "ForceField" then
                                        v.TextureID = "rbxassetid://9305457875"
                                    else
                                        v.TextureID = ""
                                    end
                                end
                            end
                        end
                    end
                end
                if library.flags.highlight_chams then
                    local highlightchams = Instance.new("Highlight")
                    highlightchams.FillTransparency = 1
                    highlightchams.OutlineColor = library.flags.highlight_color
                    highlightchams.OutlineTransparency = 0
                    highlightchams.Parent = View
                end
            end
        end
    end
end
end
end
end
end)

 --// Loops & Heartbeats
 runservice.Heartbeat:Connect(function()
    --// Skybox
    for i, v in pairs(SkyBoxes[value]) do
        Sky[i] = v
    end
 end)

 --// Loop to Update!
 runservice.RenderStepped:Connect(function()
    --// Snapline
    if not Snapline then
        Snapline = Drawing.new('Line')
        Snapline.Visible = false
        Snapline.Thickness = 1
    end

    local pos
    if enables.cursor.CustomPos then
        pos = enables.cursor.Position
    else
        pos = Vector2.new(
            game.Players.LocalPlayer:GetMouse().X,
            game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y
        )
    end
    local targetCharacter = functions:TargetPlayer()

    if targetCharacter then
        local target = camera:WorldToViewportPoint(targetCharacter.Position)
        Snapline.From = pos
        Snapline.To = Vector2.new(target.X, target.Y)
        Snapline.Color = library.flags.snapline_color
        Snapline.Visible = library.flags.snapline
    else
        Snapline.Visible = false
    end
    --
    --// Ambient LOL EZ
    if library.flags.ambient then
        lighting.Ambient = library.flags.ambient_color
    else
        lighting.Ambient = Color3.new(0, 0, 0)
    end
    --// Nigger timeclock ticking lol ez
    if library.flags.clocktime then
        lighting.ClockTime = library.flags.clocktime_value
    end
    --// ads zoom
    if replicatestorage.Players and replicatestorage.Players:FindFirstChild(localplayer.Name) and replicatestorage.Players:FindFirstChild(localplayer.Name).Inventory then
        local plr = replicatestorage.Players:FindFirstChild(localplayer.Name)
        for i,v in plr:GetDescendants() do
            if v:FindFirstChild("ItemProperties") and GunTables[v.Name] then
                v.ItemProperties.Tool:SetAttribute("Zoom", library.flags.ads_value)
                v.ItemProperties.Tool:SetAttribute("ZoomSpeed", -15)
            end
        end
    end
    if enables.cursor.CustomPos then
        enables.cursor.Position = castgun()
    end

    --// Updates
    functions:TargetPlayer()
    functions:silentaim()
    functions:updateCircle()
    functions:VisibleCheck()
    functions:spin()
    --
 end)

 --// Configures
 local uisettings = tabs.settings:createGroup('left', 'Menu')
 
 --// Menu
     local Watermark = Instance.new("ScreenGui")
     Watermark.Name = "Watermark"
     Watermark.Parent = game.CoreGui
     Watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
     local Text = Instance.new("TextLabel")
     Text.Parent = Watermark
     Text.BackgroundColor3 = Color3.fromRGB(0,0,0)
     Text.TextColor3 = Color3.fromRGB(255, 255, 255)
     Text.BorderSizePixel = 0
     Text.AnchorPoint = Vector2.new(0.5, 0.5)
     Text.Position = UDim2.new(0.5, 0, 0.5, -450)
     Text.AutomaticSize = Enum.AutomaticSize.XY
     Text.Size = UDim2.new(0, 35, 0, 20)
     Text.RichText = true
     Text.Font = Enum.Font.Code
     Text.Visible = true
     Text.TextSize = 14
     local User = "Developer"
     local FPS = 0
     Text.Text = "nil"
 
     local RS = game:GetService("RunService")
 
     RS.RenderStepped:Connect(function()
         FPS = FPS + 1
     end)
 
     spawn(function()
         while wait(0.00000000000001) do
             local time = os.date('%X', os.time())
             local Ping = game:GetService('Stats') ~= nil and math.floor(game:GetService('Stats').Network.ServerStatsItem["Data Ping"]:GetValue())
             local fps = game:GetService('Stats').FrameRateManager:FindFirstChild('RenderAverage') and string.format('%.1f', 1000 / game:GetService('Stats').FrameRateManager.RenderAverage:GetValue())
             local date = os.date("%b. %d, %Y")
             Text.Text = " anti.solutions / uid: "..User.." / ping: "..Ping.." / fps: "..fps.." / time: "..time.." / date: "..date.." "
             FPS = 0
         end
     end)
 
     local Border = Instance.new("UIStroke")
     Border.Parent = Text
     Border.ApplyStrokeMode = "Border"
     Border.Color = Color3.new(1,1,1)
 
     local Gradient = Instance.new("UIGradient")
     Gradient.Parent = Border
     Gradient.Color = ColorSequence.new({
         ColorSequenceKeypoint.new(0, Color3.new(0.952941, 0.356863, 0.874510)),
         ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
     })
 
     spawn(function()
         while task.wait() do
             Gradient.Rotation = Gradient.Rotation + 1
         end
     end)
 --
 do
     uisettings:addToggle({text = "menu bind",default = true,flag = "menubind_toggle",callback = function(Value)
     end}):addKeybind({text = "menu bind",type = "toggle",key = Enum.KeyCode.End,flag = "menubindkeybind_toggle",callback = function(Value)
         library.keybind = Value
     end})
     
     uisettings:addToggle({text = "watermark",default = true,flag = "watermark_toggle",callback = function(Value)
         Text.Visible = Value
     end})
     uisettings:addToggle({text = "animated title",default = true,flag = "animated_text",callback = function(Value)
         library.AnimatedText = Value
     end})
     uisettings:addDivider()
     uisettings:addLabel({text = "Credits: @lksiwjas."})
     uisettings:addLabel({text = "Everything Created by @lksiwjas."})
     uisettings:addLabel({text = "Supports Solara WOWZERS"})
     uisettings:addLabel({text = "Best Solara script so far #2"})
     uisettings:addLabel({text = "but swimhub is #1 has a good instant hit :)"})


 end
 
 --
 local debugTab = tabs.settings:createGroup('center', 'Debug')
 
 --// Debug
 local debug_watermark = Drawing.new("Text")
 debug_watermark.Font, debug_watermark.Size, debug_watermark.Position, debug_watermark.Outline = 3, 12, Vector2.new(game.Workspace.CurrentCamera.ViewportSize.X * 0.005, game.Workspace.CurrentCamera.ViewportSize.Y * 0.12), true
 
 do
     debugTab:addToggle({text = "debug watermark",default = false,flag = "debugwatermark_toggle",callback = function(Value)
         enables.debug.enabled = Value
     end}):addColorpicker({text = "debug color",ontop = true,flag = "debug_accent",color = Color3.fromRGB(255, 255, 255),callback = function(Value)
         debug_watermark.Color = Value
     end})
     debugTab:addSlider({text = "speed:", min = 0, max = 3, suffix = "s", float = 0.1, default = 0, flag = "update_speed_slider",callback = function(Value)
         enables.debug.speed = Value
     end})
 end
 
 --
 local gameTab = tabs.settings:createGroup('center', 'Game')
 
 --// Game
 do
     gameTab:addSlider({text = "fps cap:", min = 0, max = 999, suffix = "fps", float = 1, default = 999, flag = "fpscap_slider",callback = function(Value)
         setfpscap(Value)
     end})
     gameTab:addButton({text = "copy join code",callback = function(Value)
         setclipboard(("game:GetService('TeleportService'):TeleportToPlaceInstance(%s, '%s')"):format(game.PlaceId, game.JobId))
         library:Notify("anti.solutions - succesfully copied join code!", 5)
     end})
     gameTab:addButton({text = "rejoin",callback = function(Value)
         game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)
         library:Notify("anti.solutions - succesfully rejoining server!", 5)
     end})
 end
 
 --// Debug Watermark
 task.spawn(function()
     while wait(enables.debug.speed) do
     local character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
     while not (character and character:FindFirstChild("HumanoidRootPart")) do wait(0.1) end
     local player = game.Players.LocalPlayer
     local playerCount = #game.Players:GetPlayers()
     local formattedMousePos = string.format("Mouse Position: X: %.2f, Y: %.2f", game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y)
     local formattedPosition = string.format("Player Position: X: %.2f, Y: %.2f, Z: %.2f", character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z)
     local fps = tostring(math.floor(1 / game:GetService("RunService").RenderStepped:Wait()))
     local memoryUsage = string.format("Memory Usage: %.2f MB", collectgarbage("count")/1024)
     debug_watermark.Text = "FPS: " .. fps .. "\nPlayers: " .. playerCount .. "\nTime: " .. os.date("%X") .. "\n" .. formattedMousePos .. "\n" .. formattedPosition .. "\n" .. memoryUsage
     debug_watermark.Visible = enables.debug.enabled
     end
 end)
 --
 
 --// Config
 local createconfigs = tabs.settings:createGroup('right', 'Config')
 do
    createconfigs:addTextbox({text = "name:",flag = "config_name"})
    createconfigs:addButton({text = "create",callback = library.createConfig})
    createconfigs:addConfigbox({flag = 'config_box',values = {}})
    createconfigs:addButton({text = "load",callback = library.loadConfig})
    createconfigs:addButton({text = "update",callback = library.saveConfig})
    createconfigs:addButton({text = "delete",callback = library.deleteConfig})
 end
 library:refreshConfigs()
 library:Notify("Loader : Access Successful!", 5)
 wait(0.1) library:Notify(string.format("Success: loaded in %.2fs", os.clock() - os_clock),20)

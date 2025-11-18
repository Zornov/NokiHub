local NokiHubUI = {}
NokiHubUI.__index = NokiHubUI

local function make(parent, className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props) do inst[k] = v end
    inst.Parent = parent
    return inst
end

function NokiHubUI.new(opts)
    opts = opts or {}
    local pg = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local gui = make(pg, "ScreenGui", {Name="NokiHubUI", ResetOnSpawn=false})

    local card = make(gui, "Frame", {
        Name="Card",
        AnchorPoint=Vector2.new(0,1),
        Position=UDim2.new(0,24,1,-120),
        Size=UDim2.fromOffset(360,190),
        BackgroundColor3=Color3.fromRGB(10,10,14),
        BorderSizePixel=0
    })

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,22)
    corner.Parent = card

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(35,35,42)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = card

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0,16)
    padding.PaddingBottom = UDim.new(0,16)
    padding.PaddingLeft = UDim.new(0,18)
    padding.PaddingRight = UDim.new(0,18)
    padding.Parent = card

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,6)
    layout.Parent = card

    local activeRow = make(card, "Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,18),
        LayoutOrder = 1
    })

    local activeLayout = Instance.new("UIListLayout")
    activeLayout.FillDirection = Enum.FillDirection.Horizontal
    activeLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    activeLayout.Padding = UDim.new(0,6)
    activeLayout.Parent = activeRow

    local activeColor = opts.ActiveColor or Color3.fromRGB(0,230,118)

    local activeDot = make(activeRow, "Frame", {
        Size = UDim2.fromOffset(8,8),
        BackgroundColor3 = activeColor,
        BorderSizePixel = 0
    })

    local adCorner = Instance.new("UICorner")
    adCorner.CornerRadius = UDim.new(1,0)
    adCorner.Parent = activeDot

    local activeText = make(activeRow, "TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0,80,1,0),
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = activeColor,
        Text = opts.ActiveText or "Active"
    })

    local title = make(card, "TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,30),
        Font = Enum.Font.GothamBlack,
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1,1,1),
        Text = opts.Title or "Noki Hub",
        LayoutOrder = 2
    })

    local subtitle = make(card, "TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,18),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(185,185,195),
        Text = opts.Subtitle or "Fruits Finder Script",
        LayoutOrder = 3
    })

    local section = make(card, "TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,0,20),
        Font = Enum.Font.GothamMedium,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(210,210,220),
        Text = opts.SectionText or "Current Status",
        LayoutOrder = 4
    })

    local pillFill = opts.PillFill or Color3.fromRGB(37,21,10)
    local pillBorder = opts.PillBorder or Color3.fromRGB(235,165,60)
    local dotColor = opts.StatusDotColor or Color3.fromRGB(255,190,90)

    local pill = make(card, "Frame", {
        Size = UDim2.new(1,0,0,36),
        BackgroundColor3 = pillFill,
        BorderSizePixel = 0,
        LayoutOrder = 5
    })

    local pillCorner = Instance.new("UICorner")
    pillCorner.CornerRadius = UDim.new(0,14)
    pillCorner.Parent = pill

    local pillStroke = Instance.new("UIStroke")
    pillStroke.Color = pillBorder
    pillStroke.Thickness = 2
    pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    pillStroke.Parent = pill

    local pillPadding = Instance.new("UIPadding")
    pillPadding.PaddingLeft = UDim.new(0,14)
    pillPadding.Parent = pill

    local pillLayout = Instance.new("UIListLayout")
    pillLayout.FillDirection = Enum.FillDirection.Horizontal
    pillLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    pillLayout.Padding = UDim.new(0,8)
    pillLayout.Parent = pill

    local statusDot = make(pill, "Frame", {
        Size = UDim2.fromOffset(8,8),
        BackgroundColor3 = dotColor,
        BorderSizePixel = 0
    })

    local sdCorner = Instance.new("UICorner")
    sdCorner.CornerRadius = UDim.new(1,0)
    sdCorner.Parent = statusDot

    local statusText = make(pill, "TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,-40,1,0),
        Font = Enum.Font.GothamMedium,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1,1,1),
        Text = opts.StatusText or ""
    })

    local self = setmetatable({
        Gui = gui,
        Card = card,
        TitleLabel = title,
        SubtitleLabel = subtitle,
        SectionLabel = section,
        ActiveDot = activeDot,
        ActiveText = activeText,
        Pill = pill,
        PillStroke = pillStroke,
        StatusDot = statusDot,
        StatusText = statusText,
    }, NokiHubUI)

    return self
end

function NokiHubUI:SetTitle(t) self.TitleLabel.Text = t end
function NokiHubUI:SetSubtitle(t) self.SubtitleLabel.Text = t end
function NokiHubUI:SetSection(t) self.SectionLabel.Text = t end

function NokiHubUI:SetActiveText(t)
    self.ActiveText.Text = t
end

function NokiHubUI:SetActiveColor(c)
    self.ActiveDot.BackgroundColor3 = c
    self.ActiveText.TextColor3 = c
end

function NokiHubUI:SetStatus(text, colors)
    if text then self.StatusText.Text = text end
    if colors then
        if colors.Dot then self.StatusDot.BackgroundColor3 = colors.Dot end
        if colors.Fill then self.Pill.BackgroundColor3 = colors.Fill end
        if colors.Border then self.PillStroke.Color = colors.Border end
    end
end

return NokiHubUI

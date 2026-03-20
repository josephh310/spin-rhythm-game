local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Selection = require(script.Parent.Selection)
local Stylesheet = require(ReplicatedFirst.Client.Interface.Stylesheet)
local Vide = require(ReplicatedStorage.Packages.Vide)

local Create = Vide.create
local Source = Vide.source
local Derive = Vide.derive
local Spring = Vide.spring

local SPRING_PERIOD = 0.2
local SPRING_DAMPING_RATIO = 0.7
local CONTENT_SIZE = UDim2.fromScale(0.8, 0.8)
local HOVER_CONTENT_SIZE = UDim2.fromScale(0.75, 0.75)

return function(Props: {
    Size: UDim2,
    Position: UDim2,
    OnClick: () -> (),
    Children: {[any]: any},
    ContentPadding: UDim,
})
    local HoveredState = Source(false)
    local DerivedBackgroundColor = Derive(function() if HoveredState() then return Stylesheet.Dark() else return Stylesheet.Yellow() end end)
    local DerivedContentColor = Derive(function() if HoveredState() then return Stylesheet.Yellow() else return Stylesheet.Dark() end end)
    local DerivedContentSize = Derive(function() if HoveredState() then return HOVER_CONTENT_SIZE else return CONTENT_SIZE end end)
    local BackgroundColorSpring = Spring(DerivedBackgroundColor, SPRING_PERIOD, SPRING_DAMPING_RATIO)
    local ContentColorSpring = Spring(DerivedContentColor, SPRING_PERIOD, SPRING_DAMPING_RATIO)
    local ContentSizeSpring = Spring(DerivedContentSize, SPRING_PERIOD, SPRING_DAMPING_RATIO)

    return Create "TextButton" {
        -- Properties
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = Props.Size,
        Position = Props.Position,
        BackgroundColor3 = BackgroundColorSpring,

        -- Events
        MouseEnter = function() HoveredState(true) end,
        MouseLeave = function() HoveredState(false) end,
        Activated = Props.OnClick,

        -- Children
        Create "UICorner" {
            CornerRadius = Stylesheet.CornerRadius,
        },

        Create "CanvasGroup" {
            -- Properties
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = ContentSizeSpring,
            BackgroundTransparency = 1,
            GroupColor3 = ContentColorSpring,

            -- Children
            Create "UIListLayout" {
                Padding = Props.ContentPadding,
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            },
            -- ...
            Props.Children
        },

        Selection {
            Hovered = HoveredState,
        },
    }
end

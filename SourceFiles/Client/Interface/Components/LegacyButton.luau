local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)

local Create = Vide.create
local Source = Vide.source
local Spring = Vide.spring

return function(Props: {
	Size: UDim2, -- Size of the button
	Position: UDim2, -- Position of the button
	Text: string, -- Text to display on the button
	Activated: () -> (), -- Callback function when the button is activated
	ClickedSize: number, -- Multiplier applied to size when clicked
	Period: number, -- Period for the spring animation
	DampingRatio: number, -- Damping ratio for the spring animation
})
	local ClickedSize = UDim2.new(
		Props.Size.X.Scale * Props.ClickedSize,
		Props.Size.X.Offset * Props.ClickedSize,
		Props.Size.Y.Scale * Props.ClickedSize,
		Props.Size.Y.Offset * Props.ClickedSize
	)

	local SizeSource = Source(Props.Size)
	local SizeSpring = Spring(SizeSource, Props.Period, Props.DampingRatio)

	return Create "TextButton" {
		BackgroundColor3 = Color3.fromRGB(50, 50, 50),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		AnchorPoint = Vector2.new(0.5, 0.5),

		Size = SizeSpring,
		Position = Props.Position,
		Text = Props.Text,
		Activated = Props.Activated,

		MouseButton1Down = function() SizeSource(ClickedSize) end,
		MouseButton1Up = function() SizeSource(Props.Size) end,

		Create "UICorner" {
			CornerRadius = UDim.new(0, 5),
		}
	}
end

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Stylesheet = require(ReplicatedFirst.Client.Interface.Stylesheet)
local Vide = require(ReplicatedStorage.Packages.Vide)

local Create = Vide.create
local Source = Vide.source
local Derive = Vide.derive
local Spring = Vide.spring
local Cleanup = Vide.cleanup

local INDICATOR_PADDING = 10
local SHIMMER_SPREAD = 0.3
local SHIMMER_PERIOD = 0.35
local SHIMMER_DAMPING = 5

return function(Props: {
	Hovered: () -> boolean,
})
	local MousePosition = Source(UserInputService:GetMouseLocation())
	local FrameRef = Source(nil :: Frame?)

	local InputConnection = UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement then
			MousePosition(Vector2.new(Input.Position.X, Input.Position.Y))
		end
	end)

	Cleanup(InputConnection)

	local GradientRotation = Derive(function()
		local Frame = FrameRef()
		if not Frame then
			return 0
		end

		local Mouse = MousePosition()
		local Center = Frame.AbsolutePosition + Frame.AbsoluteSize / 2
		local Delta = Mouse - Center

		return math.deg(math.atan2(Delta.Y, Delta.X))
	end)

	local SmoothedRotation = Spring(GradientRotation, SHIMMER_PERIOD, SHIMMER_DAMPING)

	local ShimmerTransparency = Derive(function()
		if not Props.Hovered() then
			return NumberSequence.new(1)
		end

		return NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5 - SHIMMER_SPREAD, 0.85),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(0.5 + SHIMMER_SPREAD, 0.85),
			NumberSequenceKeypoint.new(1, 1),
		})
	end)

	FrameRef(Create "Frame" {
		-- Properties
		Size = UDim2.new(1, INDICATOR_PADDING, 1, INDICATOR_PADDING),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Transparency = 1,

		-- Children
		Create "UICorner" {
			CornerRadius = Stylesheet.CornerRadius,
		},

		Create "UIStroke" {
			-- Properties
			Color = Color3.fromRGB(255, 255, 255),
			StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize,
			Transparency = 0,
			Thickness = 0.1,

			-- Children
			Create "UIGradient" {
				Rotation = SmoothedRotation,
				Transparency = ShimmerTransparency,
			},
		},
	})

	return FrameRef()
end

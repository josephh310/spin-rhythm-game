local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Button = require(ReplicatedFirst.Client.Interface.Components.Button)
local Vide = require(ReplicatedStorage.Packages.Vide)
local Create = Vide.create

return {
	vide = Vide,
	story = function()
		return Create "Frame" {
			-- Properties
			Size = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),

			-- Children
			Button {
				Size = UDim2.fromScale(0.5, 0.2),
				Position = UDim2.fromScale(0.5, 0.5),
				Text = "Click me",
				ClickedSize = 0.9,
				Period = 0.1,
				DampingRatio = 0.7,
				Activated = function()
					print("Button clicked!")
				end,
			}
		}
	end
}

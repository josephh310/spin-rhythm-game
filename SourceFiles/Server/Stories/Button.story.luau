local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Button = require(ReplicatedFirst.Client.Interface.Components.Button)
local Vide = require(ReplicatedStorage.Packages.Vide)
local Create = Vide.create

local function ButtonClicked()
    print("Button clicked!")
end

local function RenderButton()
   	return Button {
   		Size = UDim2.fromScale(0.75, 0.2),
   		Position = UDim2.fromScale(0.5, 0.5),
   		ContentPadding = UDim.new(0, 4),
   		OnClick = ButtonClicked,
   		Children = {
   			Create "ImageLabel" {
   				BackgroundTransparency = 1,
   				Image = "rbxassetid://8215093320",
   				Size = UDim2.fromScale(1, 1),
   				LayoutOrder = 1,
   				Vide.create "UIAspectRatioConstraint" {
   					AspectRatio = 1,
   				},
   			},
   			Create "TextLabel" {
   				Text = "Click me!",
   				Font = Enum.Font.GothamBold,
   				TextScaled = true,
   				TextColor3 = Color3.new(1, 1, 1),
   				BackgroundTransparency = 1,
   				Size = UDim2.fromScale(0.8, 1),
   				LayoutOrder = 2,
   			},
   		}
   	}
end

return {
	vide = Vide,
	story = RenderButton
}

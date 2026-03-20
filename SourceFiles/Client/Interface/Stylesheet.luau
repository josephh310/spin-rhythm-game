local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Source = Vide.source

return {
    Dark = Source(Color3.fromRGB(10, 10, 18)),
    Yellow = Source(Color3.fromRGB(255, 213, 36)),
    CornerRadius = Source(UDim.new(0.5, 0)),
}

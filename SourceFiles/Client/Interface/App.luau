local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local App = {
	Unmount = nil :: () -> ()?
}

local Create = Vide.create
local Mount = Vide.mount
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function App.Render()
	return Create "ScreenGui" {
		Name = "Interface",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
	}
end

function App.Init()
	App.Unmount = Mount(App.Render, PlayerGui)
end

return App

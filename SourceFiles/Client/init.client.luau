if not game:IsLoaded() then
	game.Loaded:Wait()
end

local App = require(script.Interface.App)
App.Init()

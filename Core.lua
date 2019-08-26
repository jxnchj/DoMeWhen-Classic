DMW = LibStub("AceAddon-3.0"):NewAddon("DMW", "AceConsole-3.0")
local DMW = DMW
DMW.Tables = {}
DMW.Enums = {}
DMW.Functions = {}
DMW.Rotations = {}
DMW.Player = {}
DMW.UI = {}
DMW.Settings = {}
DMW.Helpers = {}
DMW.Pulses = 0
local Initialized = false

local function FindRotation()
    if DMW.Rotations[DMW.Player.Class] and DMW.Rotations[DMW.Player.Class].Rotation then
        DMW.Player.Rotation = DMW.Rotations[DMW.Player.Class].Rotation
    end
end

local function Init()
    DMW.InitSettings()
    DMW.UI.Init()
    DMW.UI.HUD.Init()
    DMW.Player = DMW.Classes.LocalPlayer(ObjectPointer("player"))
    DMW.UI.InitQueue()
    Initialized = true
end

local f = CreateFrame("Frame", "DoMeWhen", UIParent)
f:SetScript(
    "OnUpdate",
    function(self, elapsed)
        DMW.Time = GetTime()
        DMW.Pulses = DMW.Pulses + 1
        if EWT ~= nil then
            if not Initialized then
                Init()
            end
            DMW.UpdateOM()
            DMW.Helpers.Quest()
            if not DMW.Player.Rotation then
                FindRotation()
                return
            else
                if DMW.Helpers.Queue.Run() then
                    return
                end
                DMW.Player.Rotation()
                if not DMW.UI.HUD.Loaded then
                    DMW.UI.HUD.Load()
                end
            end
        end
    end
)

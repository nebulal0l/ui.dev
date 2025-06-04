-- 

local uidev = loadstring(game:HttpGet("https://raw.githubusercontent.com/nebulal0l/ui.dev/refs/heads/main/ui.dev.lua?v=" .. tick()))() -- Load the latest library version

local UI = uidev:CreateWindow({ 
   Title = "ui.dev example",
   Size = UDim2.new(0, 500, 0, 350),
   Draggable = true
}) -- create the window

-- Create tabs
local MainTab = UI:CreateTab({
   Name = "Main",
   Icon = "⭐"
}) -- this is required to create a tab.

local SettingsTab = UI:CreateTab({
   Name = "Settings", 
   Icon = "🔧"
})

-- Add elements to MainTab
MainTab:AddButton({
   Name = "Button",
   Callback = function()
       print("Button clicked!")
   end
})

MainTab:AddToggle({
   Name = "Toggle",
   Default = false,
   Callback = function(value)
       print("Toggle: " .. tostring(value))
   end
})

MainTab:AddSlider({
   Name = "Walk Speed",
   Min = 16,
   Max = 100,
   Default = 16,
   Callback = function(value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
   end
})

MainTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 100,
    Default = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
 })

MainTab:AddInput({
   Name = "Input",
   Placeholder = "Enter text...",
   Callback = function(text)
       print("Input: " .. text)
   end
})

MainTab:AddLabel({
   Text = "Status: Ready",
   Color = Color3.fromRGB(46, 204, 113)
})

-- Add elements to SettingsTab
SettingsTab:AddInput({
    Name = "Change the title.",
    Placeholder = "Enter text...",
    Callback = function(text)
        UI:SetTitle(text)
    end
 })

SettingsTab:AddButton({
   Name = "Destory Library",
   Callback = function()
       UI:Destroy()
   end
})

# ui.dev

A modern, lightweight UI library for Roblox that simplifies interface development with clean components and intuitive APIs.

## ✨ Features

- **Custom Tabs** - Create multiple organized tabs
- **Buttons** - Clickable buttons with hover effects
- **Toggles** - On/off switches with callbacks
- **Sliders** - Value sliders with min/max ranges
- **Input Fields** - Text input boxes
- **Labels** - Text display elements
- **Title Customization** - Change window titles
- **Draggable Windows** - Drag to move around
- **Smooth Animations** - TweenService integration
- **Modern Design** - Dark theme with rounded corners

## 🚀 Quick Start

### Installation

### Basic Usage

```lua
-- Load the library
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/nebulal0l/ui.dev/refs/heads/main/ui.dev.lua"))()

-- Create a window
local UI = UILibrary:CreateWindow({
    Title = "My UI",
    Size = UDim2.new(0, 500, 0, 400),
    Draggable = true
})

-- Create a tab
local MainTab = UI:CreateTab({
    Name = "Main",
    Icon = "🏠"
})

-- Add elements to the tab
MainTab:AddButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})

MainTab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})
```

## 🎨 Customization Options

### Window Options

- **Title** - Window title text
- **Size** - Window dimensions (UDim2)
- **Draggable** - Enable/disable dragging (boolean)

### Tab Options

- **Name** - Tab display name
- **Icon** - Emoji or symbol for tab

### Element Methods

- `Tab:AddButton({Name, Callback})`
- `Tab:AddToggle({Name, Default, Callback})`
- `Tab:AddSlider({Name, Min, Max, Default, Callback})`
- `Tab:AddInput({Name, Placeholder, Callback})`
- `Tab:AddLabel({Text, Color})`

## 📖 API Documentation

### Creating a Window

```lua
local UILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/nebulal0l/ui.dev/refs/heads/main/ui.dev.lua"))()

local UI = UILibrary:CreateWindow({
    Title = "Window Title",
    Size = UDim2.new(0, 600, 0, 400),
    Draggable = true -- Optional, defaults to true
})
```

### Creating Tabs

```lua
local MainTab = UI:CreateTab({
    Name = "Tab Name",
    Icon = "🎮" -- Optional emoji or symbol
})
```

### Adding Elements

#### Button
```lua
MainTab:AddButton({
    Name = "Button Text",
    Callback = function()
        print("Button was clicked!")
    end
})
```

#### Toggle
```lua
MainTab:AddToggle({
    Name = "Toggle Name",
    Default = false, -- Starting state
    Callback = function(value)
        print("Toggle is now:", value)
    end
})
```

#### Slider
```lua
MainTab:AddSlider({
    Name = "Slider Name",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Slider value:", value)
    end
})
```

#### Input Field
```lua
MainTab:AddInput({
    Name = "Input Name",
    Placeholder = "Enter text here...",
    Callback = function(text)
        print("Input text:", text)
    end
})
```

#### Label
```lua
MainTab:AddLabel({
    Text = "Label Text",
    Color = Color3.fromRGB(255, 255, 255) -- Optional
})
```

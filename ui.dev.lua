local uidev = {}
uidev.__index = uidev

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Themes = {
    Dark = {
        Primary = Color3.fromRGB(45, 45, 55),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(85, 170, 255),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 200, 200),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60)
    },
    Grape = {
        Primary = Color3.fromRGB(50, 35, 70),
        Secondary = Color3.fromRGB(40, 25, 60),
        Accent = Color3.fromRGB(155, 89, 182),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 180, 220),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60)
    },
    Blurple = {
        Primary = Color3.fromRGB(54, 57, 63),
        Secondary = Color3.fromRGB(47, 49, 54),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(181, 186, 193),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(237, 66, 69)
    },
    Blood = {
        Primary = Color3.fromRGB(60, 20, 20),
        Secondary = Color3.fromRGB(50, 15, 15),
        Accent = Color3.fromRGB(220, 20, 60),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 150, 150),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(139, 0, 0)
    }
}

local Config = {
    Animations = {
        Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        Medium = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        Slow = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    }
}

function uidev:CreateWindow(options)
    options = options or {}
    local windowData = {
        Title = options.Title or "UI Library",
        Size = options.Size or UDim2.new(0, 580, 0, 420),
        Theme = options.Theme or "Dark",
        Draggable = options.Draggable ~= false,
        Tabs = {},
        CurrentTab = nil
    }

    local CurrentTheme = Themes[windowData.Theme] or Themes.Dark

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "uidev_" .. windowData.Title
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Parent = ScreenGui
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.7
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0.5, -windowData.Size.X.Offset/2 + 5, 0.5, -windowData.Size.Y.Offset/2 + 5)
    Shadow.Size = windowData.Size
    Shadow.ZIndex = 0

    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 8)
    ShadowCorner.Parent = Shadow

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = CurrentTheme.Primary
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -windowData.Size.X.Offset/2, 0.5, -windowData.Size.Y.Offset/2)
    MainFrame.Size = windowData.Size
    MainFrame.ClipsDescendants = true
    MainFrame.ZIndex = 1

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = CurrentTheme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 35)

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar

    local TitleFix = Instance.new("Frame")
    TitleFix.Parent = TitleBar
    TitleFix.BackgroundColor3 = CurrentTheme.Secondary
    TitleFix.BorderSizePixel = 0
    TitleFix.Position = UDim2.new(0, 0, 0.7, 0)
    TitleFix.Size = UDim2.new(1, 0, 0.3, 0)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowData.Title
    TitleLabel.TextColor3 = CurrentTheme.Text
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = CurrentTheme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = CurrentTheme.Text
    CloseButton.TextSize = 16

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 35)
    TabContainer.Size = UDim2.new(0, 150, 1, -35)

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Vertical
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 5)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 150, 0, 35)
    ContentContainer.Size = UDim2.new(1, -150, 1, -35)

    if windowData.Draggable then
        local dragging = false
        local dragStart = nil
        local startPos = nil

        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                MainFrame.Position = newPos
                Shadow.Position = UDim2.new(newPos.X.Scale, newPos.X.Offset + 5, newPos.Y.Scale, newPos.Y.Offset + 5)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end

    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, Config.Animations.Fast, {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(Shadow, Config.Animations.Fast, {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.15)
        ScreenGui:Destroy()
    end)

    local Window = {}
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.ContentContainer = ContentContainer
    Window.Data = windowData
    Window.Theme = CurrentTheme

    function Window:CreateTab(options)
        options = options or {}
        local CurrentTheme = Window.Theme -- Add this line to access the theme
        
        local tabData = {
            Name = options.Name or "New Tab",
            Icon = options.Icon or "",
            Visible = true
        }
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabData.Name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = CurrentTheme.Secondary
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = tabData.Icon .. " " .. tabData.Name
        TabButton.TextColor3 = CurrentTheme.TextDark
        TabButton.TextSize = 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabButton
        TabPadding.PaddingLeft = UDim.new(0, 12)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabData.Name .. "Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = CurrentTheme.Accent
        TabContent.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        TabContent.Visible = false

        local ContentList = Instance.new("UIListLayout")
        ContentList.Parent = TabContent
        ContentList.FillDirection = Enum.FillDirection.Vertical
        ContentList.HorizontalAlignment = Enum.HorizontalAlignment.Left
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)

        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.Parent = TabContent
        ContentPadding.PaddingTop = UDim.new(0, 15)
        ContentPadding.PaddingLeft = UDim.new(0, 15)
        ContentPadding.PaddingRight = UDim.new(0, 15)
        ContentPadding.PaddingBottom = UDim.new(0, 15)

        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(windowData.Tabs) do
                tab.Content.Visible = false
                TweenService:Create(tab.Button, Config.Animations.Fast, {
                    BackgroundColor3 = CurrentTheme.Secondary,
                    TextColor3 = CurrentTheme.TextDark
                }):Play()
            end

            TabContent.Visible = true
            windowData.CurrentTab = tabData.Name
            TweenService:Create(TabButton, Config.Animations.Fast, {
                BackgroundColor3 = CurrentTheme.Accent,
                TextColor3 = CurrentTheme.Text
            }):Play()
        end)

        TabButton.MouseEnter:Connect(function()
            if windowData.CurrentTab ~= tabData.Name then
                TweenService:Create(TabButton, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Primary}):Play()
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if windowData.CurrentTab ~= tabData.Name then
                TweenService:Create(TabButton, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Secondary}):Play()
            end
        end)

        local tab = {
            Button = TabButton,
            Content = TabContent,
            Data = tabData
        }
        windowData.Tabs[tabData.Name] = tab

        if #windowData.Tabs == 1 then
            TabButton.MouseButton1Click:Fire()
        end

        local Tab = {}
        Tab.Content = TabContent
        Tab.Data = tabData

        function Tab:AddButton(options)
            options = options or {}
            local buttonData = {
                Name = options.Name or "Button",
                Callback = options.Callback or function() end,
                Description = options.Description or ""
            }

            local Button = Instance.new("TextButton")
            Button.Name = buttonData.Name
            Button.Parent = TabContent
            Button.BackgroundColor3 = CurrentTheme.Secondary
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, -10, 0, 35)
            Button.Font = Enum.Font.Gotham
            Button.Text = buttonData.Name
            Button.TextColor3 = CurrentTheme.Text
            Button.TextSize = 12

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                TweenService:Create(Button, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Accent}):Play()
                wait(0.1)
                TweenService:Create(Button, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Secondary}):Play()
                
                spawn(function()
                    buttonData.Callback()
                end)
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Primary}):Play()
            end)

            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, Config.Animations.Fast, {BackgroundColor3 = CurrentTheme.Secondary}):Play()
            end)

            return Button
        end

        function Tab:AddToggle(options)
            options = options or {}
            local toggleData = {
                Name = options.Name or "Toggle",
                Default = options.Default or false,
                Callback = options.Callback or function() end
            }

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = toggleData.Name .. "Toggle"
            ToggleFrame.Parent = TabContent
            ToggleFrame.BackgroundColor3 = CurrentTheme.Secondary
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, -10, 0, 35)

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Text = toggleData.Name
            ToggleLabel.TextColor3 = CurrentTheme.Text
            ToggleLabel.TextSize = 12
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = toggleData.Default and CurrentTheme.Success or CurrentTheme.Error
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Position = UDim2.new(1, -30, 0, 7)
            ToggleButton.Size = UDim2.new(0, 21, 0, 21)
            ToggleButton.Text = ""

            local ToggleButtonCorner = Instance.new("UICorner")
            ToggleButtonCorner.CornerRadius = UDim.new(0, 4)
            ToggleButtonCorner.Parent = ToggleButton

            local isToggled = toggleData.Default

            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                local newColor = isToggled and CurrentTheme.Success or CurrentTheme.Error
                TweenService:Create(ToggleButton, Config.Animations.Fast, {BackgroundColor3 = newColor}):Play()
                
                spawn(function()
                    toggleData.Callback(isToggled)
                end)
            end)

            return ToggleFrame
        end

        function Tab:AddSlider(options)
            options = options or {}
            local sliderData = {
                Name = options.Name or "Slider",
                Min = options.Min or 0,
                Max = options.Max or 100,
                Default = options.Default or 50,
                Callback = options.Callback or function() end
            }

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = sliderData.Name .. "Slider"
            SliderFrame.Parent = TabContent
            SliderFrame.BackgroundColor3 = CurrentTheme.Secondary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, -10, 0, 50)

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = SliderFrame

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Parent = SliderFrame
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Position = UDim2.new(0, 12, 0, 0)
            SliderLabel.Size = UDim2.new(1, -12, 0, 25)
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Text = sliderData.Name .. ": " .. sliderData.Default
            SliderLabel.TextColor3 = CurrentTheme.Text
            SliderLabel.TextSize = 12
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = CurrentTheme.Primary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Position = UDim2.new(0, 12, 0, 30)
            SliderTrack.Size = UDim2.new(1, -24, 0, 6)

            local SliderTrackCorner = Instance.new("UICorner")
            SliderTrackCorner.CornerRadius = UDim.new(0, 3)
            SliderTrackCorner.Parent = SliderTrack

            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = CurrentTheme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((sliderData.Default - sliderData.Min) / (sliderData.Max - sliderData.Min), 0, 1, 0)

            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(0, 3)
            SliderFillCorner.Parent = SliderFill

            local SliderButton = Instance.new("TextButton")
            SliderButton.Parent = SliderTrack
            SliderButton.BackgroundColor3 = CurrentTheme.Text
            SliderButton.BorderSizePixel = 0
            SliderButton.Position = UDim2.new((sliderData.Default - sliderData.Min) / (sliderData.Max - sliderData.Min), -6, 0.5, -6)
            SliderButton.Size = UDim2.new(0, 12, 0, 12)
            SliderButton.Text = ""

            local SliderButtonCorner = Instance.new("UICorner")
            SliderButtonCorner.CornerRadius = UDim.new(0, 6)
            SliderButtonCorner.Parent = SliderButton

            local currentValue = sliderData.Default
            local dragging = false

            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = input.Position.X
                    local trackPos = SliderTrack.AbsolutePosition.X
                    local trackSize = SliderTrack.AbsoluteSize.X
                    local percentage = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
                    
                    currentValue = math.floor(sliderData.Min + (sliderData.Max - sliderData.Min) * percentage)
                    SliderLabel.Text = sliderData.Name .. ": " .. currentValue
                    
                    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    SliderButton.Position = UDim2.new(percentage, -6, 0.5, -6)
                    
                    spawn(function()
                        sliderData.Callback(currentValue)
                    end)
                end
            end)

            return SliderFrame
        end

        function Tab:AddInput(options)
            options = options or {}
            local inputData = {
                Name = options.Name or "Input",
                Placeholder = options.Placeholder or "Enter text...",
                Callback = options.Callback or function() end
            }

            local InputFrame = Instance.new("Frame")
            InputFrame.Name = inputData.Name .. "Input"
            InputFrame.Parent = TabContent
            InputFrame.BackgroundColor3 = CurrentTheme.Secondary
            InputFrame.BorderSizePixel = 0
            InputFrame.Size = UDim2.new(1, -10, 0, 60)

            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 6)
            InputCorner.Parent = InputFrame

            local InputLabel = Instance.new("TextLabel")
            InputLabel.Parent = InputFrame
            InputLabel.BackgroundTransparency = 1
            InputLabel.Position = UDim2.new(0, 12, 0, 5)
            InputLabel.Size = UDim2.new(1, -12, 0, 20)
            InputLabel.Font = Enum.Font.Gotham
            InputLabel.Text = inputData.Name
            InputLabel.TextColor3 = CurrentTheme.Text
            InputLabel.TextSize = 12
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left

            local InputBox = Instance.new("TextBox")
            InputBox.Parent = InputFrame
            InputBox.BackgroundColor3 = CurrentTheme.Primary
            InputBox.BorderSizePixel = 0
            InputBox.Position = UDim2.new(0, 12, 0, 30)
            InputBox.Size = UDim2.new(1, -24, 0, 25)
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderText = inputData.Placeholder
            InputBox.PlaceholderColor3 = CurrentTheme.TextDark
            InputBox.Text = ""
            InputBox.TextColor3 = CurrentTheme.Text
            InputBox.TextSize = 11
            InputBox.TextXAlignment = Enum.TextXAlignment.Left

            local InputBoxCorner = Instance.new("UICorner")
            InputBoxCorner.CornerRadius = UDim.new(0, 4)
            InputBoxCorner.Parent = InputBox

            local InputBoxPadding = Instance.new("UIPadding")
            InputBoxPadding.Parent = InputBox
            InputBoxPadding.PaddingLeft = UDim.new(0, 8)
            InputBoxPadding.PaddingRight = UDim.new(0, 8)

            InputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    spawn(function()
                        inputData.Callback(InputBox.Text)
                    end)
                end
            end)

            return InputFrame
        end

        function Tab:AddLabel(options)
            options = options or {}
            local labelData = {
                Text = options.Text or "Label",
                Color = options.Color or CurrentTheme.Text
            }

            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = TabContent
            Label.BackgroundColor3 = CurrentTheme.Secondary
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, -10, 0, 30)
            Label.Font = Enum.Font.Gotham
            Label.Text = labelData.Text
            Label.TextColor3 = labelData.Color
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local LabelCorner = Instance.new("UICorner")
            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Parent = Label

            local LabelPadding = Instance.new("UIPadding")
            LabelPadding.Parent = Label
            LabelPadding.PaddingLeft = UDim.new(0, 12)

            return Label
        end

        return Tab
    end

    function Window:SetTitle(newTitle)
        windowData.Title = newTitle
        TitleLabel.Text = newTitle
    end

    function Window:Destroy()
        ScreenGui:Destroy()
    end

    return Window
end

return uidev

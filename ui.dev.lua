local UILibrary = {}
UILibrary.__index = UILibrary

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Config = {
    Colors = {
        Primary = Color3.fromRGB(25, 25, 35),
        Secondary = Color3.fromRGB(35, 35, 45),
        Accent = Color3.fromRGB(100, 180, 255),
        Text = Color3.fromRGB(240, 240, 245),
        TextDark = Color3.fromRGB(180, 180, 190),
        Success = Color3.fromRGB(46, 213, 115),
        Warning = Color3.fromRGB(255, 165, 0),
        Error = Color3.fromRGB(255, 71, 87),
        Background = Color3.fromRGB(15, 15, 20)
    },
    Animations = {
        Fast = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0),
        Medium = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0),
        Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0),
        Bounce = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0)
    },
    CornerRadius = UDim.new(0, 8),
    DropShadow = {
        Size = 20,
        Transparency = 0.9
    },
    LoadingScreen = {
        BackgroundColor = Color3.fromRGB(15, 15, 20),
        AccentColor = Color3.fromRGB(100, 180, 255),
        TextColor = Color3.fromRGB(240, 240, 245),
        LoadingText = "Loading..."
    }
}

local function createLoadingScreen()
    local loadingScreen = Instance.new("ScreenGui")
    loadingScreen.Name = "UILibrary_LoadingScreen"
    loadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    loadingScreen.ResetOnSpawn = false
    loadingScreen.IgnoreGuiInset = true
    loadingScreen.DisplayOrder = 999999

    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Config.LoadingScreen.BackgroundColor
    background.BorderSizePixel = 0
    background.Parent = loadingScreen

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.Size = UDim2.new(0, 300, 0, 100)
    container.BackgroundTransparency = 1
    container.Parent = background

    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.Size = UDim2.new(0, 0, 0, 4)
    loadingBar.Position = UDim2.new(0, 0, 1, -4)
    loadingBar.BackgroundColor3 = Config.LoadingScreen.AccentColor
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = container

    local loadingText = Instance.new("TextLabel")
    loadingText.Name = "LoadingText"
    loadingText.Size = UDim2.new(1, 0, 0, 30)
    loadingText.Position = UDim2.new(0, 0, 0, 0)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = Config.LoadingScreen.LoadingText
    loadingText.TextColor3 = Config.LoadingScreen.TextColor
    loadingText.TextSize = 24
    loadingText.Font = Enum.Font.GothamSemibold
    loadingText.Parent = container

    local function updateProgress(progress)
        loadingBar.Size = UDim2.new(progress, 0, 0, 4)
        loadingText.Text = string.format("%s (%.0f%%)", Config.LoadingScreen.LoadingText, progress * 100)
        if progress >= 1 then
            game:GetService("TweenService"):Create(background, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play()
            game:GetService("TweenService"):Create(container, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.4, 0),
                BackgroundTransparency = 1
            }):Play()
            task.delay(0.5, function()
                loadingScreen:Destroy()
            end)
        end
    end

    loadingScreen.Parent = game:GetService("CoreGui")
    
    return {
        Update = updateProgress,
        Instance = loadingScreen
    }
end

function UILibrary:CreateWindow(options)
    options = options or {}
    local windowData = {
        Title = options.Title or "UI Library",
        Size = options.Size or UDim2.new(0, 600, 0, 450),
        Theme = options.Theme or "Dark",
        Draggable = options.Draggable ~= false,
        Tabs = {},
        CurrentTab = nil,
        LoadingScreen = createLoadingScreen()
    }

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UILibrary_" .. windowData.Title
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
    MainFrame.BackgroundColor3 = Config.Colors.Primary
    MainFrame.BackgroundTransparency = 1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -windowData.Size.X.Offset/2, 0.5, -windowData.Size.Y.Offset/2)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ClipsDescendants = true
    MainFrame.ZIndex = 1

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = Config.CornerRadius
    MainCorner.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Config.Colors.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.ZIndex = 2

    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 160, 235))
    })
    TitleGradient.Rotation = 90
    TitleGradient.Parent = TitleBar

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = Config.CornerRadius
    TitleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = windowData.Title
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    TitleLabel.TextStrokeTransparency = 0.8
    TitleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 71, 87)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -35, 0.5, -10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.TextSize = 16
    CloseButton.AutoButtonColor = false
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, Config.Animations.Fast, {
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, Config.Animations.Medium, {
            BackgroundColor3 = Color3.fromRGB(255, 71, 87)
        }):Play()
    end)
    
    CloseButton.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, Config.Animations.Fast, {
            BackgroundColor3 = Color3.fromRGB(200, 50, 50),
            Size = UDim2.new(0, 18, 0, 18),
            Position = UDim2.new(1, -34, 0.5, -9)
        }):Play()
    end)
    
    CloseButton.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, Config.Animations.Medium, {
            BackgroundColor3 = Color3.fromRGB(255, 71, 87),
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -35, 0.5, -10)
        }):Play()
    end)

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Size = UDim2.new(0, 160, 1, -40)
    
    local TabContainerGradient = Instance.new("UIGradient")
    TabContainerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    })
    TabContainerGradient.Rotation = 90
    TabContainerGradient.Parent = TabContainer

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Vertical
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)
    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 16)
    end)

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 12)
    TabPadding.PaddingBottom = UDim.new(0, 12)
    TabPadding.PaddingLeft = UDim.new(0, 12)
    TabPadding.PaddingRight = UDim.new(0, 4)

    local ContentContainer = Instance.new("ScrollingFrame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 160, 0, 40)
    ContentContainer.Size = UDim2.new(1, -160, 1, -40)
    ContentContainer.ScrollBarThickness = 4
    ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
    ContentContainer.ScrollBarImageTransparency = 0.8
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentContainer.ScrollBarImageColor3 = Config.Colors.Accent
    ContentContainer.ScrollBarThickness = 4
    ContentContainer.ScrollBarImageTransparency = 0.7
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Parent = ContentContainer
    ContentList.Padding = UDim.new(0, 12)
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
    end)
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.Parent = ContentContainer
    ContentPadding.PaddingTop = UDim.new(0, 12)
    ContentPadding.PaddingRight = UDim.new(0, 12)
    ContentPadding.PaddingLeft = UDim.new(0, 12)
    ContentPadding.PaddingBottom = UDim.new(0, 12)

    if windowData.Draggable then
        local dragging = false
        local dragStart = nil
        local startPos = nil
        local dragStartTime = 0

        local function updateWindowPosition(input)
            if not dragging then return end
            
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
            
            MainFrame.Position = newPos
            Shadow.Position = UDim2.new(
                newPos.X.Scale, 
                newPos.X.Offset + 5, 
                newPos.Y.Scale, 
                newPos.Y.Offset + 5
            )
        end

        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                dragStartTime = tick()
                
                -- Animate click effect
                game:GetService("TweenService"):Create(TitleBar, Config.Animations.Fast, {
                    BackgroundTransparency = 0.2
                }):Play()
            end
        end)

        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                updateWindowPosition(input)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                
                -- Animate release effect
                local releaseTime = tick() - dragStartTime
                local tweenInfo = releaseTime < 0.2 and TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out) 
                    or TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                
                game:GetService("TweenService"):Create(TitleBar, tweenInfo, {
                    BackgroundTransparency = 0
                }):Play()
            end
        end)
        
        -- Cleanup connection when window is closed
        MainFrame.AncestryChanged:Connect(function(_, parent)
            if not parent then
                connection:Disconnect()
            end
        end)
    end

    CloseButton.MouseButton1Click:Connect(function()
        local closeAnim = TweenService:Create(MainFrame, Config.Animations.Slow, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        
        local shadowAnim = TweenService:Create(Shadow, Config.Animations.Slow, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        
        closeAnim:Play()
        shadowAnim:Play()
        
        closeAnim.Completed:Wait()
        ScreenGui:Destroy()
    end)

    -- Animate window in
    task.spawn(function()
        -- Initial loading animation
        for i = 1, 10 do
            windowData.LoadingScreen.Update(i/10)
            task.wait(0.05)
        end
        
        -- Show main window with animation
        MainFrame.BackgroundTransparency = 0
        
        local openAnim = TweenService:Create(MainFrame, Config.Animations.Bounce, {
            Size = windowData.Size,
            Position = UDim2.new(0.5, -windowData.Size.X.Offset/2, 0.5, -windowData.Size.Y.Offset/2)
        })
        
        local shadowAnim = TweenService:Create(Shadow, Config.Animations.Bounce, {
            Size = windowData.Size,
            Position = UDim2.new(0.5, -windowData.Size.X.Offset/2 + 5, 0.5, -windowData.Size.Y.Offset/2 + 5)
        })
        
        openAnim:Play()
        shadowAnim:Play()
        
        -- Finish loading
        windowData.LoadingScreen.Update(1)
    end)
    
    local Window = {}
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.ContentContainer = ContentContainer
    Window.Data = windowData
    
    function Window:SetLoadingText(text)
        if windowData.LoadingScreen and windowData.LoadingScreen.Instance and windowData.LoadingScreen.Instance:FindFirstChild("Background") then
            local container = windowData.LoadingScreen.Instance.Background.Container
            if container and container:FindFirstChild("LoadingText") then
                container.LoadingText.Text = text
                Config.LoadingScreen.LoadingText = text
            end
        end
    end
    
    function Window:UpdateLoadingProgress(progress)
        if windowData.LoadingScreen and windowData.LoadingScreen.Update then
            windowData.LoadingScreen.Update(math.clamp(progress, 0, 1))
        end
    end

    function Window:CreateTab(options)
        options = options or {}
        local tabData = {
            Name = options.Name or "New Tab",
            Icon = options.Icon or "",
            Visible = true,
            Selected = false
        }

        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabData.Name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -8, 0, 38)
        TabButton.AutoButtonColor = false
        TabButton.Text = ""
        TabButton.ZIndex = 2
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton
        
        local TabButtonHighlight = Instance.new("Frame")
        TabButtonHighlight.Name = "Highlight"
        TabButtonHighlight.Parent = TabButton
        TabButtonHighlight.BackgroundColor3 = Config.Colors.Accent
        TabButtonHighlight.BorderSizePixel = 0
        TabButtonHighlight.Size = UDim2.new(0, 3, 0.6, 0)
        TabButtonHighlight.Position = UDim2.new(0, -3, 0.2, 0)
        TabButtonHighlight.ZIndex = 3
        TabButtonHighlight.Visible = false
        
        local TabButtonGradient = Instance.new("UIGradient")
        TabButtonGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 70)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 55))
        })
        TabButtonGradient.Rotation = 90
        TabButtonGradient.Parent = TabButton
        
        local TabButtonContent = Instance.new("Frame")
        TabButtonContent.Name = "Content"
        TabButtonContent.Parent = TabButton
        TabButtonContent.BackgroundTransparency = 1
        TabButtonContent.Size = UDim2.new(1, -16, 1, 0)
        TabButtonContent.Position = UDim2.new(0, 12, 0, 0)
        
        local TabButtonLayout = Instance.new("UIListLayout")
        TabButtonLayout.Parent = TabButtonContent
        TabButtonLayout.FillDirection = Enum.FillDirection.Horizontal
        TabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        TabButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        TabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabButtonLayout.Padding = UDim.new(0, 8)
        
        local IconLabel = Instance.new("TextLabel")
        IconLabel.Name = "Icon"
        IconLabel.Parent = TabButtonContent
        IconLabel.Size = UDim2.new(0, 20, 0, 20)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = tabData.Icon
        IconLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
        IconLabel.TextSize = 16
        IconLabel.Font = Enum.Font.GothamBold
        IconLabel.TextXAlignment = Enum.TextXAlignment.Center
        IconLabel.TextYAlignment = Enum.TextYAlignment.Center
        
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Text"
        TextLabel.Parent = TabButtonContent
        TextLabel.Size = UDim2.new(1, -28, 1, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = tabData.Name
        TextLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
        TextLabel.TextSize = 14
        TextLabel.Font = Enum.Font.GothamSemibold
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextYAlignment = Enum.TextYAlignment.Center
        TextLabel.TextWrapped = true
        
        TabButton.MouseEnter:Connect(function()
            if not tabData.Selected then
                game:GetService("TweenService"):Create(TabButton, Config.Animations.Fast, {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not tabData.Selected then
                game:GetService("TweenService"):Create(TabButton, Config.Animations.Medium, {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                }):Play()
            end
        end)
        
        TabButton.MouseButton1Down:Connect(function()
            game:GetService("TweenService"):Create(TabButton, Config.Animations.Fast, {
                BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            }):Play()
        end)
        
        TabButton.MouseButton1Up:Connect(function()
            game:GetService("TweenService"):Create(TabButton, Config.Animations.Medium, {
                BackgroundColor3 = tabData.Selected and Color3.fromRGB(60, 60, 70) or Color3.fromRGB(45, 45, 55)
            }):Play()
        end)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = tabData.Icon .. " " .. tabData.Name
        TabButton.TextColor3 = Config.Colors.TextDark
        TabButton.TextSize = 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabButton
        TabPadding.PaddingLeft = UDim.new(0, 12)

        local TabContent = Instance.new("Frame")
        TabContent.Name = tabData.Name .. "Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false
        TabContent.ClipsDescendants = true
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Parent = TabContent
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 10)
        
        local contentPadding = Instance.new("UIPadding")
        contentPadding.Parent = TabContent
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingRight = UDim.new(0, 10)
        contentPadding.PaddingLeft = UDim.new(0, 10)
        contentPadding.PaddingBottom = UDim.new(0, 10)

        local Tab = {}
        Tab.Name = tabData.Name
        Tab.Visible = true
        Tab.Buttons = {}
        Tab.Selected = false
        
        function Tab:SetSelected(selected)
            self.Selected = selected
            TabButtonHighlight.Visible = selected
            
            if selected then
                game:GetService("TweenService"):Create(TabButton, Config.Animations.Medium, {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                }):Play()
                TabContent.Visible = true
                TabContent.BackgroundTransparency = 1
                game:GetService("TweenService"):Create(TabContent, Config.Animations.Medium, {
                    BackgroundTransparency = 0
                }):Play()
            else
                game:GetService("TweenService"):Create(TabButton, Config.Animations.Medium, {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                }):Play()
                TabContent.Visible = false
            end
        end
        
        local function selectTab()
            -- Deselect all other tabs
            for _, tab in ipairs(windowData.Tabs) do
                if tab ~= Tab then
                    tab:SetSelected(false)
                end
            end
            
            -- Select this tab if not already selected
            if not Tab.Selected then
                Tab:SetSelected(true)
            end
        end
        
        -- Set up click handler for the tab button
        TabButton.MouseButton1Click:Connect(selectTab)
        
        -- Add tab to window data
        table.insert(windowData.Tabs, Tab)
        
        -- Select first tab by default
        if #windowData.Tabs == 1 then
            Tab:SetSelected(true)
        end
        
        -- Add button creation method
        function Tab:AddButton(options)
            options = options or {}
            local buttonData = {
                Name = options.Name or "Button",
                Callback = options.Callback or function() end
            }
            
            local Button = Instance.new("TextButton")
            Button.Name = buttonData.Name
            Button.Parent = TabContent
            Button.BackgroundColor3 = Config.Colors.Secondary
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = buttonData.Name
            Button.TextColor3 = Config.Colors.Text
            Button.TextSize = 13
            Button.AutoButtonColor = false
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            -- Button hover effects
            Button.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(Button, Config.Animations.Fast, {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(Button, Config.Animations.Medium, {
                    BackgroundColor3 = Config.Colors.Secondary
                }):Play()
            end)
            
            Button.MouseButton1Down:Connect(function()
                game:GetService("TweenService"):Create(Button, Config.Animations.Fast, {
                    BackgroundColor3 = Config.Colors.Accent,
                    Size = UDim2.new(1, -4, 0, 36)
                }):Play()
            end)
            
            Button.MouseButton1Up:Connect(function()
                game:GetService("TweenService"):Create(Button, Config.Animations.Medium, {
                    BackgroundColor3 = Color3.fromRGB(60, 60, 70),
                    Size = UDim2.new(1, 0, 0, 40)
                }):Play()
                
                -- Execute callback
                spawn(function()
                    buttonData.Callback()
                end)
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
            ToggleFrame.BackgroundColor3 = Config.Colors.Secondary
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
            ToggleLabel.TextColor3 = Config.Colors.Text
            ToggleLabel.TextSize = 12
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundColor3 = toggleData.Default and Config.Colors.Success or Config.Colors.Error
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
                local newColor = isToggled and Config.Colors.Success or Config.Colors.Error
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
            SliderFrame.BackgroundColor3 = Config.Colors.Secondary
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
            SliderLabel.TextColor3 = Config.Colors.Text
            SliderLabel.TextSize = 12
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = Config.Colors.Primary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Position = UDim2.new(0, 12, 0, 30)
            SliderTrack.Size = UDim2.new(1, -24, 0, 6)

            local SliderTrackCorner = Instance.new("UICorner")
            SliderTrackCorner.CornerRadius = UDim.new(0, 3)
            SliderTrackCorner.Parent = SliderTrack

            local SliderFill = Instance.new("Frame")
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = Config.Colors.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((sliderData.Default - sliderData.Min) / (sliderData.Max - sliderData.Min), 0, 1, 0)

            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(0, 3)
            SliderFillCorner.Parent = SliderFill

            local SliderButton = Instance.new("TextButton")
            SliderButton.Parent = SliderTrack
            SliderButton.BackgroundColor3 = Config.Colors.Text
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
            InputFrame.BackgroundColor3 = Config.Colors.Secondary
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
            InputLabel.TextColor3 = Config.Colors.Text
            InputLabel.TextSize = 12
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left

            local InputBox = Instance.new("TextBox")
            InputBox.Parent = InputFrame
            InputBox.BackgroundColor3 = Config.Colors.Primary
            InputBox.BorderSizePixel = 0
            InputBox.Position = UDim2.new(0, 12, 0, 30)
            InputBox.Size = UDim2.new(1, -24, 0, 25)
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderText = inputData.Placeholder
            InputBox.PlaceholderColor3 = Config.Colors.TextDark
            InputBox.Text = ""
            InputBox.TextColor3 = Config.Colors.Text
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
                Color = options.Color or Config.Colors.Text
            }

            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Parent = TabContent
            Label.BackgroundColor3 = Config.Colors.Secondary
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

return UILibrary

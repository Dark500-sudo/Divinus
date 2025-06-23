-- DIVINUS Loader + Main GUI by ChatGPT

if getgenv().divinusLoaderLoaded then return end
getgenv().divinusLoaderLoaded = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Helper: Hover effect for buttons
local function addHoverEffect(button, hoverColor, normalColor)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, tweenInfo, {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, tweenInfo, {BackgroundColor3 = normalColor}):Play()
    end)
end

-- Dragging function
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local UserInputService = game:GetService("UserInputService")

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Main container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DivinusUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- ========== LOADER WINDOW ========== --

local loaderFrame = Instance.new("Frame")
loaderFrame.Size = UDim2.new(0, 350, 0, 170)
loaderFrame.Position = UDim2.new(0.5, -175, 0.4, 0)
loaderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loaderFrame.BorderSizePixel = 0
loaderFrame.Active = true
loaderFrame.Selectable = true
loaderFrame.Parent = screenGui
local loaderCorner = Instance.new("UICorner", loaderFrame)
loaderCorner.CornerRadius = UDim.new(0, 8)
makeDraggable(loaderFrame)

-- Header bar
local loaderHeader = Instance.new("Frame")
loaderHeader.Size = UDim2.new(1, 0, 0, 30)
loaderHeader.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loaderHeader.Parent = loaderFrame
local loaderHeaderCorner = Instance.new("UICorner", loaderHeader)
loaderHeaderCorner.CornerRadius = UDim.new(0, 8)

local loaderTitle = Instance.new("TextLabel")
loaderTitle.Size = UDim2.new(1, 0, 1, 0)
loaderTitle.BackgroundTransparency = 1
loaderTitle.Text = "DIVINUS Loader"
loaderTitle.Font = Enum.Font.GothamBold
loaderTitle.TextSize = 18
loaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loaderTitle.Parent = loaderHeader

-- Password label
local passLabel = Instance.new("TextLabel")
passLabel.Size = UDim2.new(1, -40, 0, 30)
passLabel.Position = UDim2.new(0, 20, 0, 50)
passLabel.BackgroundTransparency = 1
passLabel.Text = "Enter Password:"
passLabel.Font = Enum.Font.Gotham
passLabel.TextSize = 16
passLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
passLabel.TextXAlignment = Enum.TextXAlignment.Left
passLabel.Parent = loaderFrame

-- Password textbox
local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(1, -40, 0, 35)
passBox.Position = UDim2.new(0, 20, 0, 80)
passBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
passBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passBox.ClearTextOnFocus = false
passBox.Font = Enum.Font.Gotham
passBox.TextSize = 18
passBox.PlaceholderText = "Password"
passBox.Text = ""
passBox.TextXAlignment = Enum.TextXAlignment.Left
passBox.Password = true
passBox.Parent = loaderFrame
local passBoxCorner = Instance.new("UICorner", passBox)
passBoxCorner.CornerRadius = UDim.new(0, 6)

-- Submit button
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0, 120, 0, 35)
submitBtn.Position = UDim2.new(0.5, -60, 0, 130)
submitBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Parent = loaderFrame
local submitBtnCorner = Instance.new("UICorner", submitBtn)
submitBtnCorner.CornerRadius = UDim.new(0, 6)
addHoverEffect(submitBtn, Color3.fromRGB(85, 85, 85), submitBtn.BackgroundColor3)

-- Error label (hidden initially)
local errorLabel = Instance.new("TextLabel")
errorLabel.Name = "ErrorLabel"
errorLabel.Size = UDim2.new(1, -40, 0, 25)
errorLabel.Position = UDim2.new(0, 20, 0, 115)
errorLabel.BackgroundTransparency = 1
errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
errorLabel.Font = Enum.Font.GothamBold
errorLabel.TextSize = 14
errorLabel.Text = ""
errorLabel.TextXAlignment = Enum.TextXAlignment.Center
errorLabel.Parent = loaderFrame

-- ========== MAIN GUI WINDOW ========== --

local mainGuiFrame = Instance.new("Frame")
mainGuiFrame.Size = UDim2.new(0, 550, 0, 350)
mainGuiFrame.Position = UDim2.new(0.5, -275, 0.4, 0)
mainGuiFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainGuiFrame.BorderSizePixel = 0
mainGuiFrame.Active = true
mainGuiFrame.Selectable = true
mainGuiFrame.Visible = false -- hide initially
mainGuiFrame.Parent = screenGui
local mainGuiCorner = Instance.new("UICorner", mainGuiFrame)
mainGuiCorner.CornerRadius = UDim.new(0, 8)
makeDraggable(mainGuiFrame)

-- Header bar for main GUI
local mainGuiHeader = Instance.new("Frame")
mainGuiHeader.Size = UDim2.new(1, 0, 0, 30)
mainGuiHeader.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainGuiHeader.Parent = mainGuiFrame
local mainGuiHeaderCorner = Instance.new("UICorner", mainGuiHeader)
mainGuiHeaderCorner.CornerRadius = UDim.new(0, 8)

local mainGuiTitle = Instance.new("TextLabel")
mainGuiTitle.Size = UDim2.new(1, 0, 1, 0)
mainGuiTitle.BackgroundTransparency = 1
mainGuiTitle.Text = "DIVINUS"
mainGuiTitle.Font = Enum.Font.GothamBold
mainGuiTitle.TextSize = 20
mainGuiTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainGuiTitle.Parent = mainGuiHeader

-- Sidebar with Tabs
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainGuiFrame
local sidebarCorner = Instance.new("UICorner", sidebar)
sidebarCorner.CornerRadius = UDim.new(0, 8)

local tabs = {"Aimbot", "Misc", "Settings"}
local tabButtons = {}
local tabContents = {}

local function createTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 16
    btn.Parent = sidebar
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 5)
    addHoverEffect(btn, Color3.fromRGB(90, 90, 90), btn.BackgroundColor3)
    return btn
end

local function createTabContent(name)
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -130, 1, -10)
    contentFrame.Position = UDim2.new(0, 130, 0, 5)
    contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    contentFrame.BorderSizePixel = 0
    contentFrame.Visible = false
    contentFrame.Parent = mainGuiFrame
    local contentCorner = Instance.new("UICorner", contentFrame)
    contentCorner.CornerRadius = UDim.new(0, 8)

    local placeholder = Instance.new("TextLabel")
    placeholder.Size = UDim2.new(1, -20, 1, -20)
    placeholder.Position = UDim2.new(0, 10, 0, 10)
    placeholder.BackgroundTransparency = 1
    placeholder.TextColor3 = Color3.fromRGB(200, 200, 200)
    placeholder.Font = Enum.Font.Gotham
    placeholder.TextSize = 16
    placeholder.TextWrapped = true
    placeholder.Text = "This is the "..name.." tab content."
    placeholder.Parent = contentFrame

    return contentFrame
end

for i, tabName in ipairs(tabs) do
    local yPos = (i-1)*45 + 10
    local btn = createTabButton(tabName, yPos)
    tabButtons[tabName] = btn

    local content = createTabContent(tabName)
    tabContents[tabName] = content
end

local function setActiveTab(name)
    for tabName, btn in pairs(tabButtons) do
        if tabName == name then
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            tabContents[tabName].Visible = true
        else
            btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            tabContents[tabName].Visible = false
        end
    end
end

setActiveTab("Aimbot")

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        setActiveTab(tabName)
    end)
end

-- PASSWORD CHECK FUNCTION
local function onPasswordEntered(password)
    local correctPassword = "divinus123" -- Change to your password

    if password == correctPassword then
        loaderFrame.Visible = false
        errorLabel.Text = ""
        mainGuiFrame.Visible = true
    else
        errorLabel.Text = "Incorrect password. Try again."
    end
end

submitBtn.MouseButton1Click:Connect(function()
    onPasswordEntered(passBox.Text)
end)
passBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        onPasswordEntered(passBox.Text)
    end
end)

-- TOGGLE GUI WITH RightShift
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

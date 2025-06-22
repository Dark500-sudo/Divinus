-- Password-protected DIVINUS GUI Loader

local PASSWORD = "Divinus123"

-- Password GUI
local passwordGui = Instance.new("ScreenGui")
passwordGui.Name = "DivinusPasswordGui"
passwordGui.ResetOnSpawn = false
passwordGui.IgnoreGuiInset = true
passwordGui.Parent = game:GetService("CoreGui")

local passwordFrame = Instance.new("Frame")
passwordFrame.Size = UDim2.new(0, 300, 0, 120)
passwordFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
passwordFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
passwordFrame.BorderSizePixel = 0
passwordFrame.Parent = passwordGui

local promptLabel = Instance.new("TextLabel")
promptLabel.Size = UDim2.new(1, -20, 0, 40)
promptLabel.Position = UDim2.new(0, 10, 0, 10)
promptLabel.BackgroundTransparency = 1
promptLabel.Text = "Enter Password to Load Divinus"
promptLabel.Font = Enum.Font.GothamBold
promptLabel.TextSize = 20
promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
promptLabel.Parent = passwordFrame

local passwordBox = Instance.new("TextBox")
passwordBox.Size = UDim2.new(1, -20, 0, 40)
passwordBox.Position = UDim2.new(0, 10, 0, 60)
passwordBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextSize = 24
passwordBox.PlaceholderText = "Password"
passwordBox.ClearTextOnFocus = true
passwordBox.Parent = passwordFrame
passwordBox.Text = ""

local function showError()
    promptLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    promptLabel.Text = "Incorrect password! Try again."
    task.wait(2)
    promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    promptLabel.Text = "Enter Password to Load Divinus"
    passwordBox.Text = ""
end

passwordBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end

    if passwordBox.Text == PASSWORD then
        passwordGui:Destroy()
        createDivinusGUI()
    else
        showError()
    end
end)

-- Create the full GUI with sidebar and tabs
function createDivinusGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DivinusGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = gui

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 100, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    local categories = {
        "Aimbot",
        "Misc",
        "Settings"
    }

    local currentTab = nil
    local contentFrames = {}

    -- Content Panel
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -100, 1, 0)
    contentArea.Position = UDim2.new(0, 100, 0, 0)
    contentArea.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame

    -- Create placeholder pages for each category
    for i, categoryName in ipairs(categories) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Text = categoryName
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 18
        button.Parent = sidebar

        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, 0, 1, 0)
        contentFrame.Position = UDim2.new(0, 0, 0, 0)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Visible = false
        contentFrame.Parent = contentArea

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 30)
        label.Position = UDim2.new(0, 0, 0, 10)
        label.BackgroundTransparency = 1
        label.Text = categoryName .. " Content"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 20
        label.Parent = contentFrame

        contentFrames[categoryName] = contentFrame

        button.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Visible = false
            end
            contentFrame.Visible = true
            currentTab = contentFrame
        end)

        -- Auto-select first tab
        if i == 1 then
            button:MouseButton1Click()
        end
    end
end

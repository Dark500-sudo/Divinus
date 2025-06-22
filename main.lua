-- Password you want to set
local PASSWORD = "Divinus123"  -- Change this to your desired password

-- Create the password GUI first
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
passwordBox.TextStrokeTransparency = 0.7
passwordBox.TextEditable = true
passwordBox.TextWrapped = false
passwordBox.Text = ""

local function showError()
    promptLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    promptLabel.Text = "Incorrect password! Try again."
    task.wait(2)
    promptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    promptLabel.Text = "Enter Password to Load Divinus"
    passwordBox.Text = ""
end

-- When user presses Enter in the TextBox
passwordBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end -- only accept if user pressed enter

    if passwordBox.Text == PASSWORD then
        -- Password correct! Destroy password GUI and load main GUI
        passwordGui:Destroy()
        
        -- Call function to create your main Divinus GUI here:
        createDivinusGUI()
    else
        showError()
    end
end)

-- Function to create the main Divinus GUI (your existing GUI code)
function createDivinusGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DivinusGUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 60)
    frame.Position = UDim2.new(0.5, -100, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "DIVINUS Loaded"
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Parent = frame

    gui.Parent = game:GetService("CoreGui")
end

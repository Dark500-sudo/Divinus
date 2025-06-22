-- DIVINUS Script

-- Basic test GUI
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

-- gui.lua
-- Builds the main DIVINUS GUI with draggable window, toggle, tabs, and rounded corners
-- Returns: {
--   create = function(): { getTab = function(tabName) -> Frame }
-- }

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local module = {}

function module.create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DivinusGUI"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.4, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

    local sidebar = Instance.new("Frame", mainFrame)
    sidebar.Size = UDim2.new(0, 100, 1, 0)
    sidebar.Position = UDim2.new(0, 0, 0, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    sidebar.BorderSizePixel = 0
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

    local contentArea = Instance.new("Frame", mainFrame)
    contentArea.Size = UDim2.new(1, -100, 1, 0)
    contentArea.Position = UDim2.new(0, 100, 0, 0)
    contentArea.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    contentArea.BorderSizePixel = 0
    Instance.new("UICorner", contentArea).CornerRadius = UDim.new(0, 12)

    local categories = {"Aimbot", "Misc", "Settings"}
    local contentFrames = {}
    local currentTab = nil

    for i, name in ipairs(categories) do
        local button = Instance.new("TextButton", sidebar)
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Position = UDim2.new(0, 0, 0, (i - 1) * 42)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Text = name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 18
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

        local content = Instance.new("Frame", contentArea)
        content.Size = UDim2.new(1, 0, 1, 0)
        content.Position = UDim2.new(0, 0, 0, 0)
        content.BackgroundTransparency = 1
        content.Visible = false

        contentFrames[name] = content

        button.MouseButton1Click:Connect(function()
            if currentTab then currentTab.Visible = false end
            content.Visible = true
            currentTab = content
        end)

        if i == 1 then button:MouseButton1Click() end
    end

    -- RightShift to toggle GUI
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            screenGui.Enabled = not screenGui.Enabled
        end
    end)

    return {
        getTab = function(name)
            return contentFrames[name]
        end
    }
end

return module

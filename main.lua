--[[
    DIVINUS Main Loader + Utils
    Loads password screen and imports the GUI + tab modules
--]]

local PASSWORD = "Divinus123"
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Load module from GitHub
local function requireFromURL(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then return result end
    warn("[DIVINUS] Failed to load module:", url)
    return nil
end

-- Build password prompt
local function showPasswordPrompt(callback)
    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "DivinusPasswordGui"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 300, 0, 120)
    frame.Position = UDim2.new(0.5, -150, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -20, 0, 40)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = "Enter Password to Load Divinus"

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1, -20, 0, 40)
    box.Position = UDim2.new(0, 10, 0, 60)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.Font = Enum.Font.Gotham
    box.TextSize = 24
    box.PlaceholderText = "Password"
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Text = ""

    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    local function fail()
        label.Text = "Wrong Password!"
        label.TextColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(2)
        label.Text = "Enter Password to Load Divinus"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Text = ""
    end

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            if box.Text == PASSWORD then
                gui:Destroy()
                callback()
            else
                fail()
            end
        end
    end)
end

-- ✅ ENTRY POINT
showPasswordPrompt(function()
    -- Load GUI layout
    local guiModule = requireFromURL("https://raw.githubusercontent.com/YourUsername/Divinus/main/gui.lua")
    if not guiModule then return end

    -- Initialize GUI and get tab system
    local divinus = guiModule.create()

    -- Load category content
    local aimbot = requireFromURL("https://raw.githubusercontent.com/YourUsername/Divinus/main/modules/aimbot.lua")
    local misc = requireFromURL("https://raw.githubusercontent.com/YourUsername/Divinus/main/modules/misc.lua")
    local settings = requireFromURL("https://raw.githubusercontent.com/YourUsername/Divinus/main/modules/settings.lua")

    if aimbot then aimbot(divinus.getTab("Aimbot")) end
    if misc then misc(divinus.getTab("Misc")) end
    if settings then settings(divinus.getTab("Settings")) end
end)

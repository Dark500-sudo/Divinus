-- DIVINUS Main Loader + Utils
local PASSWORD = "Divinus123"
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local GITHUB_USERNAME = "Dark500-sudo"
local REPO = "Divinus"
local BRANCH = "main"

-- Helper to load raw scripts from GitHub
local function requireFromURL(path)
    local url = ("https://raw.githubusercontent.com/%s/%s/%s/%s"):format(GITHUB_USERNAME, REPO, BRANCH, path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        return result
    else
        warn("[DIVINUS] Failed to load:", url)
        warn("[DIVINUS] Error:", result)
        return nil
    end
end

-- Password prompt GUI
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

-- Main entry point
showPasswordPrompt(function()
    print("[DIVINUS] Password accepted, loading GUI...")

    local guiModule = requireFromURL("gui.lua")
    if not guiModule then return end

    local divinus = guiModule.create()

    local aimbot = requireFromURL("modules/aimbot.lua")
    local misc = requireFromURL("modules/misc.lua")
    local settings = requireFromURL("modules/settings.lua")

    if aimbot then aimbot(divinus.getTab("Aimbot")) end
    if misc then misc(divinus.getTab("Misc")) end
    if settings then settings(divinus.getTab("Settings")) end

    print("[DIVINUS] GUI loaded successfully.")
end)

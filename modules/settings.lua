-- settings.lua
-- Adds Close GUI button and lets user customize the toggle key

return function(container)
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local currentKey = Enum.KeyCode.RightShift
    local listening = false

    local keyLabel = Instance.new("TextLabel", container)
    keyLabel.Size = UDim2.new(0, 200, 0, 30)
    keyLabel.Position = UDim2.new(0, 20, 0, 20)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = "Current Hotkey: RightShift"
    keyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyLabel.Font = Enum.Font.Gotham
    keyLabel.TextSize = 18

    local changeKeyBtn = Instance.new("TextButton", container)
    changeKeyBtn.Size = UDim2.new(0, 200, 0, 40)
    changeKeyBtn.Position = UDim2.new(0, 20, 0, 60)
    changeKeyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    changeKeyBtn.Text = "Change Hotkey"
    changeKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    changeKeyBtn.Font = Enum.Font.Gotham
    changeKeyBtn.TextSize = 20
    Instance.new("UICorner", changeKeyBtn).CornerRadius = UDim.new(0, 6)

    local closeBtn = Instance.new("TextButton", container)
    closeBtn.Size = UDim2.new(0, 200, 0, 40)
    closeBtn.Position = UDim2.new(0, 20, 0, 120)
    closeBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
    closeBtn.Text = "Close GUI"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseButton1Click:Connect(function()
        local gui = CoreGui:FindFirstChild("DivinusGUI")
        if gui then
            gui:Destroy()
            print("[DIVINUS] GUI closed by user.")
        end
    end)

    changeKeyBtn.MouseButton1Click:Connect(function()
        listening = true
        changeKeyBtn.Text = "Press any key..."
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and input.KeyCode ~= Enum.KeyCode.Unknown then
            currentKey = input.KeyCode
            keyLabel.Text = "Current Hotkey: " .. input.KeyCode.Name
            changeKeyBtn.Text = "Change Hotkey"
            listening = false
        end
    end)

    -- Update GUI toggle listener
    local gui = CoreGui:FindFirstChild("DivinusGUI")
    if gui then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == currentKey then
                gui.Enabled = not gui.Enabled
            end
        end)
    end
end

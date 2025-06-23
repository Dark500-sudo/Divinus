return function(container)
    local player = game.Players.LocalPlayer
    local humanoid = player and player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")

    local slider = Instance.new("TextBox", container)
    slider.Size = UDim2.new(0, 200, 0, 40)
    slider.Position = UDim2.new(0, 20, 0, 20)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.Text = "WalkSpeed: 16"
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.Font = Enum.Font.Gotham
    slider.TextSize = 20
    slider.ClearTextOnFocus = true
    Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 6)

    slider.FocusLost:Connect(function(enter)
        if not enter then return end
        local num = tonumber(slider.Text:match("%d+"))
        if num and humanoid then
            humanoid.WalkSpeed = num
            slider.Text = "WalkSpeed: " .. num
            print("[DIVINUS Misc] WalkSpeed set to", num)
        else
            slider.Text = "Invalid speed!"
        end
    end)
end

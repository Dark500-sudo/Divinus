return function(container)
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")

    local speedBox = Instance.new("TextBox")
    speedBox.Size = UDim2.new(0, 200, 0, 40)
    speedBox.Position = UDim2.new(0, 20, 0, 20)
    speedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedBox.Font = Enum.Font.Gotham
    speedBox.TextSize = 20
    speedBox.PlaceholderText = "Enter WalkSpeed (e.g. 16)"
    speedBox.Parent = container
    Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

    speedBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then return end
        local speed = tonumber(speedBox.Text)
        if speed and humanoid then
            humanoid.WalkSpeed = speed
            speedBox.Text = "WalkSpeed: " .. speed
        else
            speedBox.Text = "Invalid Speed"
        end
    end)
end

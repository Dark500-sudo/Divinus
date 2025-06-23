return function(container)
    local toggle = Instance.new("TextButton", container)
    toggle.Size = UDim2.new(0, 200, 0, 40)
    toggle.Position = UDim2.new(0, 20, 0, 20)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.Text = "Aimbot: OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 20
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

    local enabled = false
    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        toggle.Text = "Aimbot: " .. (enabled and "ON" or "OFF")
        toggle.BackgroundColor3 = enabled and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(60, 60, 60)
        print("[DIVINUS Aimbot] Enabled:", enabled)
    end)
end

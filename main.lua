-- WalkSpeed input
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 120, 0, 40)
speedBox.Position = UDim2.new(0, 20, 0, 65)
speedBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "Speed"
speedBox.Text = "50"
speedBox.TextSize = 16
speedBox.Font = Enum.Font.Gotham
speedBox.ClearTextOnFocus = false
speedBox.Parent = window

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = speedBox

-- Toggle button
local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0, 120, 0, 40)
speedToggle.Position = UDim2.new(0, 160, 0, 65)
speedToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
speedToggle.Text = "WalkSpeed: OFF"
speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedToggle.TextSize = 14
speedToggle.Font = Enum.Font.GothamBold
speedToggle.Parent = window

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = speedToggle

local speedEnabled = false

local function updateSpeed()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	if speedEnabled then
		local speed = tonumber(speedBox.Text)

		if speed then
			humanoid.WalkSpeed = speed
		end
	else
		humanoid.WalkSpeed = 16
	end
end

-- Toggle ON/OFF
speedToggle.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled

	if speedEnabled then
		speedToggle.Text = "WalkSpeed: ON"
		speedToggle.BackgroundColor3 = Color3.fromRGB(60, 170, 90)
	else
		speedToggle.Text = "WalkSpeed: OFF"
		speedToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end

	updateSpeed()
end)

-- Press Enter to update the speed
speedBox.FocusLost:Connect(function(enterPressed)
	if enterPressed and speedEnabled then
		updateSpeed()
	end
end)

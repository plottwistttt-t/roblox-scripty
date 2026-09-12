-- My Roblox Game Controller
-- First GUI test: WalkSpeed control

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GameController"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Main window
local window = Instance.new("Frame")
window.Name = "MainWindow"
window.Size = UDim2.new(0, 300, 0, 180)
window.Position = UDim2.new(0.5, -150, 0.5, -90)
window.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
window.BorderSizePixel = 0
window.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = window

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "My Game Controller"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = window

-- Speed input
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 180, 0, 40)
speedBox.Position = UDim2.new(0.5, -90, 0, 60)
speedBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "WalkSpeed"
speedBox.Text = "16"
speedBox.TextSize = 16
speedBox.Font = Enum.Font.Gotham
speedBox.ClearTextOnFocus = false
speedBox.Parent = window

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = speedBox

-- Set speed button
local setButton = Instance.new("TextButton")
setButton.Size = UDim2.new(0, 180, 0, 35)
setButton.Position = UDim2.new(0.5, -90, 0, 110)
setButton.BackgroundColor3 = Color3.fromRGB(70, 120, 255)
setButton.Text = "Set WalkSpeed"
setButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setButton.TextSize = 15
setButton.Font = Enum.Font.GothamBold
setButton.Parent = window

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = setButton

local function applySpeed()
	local speed = tonumber(speedBox.Text)

	if speed then
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.WalkSpeed = speed
			end
		end
	end
end

-- Clicking the button applies the speed
setButton.MouseButton1Click:Connect(applySpeed)

-- Pressing Enter while typing applies the speed
speedBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		applySpeed()
	end
end)

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -32, 0, 10)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 80, 80)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = window

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Make the window draggable
local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPosition

window.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = window.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart

		window.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

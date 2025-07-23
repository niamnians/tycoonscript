-- Advanced Auto Collect + Auto Upgrade Script (Tagalog GUI)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local collecting, upgrading = false, false

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "TycoonHelper"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0, 10, 0.4, 0)
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2

local function makeButton(text, yPos)
	local button = Instance.new("TextButton", Frame)
	button.Text = text
	button.Size = UDim2.new(1, -10, 0, 40)
	button.Position = UDim2.new(0, 5, 0, yPos)
	button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	button.TextColor3 = Color3.new(1,1,1)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 18
	return button
end

-- Auto Collect Button
local btnCollect = makeButton("💰 Auto Kolekta", 5)
btnCollect.MouseButton1Click:Connect(function()
	collecting = not collecting
	btnCollect.Text = collecting and "✅ Kumokolekta..." or "💰 Auto Kolekta"
	
	coroutine.wrap(function()
		while collecting do
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Part") and v.Name:lower():find("collector") then
					firetouchinterest(char.HumanoidRootPart, v, 0)
					task.wait(0.1)
					firetouchinterest(char.HumanoidRootPart, v, 1)
				end
			end
			task.wait(2)
		end
	end)()
end)

-- Auto Upgrade Button
local btnUpgrade = makeButton("🛠️ Auto Upgrade", 50)
btnUpgrade.MouseButton1Click:Connect(function()
	upgrading = not upgrading
	btnUpgrade.Text = upgrading and "✅ Ina-upgrade..." or "🛠️ Auto Upgrade"
	
	coroutine.wrap(function()
		while upgrading do
			for _, part in pairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") and part.Name:lower():sub(1, 3) == "buy" then
					local root = char:FindFirstChild("HumanoidRootPart")
					if root then
						-- Try Touch
						firetouchinterest(root, part, 0)
						task.wait(0.1)
						firetouchinterest(root, part, 1)

						-- Try ClickDetector
						local click = part:FindFirstChildOfClass("ClickDetector")
						if click then
							fireclickdetector(click)
						end

						-- Try ProximityPrompt
						local prompt = part:FindFirstChildOfClass("ProximityPrompt")
						if prompt then
							fireproximityprompt(prompt)
						end
					end
				end
			end
			task.wait(1)
		end
	end)()
end)

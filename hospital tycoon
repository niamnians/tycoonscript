-- Hospital Tycoon GUI Script (All Features)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "UltimateTycoonGui"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 420)
frame.Position = UDim2.new(0, 30, 0, 30)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🏥 Tycoon Master GUI"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.BackgroundTransparency = 1

-- Reusable button function
local function makeBtn(text, order)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, 30 + (order * 40))
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(60, 130, 255)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.BorderSizePixel = 0
	return btn
end

-- Auto Claim
local btnClaim = makeBtn("🎯 Auto Claim Tycoon", 0)
btnClaim.MouseButton1Click:Connect(function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v.Name:lower():find("claim") and v:IsA("BasePart") then
			firetouchinterest(char.HumanoidRootPart, v, 0)
			wait(0.1)
			firetouchinterest(char.HumanoidRootPart, v, 1)
		end
	end
end)

-- Auto Collect
local collecting = false
local btnCollect = makeBtn("💰 Auto Collect", 1)
btnCollect.MouseButton1Click:Connect(function()
	collecting = not collecting
	btnCollect.Text = collecting and "✅ Collecting..." or "💰 Auto Collect"
	coroutine.wrap(function()
		while collecting do
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name:lower():find("collect") then
					firetouchinterest(char.HumanoidRootPart, v.Parent, 0)
					wait(0.1)
					firetouchinterest(char.HumanoidRootPart, v.Parent, 1)
				end
			end
			wait(1)
		end
	end)()
end)

-- Auto Upgrade
local upgrading = false
local btnUpgrade = makeBtn("🛠️ Auto Upgrade", 2)
btnUpgrade.MouseButton1Click:Connect(function()
	upgrading = not upgrading
	btnUpgrade.Text = upgrading and "✅ Upgrading..." or "🛠️ Auto Upgrade"
	coroutine.wrap(function()
		while upgrading do
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name:lower():find("buy") then
					firetouchinterest(char.HumanoidRootPart, v.Parent, 0)
					wait(0.1)
					firetouchinterest(char.HumanoidRootPart, v.Parent, 1)
				end
			end
			wait(1)
		end
	end)()
end)

-- Speed Boost
local btnSpeed = makeBtn("⚡ Speed Boost", 3)
btnSpeed.MouseButton1Click:Connect(function()
	local human = char:FindFirstChildOfClass("Humanoid")
	if human then
		human.WalkSpeed = 100
		btnSpeed.Text = "✅ Speed: 100"
	end
end)

-- Auto Rebirth
local btnRebirth = makeBtn("♻️ Auto Rebirth", 4)
btnRebirth.MouseButton1Click:Connect(function()
	local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireServer()
	end
end)

-- Auto Hire
local btnHire = makeBtn("👷 Auto Hire Workers", 5)
btnHire.MouseButton1Click:Connect(function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name:lower():find("hire") then
			firetouchinterest(char.HumanoidRootPart, v.Parent, 0)
			wait(0.1)
			firetouchinterest(char.HumanoidRootPart, v.Parent, 1)
		end
	end
end)

-- GUI Theme Toggle
local btnTheme = makeBtn("🎨 Neon Mode", 6)
local neon = false
btnTheme.MouseButton1Click:Connect(function()
	neon = not neon
	if neon then
		frame.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
		btnTheme.Text = "🎨 Dark Mode"
	else
		frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		btnTheme.Text = "🎨 Neon Mode"
	end
end)

-- Close GUI
local btnClose = makeBtn("❌ Close GUI", 7)
btnClose.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnClose.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Hospital Tycoon GUI (Auto Collect + Auto Upgrade Only)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TycoonHelperGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 200)
frame.Position = UDim2.new(0, 30, 0, 30)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🏥 Tycoon Helper"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.BackgroundTransparency = 1

-- Reusable Button Creator
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

-- 💰 Auto Collect
local collecting = false
local btnCollect = makeBtn("💰 Auto Collect", 0)
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

-- 🛠️ Auto Upgrade (Updated version)
local upgrading = false
local btnUpgrade = makeBtn("🛠️ Auto Upgrade", 1)
btnUpgrade.MouseButton1Click:Connect(function()
    upgrading = not upgrading
    btnUpgrade.Text = upgrading and "✅ Upgrading..." or "🛠️ Auto Upgrade"

    coroutine.wrap(function()
        while upgrading do
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Name:lower():sub(1, 3) == "buy" then
                    firetouchinterest(char.HumanoidRootPart, part, 0)
                    task.wait(0.1)
                    firetouchinterest(char.HumanoidRootPart, part, 1)

                    local click = part:FindFirstChildOfClass("ClickDetector")
                    if click then fireclickdetector(click) end

                    local prompt = part:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then fireproximityprompt(prompt) end
                end
            end
            wait(1)
        end
    end)()
end)

-- ❌ Close Button
local btnClose = makeBtn("❌ Close GUI", 2)
btnClose.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnClose.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Tycoon Master GUI Full (Tagalog Version)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "TycoonMasterGUI"

-- Function para gumawa ng button
local function makeBtn(text, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 10 + ((position - 1) * 50))
    btn.BackgroundColor3 = Color3.fromRGB(30, 144, 255)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 18
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.Parent = gui
    btn.BorderSizePixel = 0
    return btn
end

-- AUTO COLLECT
local collecting = false
local btnCollect = makeBtn("💰 Auto Kolekta", 1)
btnCollect.MouseButton1Click:Connect(function()
    collecting = not collecting
    btnCollect.Text = collecting and "✅ Kumokolekta..." or "💰 Auto Kolekta"
    
    coroutine.wrap(function()
        while collecting do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent:IsA("BasePart") then
                    if v.Parent.Name:lower():find("collect") then
                        firetouchinterest(char.HumanoidRootPart, v.Parent, 0)
                        task.wait(0.1)
                        firetouchinterest(char.HumanoidRootPart, v.Parent, 1)
                    end
                end
            end
            wait(1)
        end
    end)()
end)

-- AUTO UPGRADE
local upgrading = false
local btnUpgrade = makeBtn("🛠️ Auto Upgrade", 2)
btnUpgrade.MouseButton1Click:Connect(function()
    upgrading = not upgrading
    btnUpgrade.Text = upgrading and "✅ Ina-upgrade..." or "🛠️ Auto Upgrade"

    coroutine.wrap(function()
        while upgrading do
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Name:lower():sub(1, 3) == "buy" then
                    -- Try Touch
                    firetouchinterest(char.HumanoidRootPart, part, 0)
                    task.wait(0.1)
                    firetouchinterest(char.HumanoidRootPart, part, 1)

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
            wait(1)
        end
    end)()
end)

-- DESTROY GUI
local btnDestroy = makeBtn("🗑️ Alisin ang GUI", 3)
btnDestroy.MouseButton1Click:Connect(function()
    upgrading = false
    collecting = false
    if gui then
        gui:Destroy()
    end
end)

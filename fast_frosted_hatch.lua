--// GUI + Auto Hatch Script for Frosted Egg (Triple Hatch)

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local coreGui = game:GetService("CoreGui")

-- Create GUI
local gui = Instance.new("ScreenGui", player:FindFirstChildOfClass("PlayerGui") or coreGui)
gui.Name = "FrostedHatchGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 70)
frame.Position = UDim2.new(0.5, -110, 0.05, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local hatchBtn = Instance.new("TextButton", frame)
hatchBtn.Size = UDim2.new(1, 0, 0.5, 0)
hatchBtn.Position = UDim2.new(0, 0, 0, 0)
hatchBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
hatchBtn.TextColor3 = Color3.new(1, 1, 1)
hatchBtn.Font = Enum.Font.GothamBold
hatchBtn.TextSize = 14
hatchBtn.Text = "🎁 Start Frosted Hatch"

local destroyBtn = Instance.new("TextButton", frame)
destroyBtn.Size = UDim2.new(1, 0, 0.5, 0)
destroyBtn.Position = UDim2.new(0, 0, 0.5, 0)
destroyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
destroyBtn.TextColor3 = Color3.new(1, 1, 1)
destroyBtn.Font = Enum.Font.Gotham
destroyBtn.TextSize = 14
destroyBtn.Text = "🗑️ Destroy GUI"

-- Hatching Variables
local hatching = false
local triple = true
local eggName = "Frosted Egg"
local remote = nil

-- Auto Find Hatch Remote
for _, v in pairs(rs:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if string.lower(v.Name):find("hatch") or v.Name:lower():find("open") then
            remote = v
            break
        end
    end
end

-- Function to hatch
local function startHatching()
    spawn(function()
        while hatching do
            if remote then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(eggName, triple)
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(eggName, triple)
                    end
                end)
            end
            task.wait(0.05)
        end
    end)
end

-- Toggle Button
hatchBtn.MouseButton1Click:Connect(function()
    hatching = not hatching
    hatchBtn.Text = hatching and "✅ Stop Hatching" or "🎁 Start Frosted Hatch"
    if hatching then
        startHatching()
    end
end)

-- Destroy GUI button (keeps hatching)
destroyBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

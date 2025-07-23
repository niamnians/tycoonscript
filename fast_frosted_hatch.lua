local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AutoHatchGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 90)
frame.Position = UDim2.new(0.5, -110, 0.85, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🥚 Auto Hatch (Frosted)"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 15

local status = Instance.new("TextLabel", frame)
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 30)
status.Text = "🔍 Waiting to get near Frosted Egg..."
status.TextColor3 = Color3.fromRGB(255,255,255)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 13

local destroyBtn = Instance.new("TextButton", frame)
destroyBtn.Size = UDim2.new(1, -20, 0, 25)
destroyBtn.Position = UDim2.new(0, 10, 1, -30)
destroyBtn.Text = "❌ Destroy GUI"
destroyBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
destroyBtn.TextColor3 = Color3.new(1, 1, 1)
destroyBtn.Font = Enum.Font.Gotham
destroyBtn.TextSize = 14

destroyBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Find Frosted Egg Part
local function getFrostedEgg()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("frosted") and v.Name:lower():find("egg") then
            return v
        end
    end
    return nil
end

-- Start Monitoring Proximity
runService.RenderStepped:Connect(function()
    local egg = getFrostedEgg()
    if not egg or not char:FindFirstChild("HumanoidRootPart") then return end

    local dist = (egg.Position - char.HumanoidRootPart.Position).Magnitude
    if dist <= 10 then
        status.Text = "✅ Near Frosted Egg... Hatching!"
        local args = {
            [1] = "Frosted Egg",
            [2] = true,
            [3] = {}
        }
        pcall(function()
            RS.Network.EggOp:InvokeServer(unpack(args))
        end)
    else
        status.Text = "🔍 Move closer to Frosted Egg... ("..math.floor(dist).." studs)"
    end
end)

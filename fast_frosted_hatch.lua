-- Fast Frosted Egg Auto Hatch + Auto Bubble Collector

local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace")

-- Check if triple hatch is available
local eggRemote = RS:FindFirstChild("Network") and RS.Network:FindFirstChild("EggOp")
local triple = true

-- AUTO HATCH function
local function hatchLoop()
    while true do
        pcall(function()
            eggRemote:InvokeServer("Frosted Egg", triple)
        end)
        task.wait(0.1)
    end
end

-- AUTO BUBBLE collect
local function bubbleLoop()
    while true do
        for _, v in ipairs(ws:GetDescendants()) do
            if v:IsA("TouchTransmitter") and v.Parent.Name:lower():find("bubble") then
                firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 0)
                task.wait(0.05)
                firetouchinterest(player.Character.HumanoidRootPart, v.Parent, 1)
            end
        end
        task.wait(1)
    end
end

-- Start both loops
spawn(hatchLoop)
spawn(bubbleLoop)

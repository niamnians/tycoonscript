local eggName = "Frosted Egg"
local hatchFunction = game:GetService("ReplicatedStorage").Network.Eggs_Hatch

while true do
    pcall(function()
        -- Triple Hatch ng Frosted Egg
        hatchFunction:InvokeServer(eggName, 3)
    end)
    wait(0.1) -- adjust for speed
end

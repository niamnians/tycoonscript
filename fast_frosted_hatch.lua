game:GetService("ReplicatedStorage").NetworkRemoteFunction:InvokeServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Toggle Events",false, function(bool)
    getgenv().eventscool = bool 

    while eventscool do wait()
        game.ReplicatedStorage.Assets.Modules.Is2xSpeedEnabled.Enabled.Value = true
        wait()
        game:GetService("ReplicatedStorage").Assets.Modules.Is2xLuckEnabled.Value  = true
    end
end)

local btns = serv:Channel("Eggs")

local eggs = {};
for i,v in pairs(workspace.Eggs:GetChildren()) do
    table.insert(eggs, v.Name)
end

btns:Seperator()

btns:Dropdown("Choose Egg", eggs, function(CurrentOption)
    wait()
    SelectedEgg = CurrentOption
end)

btns:Toggle("Open Selected Egg",false, function(bool)
    getgenv().singleegg = bool 

    while singleegg do wait()
        local args = {
            [1] = "PurchaseEgg",
            [2] = (SelectedEgg), 
        }
        
        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Toggle("Triple Open Selected Egg",false, function(bool)
    getgenv().tripleeggs = bool 

    while tripleeggs do wait()
        local args = {
            [1] = "PurchaseEgg",
            [2] = (SelectedEgg), 
            [3] = "Multi"
            }

        game:GetService("ReplicatedStorage").NetworkRemoteEvent:FireServer(unpack(args))
    end
end)

btns:Seperator()

btns:Button("Remove Egg Animation", function()
    game:GetService("ReplicatedStorage").Assets.Eggs:Destroy()
end)

btns:Seperator()

btns:Button("Stats Counter", function()
    game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MobileStats.Visible = true
end)

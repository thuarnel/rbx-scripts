--- made by thuarnel 
--- most annoying feature removed! :)

local anna_bypasser_gui = game:GetService('CoreGui'):WaitForChild('AnnaBypasser')

for _, v in pairs(anna_bypasser_gui:GetDescendants()) do
    if v:IsA('TextBox') then
        v.ClearTextOnFocus = false
    end
end

anna_bypasser_gui.DescendantAdded:Connect(function(v)
    if v:IsA('TextBox') then
        v.ClearTextOnFocus = false
    end
end)
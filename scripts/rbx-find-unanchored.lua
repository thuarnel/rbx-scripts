local players = game:GetService("Players")

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA('BasePart') and not v.Anchored then
        local model = v:FindFirstAncestorWhichIsA('Model') 
        if model and players:GetPlayerFromCharacter(model) then
            continue
        end
        print('Found an unanchored part:\n\t' .. v:GetFullName())
    end
end
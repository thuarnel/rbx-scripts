local replacements = {
    Leave = 'pussy',
    Respawn = 'kill yourself',
    Resume = 'back 2 da game'
}

for _, v in pairs(game:GetService('CoreGui'):GetDescendants()) do
    if typeof(v) == 'Instance' and v:IsA('TextLabel') and replacements[v.Text] then
        v.Text = replacements[v.Text]
    end
end
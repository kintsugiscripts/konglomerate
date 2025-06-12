if not (_G.isKeyVerified and _G.isKeyVerified()) then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ScriptHub",
        Text = "❌ Please verify your key first.",
        Duration = 5
    })
    return
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmToggle = Instance.new("TextButton")
local XRayToggle = Instance.new("TextButton")
local SpawnButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")

ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "KingHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "👑 the king noree262 👑"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

local AutoFarm = false
FarmToggle.Parent = MainFrame
FarmToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
FarmToggle.Size = UDim2.new(0.8, 0, 0, 35)
FarmToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FarmToggle.Text = "Auto Farm: OFF"
FarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggle.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    FarmToggle.Text = AutoFarm and "Auto Farm: ON" or "Auto Farm: OFF"
    FarmToggle.BackgroundColor3 = AutoFarm and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    task.spawn(function()
        while AutoFarm do
            for _, egg in pairs(workspace:GetDescendants()) do
                if not AutoFarm then break end
                if egg:IsA("BasePart") and (egg.Name:lower():find("egg") or egg.Parent.Name:lower():find("egg")) then
                    local Root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if Root then
                        Root.CFrame = egg.CFrame + Vector3.new(0, 1, 0)
                        task.wait(0.5)
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

local XRay = false
XRayToggle.Parent = MainFrame
XRayToggle.Position = UDim2.new(0.1, 0, 0.35, 0)
XRayToggle.Size = UDim2.new(0.8, 0, 0, 35)
XRayToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
XRayToggle.Text = "X-Ray: OFF"
XRayToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
XRayToggle.MouseButton1Click:Connect(function()
    XRay = not XRay
    XRayToggle.Text = XRay and "X-Ray: ON" or "X-Ray: OFF"
    XRayToggle.BackgroundColor3 = XRay and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    if XRay then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("egg") and not v:FindFirstChild("EggESP") then
                local b = Instance.new("BillboardGui", v)
                b.Name = "EggESP"
                b.AlwaysOnTop = true
                b.Size = UDim2.new(0, 100, 0, 30)
                local t = Instance.new("TextLabel", b)
                t.Size = UDim2.new(1, 0, 1, 0)
                t.BackgroundTransparency = 1
                t.Text = "🥚 [بيض]"
                t.TextColor3 = Color3.fromRGB(255, 215, 0)
                t.TextSize = 14
            end
        end
    else
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "EggESP" then v:Destroy() end
        end
    end
end)

SpawnButton.Parent = MainFrame
SpawnButton.Position = UDim2.new(0.1, 0, 0.5, 0)
SpawnButton.Size = UDim2.new(0.8, 0, 0, 35)
SpawnButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
SpawnButton.Text = "🏃 العودة للسبون فوراً"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.MouseButton1Click:Connect(function()
    local Root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if Root and Spawn then
        Root.CFrame = Spawn.CFrame + Vector3.new(0, 4, 0)
    end
end)

SpeedSlider.Parent = MainFrame
SpeedSlider.Position = UDim2.new(0.1, 0, 0.65, 0)
SpeedSlider.Size = UDim2.new(0.8, 0, 0, 35)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedSlider.Text = "اكتب السرعة هنا (مثلاً 50)"
SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(SpeedSlider.Text)
        if num then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
        end
    end
end)

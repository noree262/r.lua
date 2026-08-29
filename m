-- إنشاء واجهة المستخدم (UI) مع زر الإغلاق
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "MyCustomScriptHub"

-- [زر الإغلاق وتدمير السكربت تماماً]
CloseButton.Name = "CloseButton"
CloseButton.Parent = ScreenGui
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(0, 10, 0, 10)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- يحذف الواجهة والزر تماماً من شاشتك
end)

-- 1. حل مشكلة السرعة (تحويل النص إلى رقم)
SpeedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speedValue = tonumber(SpeedInput.Text)
        if speedValue then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
        else
            warn("الرجاء إدخال رقم صحيح فقط!")
        end
    end
end)

-- 2. حل مشكلة الرجوع للسبون
local function TeleportToSpawn()
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) -- تصفير الحركة لمنع الموت
        player.Character.HumanoidRootPart.CFrame = workspace:WaitForChild("SpawnLocation").CFrame + Vector3.new(0, 3, 0)
    end
end

-- 3. حل مشكلة الاكس ري للأرباح داخل البيضة
local function XRayEggs()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Egg" or obj: some identifier then 
            -- البحث عن القيمة المالية للحيوان داخل البيضة
            local reward = obj:FindFirstChild("RewardValue") or obj:FindFirstChild("Coins")
            if reward then
                local billboard = Instance.new("BillboardGui", obj)
                local textLabel = Instance.new("TextLabel", billboard)
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0, 100, 0, 50)
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "الربح: " .. tostring(reward.Value)
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end

-- 4. حل التجميع التلقائي (تأكد من تفعيل الحلقة البرمجية)
local AutoFarmActive = true
task.spawn(function()
    while AutoFarmActive and task.wait(0.1) do
        -- كود استدعاء الـ Remote الخاص بالتجميع للتعديل حسب اللعبة
        -- game:GetService("ReplicatedStorage").RemoteEvents.Collect:FireServer()
    end
end)
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

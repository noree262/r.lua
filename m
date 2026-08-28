local Rayfield = loadstring(game:HttpGet('https://githubusercontent.com'))()

local Window = Rayfield:CreateWindow({
   Name = "تيست",
   LoadingTitle = "جاري تشغيل تيست...",
   LoadingSubtitle = "بواسطة Uzumaki",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TestScriptConfig",
      FileName = "TestHub"
   }
})

-- إنشاء قائمة الخيارات الأساسية
local Tab = Window:CreateTab("الخيارات الأساسية", 4483363487)

-- زر زيادة السرعة إلى 500
Tab:CreateButton({
   Name = "زياده السرعه",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 500
   end,
})

-- زر زيادة القفز إلى 500
Tab:CreateButton({
   Name = "زياده القفز",
   Callback = function()
       -- تفعيل القدرة على تعديل قوة القفز يدوياً في روبلوكس
       game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = 500
   end,
})

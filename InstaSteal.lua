local Players=game:GetService("Players")
local ProximityPromptService=game:GetService("ProximityPromptService")
local player=Players.LocalPlayer
local savedCFrame,tpEnabled,godModeEnabled=nil,false,false

for _,v in pairs(getconnections(player.Idled)) do v:Disable() end
game:GetService("ScriptContext").Error:Connect(function() return end)
local mt=getrawmetatable(game)
setreadonly(mt,false)
local old=mt.__namecall
mt.__namecall=newcclosure(function(self,...)
local method=getnamecallmethod()
if method=="Kick" or method=="kick" or method=="Kicked" or method=="kicked" then return nil end
return old(self,...)
end)

local gui=Instance.new("ScreenGui")
gui.Name="InstaStealHUD"
gui.ResetOnSpawn=false
gui.Parent=player:WaitForChild("PlayerGui")
gui.Enabled=true

local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,280,0,200)
frame.Position=UDim2.new(0.5,-140,0.5,-100)
frame.BackgroundColor3=Color3.fromRGB(45,45,45)
frame.BorderSizePixel=0
frame.Parent=gui
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,14)

local function createButton(text,y)
local btn=Instance.new("TextButton")
btn.Size=UDim2.new(1,-30,0,38)
btn.Position=UDim2.new(0,15,0,y)
btn.Text=text
btn.Font=Enum.Font.GothamMedium
btn.TextSize=14
btn.TextColor3=Color3.fromRGB(255,255,255)
btn.BackgroundColor3=Color3.fromRGB(70,70,70)
btn.BorderSizePixel=0
btn.Parent=frame
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,10)
return btn
end

local setBtn=createButton("Set Checkpoint",45)
local tpBtn=createButton("TP: OFF",90)

setBtn.MouseButton1Click:Connect(function()
local char=player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
savedCFrame=char.HumanoidRootPart.CFrame
end
end)

tpBtn.MouseButton1Click:Connect(function()
tpEnabled=not tpEnabled
tpBtn.Text=tpEnabled and "TP: ON" or "TP: OFF"
tpBtn.BackgroundColor3=tpEnabled and Color3.fromRGB(0,170,255) or Color3.fromRGB(70,70,70)
end)

ProximityPromptService.PromptButtonHoldEnded:Connect(function(prompt,who)
if who~=player then return end
if not tpEnabled or not savedCFrame then return end
if prompt.Name=="Steal" or prompt.ActionText=="Steal" then
local char=player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame=savedCFrame
if not godModeEnabled then godModeEnabled=true end
end
end
end)

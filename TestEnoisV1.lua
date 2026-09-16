local TS=game:GetService("TweenService")
local MS=game:GetService("MarketplaceService")
local UIS=game:GetService("UserInputService")
local CG=game:GetService("CoreGui")
local ok,info=pcall(function() return MS:GetProductInfo(game.PlaceId) end)
local nameOk=ok and info and info.Name and string.find(string.lower(info.Name),"bloxstrike",1,true)
if game.PlaceId~=114234929420007 and not nameOk then warn("[EnoisClient] не BloxStrike");return end
local HELLO="hello"
local WELCOME="Добро пожаловать в EnoisClient"
local BTN="Войти в клиент"
local WW,WH,SW=880,540,220
local WHITE=Color3.fromRGB(245,245,245)
local MUTED=Color3.fromRGB(140,140,150)
local SIDE=Color3.fromRGB(10,10,12)
local ROW=Color3.fromRGB(22,22,26)
local ROW_H=Color3.fromRGB(30,30,36)
local CARD=Color3.fromRGB(18,18,22)
local CARD_H=Color3.fromRGB(26,26,32)
local INNER=Color3.fromRGB(12,12,15)
local ACC=Color3.fromRGB(120,180,255)
local function tw(o,t,p,s,d)
local i=TweenInfo.new(t,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out)
local x=TS:Create(o,i,p);x:Play();return x
end
local function explode(cx,cy)
local sg=Instance.new("ScreenGui")
sg.ResetOnSpawn=false;sg.IgnoreGuiInset=true
sg.DisplayOrder=2000;sg.Parent=CG
for i=1,26 do
local sz=math.random(6,14)
local f=Instance.new("Frame")
f.BackgroundColor3=WHITE;f.BorderSizePixel=0
f.Size=UDim2.fromOffset(sz,sz)
f.Position=UDim2.fromOffset(cx-sz/2,cy-sz/2)
f.ZIndex=100;f.Parent=sg
local c=Instance.new("UICorner");c.CornerRadius=UDim.new(1,0);c.Parent=f
local a=math.random()*math.pi*2
local d=math.random(160,360)
TS:Create(f,TweenInfo.new(0.9,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
Position=UDim2.new(f.Position.X.Scale,f.Position.X.Offset+math.cos(a)*d,f.Position.Y.Scale,f.Position.Y.Offset+math.sin(a)*d),
Rotation=math.random(-360,360),BackgroundTransparency=1}):Play()
end
local fl=Instance.new("Frame")
fl.BackgroundColor3=WHITE;fl.BackgroundTransparency=0.8
fl.BorderSizePixel=0;fl.Size=UDim2.fromScale(1,1)
fl.ZIndex=99;fl.Parent=sg
TS:Create(fl,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
local rn=Instance.new("Frame")
rn.BackgroundTransparency=1;rn.Size=UDim2.fromOffset(0,0)
rn.Position=UDim2.fromOffset(cx,cy);rn.AnchorPoint=Vector2.new(0.5,0.5)
rn.ZIndex=99;rn.Parent=sg
local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(1,0);rc.Parent=rn
local rs=Instance.new("UIStroke");rs.Color=WHITE;rs.Thickness=3;rs.Transparency=0.2;rs.Parent=rn
TS:Create(rn,TweenInfo.new(0.9,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Size=UDim2.fromOffset(600,600)}):Play()
TS:Create(rs,TweenInfo.new(0.9),{Transparency=1,Thickness=1}):Play()
task.delay(1.1,function() if sg.Parent then sg:Destroy() end end)
end
local C={}
function C.Toggle(parent,label,default,cb)
local state=default or false
local row=Instance.new("Frame")
row.Size=UDim2.new(1,0,0,34);row.BackgroundColor3=INNER
row.BorderSizePixel=0;row.Parent=parent
local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(0,6);rc.Parent=row
local lbl=Instance.new("TextLabel")
lbl.BackgroundTransparency=1;lbl.Size=UDim2.new(1,-70,1,0)
lbl.Position=UDim2.new(0,12,0,0);lbl.Font=Enum.Font.GothamMedium
lbl.TextSize=13;lbl.TextColor3=WHITE;lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Text=label;lbl.Parent=row
local box=Instance.new("Frame")
box.Size=UDim2.fromOffset(34,18);box.Position=UDim2.new(1,-46,0.5,0)
box.AnchorPoint=Vector2.new(0,0.5);box.BackgroundColor3=Color3.fromRGB(45,45,52)
box.BorderSizePixel=0;box.Parent=row
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(1,0);bc.Parent=box
local knob=Instance.new("Frame")
knob.Size=UDim2.fromOffset(14,14);knob.Position=UDim2.new(0,2,0.5,0)
knob.AnchorPoint=Vector2.new(0,0.5);knob.BackgroundColor3=WHITE
knob.BorderSizePixel=0;knob.Parent=box
local kc=Instance.new("UICorner");kc.CornerRadius=UDim.new(1,0);kc.Parent=knob
local function apply(v,anim)
state=v
local tp=v and UDim2.new(1,-16,0.5,0) or UDim2.new(0,2,0.5,0)
local tc=v and ACC or Color3.fromRGB(45,45,52)
if anim~=false then tw(knob,0.2,{Position=tp});tw(box,0.2,{BackgroundColor3=tc}) else knob.Position=tp;box.BackgroundColor3=tc end
if cb then cb(v) end
end
apply(state,false)
local btn=Instance.new("TextButton")
btn.BackgroundTransparency=1;btn.Size=UDim2.fromScale(1,1);btn.Text=""
btn.Parent=row
btn.MouseButton1Click:Connect(function() apply(not state,true) end)
btn.MouseEnter:Connect(function() tw(row,0.15,{BackgroundColor3=Color3.fromRGB(20,20,26)}) end)
btn.MouseLeave:Connect(function() tw(row,0.15,{BackgroundColor3=INNER}) end)
return{set=apply,get=function() return state end}
end
function C.Slider(parent,label,min,max,default,cb)
local value=default or min
local row=Instance.new("Frame")
row.Size=UDim2.new(1,0,0,46);row.BackgroundColor3=INNER
row.BorderSizePixel=0;row.Parent=parent
local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(0,6);rc.Parent=row
local lbl=Instance.new("TextLabel")
lbl.BackgroundTransparency=1;lbl.Size=UDim2.new(1,-100,0,20)
lbl.Position=UDim2.new(0,12,0,4);lbl.Font=Enum.Font.GothamMedium
lbl.TextSize=13;lbl.TextColor3=WHITE;lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Text=label;lbl.Parent=row
local val=Instance.new("TextLabel")
val.BackgroundTransparency=1;val.Size=UDim2.new(0,80,0,20)
val.Position=UDim2.new(1,-92,0,4);val.Font=Enum.Font.GothamMedium
val.TextSize=13;val.TextColor3=MUTED;val.TextXAlignment=Enum.TextXAlignment.Right
val.Text=tostring(value);val.Parent=row
local barBg=Instance.new("Frame")
barBg.Size=UDim2.new(1,-24,0,5);barBg.Position=UDim2.new(0,12,1,-14)
barBg.AnchorPoint=Vector2.new(0,0.5);barBg.BackgroundColor3=Color3.fromRGB(45,45,52)
barBg.BorderSizePixel=0;barBg.Parent=row
local bgc=Instance.new("UICorner");bgc.CornerRadius=UDim.new(1,0);bgc.Parent=barBg
local fill=Instance.new("Frame")
fill.Size=UDim2.new((value-min)/(max-min),0,1,0)
fill.BackgroundColor3=ACC;fill.BorderSizePixel=0;fill.Parent=barBg
local fc=Instance.new("UICorner");fc.CornerRadius=UDim.new(1,0);fc.Parent=fill
local btn=Instance.new("TextButton")
btn.BackgroundTransparency=1;btn.Size=UDim2.fromScale(1,1);btn.Text=""
btn.Parent=barBg
local drag=false
local function upd()
local m=UIS:GetMouseLocation()
local ax=barBg.AbsolutePosition.X
local w=barBg.AbsoluteSize.X
local a=math.clamp((m.X-ax)/w,0,1)
value=math.floor(min+(max-min)*a)
fill.Size=UDim2.new(a,0,1,0)
val.Text=tostring(value)
if cb then cb(value) end
end
btn.MouseButton1Down:Connect(function() drag=true;upd() end)
UIS.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then upd() end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
return{set=function(v) value=math.clamp(v,min,max)
local a=(value-min)/(max-min);fill.Size=UDim2.new(a,0,1,0)
val.Text=tostring(value);if cb then cb(value) end
end}
end
function C.Dropdown(parent,label,options,default,cb)
local idx=1
for i,v in ipairs(options) do if v==default then idx=i end end
local row=Instance.new("Frame")
row.Size=UDim2.new(1,0,0,34);row.BackgroundColor3=INNER
row.BorderSizePixel=0;row.Parent=parent
local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(0,6);rc.Parent=row
local lbl=Instance.new("TextLabel")
lbl.BackgroundTransparency=1;lbl.Size=UDim2.new(1,-140,1,0)
lbl.Position=UDim2.new(0,12,0,0);lbl.Font=Enum.Font.GothamMedium
lbl.TextSize=13;lbl.TextColor3=WHITE;lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.Text=label;lbl.Parent=row
local val=Instance.new("TextButton")
val.Size=UDim2.new(0,110,0,24);val.Position=UDim2.new(1,-122,0.5,0)
val.AnchorPoint=Vector2.new(0,0.5);val.BackgroundColor3=Color3.fromRGB(35,35,42)
val.BorderSizePixel=0;val.Text="";val.AutoButtonColor=false
val.Parent=row
local vc=Instance.new("UICorner");vc.CornerRadius=UDim.new(0,5);vc.Parent=val
local vtxt=Instance.new("TextLabel")
vtxt.BackgroundTransparency=1;vtxt.Size=UDim2.fromScale(1,1)
vtxt.Font=Enum.Font.GothamMedium;vtxt.TextSize=12
vtxt.TextColor3=WHITE;vtxt.Text=options[idx];vtxt.Parent=val
val.MouseEnter:Connect(function() tw(val,0.15,{BackgroundColor3=Color3.fromRGB(50,50,60)}) end)
val.MouseLeave:Connect(function() tw(val,0.15,{BackgroundColor3=Color3.fromRGB(35,35,42)}) end)
val.MouseButton1Click:Connect(function()
idx=idx+1
if idx>#options then idx=1 end
vtxt.Text=options[idx]
if cb then cb(options[idx]) end
end)
return{get=function() return options[idx] end}
end
function C.Module(parent,title,builderFn)
local holder=Instance.new("Frame")
holder.Size=UDim2.new(1,0,0,44)
holder.BackgroundTransparency=1
holder.ClipsDescendants=true
holder.Parent=parent
local header=Instance.new("TextButton")
header.Size=UDim2.new(1,0,0,44)
header.BackgroundColor3=CARD
header.BorderSizePixel=0
header.Text=""
header.AutoButtonColor=false
header.Parent=holder
local hc=Instance.new("UICorner");hc.CornerRadius=UDim.new(0,8);hc.Parent=header
local titleLbl=Instance.new("TextLabel")
titleLbl.BackgroundTransparency=1
titleLbl.Size=UDim2.new(1,-60,1,0)
titleLbl.Position=UDim2.new(0,16,0,0)
titleLbl.Font=Enum.Font.GothamBold
titleLbl.TextSize=15
titleLbl.TextColor3=WHITE
titleLbl.TextXAlignment=Enum.TextXAlignment.Left
titleLbl.Text=title
titleLbl.Parent=header
local arrow=Instance.new("TextLabel")
arrow.BackgroundTransparency=1
arrow.Size=UDim2.fromOffset(24,24)
arrow.Position=UDim2.new(1,-36,0.5,0)
arrow.AnchorPoint=Vector2.new(0,0.5)
arrow.Font=Enum.Font.GothamBold
arrow.TextSize=16
arrow.TextColor3=MUTED
arrow.Text="^"
arrow.Rotation=180
arrow.Parent=header
local inner=Instance.new("Frame")
inner.Size=UDim2.new(1,-16,0,0)
inner.Position=UDim2.new(0,8,0,50)
inner.BackgroundTransparency=1
inner.Parent=holder
local layout=Instance.new("UIListLayout")
layout.Padding=UDim.new(0,6)
layout.SortOrder=Enum.SortOrder.LayoutOrder
layout.Parent=inner
local pad=Instance.new("UIPadding")
pad.PaddingBottom=UDim.new(0,8)
pad.Parent=inner
if builderFn then
local okB,errB=pcall(builderFn,inner)
if not okB then warn("[EnoisClient] "+title+": "+tostring(errB)) end
end
task.defer(function()
task.wait(0.05)
local contentH=layout.AbsoluteContentSize.Y
inner.Size=UDim2.new(1,-16,0,contentH)
holder.Size=UDim2.new(1,0,0,44)
holder.expanded=false
holder.contentH=contentH
end)
header.MouseEnter:Connect(function() tw(header,0.15,{BackgroundColor3=CARD_H}) end)
header.MouseLeave:Connect(function() tw(header,0.15,{BackgroundColor3=CARD}) end)
header.MouseButton1Click:Connect(function()
local h=holder.contentH or 0
if holder.expanded then
holder.expanded=false
tw(holder,0.3,{Size=UDim2.new(1,0,0,44)},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
tw(arrow,0.3,{Rotation=180})
tw(arrow,0.3,{TextColor3=MUTED})
else
holder.expanded=true
tw(holder,0.35,{Size=UDim2.new(1,0,0,44+h+6)},Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
tw(arrow,0.3,{Rotation=0})
tw(arrow,0.3,{TextColor3=ACC})
end
end)
return holder
end
local Sections={}
Sections.Legit=function(p)
C.Module(p,"AimBot",function(inner)
C.Toggle(inner,"AimCheck",false,function(v) print("AimCheck:",v) end)
C.Slider(inner,"FOV",1,180,90,function(v) print("FOV:",v) end)
C.Slider(inner,"Smoothes",1,100,30,function(v) print("Smooth:",v) end)
C.Dropdown(inner,"Priority",{"Head","Torso"},"Head",function(v) print("Priority:",v) end)
end)
C.Module(p,"TriggerBot",function(inner)
C.Slider(inner,"FOV",1,180,60,function(v) print("FOV:",v) end)
C.Slider(inner,"Smoothes",1,100,20,function(v) print("Smooth:",v) end)
C.Dropdown(inner,"Priority",{"Head","Torso"},"Head",function(v) print("Priority:",v) end)
C.Slider(inner,"HitChance",1,100,80,function(v) print("Hit:",v) end)
end)
end
Sections.Rage=function(p)
C.Module(p,"RageAim",function(inner)
C.Dropdown(inner,"Priority",{"Head","Torso"},"Head",function(v) print("Priority:",v) end)
C.Toggle(inner,"On jump",false,function(v) print("OnJump:",v) end)
C.Toggle(inner,"Blinded",false,function(v) print("Blinded:",v) end)
C.Toggle(inner,"No Scope",false,function(v) print("NoScope:",v) end)
end)
C.Module(p,"Resolver",function(inner)
C.Toggle(inner,"Enabled",true,function(v) print("Resolver:",v) end)
end)
C.Module(p,"Anti-Aim",function(inner)
C.Toggle(inner,"Enabled",true,function(v) print("AA:",v) end)
end)
C.Module(p,"Auto-Wall",function(inner)
C.Dropdown(inner,"Priority",{"Head","Torso"},"Head",function(v) print("Priority:",v) end)
C.Toggle(inner,"On jump",false,function(v) print("OnJump:",v) end)
C.Toggle(inner,"Blinded",false,function(v) print("Blinded:",v) end)
C.Toggle(inner,"No Scope",false,function(v) print("NoScope:",v) end)
end)
end
Sections.Movement=function(p)
C.Module(p,"Bhop",function(inner)
C.Slider(inner,"Strengh",10,100,50,function(v) print("Bhop:",v) end)
end)
C.Module(p,"SpeedHack",function(inner)
C.Slider(inner,"Speed",1,100,20,function(v) print("Speed:",v) end)
end)
C.Module(p,"LongJump",function(inner)
C.Slider(inner,"Strengh",1,10,3,function(v) print("LJ:",v) end)
end)
end
Sections.Misc=function(p)
C.Module(p,"Anti-Flash",function(inner)
C.Toggle(inner,"Enabled",true,function(v) print("AF:",v) end)
end)
C.Module(p,"Thirdperson",function(inner)
C.Toggle(inner,"Enabled",false,function(v) print("TP:",v) end)
end)
C.Module(p,"FovChanger",function(p2)
C.Slider(p2,"FOV",90,180,90,function(v) print("FOV:",v) end)
end)
end
Sections.Visuals=function(p)
C.Module(p,"CustomSky",function(inner)
C.Dropdown(inner,"Color",{"Blue","Night","Red","Purple","Sunset"},"Blue",function(v) print("Sky:",v) end)
end)
C.Module(p,"Esp",function(inner)
C.Toggle(inner,"View Health",true,function(v) print("Health:",v) end)
C.Toggle(inner,"View Box",true,function(v) print("Box:",v) end)
C.Toggle(inner,"View Weapons",false,function(v) print("Weapons:",v) end)
end)
C.Module(p,"Chams",function(inner)
C.Dropdown(inner,"Color",{"White","Red","Green","Blue","Purple"},"White",function(v) print("Chams:",v) end)
C.Toggle(inner,"AimCheck",false,function(v) print("ChamsAim:",v) end)
end)
C.Module(p,"ItemEsp",function(inner)
C.Toggle(inner,"View Chams",false,function(v) print("ItemChams:",v) end)
end)
C.Module(p,"Grenade trajectory",function(inner)
C.Dropdown(inner,"Color",{"White","Red","Green","Blue"},"White",function(v) print("Grenade:",v) end)
end)
end
Sections.UI=function(p)
C.Module(p,"Тема",function(inner)
C.Dropdown(inner,"Theme",{"Dark","Darker","Black"},"Dark",function(v) print("Theme:",v) end)
end)
end
local Menu={visible=false,cur=nil,btns={},built=false}
local ORDER={"Legit","Rage","Visuals","Movement","Misc","UI"}
local function buildMenu()
if Menu.built then return end
Menu.built=true
local sg=Instance.new("ScreenGui")
sg.ResetOnSpawn=false;sg.IgnoreGuiInset=true
sg.DisplayOrder=998;sg.Enabled=false;sg.Parent=CG
local dim=Instance.new("Frame")
dim.Size=UDim2.fromScale(1,1);dim.BackgroundColor3=Color3.new(0,0,0)
dim.BackgroundTransparency=0.45;dim.BorderSizePixel=0;dim.Parent=sg
local win=Instance.new("Frame")
win.AnchorPoint=Vector2.new(0.5,0.5);win.Position=UDim2.fromScale(0.5,0.5)
win.Size=UDim2.fromOffset(WW,WH);win.BackgroundColor3=Color3.fromRGB(14,14,16)
win.BackgroundTransparency=0.05;win.BorderSizePixel=0
win.ClipsDescendants=true;win.Parent=sg
local wc=Instance.new("UICorner");wc.CornerRadius=UDim.new(0,16);wc.Parent=win
local ws=Instance.new("UIStroke");ws.Color=Color3.fromRGB(60,60,70);ws.Thickness=1;ws.Parent=win
local sb=Instance.new("Frame")
sb.Size=UDim2.new(0,SW,1,0);sb.BackgroundColor3=SIDE
sb.BorderSizePixel=0;sb.Parent=win
local sc=Instance.new("UICorner");sc.CornerRadius=UDim.new(0,16);sc.Parent=sb
local tt=Instance.new("TextLabel")
tt.BackgroundTransparency=1;tt.Size=UDim2.new(1,-32,0,36)
tt.Position=UDim2.new(0,16,0,22);tt.Font=Enum.Font.GothamBold
tt.TextSize=18;tt.TextColor3=WHITE;tt.TextXAlignment=Enum.TextXAlignment.Left
tt.Text="EnoisClient";tt.Parent=sb
local dv=Instance.new("Frame")
dv.Size=UDim2.new(1,-32,0,1);dv.Position=UDim2.new(0,16,0,66)
dv.BackgroundColor3=Color3.fromRGB(40,40,48);dv.BorderSizePixel=0;dv.Parent=sb
local nav=Instance.new("Frame")
nav.BackgroundTransparency=1;nav.Size=UDim2.new(1,-32,1,-90)
nav.Position=UDim2.new(0,16,0,80);nav.Parent=sb
local nl=Instance.new("UIListLayout");nl.Padding=UDim.new(0,6)
nl.SortOrder=Enum.SortOrder.LayoutOrder;nl.Parent=nav
local cont=Instance.new("ScrollingFrame")
cont.Size=UDim2.new(1,-SW,1,0);cont.Position=UDim2.new(0,SW,0,0)
cont.BackgroundTransparency=1;cont.BorderSizePixel=0
cont.CanvasSize=UDim2.new(0,0,0,0)
cont.AutomaticCanvasSize=Enum.AutomaticSize.Y
cont.ScrollBarThickness=4
cont.ScrollBarImageColor3=Color3.fromRGB(60,60,70)
cont.Parent=win
local cl=Instance.new("UIListLayout")
cl.Padding=UDim.new(0,10)
cl.SortOrder=Enum.SortOrder.LayoutOrder
cl.Parent=cont
local cp=Instance.new("UIPadding")
cp.PaddingTop=UDim.new(0,24)
cp.PaddingLeft=UDim.new(0,24)
cp.PaddingRight=UDim.new(0,24)
cp.PaddingBottom=UDim.new(0,24)
cp.Parent=cont
Menu.sg=sg;Menu.win=win;Menu.cont=cont
local function select(name)
if Menu.cur==name then return end
Menu.cur=name
for n,b in pairs(Menu.btns) do
local a=(n==name)
tw(b.bg,0.2,{BackgroundColor3=a and ROW_H or ROW})
tw(b.ind,0.2,{BackgroundTransparency=a and 0 or 1})
tw(b.lbl,0.2,{TextColor3=a and WHITE or Color3.fromRGB(200,200,210)})
end
for _,ch in ipairs(cont:GetChildren()) do
if ch:IsA("Frame") or ch:IsA("TextButton") then ch:Destroy() end
end
local build=Sections[name]
if build then
local okB,errB=pcall(build,cont)
if not okB then warn("[EnoisClient] "+name+": "+tostring(errB)) end
end
for _,ch in ipairs(cont:GetChildren()) do
if ch:IsA("Frame") then
ch.Position=ch.Position+UDim2.fromOffset(40,0)
end
end
for _,ch in ipairs(cont:GetChildren()) do
if ch:IsA("Frame") then
tw(ch,0.3,{Position=ch.Position-UDim2.fromOffset(40,0)})
end
end
end
for i,name in ipairs(ORDER) do
local btn=Instance.new("TextButton")
btn.Size=UDim2.new(1,0,0,38);btn.BackgroundColor3=ROW
btn.BorderSizePixel=0;btn.Text="";btn.AutoButtonColor=false
btn.LayoutOrder=i;btn.Parent=nav
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(0,8);bc.Parent=btn
local ind=Instance.new("Frame")
ind.Size=UDim2.new(0,3,0.6,0);ind.Position=UDim2.new(0,0,0.5,0)
ind.AnchorPoint=Vector2.new(0,0.5);ind.BackgroundColor3=ACC
ind.BorderSizePixel=0;ind.BackgroundTransparency=1;ind.Parent=btn
local ic=Instance.new("UICorner");ic.CornerRadius=UDim.new(0,2);ic.Parent=ind
local lbl=Instance.new("TextLabel")
lbl.BackgroundTransparency=1;lbl.Size=UDim2.new(1,-20,1,0)
lbl.Position=UDim2.new(0,14,0,0);lbl.Font=Enum.Font.GothamMedium
lbl.TextSize=14;lbl.TextColor3=Color3.fromRGB(200,200,210)
lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Text=name;lbl.Parent=btn
Menu.btns[name]={bg=btn,ind=ind,lbl=lbl}
btn.MouseEnter:Connect(function()
if Menu.cur==name then return end
tw(btn,0.15,{BackgroundColor3=ROW_H})
end)
btn.MouseLeave:Connect(function()
if Menu.cur==name then return end
tw(btn,0.15,{BackgroundColor3=ROW})
end)
btn.MouseButton1Click:Connect(function() select(name) end)
end
select(ORDER[1])
end
local function openMenu(fx,fy)
if not Menu.built then buildMenu() end
if Menu.visible then return end
Menu.visible=true;Menu.sg.Enabled=true
local vp=workspace.CurrentCamera.ViewportSize
Menu.win.AnchorPoint=Vector2.new(0.5,0.5)
Menu.win.Position=UDim2.fromOffset(fx or vp.X/2,fy or vp.Y/2)
Menu.win.Size=UDim2.fromOffset(0,0)
tw(Menu.win,0.6,{Size=UDim2.fromOffset(WW,WH),Position=UDim2.fromOffset(vp.X/2,vp.Y/2)})
end
local function closeMenu()
if not Menu.built or not Menu.visible then return end
Menu.visible=false
local t=tw(Menu.win,0.35,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
t.Completed:Connect(function() Menu.sg.Enabled=false end)
end
local function toggle()
if Menu.visible then closeMenu() else
local vp=workspace.CurrentCamera.ViewportSize
openMenu(vp.X/2,vp.Y/2)
end
end
local function runWelcome(onDone)
local sg=Instance.new("ScreenGui")
sg.ResetOnSpawn=false;sg.IgnoreGuiInset=true
sg.DisplayOrder=1000;sg.Parent=CG
local dim=Instance.new("Frame")
dim.Size=UDim2.fromScale(1,1);dim.BackgroundColor3=Color3.new(0,0,0)
dim.BackgroundTransparency=0.45;dim.BorderSizePixel=0;dim.Parent=sg
local win=Instance.new("Frame")
win.Size=UDim2.fromOffset(WW,WH);win.Position=UDim2.fromScale(0.5,0.5)
win.AnchorPoint=Vector2.new(0.5,0.5);win.BackgroundColor3=Color3.fromRGB(8,8,10)
win.BorderSizePixel=0;win.ZIndex=1;win.Parent=sg
local wc=Instance.new("UICorner");wc.CornerRadius=UDim.new(0,16);wc.Parent=win
local ws=Instance.new("UIStroke");ws.Color=Color3.fromRGB(60,60,70);ws.Thickness=1;ws.Parent=win
local glass=Instance.new("Frame")
glass.BackgroundColor3=WHITE;glass.BackgroundTransparency=0.9
glass.Size=UDim2.fromOffset(420,180);glass.Position=UDim2.fromScale(0.5,0.5)
glass.AnchorPoint=Vector2.new(0.5,0.5);glass.ZIndex=3;glass.Parent=win
local gc=Instance.new("UICorner");gc.CornerRadius=UDim.new(0,28);gc.Parent=glass
local gs=Instance.new("UIStroke");gs.Color=WHITE;gs.Thickness=1;gs.Transparency=0.5;gs.Parent=glass
local lh=Instance.new("Frame")
lh.BackgroundTransparency=1;lh.Size=UDim2.fromScale(1,1)
lh.ZIndex=4;lh.Parent=glass
local ll=Instance.new("UIListLayout")
ll.FillDirection=Enum.FillDirection.Horizontal
ll.HorizontalAlignment=Enum.HorizontalAlignment.Center
ll.VerticalAlignment=Enum.VerticalAlignment.Center
ll.SortOrder=Enum.SortOrder.LayoutOrder;ll.Padding=UDim.new(0,-6);ll.Parent=lh
local letters={}
for i=1,#HELLO do
local lbl=Instance.new("TextLabel")
lbl.BackgroundTransparency=1;lbl.Size=UDim2.fromOffset(72,140)
lbl.Font=Enum.Font.IndieFlower;lbl.TextSize=100
lbl.Text=HELLO:sub(i,i);lbl.TextColor3=WHITE
lbl.TextTransparency=1;lbl.TextXAlignment=Enum.TextXAlignment.Center
lbl.TextYAlignment=Enum.TextYAlignment.Center;lbl.ZIndex=4
lbl.LayoutOrder=i;lbl.Position=UDim2.fromOffset(-50,0);lbl.Parent=lh
table.insert(letters,lbl)
end
local wl=Instance.new("TextLabel")
wl.BackgroundTransparency=1;wl.Size=UDim2.fromOffset(400,22)
wl.Position=UDim2.new(0.5,0,1,-92);wl.AnchorPoint=Vector2.new(0.5,0)
wl.Font=Enum.Font.Gotham;wl.TextSize=15;wl.TextColor3=MUTED
wl.TextTransparency=1;wl.Text=WELCOME;wl.ZIndex=4;wl.Parent=win
local btn=Instance.new("TextButton")
btn.Size=UDim2.fromOffset(220,46);btn.Position=UDim2.new(0.5,0,1,-54)
btn.AnchorPoint=Vector2.new(0.5,0);btn.BackgroundColor3=WHITE
btn.BackgroundTransparency=1;btn.Text="";btn.AutoButtonColor=false
btn.ZIndex=5;btn.Parent=win
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(1,0);bc.Parent=btn
local bs=Instance.new("UIStroke");bs.Color=WHITE;bs.Thickness=1;bs.Transparency=1;bs.Parent=btn
local bl=Instance.new("TextLabel")
bl.BackgroundTransparency=1;bl.Size=UDim2.fromScale(1,1)
bl.Font=Enum.Font.GothamMedium;bl.TextSize=15
bl.TextColor3=WHITE;bl.TextTransparency=1;bl.Text=BTN
bl.ZIndex=6;bl.Parent=btn
task.spawn(function()
task.wait(0.35)
for _,l in ipairs(letters) do
tw(l,0.4,{TextTransparency=0},Enum.EasingStyle.Cubic)
tw(l,0.5,{Position=UDim2.fromOffset(0,0)})
task.wait(0.1)
end
end
task.wait(0.4)
tw(wl,0.6,{TextTransparency=0})
tw(btn,0.6,{BackgroundTransparency=0.85})
tw(bs,0.6,{Transparency=0.4})
tw(bl,0.6,{TextTransparency=0})
end)
btn.MouseButton1Click:Connect(function()
tw(wl,0.3,{TextTransparency=1})
tw(bl,0.3,{TextTransparency=1})
tw(btn,0.3,{BackgroundTransparency=1})
tw(bs,0.3,{Transparency=1})
tw(glass,0.3,{BackgroundTransparency=1})
tw(gs,0.3,{Transparency=1})
for _,l in ipairs(letters) do tw(l,0.25,{TextTransparency=1}) end
task.wait(0.35)
local wAbs=win.AbsolutePosition
local wSize=win.AbsoluteSize
explode(wAbs.X+wSize.X/2,wAbs.Y+wSize.Y/2)
tw(win,0.4,{Size=UDim2.fromOffset(0,0)},Enum.EasingStyle.Quart,Enum.EasingDirection.In)
task.wait(0.5)
sg:Destroy()
if onDone then onDone() end
end)
end
UIS.InputBegan:Connect(function(i,gp)
if gp then return end
if i.KeyCode==Enum.KeyCode.K then toggle() end
end)
runWelcome(function() openMenu() end)
_G.EnoisMenu=Menu
_G.EnoisToggle=toggle

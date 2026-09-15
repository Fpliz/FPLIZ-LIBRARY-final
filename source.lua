--[[
    Compkiller Interface - ENHANCED EDITION v3.0
    Original: 4lpaca (https://github.com/4lpaca-pin/CompKiller)
    Enhanced: Fpliz
    License: MIT
]]

export type cloneref = (target: Instance) -> Instance;
export type Window = {Name: string, Keybind: string | Enum.KeyCode, Logo: string, Scale: UDim2, TextSize: number};
export type ConfigManager = {Directory: string, Config: string};
export type WriteConfig = {Name: string, Author: string};
export type WindowUpdate = {Username: string, ExpireDate: string, Logo: string, WindowName: string, UserProfile: string};
export type ConfigFunctions = {
    Directory: string,
    WriteConfig: (self: ConfigFunctions, Config: WriteConfig) -> any?,
    ReadInfo: (self: ConfigFunctions, ConfigName: string) -> any?,
    DeleteConfig: (self: ConfigFunctions, ConfigName: string) -> any?,
    LoadConfig: (self: ConfigFunctions, ConfigName: string) -> any?,
    GetConfigs: (self: ConfigFunctions, ConfigName: string) -> {string},
    GetConfigCount: (self: ConfigFunctions) -> number,
    GetFullConfigs: (self: ConfigFunctions, ConfigName: string) -> {{Name: string, Info: {Type: string, Author: string, Name: string, CreatedDate: string}}},
};
export type KeybindSettings = {Key: string, On: boolean | number, Off: boolean | number, Mode: number, Name: string};
export type SecurityConfig = {BlurEnabled: boolean, ImageScale: number};
export type Notify = {Icon: string, Title: string, Content: string, Duration: number, Type: string?};
export type NotifyPayback = {SetProgress: (self: Notify, time: number) -> any?, Content: (self: Notify, str: string) -> any?, Title: (self: Notify, str: string) -> any?, Close: () -> any?};
export type Watermark = {Icon: string, Text: string};
export type TabConfig = {Name: string, Icon: string, Type: string, EnableScrolling: boolean};
export type TabConfigManager = {Name: string, Icon: string, Config: ConfigFunctions};
export type ContainerTab = {Name: string, Icon: string, EnableScrolling: boolean};
export type Category = {Name: string};
export type Section = {Name: string, Position: string};
export type Toggle = {Name: string, Default: boolean, Flag: string | nil, Risky: boolean, Callback: (Value: boolean) -> any?};
export type MiniToggle = {Default: boolean, Flag: string | nil, Callback: (Value: boolean) -> any?};
export type TextBoxConfig = {Name: string, Default: string, Placeholder: string, Flag: string | nil, Numeric: boolean, Callback: (Text: string) -> any?};
export type ColorPicker = {Name: string, Default: Color3, Flag: string | nil, Transparency: number, Callback: (Value: Color3, Trans: number) -> any?};
export type MiniColorPicker = {Default: Color3, Transparency: number, Flag: string | nil, Callback: (Value: Color3, Trans: number) -> any?};
export type Slider = {Name: string, Min: number, Max: number, Default: number, Type: string, Round: number, Callback: (Value: number) -> any?};
export type Dropdown = {Name: string, Default: string | {string}, Values: {string}, Multi: boolean, Callback: (Value: string | {[string]: boolean}) -> any?};
export type Button = {Name: string, Callback: () -> any?};
export type Keybind = {Name: string, Default: string | Enum.KeyCode, Callback: (Value: string) -> any, Blacklist: {string | Enum.KeyCode}};
export type MiniKeybind = {Default: string | Enum.KeyCode, Callback: (Value: string) -> any, Blacklist: {string | Enum.KeyCode}};
export type Helper = {Text: string};
export type Paragraph = {Title: string, Content: string};

pcall(function()
    local Constant = table.concat({"LP","H_NO"}).."_VI".."RTU".."AL".."IZE";
    getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end);
pcall(function()
    local Constant = "IB".."_NO_VI".."RTU".."AL".."IZE";
    getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end);

getgenv = getgenv or getfenv;

if game:GetService('RunService'):IsStudio() then
    local BaseWorkspace = Instance.new('Folder',game:GetService("ReplicatedFirst"));
    BaseWorkspace.Name = tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));
    local __get_path_c = function(path)
        return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
    end;
    local __get_path = function(path)
        local main = __get_path_c(path);
        local block = BaseWorkspace;
        for i,v in next , main do block = block[v]; end;
        return block;
    end;
    getgenv().readfile = function(path) local path = __get_path(path); return path.Value; end;
    getgenv().isfile = function(path)
        local success , message = pcall(function() return __get_path(path); end);
        if success and not message:IsA("Folder") then return true; end;
        return false;
    end;
    getgenv().isfolder = function(path)
        local success , message = pcall(function() return __get_path(path); end);
        if success and message:IsA("Folder") then return true; end;
        return false;
    end;
    getgenv().writefile = function(path,content)
        local main = __get_path_c(path);
        local block = BaseWorkspace;
        for i,v in next , main do
            local item = block:FindFirstChild(v);
            if not item then
                local c = Instance.new('StringValue',block);
                c.Name = tostring(v); c.Value = content;
            else
                if item:IsA('StringValue') and tostring(item) == v then
                    item.Name = tostring(v); item.Value = content;
                end;
                block = item;
            end;
        end;
    end;
    getgenv().listfiles = function(path)
        local fold = __get_path(path); local pa = {};
        for i,v in next , fold:GetChildren() do
            if v:IsA('StringValue') then table.insert(pa,path..'/'..tostring(v)); end;
        end;
        return pa;
    end;
    getgenv().makefolder = function(path)
        local main = __get_path_c(path); local block = BaseWorkspace;
        for i,v in next , main do
            local item = block:FindFirstChild(v);
            if not item then
                local c = Instance.new('Folder',block); c.Name = tostring(v);
            else block = item; end;
        end;
    end;
    getgenv().delfile = function(path)
        local main = __get_path_c(path); local block = BaseWorkspace;
        for i,v in next , main do
            local item = block:FindFirstChild(v);
            if item and item:IsA('StringValue') then item:Destroy(); else block = item; end;
        end;
    end;
end;

local cloneref = cloneref or function(f) return f end;
local TweenService = cloneref(game:GetService('TweenService'));
local UserInputService = cloneref(game:GetService('UserInputService'));
local TextService = cloneref(game:GetService('TextService'));
local RunService = cloneref(game:GetService('RunService'));
local Players = cloneref(game:GetService('Players'));
local HttpService = cloneref(game:GetService('HttpService'));
local SoundService = cloneref(game:GetService('SoundService'));
local LocalPlayer = Players.LocalPlayer;
local CoreGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse = LocalPlayer:GetMouse();
local CurrentCamera = cloneref(workspace.CurrentCamera);

local Compkiller = {
    Version = '3.0-Enhanced',
    Logo = "rbxassetid://120245531583106",
    Windows = {},
    Scale = {Window = UDim2.new(0, 485,0, 565), Mobile = UDim2.new(0, 450,0, 375), TabOpen = 185, TabClose = 85},
    PerformanceMode = false,
    WindowsNil = {},
    NilFolder = Instance.new('Folder'),
    ArcylicParent = CurrentCamera,
    ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end,
};

Compkiller.Colors = {
    Highlight = Color3.fromRGB(139, 92, 246), Toggle = Color3.fromRGB(167, 139, 250),
    Risky = Color3.fromRGB(251, 191, 36), BGDBColor = Color3.fromRGB(15, 15, 18),
    BlockColor = Color3.fromRGB(22, 22, 26), StrokeColor = Color3.fromRGB(38, 38, 45),
    SwitchColor = Color3.fromRGB(250, 250, 252), DropColor = Color3.fromRGB(32, 32, 38),
    MouseEnter = Color3.fromRGB(48, 42, 70), BlockBackground = Color3.fromRGB(28, 26, 36),
    LineColor = Color3.fromRGB(45, 40, 58), HighStrokeColor = Color3.fromRGB(60, 50, 90),
};

Compkiller.Elements = {
    Highlight = {}, DropHighlight = {}, Risky = {}, BGDBColor = {}, BlockColor = {},
    StrokeColor = {}, SwitchColor = {}, DropColor = {}, BlockBackground = {}, LineColor = {}, HighStrokeColor = {},
};

Compkiller.DragBlacklist = {};
Compkiller.IaDrag = false;
Compkiller.LastDrag = tick();
Compkiller.Flags = {};

-- ===== SISTEMA DE SONS (com ID fornecido) =====
Compkiller.Sounds = {
    Enabled = true, Volume = 0.5,
    Click = "rbxassetid://139719503904449",
    Hover = "rbxassetid://139719503904449",
    ToggleOn = "rbxassetid://139719503904449",
    ToggleOff = "rbxassetid://139719503904449",
    TabSwitch = "rbxassetid://139719503904449",
    Open = "rbxassetid://139719503904449",
    Close = "rbxassetid://139719503904449",
    Success = "rbxassetid://139719503904449",
    Error = "rbxassetid://139719503904449",
    Warning = "rbxassetid://139719503904449",
    Info = "rbxassetid://139719503904449",
    Typing = "rbxassetid://139719503904449",
    Slider = "rbxassetid://139719503904449",
    Dropdown = "rbxassetid://139719503904449",
};

local SoundCache = {};
function Compkiller:PlaySound(name, pitch, volume)
    if not Compkiller.Sounds.Enabled then return end;
    local id = Compkiller.Sounds[name];
    if not id then return end;
    local sound = SoundCache[id];
    if not sound then
        sound = Instance.new("Sound");
        sound.SoundId = id;
        sound.Parent = SoundService;
        SoundCache[id] = sound;
    end;
    sound.Volume = (volume or Compkiller.Sounds.Volume);
    sound.PlaybackSpeed = pitch or 1;
    sound:Play();
end;

-- ===== AUTO-SAVE =====
Compkiller._AutoSave = {Enabled = false, Config = nil, Name = "auto", Interval = 30};
function Compkiller:EnableAutoSave(ConfigManager, name, interval)
    Compkiller._AutoSave.Enabled = true;
    Compkiller._AutoSave.Config = ConfigManager;
    Compkiller._AutoSave.Name = name or "auto";
    Compkiller._AutoSave.Interval = interval or 30;
    task.spawn(function()
        while Compkiller._AutoSave.Enabled do
            task.wait(Compkiller._AutoSave.Interval);
            if Compkiller._AutoSave.Config then
                pcall(function()
                    Compkiller._AutoSave.Config:WriteConfig({
                        Name = Compkiller._AutoSave.Name,
                        Author = LocalPlayer.Name,
                    });
                end);
            end;
        end;
    end);
    return true;
end;
function Compkiller:DisableAutoSave()
    Compkiller._AutoSave.Enabled = false;
    return true;
end;

-- ===== BUSCA DE ELEMENTOS =====
function Compkiller:SearchElements(query)
    query = string.lower(query or "");
    if query == "" then return {} end;
    local results = {};
    for _, window in pairs(Compkiller.Windows) do
        for _, desc in pairs(window:GetDescendants()) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                if string.find(string.lower(desc.Text or ""), query, 1, true) then
                    table.insert(results, {Element = desc, Text = desc.Text, Window = window});
                end;
            end;
        end;
    end;
    return results;
end;

Compkiller.Lucide = {
    ['lucide-mouse-2'] = "rbxassetid://10088146939",
    ['lucide-internet'] = "rbxassetid://12785195438",
    ['lucide-earth'] = "rbxassetid://115986292591138",
    ['lucide-settings-3'] = "rbxassetid://14007344336",
    ['lucide-home'] = "rbxassetid://10723407389",
    ['lucide-settings'] = "rbxassetid://10734950309",
    ['lucide-user'] = "rbxassetid://10747373176",
    ['lucide-shield'] = "rbxassetid://10734951847",
    ['lucide-sword'] = "rbxassetid://10734975486",
    ['lucide-target'] = "rbxassetid://10734977012",
    ['lucide-zap'] = "rbxassetid://10709752035",
    ['lucide-star'] = "rbxassetid://10734966248",
    ['lucide-heart'] = "rbxassetid://10723406885",
    ['lucide-eye'] = "rbxassetid://10723346959",
    ['lucide-lock'] = "rbxassetid://10723434711",
    ['lucide-key'] = "rbxassetid://10723416652",
    ['lucide-bell'] = "rbxassetid://10709775704",
    ['lucide-search'] = "rbxassetid://10734943674",
    ['lucide-play'] = "rbxassetid://10734923549",
    ['lucide-pause'] = "rbxassetid://10734919336",
    ['lucide-plus'] = "rbxassetid://10734924532",
    ['lucide-minus'] = "rbxassetid://10734896206",
    ['lucide-x'] = "rbxassetid://10747384394",
    ['lucide-check'] = "rbxassetid://10709790644",
    ['lucide-info'] = "rbxassetid://10723415903",
    ['lucide-alert-circle'] = "rbxassetid://10709752996",
    ['lucide-activity'] = "rbxassetid://10709752035",
    ['lucide-box'] = "rbxassetid://10709782497",
    ['lucide-gift'] = "rbxassetid://10723396402",
    ['lucide-palette'] = "rbxassetid://10734910430",
    ['lucide-camera'] = "rbxassetid://10709789686",
    ['lucide-image'] = "rbxassetid://10723415040",
    ['lucide-video'] = "rbxassetid://10747374938",
    ['lucide-music'] = "rbxassetid://10734905958",
    ['lucide-gamepad'] = "rbxassetid://10723395457",
    ['lucide-terminal'] = "rbxassetid://10734982144",
    ['lucide-code'] = "rbxassetid://10709810463",
    ['lucide-cpu'] = "rbxassetid://10709813383",
    ['lucide-server'] = "rbxassetid://10734949856",
    ['lucide-globe'] = "rbxassetid://10723404337",
    ['lucide-map'] = "rbxassetid://10734886202",
    ['lucide-compass'] = "rbxassetid://10709811445",
    ['lucide-wrench'] = "rbxassetid://10747383470",
    ['lucide-save'] = "rbxassetid://10734941499",
    ['lucide-download'] = "rbxassetid://10723344270",
    ['lucide-upload'] = "rbxassetid://10747366434",
    ['lucide-filter'] = "rbxassetid://10723375128",
    ['lucide-list'] = "rbxassetid://10723433811",
    ['lucide-grid'] = "rbxassetid://10723404936",
    ['lucide-layers'] = "rbxassetid://10723424505",
    ['lucide-crown'] = "rbxassetid://10709818626",
    ['lucide-diamond'] = "rbxassetid://10709819149",
    ['lucide-flame'] = "rbxassetid://10723376114",
    ['lucide-rocket'] = "rbxassetid://10734934585",
};

Compkiller.FontAwesome = {
    discord = "rbxassetid://75871011309830",
    github = "rbxassetid://123783733365919",
    user = "rbxassetid://98376828270066",
    gear = "rbxassetid://137945854328407",
    house = "rbxassetid://86540166012974",
    info = "rbxassetid://113157514619684",
    lock = "rbxassetid://80031239225283",
    shield = "rbxassetid://73441026473893",
    trash = "rbxassetid://82859108629080",
    skull = "rbxassetid://99276754296574",
    robot = "rbxassetid://134497060038109",
    tag = "rbxassetid://129024358125754",
    video = "rbxassetid://112274059143251",
    ['magnifying-glass'] = "rbxassetid://74387839235930",
};

function Compkiller:OptimizeMode(v) Compkiller.PerformanceMode = v; end;
function Compkiller:IsStudio() return RunService:IsStudio() end;
function Compkiller:CustomIconHighlight() Compkiller.CustomHighlightMode = true; end;

function Compkiller:_SetNilP(Ins, Parent)
    Compkiller.WindowsNil = Compkiller.WindowsNil or {};
    Compkiller.NilFolder = Compkiller.NilFolder or Instance.new('Folder');
    if not Compkiller.WindowsNil[Ins] then
        local win = Compkiller:_GetWindowFromElement(Ins);
        Compkiller.WindowsNil[Ins] = win;
    end;
    Ins.Parent = Parent or Compkiller.NilFolder;
end;

function Compkiller:SetAllText(flags)
    if not flags then
        for i,v in next , Compkiller.Flags do
            if v.SetText then v:SetText(nil); end;
        end;
        return;
    end;
    flags = flags or {};
    for i,v in next , flags do
        if Compkiller.Flags[i] and Compkiller.Flags[i].SetText then
            Compkiller.Flags[i]:SetText(v);
        end;
    end;
end;

function Compkiller:_GetIcon(name, font_aws)
    if Compkiller.SecureMode then
        local AssetId;
        if font_aws then AssetId = Compkiller.FontAwesome[name] or name;
        else AssetId = Compkiller.Lucide['lucide-'..tostring(name)] or Compkiller.Lucide[name] or Compkiller.Lucide[tostring(name)] or Compkiller.FontAwesome[name] or name; end;
        if AssetId and AssetId ~= nil then return AssetId; end;
        return "";
    end;
    if font_aws then return Compkiller.FontAwesome[name] or name; end;
    return Compkiller.Lucide['lucide-'..tostring(name)] or Compkiller.Lucide[name] or Compkiller.Lucide[tostring(name)] or Compkiller.FontAwesome[name] or name;
end;

function Compkiller:_RandomString()
    return "CK="..string.char(math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102),math.random(64,102));
end;

function Compkiller:_IsMouseOverFrame(Frame)
    if not Frame then return; end;
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize;
    if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
        return true;
    end;
end;

function Compkiller:_Rounding(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0);
    return math.floor(num * mult + 0.5) / mult;
end;

function Compkiller:_Animation(Self, Info, Property)
    local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);
    Tween:Play();
    return Tween;
end;

function Compkiller:_Input(Frame, Callback)
    local Button = Instance.new('TextButton',Frame);
    Button.ZIndex = Frame.ZIndex + 10;
    Button.Size = UDim2.fromScale(1,1);
    Button.BackgroundTransparency = 1;
    Button.TextTransparency = 1;
    if Callback then Button.MouseButton1Click:Connect(Callback); end;
    return Button;
end;

function Compkiller:GetCalculatePosition(planePos, planeNormal, rayOrigin, rayDirection)
    local n = planeNormal; local d = rayDirection; local v = rayOrigin - planePos;
    local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
    local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
    local a = -num / den;
    return rayOrigin + (a * rayDirection);
end;

function Compkiller:_Blur(element, WindowRemote)
    if Compkiller.SecureMode and not Compkiller.SecurityConfig.BlurEnabled then return game.Changed:Connect(function() end); end;
    local Part = Instance.new('Part',Compkiller.ArcylicParent);
    local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
    local BlockMesh = Instance.new("BlockMesh");
    local userSettings = UserSettings():GetService("UserGameSettings");
    BlockMesh.Parent = Part;
    Part.Material = Enum.Material.Glass;
    Part.Transparency = 1;
    Part.Reflectance = 1;
    Part.CastShadow = false;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CollisionGroup = Compkiller:_RandomString();
    Part.Size = Vector3.new(1, 1, 1) * 0.01;
    Part.Color = Color3.fromRGB(0,0,0);
    DepthOfField.Enabled = true;
    DepthOfField.FarIntensity = 0;
    DepthOfField.FocusDistance = 0;
    DepthOfField.InFocusRadius = 1000;
    DepthOfField.NearIntensity = 1;
    DepthOfField.Name = Compkiller:_RandomString();
    Part.Name = Compkiller:_RandomString();
    local disconnect;
    local UpdateFunction = function()
        if Compkiller.SecureMode then
            if Part then Part:Destroy(); Part = nil; end;
            if DepthOfField then DepthOfField:Destroy(); DepthOfField = nil; end;
            if BlockMesh then BlockMesh:Destroy(); BlockMesh = nil; end;
            if disconnect then disconnect(); disconnect = nil; end;
            return;
        end;
        local IsWindowActive = WindowRemote:GetValue();
        if IsWindowActive then
            Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{NearIntensity = 1})
            Compkiller:_Animation(Part,TweenInfo.new(0.1),{Transparency = 0.97, Size = Vector3.new(1, 1, 1) * 0.01;})
        else
            Compkiller:_Animation(DepthOfField,TweenInfo.new(0.1),{NearIntensity = 0})
            Compkiller:_Animation(Part,TweenInfo.new(0.1),{Size = Vector3.zero, Transparency = 1.5,})
            return false;
        end;
        if IsWindowActive then
            local corner0 = element.AbsolutePosition;
            local corner1 = corner0 + element.AbsoluteSize;
            local ray0 = CurrentCamera:ScreenPointToRay(corner0.X, corner0.Y, 1);
            local ray1 = CurrentCamera:ScreenPointToRay(corner1.X, corner1.Y, 1);
            local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);
            local planeNormal = CurrentCamera.CFrame.LookVector;
            local pos0 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
            local pos1 = Compkiller:GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);
            pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
            pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);
            local size = pos1 - pos0; local center = (pos0 + pos1) / 2;
            BlockMesh.Offset = center; BlockMesh.Scale = size / 0.0101;
            Part.CFrame = CurrentCamera.CFrame;
        end;
    end;
    local rbxsignal = CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction)
    local loopThread = UserInputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            pcall(UpdateFunction);
        end;
    end);
    local THREAD = task.spawn(function() while true do task.wait(0.1) pcall(UpdateFunction); end; end);
    disconnect = function()
        rbxsignal:Disconnect(); loopThread:Disconnect(); task.cancel(THREAD);
        Part:Destroy(); DepthOfField:Destroy();
    end;
    element.Destroying:Connect(disconnect);
    return rbxsignal;
end;

function Compkiller:_AddDragBlacklist(Frame)
    local IsAdded = false; local BASE_TIME = 0.01;
    local SET_BLACKLIST = function(value)
        local index = table.find(Compkiller.DragBlacklist , Frame);
        if value and not Compkiller.IS_DRAG_MOVE then
            if not index then table.insert(Compkiller.DragBlacklist,Frame); end;
        else
            if index then table.remove(Compkiller.DragBlacklist,index); end;
        end;
    end;
    Frame.InputBegan:Connect(function(input) if Compkiller:_IsMouseOverFrame(Frame) then SET_BLACKLIST(true) end; end);
    Frame.InputEnded:Connect(function(input) SET_BLACKLIST(false); end);
    UserInputService.InputChanged:Connect(function() if not Compkiller:_IsMouseOverFrame(Frame) then SET_BLACKLIST(false); end end);
end;

function Compkiller:_GetWindowFromElement(Element)
    if Compkiller.WindowsNil[Element] then return Compkiller.WindowsNil[Element]; end;
    for i,v in next , Compkiller.Windows do if v and Element:IsDescendantOf(v) then return v; end; end;
    for Frame,Window in next , Compkiller.WindowsNil do
        if Element:IsDescendantOf(Frame) or Frame == Element then return Window; end;
    end;
end;

function Compkiller.__SIGNAL(default)
    local Bindable = Instance.new('BindableEvent');
    Bindable.Name = string.sub(tostring({}),7);
    Bindable:SetAttribute('Value',default);
    local Binds = {__signals = {}};
    function Binds:Connect(event)
        event(Bindable:GetAttribute("Value"));
        local signal = Bindable.Event:Connect(event);
        table.insert(Binds.__signals,signal);
        return signal;
    end;
    function Binds:Fire(value)
        local IsSame = Bindable:GetAttribute("Value") == value;
        Bindable:SetAttribute('Value',value);
        if not IsSame then Bindable:Fire(value); end;
    end;
    function Binds:GetValue() return Bindable:GetAttribute("Value"); end;
    return Binds;
end;

function Compkiller:_Hover(Frame, OnHover, Release)
    Frame.MouseEnter:Connect(OnHover);
    Frame.MouseLeave:Connect(Release);
end;

function Compkiller.__CONFIG(config, default)
    config = config or {};
    for i,v in next , default do
        if config[i] == nil then config[i] = v; end;
    end;
    return config;
end;

function Compkiller:Drag(InputFrame, MoveFrame, Speed)
    local dragToggle = false; local dragStart = nil; local startPos = nil; local Tween = TweenInfo.new(Speed);
    local updateInput = function(input)
        local delta = input.Position - dragStart;
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
        Compkiller:_Animation(MoveFrame,Tween,{Position = position});
    end;
    InputFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and #Compkiller.DragBlacklist <= 0 then
            dragToggle = true
            dragStart = input.Position
            startPos = MoveFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false;
                    Compkiller.IS_DRAG_MOVE = false;
                end
            end)
        end
        if not Compkiller.IsDrage and dragToggle then Compkiller.LastDrag = tick(); end;
        Compkiller.IaDrag = dragToggle;
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch and #Compkiller.DragBlacklist <= 0 then
            if dragToggle then
                Compkiller.IS_DRAG_MOVE = true;
                updateInput(input)
            else Compkiller.IS_DRAG_MOVE = false; end
        else
            if #Compkiller.DragBlacklist > 0 then
                dragToggle = false
                Compkiller.IS_DRAG_MOVE = false;
            end
        end
        Compkiller.IaDrag = dragToggle;
    end);
end;

function Compkiller:_IsMobile() return UserInputService.TouchEnabled; end;

-- ============================================================
-- _AddLinkValue : conecta flag e sincroniza mudanças
-- ============================================================
function Compkiller:_AddLinkValue(flagName, obj)
    if not flagName then return obj end;
    obj.Flag = flagName;
    Compkiller.Flags[flagName] = obj;
    obj.SetText = obj.SetText or function(self, v) end;
    obj.SetValue = obj.SetValue or function(self, v) end;
    obj.GetValue = obj.GetValue or function(self) return nil end;
    return obj;
end;

-- ============================================================
-- _CreateBlock : cria bloco / seção
-- ============================================================
function Compkiller:_CreateBlock(parent, info)
    info = Compkiller.__CONFIG(info, {Name = "Section", Position = "left"});
    local Section = Instance.new("Frame");
    Section.Name = info.Name;
    Section.BackgroundColor3 = Compkiller.Colors.BlockColor;
    Section.BackgroundTransparency = 1;
    Section.BorderSizePixel = 0;
    Section.Size = UDim2.new(1, 0, 0, 30);
    Section.AutomaticSize = Enum.AutomaticSize.Y;
    Section.Parent = parent;

    local Title = Instance.new("TextLabel");
    Title.Name = "Title";
    Title.BackgroundTransparency = 1;
    Title.Size = UDim2.new(1, -6, 0, 24);
    Title.Position = UDim2.new(0, 6, 0, 0);
    Title.Font = Enum.Font.GothamMedium;
    Title.Text = info.Name;
    Title.TextColor3 = Color3.fromRGB(200, 200, 210);
    Title.TextSize = 13;
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.Parent = Section;

    local Holder = Instance.new("Frame");
    Holder.Name = "Holder";
    Holder.BackgroundTransparency = 1;
    Holder.Position = UDim2.new(0, 0, 0, 28);
    Holder.Size = UDim2.new(1, 0, 0, 0);
    Holder.AutomaticSize = Enum.AutomaticSize.Y;
    Holder.Parent = Section;

    local UIList = Instance.new("UIListLayout");
    UIList.Padding = UDim.new(0, 6);
    UIList.SortOrder = Enum.SortOrder.LayoutOrder;
    UIList.Parent = Holder;

    local Padding = Instance.new("UIPadding");
    Padding.PaddingTop = UDim.new(0, 4);
    Padding.PaddingBottom = UDim.new(0, 4);
    Padding.PaddingLeft = UDim.new(0, 4);
    Padding.PaddingRight = UDim.new(0, 4);
    Padding.Parent = Holder;

    return Section, Holder;
end;

-- ============================================================
-- _AddColorPickerPanel : painel de cor estilo HSV
-- ============================================================
function Compkiller:_AddColorPickerPanel(parent, defaultColor, transparency, callback)
    defaultColor = defaultColor or Color3.fromRGB(139, 92, 246);
    transparency = transparency or 0;
    local h, s, v = Color3.toHSV(defaultColor);

    local Panel = Instance.new("Frame");
    Panel.Name = "ColorPickerPanel";
    Panel.BackgroundColor3 = Compkiller.Colors.BlockBackground;
    Panel.BorderSizePixel = 0;
    Panel.Size = UDim2.new(1, 0, 0, 160);
    Panel.Parent = parent;

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = Panel;

    local Stroke = Instance.new("UIStroke");
    Stroke.Color = Compkiller.Colors.LineColor;
    Stroke.Thickness = 1;
    Stroke.Parent = Panel;

    -- Área S/V (gradiente)
    local SV = Instance.new("Frame");
    SV.Name = "SV";
    SV.BackgroundColor3 = Color3.fromHSV(h, 1, 1);
    SV.BorderSizePixel = 0;
    SV.Position = UDim2.new(0, 8, 0, 8);
    SV.Size = UDim2.new(1, -16, 0, 100);
    SV.Parent = Panel;
    local svCorner = Instance.new("UICorner"); svCorner.CornerRadius = UDim.new(0, 4); svCorner.Parent = SV;

    local WhiteGrad = Instance.new("Frame", SV);
    WhiteGrad.BackgroundColor3 = Color3.new(1,1,1); WhiteGrad.BorderSizePixel = 0;
    WhiteGrad.Size = UDim2.new(1,0,1,0); WhiteGrad.BackgroundTransparency = 0.0;
    local wg = Instance.new("UIGradient", WhiteGrad);
    wg.Color = ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1));
    wg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    });
    wg.Rotation = 90;
    local wgc = Instance.new("UICorner"); wgc.CornerRadius = UDim.new(0,4); wgc.Parent = WhiteGrad;

    local BlackGrad = Instance.new("Frame", SV);
    BlackGrad.BackgroundColor3 = Color3.new(0,0,0); BlackGrad.BorderSizePixel = 0;
    BlackGrad.Size = UDim2.new(1,0,1,0);
    local bg = Instance.new("UIGradient", BlackGrad);
    bg.Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0));
    bg.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0),
    });
    local bgc = Instance.new("UICorner"); bgc.CornerRadius = UDim.new(0,4); bgc.Parent = BlackGrad;

    local SVInput = Compkiller:_Input(SV);
    local SVCursor = Instance.new("Frame", SV);
    SVCursor.Size = UDim2.new(0, 8, 0, 8);
    SVCursor.BackgroundColor3 = Color3.new(1,1,1);
    SVCursor.BorderSizePixel = 0;
    SVCursor.ZIndex = 5;
    local sc = Instance.new("UICorner"); sc.CornerRadius = UDim.new(1,0); sc.Parent = SVCursor;
    local sstroke = Instance.new("UIStroke"); sstroke.Color = Color3.new(0,0,0); sstroke.Thickness = 1; sstroke.Parent = SVCursor;

    local function updateSV()
        local absPos = SV.AbsolutePosition;
        local absSize = SV.AbsoluteSize;
        SVCursor.Position = UDim2.new(s, 0, 1 - v, 0) - UDim2.new(0, 4, 0, 4);
        SV.BackgroundColor3 = Color3.fromHSV(h, 1, 1);
    end;
    updateSV();

    local sDragging = false;
    SVInput.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            sDragging = true;
        end;
    end);
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            sDragging = false;
        end;
    end);
    UserInputService.InputChanged:Connect(function(i)
        if sDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local absPos = SV.AbsolutePosition;
            local absSize = SV.AbsoluteSize;
            local mx = math.clamp((Mouse.X - absPos.X) / absSize.X, 0, 1);
            local my = math.clamp((Mouse.Y - absPos.Y) / absSize.Y, 0, 1);
            s = mx; v = 1 - my;
            updateSV();
            local newColor = Color3.fromHSV(h, s, v);
            if callback then callback(newColor, transparency) end;
        end;
    end);

    -- Barra de Hue
    local Hue = Instance.new("Frame");
    Hue.BackgroundColor3 = Color3.new(1,1,1);
    Hue.BorderSizePixel = 0;
    Hue.Position = UDim2.new(0, 8, 0, 116);
    Hue.Size = UDim2.new(1, -16, 0, 14);
    Hue.Parent = Panel;
    local hc = Instance.new("UICorner"); hc.CornerRadius = UDim.new(0,4); hc.Parent = Hue;
    local hueGrad = Instance.new("UIGradient", Hue);
    local colorKeys = {};
    for i = 0, 1, 1/6 do
        table.insert(colorKeys, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)));
    end
    colorKeys[#colorKeys] = ColorSequenceKeypoint.new(1, Color3.fromHSV(0,1,1));
    hueGrad.Color = ColorSequence.new(colorKeys);

    local HueInput = Compkiller:_Input(Hue);
    local HueCursor = Instance.new("Frame", Hue);
    HueCursor.Size = UDim2.new(0, 3, 1, 4);
    HueCursor.BackgroundColor3 = Color3.new(1,1,1);
    HueCursor.BorderSizePixel = 0;
    HueCursor.ZIndex = 5;
    HueCursor.Position = UDim2.new(h, 0, 0, -2);

    local hDragging = false;
    HueInput.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hDragging = true end
    end);
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hDragging = false end
    end);
    UserInputService.InputChanged:Connect(function(i)
        if hDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local absPos = Hue.AbsolutePosition;
            local absSize = Hue.AbsoluteSize;
            h = math.clamp((Mouse.X - absPos.X) / absSize.X, 0, 1);
            HueCursor.Position = UDim2.new(h, 0, 0, -2);
            updateSV();
            local newColor = Color3.fromHSV(h, s, v);
            if callback then callback(newColor, transparency) end;
        end;
    end);

    -- Barra de Transparência
    local Alpha = Instance.new("Frame");
    Alpha.BackgroundColor3 = Color3.fromRGB(100,100,100);
    Alpha.BorderSizePixel = 0;
    Alpha.Position = UDim2.new(0, 8, 0, 136);
    Alpha.Size = UDim2.new(1, -16, 0, 14);
    Alpha.Parent = Panel;
    local ac = Instance.new("UICorner"); ac.CornerRadius = UDim.new(0,4); ac.Parent = Alpha;
    local alphaGrad = Instance.new("UIGradient", Alpha);
    alphaGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    });

    local AlphaInput = Compkiller:_Input(Alpha);
    local AlphaCursor = Instance.new("Frame", Alpha);
    AlphaCursor.Size = UDim2.new(0, 3, 1, 4);
    AlphaCursor.BackgroundColor3 = Color3.new(1,1,1);
    AlphaCursor.BorderSizePixel = 0;
    AlphaCursor.ZIndex = 5;
    AlphaCursor.Position = UDim2.new(1 - transparency, 0, 0, -2);

    local aDragging = false;
    AlphaInput.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then aDragging = true end
    end);
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then aDragging = false end
    end);
    UserInputService.InputChanged:Connect(function(i)
        if aDragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local absPos = Alpha.AbsolutePosition;
            local absSize = Alpha.AbsoluteSize;
            transparency = 1 - math.clamp((Mouse.X - absPos.X) / absSize.X, 0, 1);
            AlphaCursor.Position = UDim2.new(1 - transparency, 0, 0, -2);
            local newColor = Color3.fromHSV(h, s, v);
            if callback then callback(newColor, transparency) end;
        end;
    end);

    return Panel;
end;

-- ============================================================
-- _DrawKeybinds : desenha UI de keybinds na tela
-- ============================================================
function Compkiller:_DrawKeybinds()
    if Compkiller._KeybindFrame then
        Compkiller._KeybindFrame:Destroy();
        Compkiller._KeybindFrame = nil;
    end;
    local Frame = Instance.new("Frame");
    Frame.Name = "CompkillerKeybinds";
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.new(0, 20, 0.5, -100);
    Frame.Size = UDim2.new(0, 140, 0, 200);
    Frame.Parent = CoreGui;

    local List = Instance.new("UIListLayout", Frame);
    List.Padding = UDim.new(0, 6);
    List.SortOrder = Enum.SortOrder.LayoutOrder;

    Compkiller._KeybindFrame = Frame;
    return Frame;
end;

-- ============================================================
-- _KeybindHandler : registra e trata keybinds
-- ============================================================
Compkiller._KeybindConnections = {};
function Compkiller:_KeybindHandler(key, callback, onState, blacklist)
    blacklist = blacklist or {};
    local conn = UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end;
        local keyStr = typeof(key) == "EnumItem" and key.Name or tostring(key);
        if input.KeyCode.Name == keyStr or input.UserInputType.Name == keyStr then
            if table.find(blacklist, input.KeyCode) then return end;
            if callback then callback(keyStr, true) end;
        end;
    end);
    local conn2 = UserInputService.InputEnded:Connect(function(input, gpe)
        if gpe then return end;
        local keyStr = typeof(key) == "EnumItem" and key.Name or tostring(key);
        if input.KeyCode.Name == keyStr or input.UserInputType.Name == keyStr then
            if table.find(blacklist, input.KeyCode) then return end;
            if callback then callback(keyStr, false) end;
        end;
    end);
    table.insert(Compkiller._KeybindConnections, conn);
    table.insert(Compkiller._KeybindConnections, conn2);
    return {conn, conn2};
end;

-- ============================================================
-- _LoadOption : container de opção (bloco)
-- ============================================================
function Compkiller:_LoadOption(parent, name, height)
    local Option = Instance.new("Frame");
    Option.Name = name or "Option";
    Option.BackgroundColor3 = Compkiller.Colors.BlockBackground;
    Option.BorderSizePixel = 0;
    Option.Size = UDim2.new(1, 0, 0, height or 36);
    Option.Parent = parent;

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 6);
    UICorner.Parent = Option;

    local Stroke = Instance.new("UIStroke");
    Stroke.Color = Compkiller.Colors.LineColor;
    Stroke.Thickness = 1;
    Stroke.Parent = Option;

    return Option;
end;

-- ============================================================
-- _LoadDropdown : elemento dropdown
-- ============================================================
function Compkiller:_LoadDropdown(parent, config)
    config = Compkiller.__CONFIG(config, {
        Name = "Dropdown", Default = nil, Values = {}, Multi = false, Callback = function() end,
    });

    local Option = Compkiller:_LoadOption(parent, config.Name, 36);
    Compkiller:_AddDragBlacklist(Option);

    local Title = Instance.new("TextLabel");
    Title.BackgroundTransparency = 1;
    Title.Size = UDim2.new(1, -80, 1, 0);
    Title.Position = UDim2.new(0, 12, 0, 0);
    Title.Font = Enum.Font.Gotham;
    Title.Text = config.Name;
    Title.TextColor3 = Color3.fromRGB(230, 230, 235);
    Title.TextSize = 13;
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.Parent = Option;

    local Selected = Instance.new("TextLabel");
    Selected.BackgroundTransparency = 1;
    Selected.Size = UDim2.new(0, 60, 1, 0);
    Selected.Position = UDim2.new(1, -70, 0, 0);
    Selected.Font = Enum.Font.Gotham;
    Selected.Text = config.Multi and "0 selected" or (typeof(config.Default) == "string" and config.Default or "None");
    Selected.TextColor3 = Color3.fromRGB(160, 160, 170);
    Selected.TextSize = 12;
    Selected.TextXAlignment = Enum.TextXAlignment.Right;
    Selected.Parent = Option;

    local Arrow = Instance.new("ImageLabel");
    Arrow.BackgroundTransparency = 1;
    Arrow.Image = Compkiller:_GetIcon("chevron-down");
    Arrow.Size = UDim2.new(0, 16, 0, 16);
    Arrow.Position = UDim2.new(1, -22, 0.5, -8);
    Arrow.ImageColor3 = Color3.fromRGB(160, 160, 170);
    Arrow.Parent = Option;

    local Holder = Instance.new("Frame");
    Holder.BackgroundTransparency = 1;
    Holder.Position = UDim2.new(0, 0, 1, 6);
    Holder.Size = UDim2.new(1, 0, 0, 0);
    Holder.AutomaticSize = Enum.AutomaticSize.Y;
    Holder.Visible = false;
    Holder.ZIndex = 10;
    Holder.Parent = parent;

    local DropStroke = Instance.new("UIStroke", Holder);
    DropStroke.Color = Compkiller.Colors.LineColor;
    DropStroke.Thickness = 1;
    local DropCorner = Instance.new("UICorner", Holder);
    DropCorner.CornerRadius = UDim.new(0, 6);
    Holder.BackgroundColor3 = Compkiller.Colors.DropColor;
    Holder.BackgroundTransparency = 0;

    local List = Instance.new("UIListLayout", Holder);
    List.Padding = UDim.new(0, 2);
    List.SortOrder = Enum.SortOrder.LayoutOrder;

    local selectedValues = {};
    if config.Multi then
        if typeof(config.Default) == "table" then
            for _, v in ipairs(config.Default) do selectedValues[v] = true end;
        end;
    else
        if typeof(config.Default) == "string" then selectedValues[config.Default] = true end;
    end;

    local function updateSelectedLabel()
        if config.Multi then
            local count = 0; for _ in pairs(selectedValues) do count = count + 1 end;
            Selected.Text = count .. " selected";
        else
            for k in pairs(selectedValues) do Selected.Text = k; break end;
            if next(selectedValues) == nil then Selected.Text = "None" end;
        end;
    end;
    updateSelectedLabel();

    local opened = false;
    Compkiller:_Input(Option, function()
        opened = not opened;
        Holder.Visible = opened;
        Compkiller:PlaySound("Dropdown");
        Compkiller:_Animation(Arrow, TweenInfo.new(0.15), {Rotation = opened and 180 or 0});
    end);

    for _, value in ipairs(config.Values) do
        local Item = Instance.new("TextButton");
        Item.BackgroundColor3 = Compkiller.Colors.BlockBackground;
        Item.BackgroundTransparency = 1;
        Item.Size = UDim2.new(1, 0, 0, 28);
        Item.Font = Enum.Font.Gotham;
        Item.Text = tostring(value);
        Item.TextColor3 = Color3.fromRGB(220, 220, 228);
        Item.TextSize = 12;
        Item.TextXAlignment = Enum.TextXAlignment.Left;
        Item.Parent = Holder;

        local ItemPad = Instance.new("UIPadding", Item);
        ItemPad.PaddingLeft = UDim.new(0, 10);

        if selectedValues[value] then Item.TextColor3 = Compkiller.Colors.Highlight end;

        Item.MouseEnter:Connect(function() Compkiller:_Animation(Item, TweenInfo.new(0.1), {BackgroundTransparency = 0.9}); end);
        Item.MouseLeave:Connect(function() Compkiller:_Animation(Item, TweenInfo.new(0.1), {BackgroundTransparency = 1}); end);

        Item.MouseButton1Click:Connect(function()
            Compkiller:PlaySound("Click");
            if config.Multi then
                selectedValues[value] = not selectedValues[value] or nil;
                Item.TextColor3 = selectedValues[value] and Compkiller.Colors.Highlight or Color3.fromRGB(220, 220, 228);
            else
                selectedValues = {[value] = true};
                for _, child in ipairs(Holder:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.TextColor3 = (child.Text == tostring(value)) and Compkiller.Colors.Highlight or Color3.fromRGB(220, 220, 228);
                    end
                end
            end
            updateSelectedLabel();
            config.Callback(config.Multi and selectedValues or value);
        end);
    end;

    return Option;
end;

-- ============================================================
-- _LoadElement : carrega todos os tipos de elementos
-- ============================================================
function Compkiller:_LoadElement(parent, elementType, config)
    config = config or {};
    if elementType == "Toggle" or elementType == "MiniToggle" then
        local isMini = elementType == "MiniToggle";
        local Option = Compkiller:_LoadOption(parent, config.Name or "Toggle", isMini and 28 or 36);
        if not isMini then Compkiller:_AddDragBlacklist(Option) end;

        if not isMini then
            local Title = Instance.new("TextLabel");
            Title.BackgroundTransparency = 1;
            Title.Size = UDim2.new(1, -70, 1, 0);
            Title.Position = UDim2.new(0, 12, 0, 0);
            Title.Font = Enum.Font.Gotham;
            Title.Text = config.Name or "Toggle";
            Title.TextColor3 = Color3.fromRGB(230, 230, 235);
            Title.TextSize = 13;
            Title.TextXAlignment = Enum.TextXAlignment.Left;
            Title.Parent = Option;

            if config.Risky then
                local RiskyDot = Instance.new("Frame", Title);
                RiskyDot.Size = UDim2.new(0, 6, 0, 6);
                RiskyDot.Position = UDim2.new(1, 4, 0.5, -3);
                RiskyDot.BackgroundColor3 = Compkiller.Colors.Risky;
                RiskyDot.BorderSizePixel = 0;
                local rc = Instance.new("UICorner", RiskyDot); rc.CornerRadius = UDim.new(1,0);
            end
        end

        local Switch = Instance.new("TextButton");
        Switch.BackgroundColor3 = Compkiller.Colors.SwitchColor;
        Switch.BorderSizePixel = 0;
        Switch.Size = UDim2.new(0, 34, 0, 18);
        Switch.Position = UDim2.new(1, -46, 0.5, -9);
        Switch.Text = "";
        Switch.Parent = Option;
        local sc = Instance.new("UICorner", Switch); sc.CornerRadius = UDim.new(1,0);

        local Knob = Instance.new("Frame", Switch);
        Knob.Size = UDim2.new(0, 14, 0, 14);
        Knob.Position = UDim2.new(0, 2, 0.5, -7);
        Knob.BackgroundColor3 = Color3.fromRGB(30, 30, 35);
        Knob.BorderSizePixel = 0;
        local kc = Instance.new("UICorner", Knob); kc.CornerRadius = UDim.new(1,0);

        local state = config.Default or false;
        local function render()
            Compkiller:_Animation(Switch, TweenInfo.new(0.15), {BackgroundColor3 = state and Compkiller.Colors.Highlight or Compkiller.Colors.SwitchColor});
            Compkiller:_Animation(Knob, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)});
        end
        render();

        local obj = {};
        obj.SetValue = function(_, v) state = v; render(); if config.Callback then config.Callback(v) end end;
        obj.GetValue = function() return state end;
        obj.SetText = function() end;

        Compkiller:_Input(Switch, function()
            state = not state;
            Compkiller:PlaySound(state and "ToggleOn" or "ToggleOff");
            render();
            if config.Callback then config.Callback(state) end;
            if config.Flag then Compkiller.Flags[config.Flag] = obj end;
        end);

        if config.Flag then Compkiller:_AddLinkValue(config.Flag, obj) end;
        if config.Callback then task.spawn(function() config.Callback(state) end) end;
        return Option;

    elseif elementType == "Slider" then
        config = Compkiller.__CONFIG(config, {Name = "Slider", Min = 0, Max = 100, Default = 50, Round = 0, Type = "", Callback = function() end});
        local Option = Compkiller:_LoadOption(parent, config.Name, 48);
        Compkiller:_AddDragBlacklist(Option);

        local Title = Instance.new("TextLabel");
        Title.BackgroundTransparency = 1;
        Title.Size = UDim2.new(1, -80, 0, 20);
        Title.Position = UDim2.new(0, 12, 0, 4);
        Title.Font = Enum.Font.Gotham;
        Title.Text = config.Name;
        Title.TextColor3 = Color3.fromRGB(230, 230, 235);
        Title.TextSize = 13;
        Title.TextXAlignment = Enum.TextXAlignment.Left;
        Title.Parent = Option;

        local ValueLabel = Instance.new("TextLabel");
        ValueLabel.BackgroundTransparency = 1;
        ValueLabel.Size = UDim2.new(0, 70, 0, 20);
        ValueLabel.Position = UDim2.new(1, -82, 0, 4);
        ValueLabel.Font = Enum.Font.Gotham;
        ValueLabel.Text = tostring(config.Default) .. config.Type;
        ValueLabel.TextColor3 = Compkiller.Colors.Highlight;
        ValueLabel.TextSize = 12;
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right;
        ValueLabel.Parent = Option;

        local Bar = Instance.new("Frame");
        Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 48);
        Bar.BorderSizePixel = 0;
        Bar.Position = UDim2.new(0, 12, 1, -14);
        Bar.Size = UDim2.new(1, -24, 0, 6);
        Bar.Parent = Option;
        local bc = Instance.new("UICorner", Bar); bc.CornerRadius = UDim.new(1,0);

        local Fill = Instance.new("Frame");
        Fill.BackgroundColor3 = Compkiller.Colors.Highlight;
        Fill.BorderSizePixel = 0;
        Fill.Size = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 1, 0);
        Fill.Parent = Bar;
        local fc = Instance.new("UICorner", Fill); fc.CornerRadius = UDim.new(1,0);

        local dragging = false;
        local function apply(x)
            local pct = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1);
            local value = config.Min + (config.Max - config.Min) * pct;
            value = Compkiller:_Rounding(value, config.Round);
            Fill.Size = UDim2.new(pct, 0, 1, 0);
            ValueLabel.Text = tostring(value) .. config.Type;
            config.Callback(value);
        end;

        Compkiller:_Input(Bar, function() end);
        Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true; apply(Mouse.X); end end);
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end);
        UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then apply(Mouse.X) end end);

        return Option;

    elseif elementType == "Button" then
        local Option = Compkiller:_LoadOption(parent, config.Name, 34);
        Compkiller:_AddDragBlacklist(Option);
        local Btn = Instance.new("TextButton");
        Btn.BackgroundTransparency = 1;
        Btn.Size = UDim2.new(1, 0, 1, 0);
        Btn.Text = config.Name or "Button";
        Btn.Font = Enum.Font.Gotham;
        Btn.TextColor3 = Color3.fromRGB(230, 230, 235);
        Btn.TextSize = 13;
        Btn.Parent = Option;

        Btn.MouseEnter:Connect(function() Compkiller:_Animation(Option, TweenInfo.new(0.1), {BackgroundColor3 = Compkiller.Colors.MouseEnter}) end);
        Btn.MouseLeave:Connect(function() Compkiller:_Animation(Option, TweenInfo.new(0.1), {BackgroundColor3 = Compkiller.Colors.BlockBackground}) end);
        Btn.MouseButton1Click:Connect(function()
            Compkiller:PlaySound("Click");
            if config.Callback then config.Callback() end;
        end);
        return Option;

    elseif elementType == "TextBox" then
        config = Compkiller.__CONFIG(config, {Name = "TextBox", Default = "", Placeholder = "", Numeric = false, Callback = function() end});
        local Option = Compkiller:_LoadOption(parent, config.Name, 36);
        Compkiller:_AddDragBlacklist(Option);

        local Box = Instance.new("TextBox");
        Box.BackgroundColor3 = Compkiller.Colors.DropColor;
        Box.BorderSizePixel = 0;
        Box.Size = UDim2.new(1, -20, 0, 26);
        Box.Position = UDim2.new(0, 10, 0.5, -13);
        Box.Font = Enum.Font.Gotham;
        Box.PlaceholderText = config.Placeholder ~= "" and config.Placeholder or config.Name;
        Box.Text = config.Default;
        Box.TextColor3 = Color3.fromRGB(230, 230, 235);
        Box.PlaceholderColor3 = Color3.fromRGB(120, 120, 130);
        Box.TextSize = 12;
        Box.ClearTextOnFocus = false;
        Box.Parent = Option;
        local bc = Instance.new("UICorner", Box); bc.CornerRadius = UDim.new(0, 4);

        Box.Focused:Connect(function() Compkiller:_Animation(Box, TweenInfo.new(0.1), {BackgroundColor3 = Compkiller.Colors.MouseEnter}) end);
        Box.FocusLost:Connect(function()
            Compkiller:_Animation(Box, TweenInfo.new(0.1), {BackgroundColor3 = Compkiller.Colors.DropColor});
            local txt = Box.Text;
            if config.Numeric then txt = tonumber(txt) or 0 end;
            if config.Callback then config.Callback(txt) end;
        end);
        return Option;

    elseif elementType == "Keybind" then
        config = Compkiller.__CONFIG(config, {Name = "Keybind", Default = "F", Callback = function() end, Blacklist = {}});
        local Option = Compkiller:_LoadOption(parent, config.Name, 36);
        Compkiller:_AddDragBlacklist(Option);

        local Title = Instance.new("TextLabel");
        Title.BackgroundTransparency = 1;
        Title.Size = UDim2.new(1, -80, 1, 0);
        Title.Position = UDim2.new(0, 12, 0, 0);
        Title.Font = Enum.Font.Gotham;
        Title.Text = config.Name;
        Title.TextColor3 = Color3.fromRGB(230, 230, 235);
        Title.TextSize = 13;
        Title.TextXAlignment = Enum.TextXAlignment.Left;
        Title.Parent = Option;

        local KeyBtn = Instance.new("TextButton");
        KeyBtn.BackgroundColor3 = Compkiller.Colors.DropColor;
        KeyBtn.BorderSizePixel = 0;
        KeyBtn.Size = UDim2.new(0, 50, 0, 22);
        KeyBtn.Position = UDim2.new(1, -62, 0.5, -11);
        KeyBtn.Font = Enum.Font.Gotham;
        KeyBtn.Text = typeof(config.Default) == "EnumItem" and config.Default.Name or tostring(config.Default);
        KeyBtn.TextColor3 = Color3.fromRGB(230, 230, 235);
        KeyBtn.TextSize = 11;
        KeyBtn.Parent = Option;
        local kc = Instance.new("UICorner", KeyBtn); kc.CornerRadius = UDim.new(0, 4);

        local listening = false;
        local currentKey = config.Default;
        Compkiller:_Input(KeyBtn, function()
            listening = true;
            KeyBtn.Text = "...";
        end);

        local conn = UserInputService.InputBegan:Connect(function(input, gpe)
            if not listening then return end;
            if gpe then return end;
            if table.find(config.Blacklist, input.KeyCode) then return end;
            listening = false;
            currentKey = input.KeyCode;
            KeyBtn.Text = input.KeyCode.Name;
            if config.Callback then config.Callback(input.KeyCode.Name) end;
        end);
        return Option;

    elseif elementType == "Dropdown" then
        return Compkiller:_LoadDropdown(parent, config);

    elseif elementType == "ColorPicker" or elementType == "MiniColorPicker" then
        local Option = Compkiller:_LoadOption(parent, config.Name or "Color", 36);
        Compkiller:_AddDragBlacklist(Option);
        local Color = config.Default or Color3.fromRGB(139, 92, 246);

        local Preview = Instance.new("TextButton");
        Preview.BackgroundColor3 = Color;
        Preview.BorderSizePixel = 0;
        Preview.Size = UDim2.new(0, 26, 0, 22);
        Preview.Position = UDim2.new(1, -38, 0.5, -11);
        Preview.Text = "";
        Preview.Parent = Option;
        local pc = Instance.new("UICorner", Preview); pc.CornerRadius = UDim.new(0, 4);

        if config.Name then
            local Title = Instance.new("TextLabel");
            Title.BackgroundTransparency = 1;
            Title.Size = UDim2.new(1, -60, 1, 0);
            Title.Position = UDim2.new(0, 12, 0, 0);
            Title.Font = Enum.Font.Gotham;
            Title.Text = config.Name;
            Title.TextColor3 = Color3.fromRGB(230, 230, 235);
            Title.TextSize = 13;
            Title.TextXAlignment = Enum.TextXAlignment.Left;
            Title.Parent = Option;
        end

        local PickerHolder = Instance.new("Frame");
        PickerHolder.BackgroundTransparency = 1;
        PickerHolder.Size = UDim2.new(1, 0, 0, 0);
        PickerHolder.AutomaticSize = Enum.AutomaticSize.Y;
        PickerHolder.Visible = false;
        PickerHolder.Parent = parent;

        Compkiller:_AddColorPickerPanel(PickerHolder, Color, config.Transparency or 0, function(c, t)
            Preview.BackgroundColor3 = c;
            if config.Callback then config.Callback(c, t) end;
        end);

        Compkiller:_Input(Preview, function()
            PickerHolder.Visible = not PickerHolder.Visible;
        end);
        return Option;

    elseif elementType == "Paragraph" then
        local Option = Compkiller:_LoadOption(parent, config.Title or "Paragraph", 60);
        Option.AutomaticSize = Enum.AutomaticSize.Y;

        local Title = Instance.new("TextLabel");
        Title.BackgroundTransparency = 1;
        Title.Size = UDim2.new(1, -20, 0, 20);
        Title.Position = UDim2.new(0, 10, 0, 4);
        Title.Font = Enum.Font.GothamMedium;
        Title.Text = config.Title or "";
        Title.TextColor3 = Compkiller.Colors.Highlight;
        Title.TextSize = 13;
        Title.TextXAlignment = Enum.TextXAlignment.Left;
        Title.Parent = Option;

        local Content = Instance.new("TextLabel");
        Content.BackgroundTransparency = 1;
        Content.Size = UDim2.new(1, -20, 0, 0);
        Content.Position = UDim2.new(0, 10, 0, 26);
        Content.AutomaticSize = Enum.AutomaticSize.Y;
        Content.Font = Enum.Font.Gotham;
        Content.Text = config.Content or "";
        Content.TextWrapped = true;
        Content.TextColor3 = Color3.fromRGB(180, 180, 190);
        Content.TextSize = 12;
        Content.TextXAlignment = Enum.TextXAlignment.Left;
        Content.TextYAlignment = Enum.TextYAlignment.Top;
        Content.Parent = Option;
        return Option;

    elseif elementType == "Helper" then
        local Label = Instance.new("TextLabel");
        Label.BackgroundTransparency = 1;
        Label.Size = UDim2.new(1, 0, 0, 20);
        Label.Font = Enum.Font.Gotham;
        Label.Text = config.Text or "";
        Label.TextColor3 = Color3.fromRGB(150, 150, 160);
        Label.TextSize = 11;
        Label.TextXAlignment = Enum.TextXAlignment.Left;
        Label.Parent = parent;
        return Label;
    end;

    return nil;
end;

-- ============================================================
-- Compkiller.new : cria a janela principal
-- ============================================================
function Compkiller.new(config)
    config = Compkiller.__CONFIG(config, {
        Name = "Compkiller",
        Keybind = "RightShift",
        Logo = Compkiller.Logo,
        Scale = Compkiller.Scale.Window,
        TextSize = 13,
        Theme = "Purple",
        ToggleKeybind = "RightShift",
    });

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = Compkiller:_RandomString();
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    Compkiller.ProtectGui(ScreenGui);
    ScreenGui.Parent = CoreGui;

    -- Overlay para fechar com clique fora
    local Overlay = Instance.new("TextButton");
    Overlay.BackgroundTransparency = 1;
    Overlay.Size = UDim2.new(1, 0, 1, 0);
    Overlay.Text = "";
    Overlay.Parent = ScreenGui;

    -- Janela principal
    local Main = Instance.new("Frame");
    Main.Name = "Main";
    Main.BackgroundColor3 = Compkiller.Colors.BGDBColor;
    Main.BorderSizePixel = 0;
    Main.Size = config.Scale;
    Main.Position = UDim2.new(0.5, -config.Scale.X.Offset/2, 0.5, -config.Scale.Y.Offset/2);
    Main.ClipsDescendants = true;
    Main.Parent = ScreenGui;

    local MainCorner = Instance.new("UICorner", Main);
    MainCorner.CornerRadius = UDim.new(0, 10);

    local MainStroke = Instance.new("UIStroke", Main);
    MainStroke.Color = Compkiller.Colors.StrokeColor;
    MainStroke.Thickness = 1;

    -- Barra de título
    local TopBar = Instance.new("Frame", Main);
    TopBar.Name = "TopBar";
    TopBar.BackgroundColor3 = Compkiller.Colors.BlockColor;
    TopBar.BorderSizePixel = 0;
    TopBar.Size = UDim2.new(1, 0, 0, 40);
    local tc = Instance.new("UICorner", TopBar); tc.CornerRadius = UDim.new(0, 10);

    local Logo = Instance.new("ImageLabel", TopBar);
    Logo.BackgroundTransparency = 1;
    Logo.Image = config.Logo;
    Logo.Size = UDim2.new(0, 24, 0, 24);
    Logo.Position = UDim2.new(0, 12, 0.5, -12);

    local Title = Instance.new("TextLabel", TopBar);
    Title.BackgroundTransparency = 1;
    Title.Size = UDim2.new(1, -120, 1, 0);
    Title.Position = UDim2.new(0, 44, 0, 0);
    Title.Font = Enum.Font.GothamBold;
    Title.Text = config.Name;
    Title.TextColor3 = Color3.fromRGB(240, 240, 245);
    Title.TextSize = 14;
    Title.TextXAlignment = Enum.TextXAlignment.Left;

    -- Botões de controle
    local Minimize = Instance.new("TextButton", TopBar);
    Minimize.BackgroundTransparency = 1;
    Minimize.Size = UDim2.new(0, 30, 0, 30);
    Minimize.Position = UDim2.new(1, -70, 0.5, -15);
    Minimize.Font = Enum.Font.GothamBold;
    Minimize.Text = "—";
    Minimize.TextColor3 = Color3.fromRGB(180, 180, 190);
    Minimize.TextSize = 16;
    local mc = Instance.new("UICorner", Minimize); mc.CornerRadius = UDim.new(0, 6);

    local Close = Instance.new("TextButton", TopBar);
    Close.BackgroundTransparency = 1;
    Close.Size = UDim2.new(0, 30, 0, 30);
    Close.Position = UDim2.new(1, -36, 0.5, -15);
    Close.Font = Enum.Font.GothamBold;
    Close.Text = "✕";
    Close.TextColor3 = Color3.fromRGB(180, 180, 190);
    Close.TextSize = 14;
    local cc = Instance.new("UICorner", Close); cc.CornerRadius = UDim.new(0, 6);

    -- Sidebar (tabs)
    local Sidebar = Instance.new("Frame", Main);
    Sidebar.Name = "Sidebar";
    Sidebar.BackgroundColor3 = Compkiller.Colors.BlockColor;
    Sidebar.BorderSizePixel = 0;
    Sidebar.Position = UDim2.new(0, 0, 0, 40);
    Sidebar.Size = UDim2.new(0, Compkiller.Scale.TabClose, 1, -40);

    local TabList = Instance.new("UIListLayout", Sidebar);
    TabList.Padding = UDim.new(0, 4);
    TabList.SortOrder = Enum.SortOrder.LayoutOrder;

    local TabPad = Instance.new("UIPadding", Sidebar);
    TabPad.PaddingTop = UDim.new(0, 8);
    TabPad.PaddingLeft = UDim.new(0, 8);
    TabPad.PaddingRight = UDim.new(0, 8);

    -- Container de conteúdo
    local Content = Instance.new("Frame", Main);
    Content.Name = "Content";
    Content.BackgroundTransparency = 1;
    Content.Position = UDim2.new(0, Compkiller.Scale.TabClose, 0, 40);
    Content.Size = UDim2.new(1, -Compkiller.Scale.TabClose, 1, -40);

    local ContentScroll = Instance.new("ScrollingFrame", Content);
    ContentScroll.BackgroundTransparency = 1;
    ContentScroll.BorderSizePixel = 0;
    ContentScroll.Size = UDim2.new(1, 0, 1, 0);
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0);
    ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ContentScroll.ScrollBarThickness = 3;
    ContentScroll.ScrollBarImageColor3 = Compkiller.Colors.Highlight;

    local ContentList = Instance.new("UIListLayout", ContentScroll);
    ContentList.Padding = UDim.new(0, 10);
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder;

    local ContentPad = Instance.new("UIPadding", ContentScroll);
    ContentPad.PaddingTop = UDim.new(0, 10);
    ContentPad.PaddingLeft = UDim.new(0, 10);
    ContentPad.PaddingRight = UDim.new(0, 10);
    ContentPad.PaddingBottom = UDim.new(0, 10);

    -- Janela miníma para reabrir
    local MiniButton = Instance.new("TextButton", ScreenGui);
    MiniButton.BackgroundColor3 = Compkiller.Colors.BlockColor;
    MiniButton.BorderSizePixel = 0;
    MiniButton.Size = UDim2.new(0, 50, 0, 50);
    MiniButton.Position = UDim2.new(0, 20, 0.5, -25);
    MiniButton.Text = "CK";
    MiniButton.Font = Enum.Font.GothamBold;
    MiniButton.TextColor3 = Compkiller.Colors.Highlight;
    MiniButton.TextSize = 14;
    MiniButton.Visible = false;
    MiniButton.Parent = ScreenGui;
    local mbc = Instance.new("UICorner", MiniButton); mbc.CornerRadius = UDim.new(1, 0);

    Compkiller:Drag(TopBar, Main, 0.1);
    Compkiller:Drag(MiniButton, MiniButton, 0.1);

    -- Estado de visibilidade
    local visible = true;
    local function setVisible(v)
        visible = v;
        Main.Visible = v;
        MiniButton.Visible = not v;
        if v then Compkiller:PlaySound("Open") else Compkiller:PlaySound("Close") end;
    end;

    Close.MouseButton1Click:Connect(function() setVisible(false) end);
    Minimize.MouseButton1Click:Connect(function() setVisible(false) end);
    MiniButton.MouseButton1Click:Connect(function() setVisible(true) end);

    -- Keybind de toggle
    if config.ToggleKeybind then
        Compkiller:_KeybindHandler(config.ToggleKeybind, function(_, state)
            if state then setVisible(not visible) end;
        end);
    end;

    -- Retorno da janela
    local WindowObj = {};
    WindowObj.Name = config.Name;
    WindowObj.Gui = ScreenGui;
    WindowObj.Frame = Main;
    WindowObj.Visible = true;
    WindowObj.Tabs = {};
    WindowObj.Containers = {};

    function WindowObj:SelectTab(tab)
        for _, t in pairs(WindowObj.Tabs) do
            t.Active = (t == tab);
            t:Render();
        end
        for name, container in pairs(WindowObj.Containers) do
            container.Visible = (name == tab.Name);
        end
        Compkiller:PlaySound("TabSwitch");
    end;

    function WindowObj:Toggle(v)
        if v == nil then v = not visible end;
        setVisible(v);
    end;

    function WindowObj:Destroy()
        pcall(function() ScreenGui:Destroy() end);
    end;

    -- Cria tab
    function WindowObj:Tab(tabConfig)
        tabConfig = Compkiller.__CONFIG(tabConfig, {Name = "Tab", Icon = "", EnableScrolling = true});
        local tabName = tabConfig.Name;

        local TabBtn = Instance.new("TextButton", Sidebar);
        TabBtn.BackgroundColor3 = Compkiller.Colors.BlockColor;
        TabBtn.BackgroundTransparency = 1;
        TabBtn.BorderSizePixel = 0;
        TabBtn.Size = UDim2.new(1, 0, 0, 32);
        TabBtn.Text = "";
        TabBtn.AutoButtonColor = false;
        local tbc = Instance.new("UICorner", TabBtn); tbc.CornerRadius = UDim.new(0, 6);

        local TabIcon = Instance.new("ImageLabel", TabBtn);
        TabIcon.BackgroundTransparency = 1;
        TabIcon.Image = Compkiller:_GetIcon(tabConfig.Icon);
        TabIcon.Size = UDim2.new(0, 18, 0, 18);
        TabIcon.Position = UDim2.new(0, 8, 0.5, -9);
        TabIcon.ImageColor3 = Color3.fromRGB(160, 160, 170);

        local TabTitle = Instance.new("TextLabel", TabBtn);
        TabTitle.BackgroundTransparency = 1;
        TabTitle.Size = UDim2.new(1, -34, 1, 0);
        TabTitle.Position = UDim2.new(0, 32, 0, 0);
        TabTitle.Font = Enum.Font.Gotham;
        TabTitle.Text = tabConfig.Name;
        TabTitle.TextColor3 = Color3.fromRGB(180, 180, 190);
        TabTitle.TextSize = 12;
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left;

        -- Container da aba
        local Container = Instance.new("Frame", ContentScroll);
        Container.Name = "Tab_"..tabConfig.Name;
        Container.BackgroundTransparency = 1;
        Container.Size = UDim2.new(1, 0, 0, 0);
        Container.AutomaticSize = Enum.AutomaticSize.Y;
        Container.Visible = false;

        local ContainerList = Instance.new("UIListLayout", Container);
        ContainerList.Padding = UDim.new(0, 10);
        ContainerList.SortOrder = Enum.SortOrder.LayoutOrder;

        local TabObj = {Name = tabConfig.Name, Active = false, Container = Container, Button = TabBtn};
        function TabObj:Render()
            local active = self.Active;
            TabBtn.BackgroundTransparency = active and 0 or 1;
            TabBtn.BackgroundColor3 = active and Compkiller.Colors.MouseEnter or Compkiller.Colors.BlockColor;
            TabTitle.TextColor3 = active and Compkiller.Colors.Highlight or Color3.fromRGB(180, 180, 190);
            TabIcon.ImageColor3 = active and Compkiller.Colors.Highlight or Color3.fromRGB(160, 160, 170);
        end;

        TabBtn.MouseEnter:Connect(function()
            if not TabObj.Active then TabBtn.BackgroundTransparency = 0.7 end;
        end);
        TabBtn.MouseLeave:Connect(function()
            if not TabObj.Active then TabBtn.BackgroundTransparency = 1 end;
        end);
        TabBtn.MouseButton1Click:Connect(function()
            WindowObj:SelectTab(TabObj);
        end);

        table.insert(WindowObj.Tabs, TabObj);
        WindowObj.Containers[tabConfig.Name] = Container;

        if #WindowObj.Tabs == 1 then
            WindowObj:SelectTab(TabObj);
        end

        -- Seções
        function TabObj:Section(sectionConfig)
            sectionConfig = Compkiller.__CONFIG(sectionConfig, {Name = "Section", Position = "left"});
            local Sec, Holder = Compkiller:_CreateBlock(Container, sectionConfig);
            local SecObj = {Holder = Holder, Name = sectionConfig.Name};
            function SecObj:Toggle(cfg)
                return Compkiller:_LoadElement(Holder, "Toggle", cfg);
            end;
            function SecObj:MiniToggle(cfg)
                return Compkiller:_LoadElement(Holder, "MiniToggle", cfg);
            end;
            function SecObj:Slider(cfg)
                return Compkiller:_LoadElement(Holder, "Slider", cfg);
            end;
            function SecObj:Dropdown(cfg)
                return Compkiller:_LoadElement(Holder, "Dropdown", cfg);
            end;
            function SecObj:Button(cfg)
                return Compkiller:_LoadElement(Holder, "Button", cfg);
            end;
            function SecObj:TextBox(cfg)
                return Compkiller:_LoadElement(Holder, "TextBox", cfg);
            end;
            function SecObj:Keybind(cfg)
                return Compkiller:_LoadElement(Holder, "Keybind", cfg);
            end;
            function SecObj:MiniKeybind(cfg)
                return Compkiller:_LoadElement(Holder, "Keybind", cfg);
            end;
            function SecObj:ColorPicker(cfg)
                return Compkiller:_LoadElement(Holder, "ColorPicker", cfg);
            end;
            function SecObj:MiniColorPicker(cfg)
                return Compkiller:_LoadElement(Holder, "MiniColorPicker", cfg);
            end;
            function SecObj:Paragraph(cfg)
                return Compkiller:_LoadElement(Holder, "Paragraph", cfg);
            end;
            function SecObj:Helper(cfg)
                return Compkiller:_LoadElement(Holder, "Helper", cfg);
            end;
            return SecObj;
        end;

        return TabObj;
    end;

    table.insert(Compkiller.Windows, Main);
    return WindowObj;
end;

-- ============================================================
-- ConfigManager
-- ============================================================
function Compkiller.ConfigManager(config)
    config = Compkiller.__CONFIG(config, {Directory = "Compkiller/Configs"});
    local self = {};
    self.Directory = config.Directory;

    local function ensureDir()
        if isfolder and not isfolder(self.Directory) then
            if makefolder then makefolder(self.Directory) end;
        end;
    end;

    function self:WriteConfig(cfg)
        ensureDir();
        local name = (cfg and cfg.Name) or "config";
        local author = (cfg and cfg.Author) or "Unknown";
        local data = {
            Info = {Type = "Config", Author = author, Name = name, CreatedDate = os.date("%Y-%m-%d")},
            Flags = {},
        };
        for flag, obj in pairs(Compkiller.Flags) do
            if obj.GetValue then
                local ok, val = pcall(function() return obj:GetValue() end);
                if ok then data.Flags[flag] = val end;
            end;
        end;
        local path = self.Directory .. "/" .. name .. ".json";
        if writefile then
            writefile(path, HttpService:JSONEncode(data));
            return true;
        end;
        return false;
    end;

    function self:ReadInfo(name)
        local path = self.Directory .. "/" .. name .. ".json";
        if isfile and isfile(path) then
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end);
            if ok then return data.Info end;
        end;
        return nil;
    end;

    function self:DeleteConfig(name)
        local path = self.Directory .. "/" .. name .. ".json";
        if isfile and isfile(path) and delfile then
            delfile(path);
            return true;
        end;
        return false;
    end;

    function self:LoadConfig(name)
        local path = self.Directory .. "/" .. name .. ".json";
        if isfile and isfile(path) then
            local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end);
            if ok and data.Flags then
                for flag, val in pairs(data.Flags) do
                    local obj = Compkiller.Flags[flag];
                    if obj and obj.SetValue then
                        pcall(function() obj:SetValue(val) end);
                    end;
                end;
                return true;
            end;
        end;
        return false;
    end;

    function self:GetConfigs()
        ensureDir();
        local result = {};
        if listfiles then
            for _, file in ipairs(listfiles(self.Directory)) do
                local name = file:match("([^/]+)%.json$");
                if name then table.insert(result, name) end;
            end;
        end;
        return result;
    end;

    function self:GetConfigCount()
        return #self:GetConfigs();
    end;

    function self:GetFullConfigs()
        local result = {};
        for _, name in ipairs(self:GetConfigs()) do
            local info = self:ReadInfo(name);
            if info then table.insert(result, {Name = name, Info = info}) end;
        end;
        return result;
    end;

    return self;
end;

-- ============================================================
-- Loader (tela de carregamento)
-- ============================================================
function Compkiller.Loader(text)
    text = text or "Loading...";
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = Compkiller:_RandomString();
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    Compkiller.ProtectGui(ScreenGui);
    ScreenGui.Parent = CoreGui;

    local BG = Instance.new("Frame", ScreenGui);
    BG.BackgroundColor3 = Compkiller.Colors.BGDBColor;
    BG.BorderSizePixel = 0;
    BG.Size = UDim2.new(1, 0, 1, 0);
    BG.BackgroundTransparency = 0.2;

    local Box = Instance.new("Frame", BG);
    Box.BackgroundColor3 = Compkiller.Colors.BlockColor;
    Box.BorderSizePixel = 0;
    Box.Size = UDim2.new(0, 320, 0, 100);
    Box.Position = UDim2.new(0.5, -160, 0.5, -50);
    local bc = Instance.new("UICorner", Box); bc.CornerRadius = UDim.new(0, 12);

    local Label = Instance.new("TextLabel", Box);
    Label.BackgroundTransparency = 1;
    Label.Size = UDim2.new(1, 0, 0, 30);
    Label.Position = UDim2.new(0, 0, 0, 15);
    Label.Font = Enum.Font.GothamBold;
    Label.Text = "Compkiller";
    Label.TextColor3 = Compkiller.Colors.Highlight;
    Label.TextSize = 16;

    local Sub = Instance.new("TextLabel", Box);
    Sub.BackgroundTransparency = 1;
    Sub.Size = UDim2.new(1, 0, 0, 20);
    Sub.Position = UDim2.new(0, 0, 0, 40);
    Sub.Font = Enum.Font.Gotham;
    Sub.Text = text;
    Sub.TextColor3 = Color3.fromRGB(180, 180, 190);
    Sub.TextSize = 12;

    local Bar = Instance.new("Frame", Box);
    Bar.BackgroundColor3 = Compkiller.Colors.DropColor;
    Bar.BorderSizePixel = 0;
    Bar.Size = UDim2.new(1, -40, 0, 4);
    Bar.Position = UDim2.new(0, 20, 1, -20);
    local brc = Instance.new("UICorner", Bar); brc.CornerRadius = UDim.new(1, 0);

    local Fill = Instance.new("Frame", Bar);
    Fill.BackgroundColor3 = Compkiller.Colors.Highlight;
    Fill.BorderSizePixel = 0;
    Fill.Size = UDim2.new(0, 0, 1, 0);
    local fc = Instance.new("UICorner", Fill); fc.CornerRadius = UDim.new(1, 0);

    local loader = {};
    function loader:SetProgress(p)
        Compkiller:_Animation(Fill, TweenInfo.new(0.2), {Size = UDim2.new(math.clamp(p, 0, 1), 0, 1, 0)});
    end;
    function loader:SetText(t)
        Sub.Text = t;
    end;
    function loader:Close()
        Compkiller:_Animation(BG, TweenInfo.new(0.3), {BackgroundTransparency = 1});
        Compkiller:_Animation(Box, TweenInfo.new(0.3), {BackgroundTransparency = 1});
        task.wait(0.35);
        ScreenGui:Destroy();
    end;
    return loader;
end;

-- ============================================================
-- newNotify : notificações com tipos
-- ============================================================
Compkiller._NotifyHolder = nil;
function Compkiller.newNotify(config)
    config = Compkiller.__CONFIG(config, {
        Icon = "info",
        Title = "Notification",
        Content = "",
        Duration = 5,
        Type = "info",
    });

    if not Compkiller._NotifyHolder or not Compkiller._NotifyHolder.Parent then
        local holder = Instance.new("Frame");
        holder.Name = "CompkillerNotifyHolder";
        holder.BackgroundTransparency = 1;
        holder.Position = UDim2.new(1, -280, 0, 20);
        holder.Size = UDim2.new(0, 260, 0, 0);
        holder.AutomaticSize = Enum.AutomaticSize.Y;
        holder.Parent = CoreGui;
        local hl = Instance.new("UIListLayout", holder);
        hl.Padding = UDim.new(0, 8);
        hl.SortOrder = Enum.SortOrder.LayoutOrder;
        Compkiller._NotifyHolder = holder;
    end

    local typeColors = {
        success = Color3.fromRGB(34, 197, 94),
        error = Color3.fromRGB(239, 68, 68),
        warning = Color3.fromRGB(251, 191, 36),
        info = Compkiller.Colors.Highlight,
    };
    local typeIcons = {
        success = "check",
        error = "x",
        warning = "alert-circle",
        info = "info",
    };

    local type = config.Type or "info";
    local accent = typeColors[type] or typeColors.info;

    local NotifyFrame = Instance.new("Frame");
    NotifyFrame.BackgroundColor3 = Compkiller.Colors.BlockColor;
    NotifyFrame.BorderSizePixel = 0;
    NotifyFrame.Size = UDim2.new(1, 0, 0, 0);
    NotifyFrame.AutomaticSize = Enum.AutomaticSize.Y;
    NotifyFrame.Parent = Compkiller._NotifyHolder;
    local nfc = Instance.new("UICorner", NotifyFrame); nfc.CornerRadius = UDim.new(0, 8);
    local nfs = Instance.new("UIStroke", NotifyFrame); nfs.Color = Compkiller.Colors.LineColor;

    local Accent = Instance.new("Frame", NotifyFrame);
    Accent.BackgroundColor3 = accent;
    Accent.BorderSizePixel = 0;
    Accent.Size = UDim2.new(0, 3, 1, 0);
    Accent.Position = UDim2.new(0, 0, 0, 0);
    local ac = Instance.new("UICorner", Accent); ac.CornerRadius = UDim.new(0, 8);

    local Icon = Instance.new("ImageLabel", NotifyFrame);
    Icon.BackgroundTransparency = 1;
    Icon.Image = Compkiller:_GetIcon(typeIcons[type] or config.Icon);
    Icon.Size = UDim2.new(0, 20, 0, 20);
    Icon.Position = UDim2.new(0, 14, 0, 14);
    Icon.ImageColor3 = accent;

    local Title = Instance.new("TextLabel", NotifyFrame);
    Title.BackgroundTransparency = 1;
    Title.Size = UDim2.new(1, -50, 0, 20);
    Title.Position = UDim2.new(0, 42, 0, 10);
    Title.Font = Enum.Font.GothamBold;
    Title.Text = config.Title;
    Title.TextColor3 = Color3.fromRGB(240, 240, 245);
    Title.TextSize = 13;
    Title.TextXAlignment = Enum.TextXAlignment.Left;

    local Content = Instance.new("TextLabel", NotifyFrame);
    Content.BackgroundTransparency = 1;
    Content.Size = UDim2.new(1, -56, 0, 0);
    Content.Position = UDim2.new(0, 42, 0, 32);
    Content.AutomaticSize = Enum.AutomaticSize.Y;
    Content.Font = Enum.Font.Gotham;
    Content.Text = config.Content;
    Content.TextColor3 = Color3.fromRGB(180, 180, 190);
    Content.TextSize = 12;
    Content.TextWrapped = true;
    Content.TextXAlignment = Enum.TextXAlignment.Left;
    Content.TextYAlignment = Enum.TextYAlignment.Top;

    local Progress = Instance.new("Frame", NotifyFrame);
    Progress.BackgroundColor3 = accent;
    Progress.BorderSizePixel = 0;
    Progress.Position = UDim2.new(0, 0, 1, -2);
    Progress.Size = UDim2.new(1, 0, 0, 2);
    Progress.BackgroundTransparency = 0.3;

    local obj = {};
    obj.Frame = NotifyFrame;
    function obj:Close()
        Compkiller:_Animation(NotifyFrame, TweenInfo.new(0.2), {BackgroundTransparency = 1});
        task.wait(0.2);
        NotifyFrame:Destroy();
    end;
    function obj:Title(t) Title.Text = t end;
    function obj:Content(c) Content.Text = c end;
    function obj:SetProgress(t)
        Compkiller:_Animation(Progress, TweenInfo.new(t or 1), {Size = UDim2.new(0, 0, 0, 2)});
    end;

    Compkiller:PlaySound(type == "success" and "Success" or type == "error" and "Error" or type == "warning" and "Warning" or "Info");
    obj:SetProgress(config.Duration);
    task.delay(config.Duration, function() pcall(function() obj:Close() end) end);
    return obj;
end;

-- ============================================================
-- Watermark com FPS / Ping / RAM / Time
-- ============================================================
function Compkiller.Watermark(config)
    config = Compkiller.__CONFIG(config, {Icon = "activity", Text = "Compkiller"});

    local WM = Instance.new("Frame");
    WM.Name = "CompkillerWatermark";
    WM.BackgroundColor3 = Compkiller.Colors.BlockColor;
    WM.BorderSizePixel = 0;
    WM.Size = UDim2.new(0, 280, 0, 26);
    WM.Position = UDim2.new(0, 20, 0, 20);
    WM.Parent = CoreGui;
    local wmc = Instance.new("UICorner", WM); wmc.CornerRadius = UDim.new(0, 6);
    local wms = Instance.new("UIStroke", WM); wms.Color = Compkiller.Colors.LineColor;

    local Icon = Instance.new("ImageLabel", WM);
    Icon.BackgroundTransparency = 1;
    Icon.Image = Compkiller:_GetIcon(config.Icon);
    Icon.Size = UDim2.new(0, 16, 0, 16);
    Icon.Position = UDim2.new(0, 8, 0.5, -8);
    Icon.ImageColor3 = Compkiller.Colors.Highlight;

    local Label = Instance.new("TextLabel", WM);
    Label.BackgroundTransparency = 1;
    Label.Size = UDim2.new(1, -30, 1, 0);
    Label.Position = UDim2.new(0, 28, 0, 0);
    Label.Font = Enum.Font.Gotham;
    Label.Text = config.Text .. "  |  ...";
    Label.TextColor3 = Color3.fromRGB(220, 220, 230);
    Label.TextSize = 11;
    Label.TextXAlignment = Enum.TextXAlignment.Left;

    Compkiller:Drag(WM, WM, 0.1);

    local frames = 0;
    local fps = 0;
    local lastUpdate = tick();

    task.spawn(function()
        while WM.Parent do
            frames = frames + 1;
            if tick() - lastUpdate >= 1 then
                fps = frames;
                frames = 0;
                lastUpdate = tick();
                local ping = 0;
                pcall(function()
                    ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue());
                end);
                local ram = math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb());
                local time = os.date("%H:%M:%S");
                Label.Text = string.format("%s  |  %d FPS  |  %dms  |  %dMB  |  %s", config.Text, fps, ping, ram, time);
            end
            RunService.RenderStepped:Wait();
        end
    end);

    return WM;
end;

return Compkiller;

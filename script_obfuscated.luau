-- Lua 5.3+ / Luau compatibility polyfills
if not math.ldexp then math.ldexp = function(x, n) return x * 2 ^ n end end
if not math.frexp then math.frexp = function(x)
    if x == 0 then return 0, 0 end
    local exp = math.floor(math.log(math.abs(x)) / math.log(2)) + 1
    local mantissa = x / 2 ^ exp
    return mantissa, exp
end end
if not loadstring and load then loadstring = load end
if not loadstring then loadstring = function(s) return load(s) end end

--[Obfuscated by Hercules v2.0.0 | hercules-obfuscator.xyz/discord | hercules-obfuscator.xyz/source]
(function(...) if true then local _=52 end local function hswrek(xggxcr)local _=37 end local gusexu=49;local function tlfmve(tmdcca)local _=17 end if false then local _=62 end if true then local _=94 end local function xmsuzr(utdgei)local _=39 end local function tzbvtk(nubguf)local _=64 end local function sfbcid(vokonw)local _=55 end local function fhtawe(dwavta)local _=90 end local function fsmwov(qwpdac)local _=13 end while false do local _=12 break end local function tyzuuj(yiqpon)local _=55 end local function cwkqkz(uggrnx)local _=51 end local thing=3551;local thing2=3551;local counter=0;while thing==thing2 and counter<1 do thing=thing+1;counter=counter+1;if thing==thing2 then local str='dummy';str=str..str; else do do local _BFR,_MFR,T,E,Pa,GM,RG={["string.char"]=string.char,["string.reverse"]=string.reverse,["type"]=type,["table.insert"]=table.insert,["string.lower"]=string.lower,["string.upper"]=string.upper,["setmetatable"]=setmetatable,["table.remove"]=table.remove,["rawset"]=rawset,["math.abs"]=math.abs,["os.time"]=os.time,["string.byte"]=string.byte,["os.difftime"]=os.difftime,["assert"]=assert,["os.date"]=os.date,["error"]=error,["next"]=next,["string.sub"]=string.sub,["math.exp"]=math.exp,["string.gmatch"]=string.gmatch,["rawequal"]=rawequal,["os.clock"]=os.clock,["math.sqrt"]=math.sqrt,["math.tan"]=math.tan,["math.sin"]=math.sin,["string.match"]=string.match,["math.rad"]=math.rad,["select"]=select,["math.modf"]=math.modf,["tostring"]=tostring,["math.min"]=math.min,["math.max"]=math.max,["pcall"]=pcall,["math.floor"]=math.floor,["xpcall"]=xpcall,["math.fmod"]=math.fmod,["table.sort"]=table.sort,["getmetatable"]=getmetatable,["string.gsub"]=string.gsub,["math.asin"]=math.asin,["math.cos"]=math.cos,["table.concat"]=table.concat,["math.ceil"]=math.ceil,["math.acos"]=math.acos,["math.atan"]=math.atan,["rawget"]=rawget,["string.format"]=string.format,["string.find"]=string.find,["math.deg"]=math.deg,["string.rep"]=string.rep,["tonumber"]=tonumber,["string.len"]=string.len},{},type,error,pairs,getmetatable,rawget;local DG={table=table,string=string,math=math,os=os};local function check() for n,ref in Pa(_BFR)do if ref==nil then E("Tamper Detected! Reason: Critical function removed: "..n);return end if T(ref)~="function" then E("Tamper Detected! Reason: Critical function type changed: "..n.." (was function, now "..T(ref)..")");return end end for tname in Pa(_MFR)do local parts={};for p in tname:gmatch("[^.]+")do parts[#parts+1]=p end local t=DG[(parts[1])];if t then local mt=GM(t);if mt then local mf=RG(mt,parts[2]);if mf then local expected=_MFR[tname];if T(mf)~=expected then E("Tamper Detected! Reason: Metamethod tampered: "..tname);return end end end end end local d=debug;if T(d)=="table" then local _DK={"info","traceback"};for _,k in Pa(_DK)do if T(d[k])~="function" then E("Tamper Detected! Reason: Debug library incomplete");return end end end end check() end local OBqxxldqsKZx,mXmZfMtAi,KFtbrNIm,ESIEhvDMyEJA,YHlpFdRBy,nEnqpfejPegn,VmIuUSWXRv,horMIlCWJs,CTJAbhuTKQBH,aemzoWfOdp,RVuNswPSPyfT;OBqxxldqsKZx=ipairs;mXmZfMtAi=next;KFtbrNIm=pairs;ESIEhvDMyEJA=pcall;YHlpFdRBy=math.floor;nEnqpfejPegn=math.random;VmIuUSWXRv=string.char;horMIlCWJs=string.find;CTJAbhuTKQBH=string.format;aemzoWfOdp=table.concat;RVuNswPSPyfT=table.insert;local iOphscmh={[63]="?",[65]="A",[66]="B",[67]="C",[70]="F",[71]="G",[72]="H",[73]="I",[76]="L",[77]="M",[80]="P",[82]="R",[83]="S",[84]="T",[85]="U",[87]="W",[91]="[",[37]="%",[93]="]",[38]="&",[32]=" ",[49]="1",[97]="a",[98]="b",[99]="c",[100]="d",[101]="e",[102]="f",[103]="g",[104]="h",[105]="i",[48]="0",[107]="k",[108]="l",[109]="m",[110]="n",[111]="o",[112]="p",[10]="\\010",[114]="r",[115]="s",[116]="t",[117]="u",[118]="v",[119]="w",[120]="x",[121]="y",[122]="z",[47]="/",[61]="=",[46]=".",[58]=":"};local function lvuzeQir(GjwHJAAIIkvh) return(GjwHJAAIIkvh>=48 and GjwHJAAIIkvh<=57)or(GjwHJAAIIkvh>=65 and GjwHJAAIIkvh<=90)or(GjwHJAAIIkvh>=97 and GjwHJAAIIkvh<=122) end local function xTBrpDnHrke(AaNCMVLjEx,bywuqmjqj) local iFTHEwflP={};for i=1,#AaNCMVLjEx do local GjwHJAAIIkvh=AaNCMVLjEx:byte(i);if lvuzeQir(GjwHJAAIIkvh)then local KgxNrTSeXe if GjwHJAAIIkvh>=48 and GjwHJAAIIkvh<=57 then KgxNrTSeXe=((GjwHJAAIIkvh-48-bywuqmjqj+10)%10)+48 elseif GjwHJAAIIkvh>=65 and GjwHJAAIIkvh<=90 then KgxNrTSeXe=((GjwHJAAIIkvh-65-bywuqmjqj+26)%26)+65 elseif GjwHJAAIIkvh>=97 and GjwHJAAIIkvh<=122 then KgxNrTSeXe=((GjwHJAAIIkvh-97-bywuqmjqj+26)%26)+97 end table.insert(iFTHEwflP,string.char(KgxNrTSeXe)) else table.insert(iFTHEwflP,string.char(GjwHJAAIIkvh)) end end return table.concat(iFTHEwflP) end local wNKmlOgaN=[[
local TS, HS, Players, WS, RS = game:GetService((chars[411 - (327)]..chars[-368 + 469]..chars[741 - (633)]..chars[-271 + 372]..chars[463 - (351)]..chars[-505 + 616]..chars[841 - (727)]..chars[391 - (275)]..chars[806 - (723)]..chars[-284 + 385]..chars[706 - (592)]..chars[903 - (785)]..chars[-10 + 115]..chars[133 - (34)]..chars[301 - (200)])), game:GetService((chars[-264 + 336]..chars[-29 + 145]..chars[-184 + 300]..chars[234 - (122)]..chars[341 - (258)]..chars[-337 + 438]..chars[-372 + 486]..chars[774 - (656)]..chars[-45 + 150]..chars[-27 + 126]..chars[910 - (809)])), game:GetService((chars[-319 + 399]..chars[817 - (709)]..chars[217 - (120)]..chars[-179 + 300]..chars[103 - (2)]..chars[-810 + 924]..chars[-87 + 202])), game:GetService((chars[-262 + 349]..chars[-295 + 406]..chars[860 - (746)]..chars[143 - (36)]..chars[151 - (36)]..chars[309 - (197)]..chars[356 - (259)]..chars[335 - (236)]..chars[-162 + 263])), game:GetService((chars[555 - (473)]..chars[-431 + 548]..chars[519 - (409)]..chars[-916 + 999]..chars[-718 + 819]..chars[-30 + 144]..chars[-665 + 783]..chars[110 - (5)]..chars[-848 + 947]..chars[-33 + 134]))
local lp, placeId, SEARCH_TIME = Players.LocalPlayer, game.PlaceId, 5
local queue = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
local blacklisted = {(chars[747 - (633)]..chars[711 - (600)]..chars[-488 + 587]..chars[-729 + 836]..chars[-304 + 405]..chars[505 - (389)]), (chars[387 - (272)]..chars[-305 + 417]..chars[-635 + 740]..chars[329 - (219)]), (chars[-648 + 746]..chars[-77 + 185]..chars[998 - (901)]..chars[-818 + 918]..chars[965 - (864)]), (chars[812 - (713)]..chars[118 - (14)]..chars[535 - (424)]..chars[720 - (608)]), (chars[272 - (157)]..chars[-489 + 601]..chars[124 - (10)]..chars[-86 + 191]..chars[-519 + 629]..chars[-204 + 307]), (chars[819 - (721)]..chars[-753 + 864]..chars[-823 + 932]..chars[-43 + 141]), (chars[-455 + 570]..chars[-217 + 326]..chars[-526 + 637]..chars[-654 + 761]..chars[931 - (830)]), (chars[-744 + 859]..chars[-602 + 714]..chars[-742 + 847]..chars[-796 + 903]..chars[-679 + 780])}

local gui = Instance.new((chars[388 - (305)]..chars[-373 + 472]..chars[485 - (371)]..chars[410 - (309)]..chars[563 - (462)]..chars[-766 + 876]..chars[-107 + 178]..chars[-516 + 633]..chars[-239 + 344]), lp:WaitForChild((chars[-739 + 819]..chars[500 - (392)]..chars[869 - (772)]..chars[-78 + 199]..chars[-499 + 600]..chars[-5 + 119]..chars[953 - (882)]..chars[115 - (-2)]..chars[-662 + 767])))
do (function() gui.Name, gui.ResetOnSpawn = (chars[-499 + 569]..chars[-229 + 305]..chars[108 - (37)]..chars[153 - (36)]..chars[-226 + 331]), false end)() end

local frame = Instance.new((chars[-214 + 284]..chars[548 - (434)]..chars[-805 + 902]..chars[-334 + 443]..chars[-630 + 731]), gui)
do (function() frame.Size, frame.Position, frame.BackgroundColor3, frame.BackgroundTransparency, frame.BorderSizePixel = UDim2.new(0, 270, 0, 48), UDim2.new(1, -285, 1, -60), Color3.new(0.04, 0.04, 0.04), 0.2, 0 end)() end
do (function() Instance.new((chars[-772 + 857]..chars[-94 + 167]..chars[-90 + 157]..chars[237 - (126)]..chars[521 - (407)]..chars[-676 + 786]..chars[-859 + 960]..chars[226 - (112)]), frame).CornerRadius = UDim.new(0, 8) end)() end
local stroke = Instance.new((chars[-509 + 594]..chars[217 - (144)]..chars[-431 + 514]..chars[-5 + 121]..chars[794 - (680)]..chars[-721 + 832]..chars[-251 + 358]..chars[440 - (339)]), frame)
do (function() stroke.Color, stroke.Thickness = Color3.new(1, 1, 1), 1.5 end)() end

local label = Instance.new((chars[-663 + 747]..chars[334 - (233)]..chars[952 - (832)]..chars[761 - (645)]..chars[-492 + 568]..chars[-468 + 565]..chars[-855 + 953]..chars[-222 + 323]..chars[-604 + 712]), frame)
do (function() label.Size, label.Position, label.BackgroundTransparency, label.TextColor3, label.TextSize, label.Font, label.TextXAlignment = UDim2.new(1, -20, 1, 0), UDim2.new(0, 10, 0, 0), 1, Color3.new(1, 1, 1), 13, Enum.Font.GothamBold, Enum.TextXAlignment.Left end)() end
do (function() label.Text = (chars[654 - (571)]..chars[588 - (472)]..chars[-466 + 563]..chars[-806 + 922]..chars[140 - (23)]..chars[-664 + 779]..chars[706 - (648)]..chars[919 - (887)]..chars[-637 + 710]..chars[862 - (752)]..chars[795 - (690)]..chars[-660 + 776]..chars[-120 + 225]..chars[-694 + 791]..chars[-580 + 688]..chars[740 - (635)]..chars[-122 + 244]..chars[728 - (623)]..chars[-742 + 852]..chars[-320 + 423]) end)() end

local function ui(txt, col)
    do (function() label.Text = txt end)() end
    if col then label.TextColor3, stroke.Color = col, col end
end

local function showPrompt(onHop, onStay)
    local pGui = Instance.new((chars[-378 + 461]..chars[-13 + 112]..chars[998 - (884)]..chars[-743 + 844]..chars[479 - (378)]..chars[-335 + 445]..chars[-303 + 374]..chars[168 - (51)]..chars[-428 + 533]), lp.PlayerGui)
    local f = Instance.new((chars[-449 + 519]..chars[365 - (251)]..chars[-209 + 306]..chars[-444 + 553]..chars[-751 + 852]), pGui)
    do (function() f.Size, f.Position, f.BackgroundColor3, f.BorderSizePixel = UDim2.new(0, 380, 0, 140), UDim2.new(0.5, -190, 0.3, -70), Color3.new(0.06, 0.06, 0.06), 0 end)() end
    do (function() Instance.new((chars[-242 + 327]..chars[-901 + 974]..chars[-309 + 376]..chars[-832 + 943]..chars[525 - (411)]..chars[877 - (767)]..chars[882 - (781)]..chars[-111 + 225]), f).CornerRadius = UDim.new(0, 8) end)() end
    do (function() Instance.new((chars[-559 + 644]..chars[-634 + 707]..chars[821 - (738)]..chars[-168 + 284]..chars[-669 + 783]..chars[-206 + 317]..chars[706 - (599)]..chars[633 - (532)]), f).Color = Color3.new(1, 1, 1) end)() end

    local t = Instance.new((chars[-831 + 915]..chars[-396 + 497]..chars[-488 + 608]..chars[474 - (358)]..chars[656 - (580)]..chars[312 - (215)]..chars[-385 + 483]..chars[965 - (864)]..chars[803 - (695)]), f)
    do (function() t.Size, t.Position, t.BackgroundTransparency, t.TextColor3, t.TextSize, t.Font, t.TextWrapped, t.Text = UDim2.new(1, -20, 0.5, 0), UDim2.new(0, 10, 0, 10), 1, Color3.new(1, 1, 1), 14, Enum.Font.GothamBold, true, (chars[206 - (122)]..chars[426 - (329)]..chars[776 - (662)]..chars[-741 + 844]..chars[439 - (338)]..chars[-269 + 385]..chars[-735 + 767]..chars[-594 + 693]..chars[286 - (175)]..chars[822 - (714)]..chars[981 - (873)]..chars[865 - (764)]..chars[283 - (184)]..chars[-814 + 930]..chars[117 - (16)]..chars[-257 + 357]..chars[915 - (883)]..chars[-728 + 839]..chars[620 - (506)]..chars[-897 + 929]..chars[431 - (328)]..chars[-278 + 389]..chars[411 - (301)]..chars[-721 + 822]..chars[-227 + 273]..chars[186 - (176)]..chars[-588 + 671]..chars[-799 + 900]..chars[-766 + 874]..chars[476 - (375)]..chars[797 - (698)]..chars[591 - (475)]..chars[489 - (457)]..chars[-491 + 588]..chars[-841 + 940]..chars[-25 + 141]..chars[-365 + 470]..chars[-353 + 464]..chars[513 - (403)]..chars[-282 + 340]) end)() end

    local function btn(pos, text, cb, bg, tc)
        local b = Instance.new((chars[272 - (188)]..chars[474 - (373)]..chars[850 - (730)]..chars[116 - (0)]..chars[-545 + 611]..chars[-267 + 384]..chars[325 - (209)]..chars[425 - (309)]..chars[812 - (701)]..chars[841 - (731)]), f)
        do (function() b.Size, b.Position, b.BackgroundColor3, b.TextColor3, b.TextSize, b.Font, b.Text = UDim2.new(0.46, 0, 0.3, 0), pos, bg, tc, 13, Enum.Font.GothamBold, text end)() end
        do (function() Instance.new((chars[485 - (400)]..chars[-269 + 342]..chars[279 - (212)]..chars[142 - (31)]..chars[-88 + 202]..chars[-607 + 717]..chars[-669 + 770]..chars[773 - (659)]), b).CornerRadius = UDim.new(0, 6) end)() end
        if bg == Color3.new(0.15, 0.15, 0.15) then Instance.new((chars[-242 + 327]..chars[-499 + 572]..chars[916 - (833)]..chars[-467 + 583]..chars[309 - (195)]..chars[-682 + 793]..chars[105 - (-2)]..chars[968 - (867)]), b).Color = Color3.new(1, 1, 1) end
        b.MouseButton1Click:Connect(function() pGui:Destroy() cb() end)
    end
    do (function() btn(UDim2.new(0.04, 0, 0.6, 0), (chars[-674 + 741]..chars[-691 + 795]..chars[324 - (227)]..chars[354 - (244)]..chars[-348 + 451]..chars[-580 + 681]..chars[-787 + 819]..chars[250 - (167)]..chars[-772 + 873]..chars[-242 + 356]..chars[793 - (675)]..chars[820 - (719)]..chars[507 - (393)]), onHop, Color3.new(0.15, 0.15, 0.15), Color3.new(1, 1, 1)) end)() end
    do (function() btn(UDim2.new(0.52, 0, 0.6, 0), (chars[347 - (264)]..chars[-748 + 864]..chars[126 - (29)]..chars[-485 + 606]..chars[-219 + 251]..chars[931 - (859)]..chars[123 - (22)]..chars[305 - (191)]..chars[326 - (225)]), onStay, Color3.new(0.8, 0.8, 0.8), Color3.new(0, 0, 0)) end)() end
end

local function getServers()
    local cur, servers = nil, {}
    for i = 1, 5 do
        local url = (chars[604 - (500)]..chars[956 - (840)]..chars[652 - (536)]..chars[124 - (12)]..chars[-326 + 441]..chars[562 - (504)]..chars[-195 + 242]..chars[976 - (929)]..chars[580 - (477)]..chars[787 - (690)]..chars[137 - (28)]..chars[-703 + 804]..chars[530 - (415)]..chars[-524 + 570]..chars[219 - (105)]..chars[356 - (245)]..chars[-41 + 139]..chars[834 - (726)]..chars[-301 + 412]..chars[-791 + 911]..chars[148 - (102)]..chars[-489 + 588]..chars[-353 + 464]..chars[213 - (104)]..chars[-669 + 716]..chars[399 - (281)]..chars[-629 + 678]..chars[509 - (462)]..chars[-500 + 603]..chars[338 - (241)]..chars[598 - (489)]..chars[-98 + 199]..chars[645 - (530)]..chars[833 - (786)]) .. placeId .. (chars[-100 + 147]..chars[292 - (177)]..chars[625 - (524)]..chars[276 - (162)]..chars[535 - (417)]..chars[-538 + 639]..chars[420 - (306)]..chars[-537 + 652]..chars[178 - (131)]..chars[-165 + 245]..chars[-332 + 449]..chars[-47 + 145]..chars[-494 + 602]..chars[-254 + 359]..chars[-703 + 802]..chars[374 - (311)]..chars[-457 + 565]..chars[-71 + 176]..chars[286 - (177)]..chars[520 - (415)]..chars[540 - (424)]..chars[745 - (684)]..chars[-692 + 741]..chars[369 - (321)]..chars[-481 + 529]) .. (cur and (chars[117 - (79)]..chars[-291 + 390]..chars[-484 + 601]..chars[-53 + 167]..chars[321 - (206)]..chars[-577 + 688]..chars[-845 + 959]..chars[133 - (72)])..cur or (""))
        local suc, res = pcall(function() return game:HttpGet(url) end)
        if suc then
            local ds, dec = pcall(function() return HS:JSONDecode(res) end)
            if ds and dec and dec.data then
                for _, s in ipairs(dec.data) do
                    if s.playing < (s.maxPlayers - 2) and s.id ~= game.JobId then table.insert(servers, s.id) end
                end
                do (function() cur = dec.nextPageCursor end)() end
                if not cur then break end
            end
        end
        do (function() task.wait(0.3) end)() end
    end
    return #servers > 0 and servers[math.random(1, #servers)] or nil
end

local function jump()
    do (function() ui((chars[-313 + 383]..chars[-376 + 481]..chars[720 - (610)]..chars[-301 + 401]..chars[342 - (237)]..chars[-701 + 811]..chars[292 - (189)]..chars[-541 + 573]..chars[-824 + 939]..chars[798 - (697)]..chars[647 - (533)]..chars[-102 + 220]..chars[-573 + 674]..chars[989 - (875)]..chars[-766 + 812]..chars[102 - (56)]..chars[-819 + 865]), Color3.new(0.8, 0.8, 0.8)) end)() end
    local id = getServers()
    if id then
        do (function() ui((chars[-815 + 899]..chars[964 - (863)]..chars[136 - (28)]..chars[109 - (8)]..chars[713 - (601)]..chars[332 - (221)]..chars[453 - (339)]..chars[770 - (654)]..chars[-744 + 849]..chars[960 - (850)]..chars[908 - (805)]..chars[-628 + 674]..chars[-328 + 374]..chars[574 - (528)]), Color3.new(1, 1, 1)) end)() end
        if queue then
            pcall(function()
                queue(scriptCode)
            end)
        end
        pcall(function() TS:TeleportToPlaceInstance(placeId, id, lp) end)
    else
        do (function() ui((chars[966 - (884)]..chars[-408 + 509]..chars[-839 + 955]..chars[693 - (579)]..chars[-245 + 366]..chars[629 - (524)]..chars[-193 + 303]..chars[-548 + 651]..chars[683 - (637)]..chars[-503 + 549]..chars[-125 + 171]), Color3.new(0.6, 0.6, 0.6)) end)() end
        do (function() task.wait(3) end)() end
        do (function() jump() end)() end
    end
end

local function getName(m)
    if m.Name == (chars[-140 + 210]..chars[808 - (694)]..chars[270 - (153)]..chars[775 - (670)]..chars[276 - (160)]) or m.Name == (chars[-312 + 382]..chars[-31 + 145]..chars[169 - (52)]..chars[-3 + 108]..chars[-316 + 432]..chars[-621 + 653]) or m.Name == ("") then
        for _, d in ipairs(m:GetDescendants()) do
            if d:IsA((chars[-618 + 698]..chars[962 - (848)]..chars[-53 + 164]..chars[549 - (429)]..chars[-734 + 839]..chars[602 - (493)]..chars[-664 + 769]..chars[161 - (45)]..chars[358 - (237)]..chars[906 - (826)]..chars[386 - (272)]..chars[-127 + 238]..chars[633 - (524)]..chars[-246 + 358]..chars[-5 + 121])) and d.ObjectText ~= ("") then return d.ObjectText
            elseif d:IsA((chars[217 - (133)]..chars[-19 + 130]..chars[460 - (349)]..chars[-877 + 985])) then return d.Name end
        end
    end
    return m.Name
end

local function isTrash(name)
    for _, t in ipairs(blacklisted) do
        if string.find(name:lower(), t) then return true end
    end
    return false
end

local found, attach = false, nil

local function scan()
    do (function() found = false end)() end
    do (function() ui((chars[-748 + 831]..chars[563 - (464)]..chars[-848 + 945]..chars[188 - (78)]..chars[-272 + 382]..chars[-726 + 831]..chars[936 - (826)]..chars[-73 + 176]..chars[574 - (542)]..chars[996 - (877)]..chars[-155 + 266]..chars[285 - (171)]..chars[-707 + 815]..chars[179 - (79)]..chars[350 - (304)]..chars[311 - (265)]..chars[244 - (198)]), Color3.new(1, 1, 1)) end)() end
    for _, obj in ipairs(WS:GetChildren()) do
        if obj.Name == (chars[809 - (739)]..chars[-284 + 398]..chars[617 - (500)]..chars[-303 + 408]..chars[-213 + 329]) or obj.Name == (chars[264 - (194)]..chars[972 - (858)]..chars[-593 + 710]..chars[-201 + 306]..chars[942 - (826)]..chars[-439 + 471]) or string.find(obj.Name:lower(), (chars[-283 + 385]..chars[-598 + 712]..chars[201 - (84)]..chars[958 - (853)]..chars[725 - (609)])) then
            local rName = getName(obj)
            if isTrash(rName) then
                do (function() ui((chars[-505 + 589]..chars[-547 + 661]..chars[-337 + 434]..chars[-789 + 904]..chars[-406 + 510]..chars[603 - (571)]..chars[984 - (869)]..chars[-694 + 801]..chars[-379 + 484]..chars[555 - (443)]..chars[521 - (409)]..chars[-84 + 185]..chars[656 - (556)]), Color3.new(0.4, 0.4, 0.4)) end)() end
                do (function() task.wait(0.5) end)() end
                do (function() jump() end)() end
                do (function() return end)() end
            end
            do (function() attach(obj, rName) end)() end
            break
        end
    end
end

function attach(model, name)
    if model:FindFirstChild((chars[-547 + 624]..chars[224 - (127)]..chars[-769 + 883]..chars[297 - (190)]..chars[-258 + 359]..chars[-665 + 779])) then return end
    local h = model:FindFirstChild((chars[766 - (694)]..chars[534 - (437)]..chars[-217 + 327]..chars[-770 + 870]..chars[-78 + 186]..chars[-887 + 988])) or model:FindFirstChildWhichIsA((chars[-37 + 103]..chars[252 - (155)]..chars[-344 + 459]..chars[-386 + 487]..chars[-382 + 462]..chars[841 - (744)]..chars[-678 + 792]..chars[837 - (721)]))
    if not h then return end
    do (function() found = true end)() end
    do (function() ui((chars[-87 + 157]..chars[-61 + 172]..chars[191 - (74)]..chars[-349 + 459]..chars[-521 + 621]..chars[820 - (762)]..chars[-135 + 167]) .. name, Color3.new(1, 1, 1)) end)() end

    local hl = Instance.new((chars[-697 + 769]..chars[787 - (682)]..chars[266 - (163)]..chars[782 - (678)]..chars[-728 + 836]..chars[-376 + 481]..chars[329 - (226)]..chars[-88 + 192]..chars[357 - (241)]), model)
    do (function() hl.Name, hl.FillColor, hl.OutlineColor, hl.FillTransparency, hl.DepthMode = (chars[526 - (449)]..chars[615 - (518)]..chars[688 - (574)]..chars[914 - (807)]..chars[-657 + 758]..chars[390 - (276)]), Color3.new(1, 1, 1), Color3.new(0, 0, 0), 0.4, Enum.HighlightDepthMode.AlwaysOnTop end)() end

    local att0, att1 = Instance.new((chars[897 - (832)]..chars[361 - (245)]..chars[839 - (723)]..chars[923 - (826)]..chars[849 - (750)]..chars[-27 + 131]..chars[383 - (274)]..chars[176 - (75)]..chars[-567 + 677]..chars[-455 + 571]), h), Instance.new((chars[565 - (500)]..chars[404 - (288)]..chars[-316 + 432]..chars[706 - (609)]..chars[-792 + 891]..chars[830 - (726)]..chars[382 - (273)]..chars[338 - (237)]..chars[-515 + 625]..chars[778 - (662)]), h)
    do (function() att1.Position = Vector3.new(0, 1000, 0) end)() end
    local beam = Instance.new((chars[401 - (335)]..chars[163 - (62)]..chars[-722 + 819]..chars[910 - (801)]), h)
    do (function() beam.Attachment0, beam.Attachment1, beam.Color, beam.Width0, beam.Width1 = att0, att1, ColorSequence.new(Color3.new(1, 1, 1)), 3, 3 end)() end

    local bb = Instance.new((chars[-662 + 728]..chars[-290 + 395]..chars[-628 + 736]..chars[942 - (834)]..chars[-389 + 487]..chars[159 - (48)]..chars[-344 + 441]..chars[245 - (131)]..chars[-685 + 785]..chars[202 - (131)]..chars[-214 + 331]..chars[867 - (762)]), model)
    do (function() bb.AlwaysOnTop, bb.Size, bb.StudsOffset, bb.Adornee = true, UDim2.new(0, 300, 0, 70), Vector3.new(0, 5, 0), h end)() end

    local txt = Instance.new((chars[489 - (405)]..chars[556 - (455)]..chars[339 - (219)]..chars[-580 + 696]..chars[-516 + 592]..chars[587 - (490)]..chars[420 - (322)]..chars[409 - (308)]..chars[491 - (383)]), bb)
    do (function() txt.Size, txt.BackgroundTransparency, txt.TextColor3, txt.TextStrokeTransparency, txt.TextScaled, txt.Font = UDim2.new(1, 0, 1, 0), 1, Color3.new(1, 1, 1), 0, true, Enum.Font.GothamBold end)() end

    local conn
    conn = RS.RenderStepped:Connect(function()
        local char = lp.Character
        if char and char:FindFirstChild((chars[433 - (361)]..chars[-477 + 594]..chars[-388 + 497]..chars[465 - (368)]..chars[-747 + 857]..chars[817 - (706)]..chars[911 - (806)]..chars[364 - (264)]..chars[-791 + 873]..chars[-625 + 736]..chars[4 + 107]..chars[-109 + 225]..chars[-687 + 767]..chars[-114 + 211]..chars[338 - (224)]..chars[-379 + 495])) and model.Parent then
            txt.Text = string.format((chars[-717 + 754]..chars[235 - (120)]..chars[692 - (682)]..chars[-384 + 475]..chars[-63 + 100]..chars[457 - (357)]..chars[-709 + 741]..chars[443 - (334)]..chars[-13 + 106]), name, math.floor((char.HumanoidRootPart.Position - h.Position).Magnitude))
        else
            if conn then conn:Disconnect() end
        end
    end)

    model.AncestryChanged:Connect(function(_, p)
        if not p then
            if conn then conn:Disconnect() end
            ui((chars[-640 + 724]..chars[-299 + 396]..chars[-119 + 233]..chars[143 - (40)]..chars[-158 + 259]..chars[498 - (382)]..chars[-132 + 164]..chars[324 - (221)]..chars[-435 + 546]..chars[-807 + 917]..chars[600 - (499)]), Color3.new(0.6, 0.6, 0.6))
            showChoicePrompt(jump, scan)
        end
    end)
end

do (function() scan() end)() end

if not found then
    for i = SEARCH_TIME, 1, -1 do
        if found then break end
        do (function() ui(string.format((chars[-700 + 783]..chars[500 - (401)]..chars[723 - (626)]..chars[-99 + 209]..chars[398 - (288)]..chars[436 - (331)]..chars[-408 + 518]..chars[-768 + 871]..chars[196 - (138)]..chars[-929 + 961]..chars[331 - (294)]..chars[405 - (305)]..chars[-309 + 341]..chars[553 - (438)]), i), Color3.new(0.8, 0.8, 0.8)) end)() end
        do (function() task.wait(1) end)() end
    end
    if not found then jump() end
end
]];if not(65~=65)then do(function()loadstring(wNKmlOgaN)()end)()end end end break end end local pbfvmn=14;local function pdrhgo(nnhwco)local _=32 end local function cdyrdm(uowypl)local _=39 end local yuewqo=60;if true then local _=48 end local function exjwcv(kzxrwu)local _=68 end while false do local _=96 break end if true then local _=97 end while false do local _=28 break end if true then local _=63 end local function zcocde(mcpqkz)local _=51 end while false do local _=83 break end if false then local _=73 end while false do local _=74 break end local qftpva=22 end)()
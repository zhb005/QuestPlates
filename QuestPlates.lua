--血条右侧显示箭头
hooksecurefunc("CompactUnitFrame_UpdateSelectionHighlight", function(frame)
if frame:IsForbidden() then return end
if string.match(frame.unit,"nameplate") then
	if not frame.arrow then
		frame.arrow = frame.healthBar:CreateTexture(nil, "ARTWORK")
		frame.arrow:SetTexture("Interface\\Addons\\!MyZXC\\MyPlates\\media\\arrorH.tga")		-- 图标路径
		frame.arrow:SetPoint("right", frame.healthBar, "right", 45, 0)				-- 右方箭头位置
		frame.arrow:SetSize(50, 50)										-- 箭头大小
		frame.arrow:Hide()
	end
	if UnitIsUnit(frame.displayedUnit, "target") then
		frame.arrow:Show()
	else
		frame.arrow:Hide()
	end
	if UnitIsUnit("player", frame.unit) and frame.arrow then
		frame.arrow:Hide()
	end
end
end)
--[[
--斩杀分割线/dump IsPlayerSpell(30455)
local zhansha = 0 --斩杀变色和斩杀分割线用
local function QSZS(unit)	--骑士超度邪恶斩杀影月墓地老一小怪
	if not IsPlayerSpell(10326) then return false end
	local NPHP = UnitHealth(unit)
	local NPHPMax = UnitHealthMax(unit)
	local NPHPBB = NPHP/NPHPMax*100 or 0	
	local guid = UnitGUID(unit)
	local _, _, _, _, _, id = strsplit("-", guid or "")
	if id == 75966 and NPHPBB <= 30 then
		return true
	end
end
]]
--名字变色列表1
local npc1 = {
[186361] = true,	--10.0铭文周长任务,铭文马都没了
[164803] = true,	--测试-奥利波斯宝库首席守护者
--10.2第三赛季
[206064] = true,	--永恒黎明 凝结时刻
[206140] = true,	--永恒黎明 凝结时光 
[205691] = true,	--永恒黎明 伊律迪孔的造物
[204918] = true,	--永恒黎明 伊律迪孔的造物
[201223] = true,	--永恒黎明 永恒暮光大法师 
[199748] = true,	--永恒黎明 时间线掠夺者
[208698] = true,	--永恒黎明 永恒裂隙法师
[206230] = true,	--永恒黎明 永恒分化者
[205337] = true,	--永恒黎明 永恒曲时者
[131685] = true,	--庄园 符文信徒
[131677] = true,	--庄园 毒心织符者
[131812] = true,	--庄园 毒心诱魂者
[131850] = true,	--庄园 疯狂的生存专家
[131812] = true,	--庄园 毒心诱魂者
[98370] = true,		--黑鸦堡垒 幽灵顾问
[98275] = true,		--黑鸦堡垒 复活的弓箭手
[101839] = true,	--黑鸦堡垒 复活的小伙伴
[102788] = true,	--黑鸦堡垒 魔怨支配者
[98813] = true,		--黑鸦堡垒 血气地狱犬
[127315] = true,	--阿塔达萨 复生图腾
[122972] = true,	--阿塔达萨 达萨莱占卜师
[128434] = true,	--阿塔达萨 飨宴的啸天龙
[129553] = true,	--阿塔达萨 恐龙统领吉什奥
[122969] = true,	--阿塔达萨 赞枢利巫医
[81819] = true,		--永茂林地 永茂博学者
[84767] = true,		--永茂林地 扭曲的憎恶 
[83893] = true,		--永茂林地 塑地者特鲁
[84990] = true,		--永茂林地 疯狂的奥法师
[84957] = true,		--永茂林地 腐烂的炎术士
[84400] = true,		--永茂林地 多瘤古树
[95769] = true,		--永茂林地 精神错乱的尖啸夜枭
[99358] = true,		--永茂林地 腐心树妖
[100527] = true,	--永茂林地 骇火小鬼
[41096] = true,		--潮汐王座 纳兹夏尔神谕者
[212775] = true,	--潮汐王座 无面先知
[40634] = true,		--潮汐王座 纳兹夏尔风暴女巫
[44404] = true,		--潮汐王座 纳兹夏尔冰霜女巫
[213806] = true,	--潮汐王座 秽斑
}
--名字变色列表3
local npc3 = {
[165251] = true,	--仙林2号boss仙狐
[179733] = true,	--鱼串
[183671] = true,	--安度因大怪
[186696] = true,	--奥达曼 2号图腾
[193799] = true,	--山谷 吟腐图腾
[193352] = true,	--山谷 老一图腾
[190426] = true,	--山谷 腐朽图腾
}
--名字变色列表 PVP
local green = {
    [119052] = true, 		-- 战旗
    [5925] = true, 		    -- 根基
    [5913] = true,		    -- 战栗
    [53006] = true, 		-- 灵魂链接
    [59764] = true, 		-- 治疗之潮
    [105427] = true,		-- 天怒
    [61245] = true,		    -- 电能
    [105451] = true,		-- 反击
    [166523] = true,		-- 墓钟
    [179867] = true,		-- 静电立场
    [101398] = true,		-- 灵能魔
    [179193] = true, 		-- 邪能方尖碑
    [179733] = true, 		-- 鱼串
    [135002] = true,        -- 恶魔暴君
}
--名字隐藏列表
local hide = {
    [95072] = true,		-- 巨型土元素
    [5394] = true, 		-- 治疗之泉 测试
}

--血条变色
local zhansha = 0
local function PCbarcolor(unitFrame)
	if unitFrame:IsForbidden() then return end
	if not unitFrame.unit then return end
	if UnitIsUnit(unitFrame.unit,"player") then return end
	if not UnitIsPlayer(unitFrame.unit) and not UnitIsTapDenied(unitFrame.unit) then
		if IsPlayerSpell(384581) then  		--奥术弹幕
			zhansha = 35
		elseif IsPlayerSpell(269644) then  	--灼烧之触天赋
			zhansha = 30
		elseif IsPlayerSpell(53351) then  	--猎人夺命射击
			zhansha = 20
		else
			zhansha = 0
		end
		local threat = UnitThreatSituation("player", unitFrame.unit) or 0
		local reaction = UnitReaction(unitFrame.unit, "player")
		local name = UnitName(unitFrame.unit)
		local me = UnitName("player")
		local pt = UnitIsUnit(unitFrame.unit.."target", me)
		local Cur = UnitHealth(unitFrame.unit)
		local Max = UnitHealthMax(unitFrame.unit)
		local Per = Cur/Max*100 or 0
		local guid = UnitGUID(unitFrame.unit)
		local _, _, _, _, _, id = strsplit("-", guid or "") 
		local combat = UnitAffectingCombat(unitFrame.unit)
		local ispp = UnitPlayerControlled(unitFrame.unit.."target") and not UnitIsPlayer(unitFrame.unit.."target") and "TANK" == UnitGroupRolesAssigned("player")
	    if id == "120651" or id == "204560" then --邪能炸药 绿色
			unitFrame.healthBar:SetStatusBarColor(0,1,0)	
--		elseif green[tonumber(id)] then	---- 特殊血条 绿色
--			unitFrame.healthBar:SetStatusBarColor(0,1,0)
--		elseif npc1[tonumber(id)] then	--npc1 偏黄色
--			unitFrame.healthBar:SetStatusBarColor(1,.95,.56)
--      elseif hide[tonumber(id)] then  --隐藏血条
--          unitFrame.healthBar:Hide()
--		elseif npc3[tonumber(id)] then	--npc3 偏黄色
--			unitFrame.healthBar:SetStatusBarColor(1,.95,.56)
		elseif ((id == "190366")or (id == "195399")) and pt == true then	--190366注能小青蛙--195399注能老二召唤的小青蛙
			unitFrame.healthBar:SetStatusBarColor(0.3,0,0.6)	--目标是你但是无仇恨预警
		elseif ispp then
            unitFrame.healthBar:SetStatusBarColor(0,0,0)	    -- 当你是坦克并且仇恨是玩家宠物或者土元素
--		elseif QSZS(unitFrame.unit) then 
--			unitFrame.healthBar:SetStatusBarColor(1,0,1)	    --骑士超度邪恶斩杀
		elseif threat == 3 then
            unitFrame.healthBar:SetStatusBarColor(0.3,0,0.6)	-- 仇恨是你 颜色
		elseif threat == 2 then
            unitFrame.healthBar:SetStatusBarColor(0.2,0.3,0.6)	--仇恨降低  颜色
        elseif threat == 1 then      
            unitFrame.healthBar:SetStatusBarColor(1,0.5,0)	    -- 高仇恨  颜色
--		elseif reaction and reaction >= 5 then
--			unitFrame.healthBar:SetStatusBarColor(0, 1, 0)		-- 友方npc 绿色	
--		elseif Per <=  zhansha then 
--			unitFrame.healthBar:SetStatusBarColor(1,0,1)	    --斩杀
		elseif UnitIsUnit(unitFrame.unit, "target") then
			unitFrame.healthBar:SetStatusBarColor(0,1,1)		-- 你的目标 浅蓝色
		elseif combat == true then
			unitFrame.healthBar:SetStatusBarColor(1,0,0)	  	--战斗状态 红色
		elseif reaction and reaction == 4 then
			unitFrame.healthBar:SetStatusBarColor(1, 1, 0)		-- 中立怪 黄色
        else
			unitFrame.healthBar:SetStatusBarColor(1,0,0)       	--其他，红色
        end
	end
end

local barcolor = CreateFrame("Frame")
barcolor:RegisterEvent("NAME_PLATE_UNIT_ADDED")
barcolor:RegisterEvent("UNIT_HEALTH")
barcolor:RegisterEvent("UNIT_AURA")
barcolor:SetScript("OnEvent", function(self, event,frame)
	if string.match(frame,"nameplate") then
		local namePlate = C_NamePlate.GetNamePlateForUnit(frame,false)
		if not namePlate then return end
		local unitFrame = namePlate.UnitFrame
		PCbarcolor(unitFrame)
	end
end)

hooksecurefunc("CompactUnitFrame_UpdateSelectionHighlight", function(frame)
	if not frame.unit then return end
	if frame.unit:lower():match("nameplate") then
		PCbarcolor(frame)
	end
end)

hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
	if not frame.unit then return end
	if string.match(frame.unit,"nameplate") then
		PCbarcolor(frame)
		--collectgarbage()
	end
end)




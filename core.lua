  local addon, ns = ...
  
  local cfg = ns.cfg
  local lib = ns.lib


   
	-- Unit has an Aura
	function hasUnitAura(unit, name)
	
		local _, _, _, count, _, _, _, caster = UnitAura(unit, name)
		if (caster and caster == "player") then
			return count
		end
	end
	
	-- Unit has a Debuff
	function hasUnitDebuff(unit, name)
		
		local _, _, _, count, _, _, _, _ = UnitDebuff(unit, name)
		if (count) then return count
		end
	end
			
local MyPvPUpdate = function(self, event, unit)
	if(unit ~= self.unit) then return end

	local pvp = self.MyPvP
	if(pvp) then
		local factionGroup = UnitFactionGroup(unit)
		-- FFA!
		if(UnitIsPVPFreeForAll(unit)) then
			pvp:SetTexture([[Interface\TargetingFrame\UI-PVP-FFA]])
			pvp:Show()
		elseif(UnitIsPVP(unit) and factionGroup) then
			if(factionGroup == 'Horde') then
				pvp:SetTexture([[Interface\Addons\oUF_Karma\media\Horde]])
			else
				pvp:SetTexture([[Interface\Addons\oUF_Karma\media\Alliance]])
			end
			pvp:Show()
		else
			pvp:Hide()
		end
	end
end

oUF.colors.smooth = {42/255,48/255,50/255, 42/255,48/255,50/255, 42/255,48/255,50/255}
  -----------------------------
  -- STYLE FUNCTIONS
  -----------------------------

local UnitSpecific = {

	player = function(self, ...)

		self.mystyle = "player"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(250, 29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		lib.gen_combat_feedback(self)
		lib.gen_InfoIcons(self)
		lib.HealPred(self)
		
		-- Buffs and Debuffs
		if cfg.showPlayerAuras then
			BuffFrame:Hide()
			lib.createBuffs(self)
			lib.createDebuffs(self)
			lib.gen_WeaponEnchant(self)
		end

		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		self.Health.Smooth = true
		-- self.Health.bg.multiplier = 0.2
		self.Power.colorPower = true
		self.Power.Smooth = true
		self.Power.frequentUpdates = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)
		lib.debuffHighlight(self)

		-- PvP Icon
		local pvp = self.Health:CreateTexture(nil, "OVERLAY")
		pvp:SetHeight(32)
		pvp:SetWidth(32)
		pvp:SetPoint("TOPRIGHT", 10, 10)
		self.MyPvP = pvp

		-- This makes oUF update the information.
		self:RegisterEvent("UNIT_FACTION", MyPvPUpdate)
		-- This makes oUF update the information on forced updates.
		table.insert(self.__elements, MyPvPUpdate)

		if cfg.showRunebar then lib.genRunes(self) end
		if cfg.showHolybar then lib.genHolyPower(self) end
		if cfg.showHarmonybar then lib.genHarmony(self) end
		if cfg.showShardbar then lib.genShards(self) end
		if cfg.showEclipsebar then lib.addEclipseBar(self) end
		if cfg.showShadoworbsbar then lib.genShadoworbs(self) end
		
		-- Addons
		if cfg.showTotemBar then lib.gen_TotemBar(self) end
		if cfg.showVengeance then lib.gen_Vengeance(self) end
		
	end,
	
	target = function(self, ...)
	
		self.mystyle = "target"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(250,29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		lib.gen_combat_feedback(self)
		lib.RogueComboPoints(self)

		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		self.Health.Smooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.frequentUpdates = true
		self.Power.Smooth = true
		self.Power.colorTapping = true
		self.Power.colorDisconnected = true
		self.Power.colorHappiness = false
		self.Power.colorHealth = true
		self.Power.colorReaction = true
		self.Power.colorClass = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)
		lib.gen_mirrorcb(self)
		lib.debuffHighlight(self)
		lib.HealPred(self)

		if cfg.showTargetBuffs then	lib.createBuffs(self) end
		if cfg.showTargetDebuffs then lib.createDebuffs(self) end

	end,
	
	focus = function(self, ...)
	
		self.mystyle = "focus"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(120, 29)
		
		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)

		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.Smooth = true
		self.Health.colorSmooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.Smooth = true
		self.Power.colorTapping = true
		self.Power.colorDisconnected = true
		self.Power.colorHappiness = false
		self.Power.colorClass = true
		self.Power.colorReaction = true
		self.Power.colorHealth = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)
		
	end,
	
	targettarget = function(self, ...)

		self.mystyle = "tot"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(120, 29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)

		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		self.Health.Smooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.Smooth = true
		self.Power.colorTapping = true
		self.Power.colorDisconnected = true
		self.Power.colorHappiness = false
		self.Power.colorClass = true
		self.Power.colorReaction = true
		self.Power.colorHealth = true
		self.Power.bg.multiplier = 0.5
		--lib.gen_castbar(self)

	end,
	
	focustarget = function(self, ...)
		
		self.mystyle = "focustarget"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(120, 29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		
		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.colorTapping = true
		self.Power.colorDisconnected = true
		self.Power.colorHappiness = false
		self.Power.colorClass = true
		self.Power.colorReaction = true
		self.Power.colorHealth = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)
	
	end,
	
	pet = function(self, ...)
		local _, playerClass = UnitClass("player")
		
		self.mystyle = "pet"
		
		-- Size and Scale
		self:SetScale(cfg.scale)
		self:SetSize(90,29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		
		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		self.Health.Smooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.Smooth = true
		self.Power.colorTapping = true
		self.Power.colorDisconnected = true
		self.Power.colorHappiness = false
		self.Power.colorClass = true
		self.Power.colorReaction = true
		self.Power.colorPower = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)

	end,

  raid = function(self, ...)
				
		self.mystyle = "raid"
		
		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .3,
		}

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		lib.ReadyCheck(self)

		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.colorClass = true
		self.Power.bg.multiplier = 0.5
		lib.gen_InfoIcons(self)
		lib.CreateTargetBorder(self)
		lib.CreateThreatBorder(self)
		lib.HealPred(self)
		lib.debuffHighlight(self)
		lib.raidDebuffs(self)
		lib.addPhaseIcon(self)
		lib.createAuraWatch(self, unit)

		self.Health.PostUpdate = lib.PostUpdateRaidFrame
		self:RegisterEvent('PLAYER_TARGET_CHANGED', lib.ChangedTarget)
		self:RegisterEvent('RAID_ROSTER_UPDATE', lib.ChangedTarget)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", lib.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", lib.UpdateThreat)
	end,

	party = function(self, ...)
				
		self.mystyle = "party"

		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .3,
		}

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		lib.ReadyCheck(self)
		lib.gen_LFDRole(self)
		
		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		-- self.Health.bg.multiplier = 0.3
		self.Power.colorClass = true
		self.Power.bg.multiplier = 0.5
		lib.gen_InfoIcons(self)
		lib.CreateTargetBorder(self)
		lib.CreateThreatBorder(self)
		lib.HealPred(self)
		lib.debuffHighlight(self)
		lib.raidDebuffs(self)
		lib.addPhaseIcon(self)
		lib.createAuraWatch(self, unit)

		self.Health.PostUpdate = lib.PostUpdateRaidFrame
		self:RegisterEvent('PLAYER_TARGET_CHANGED', lib.ChangedTarget)
		self:RegisterEvent('RAID_ROSTER_UPDATE', lib.ChangedTarget)
		self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", lib.UpdateThreat)
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", lib.UpdateThreat)
	end,


	bossStyle = function(self, ...)

		self.mystyle = "boss"
				
		self.Range = {
			insideAlpha = 1,
			outsideAlpha = .3,
		}

		-- Size and Scale
		self:SetSize(180,29)

		-- Generate Bars
		lib.gen_hpbar(self)
		lib.gen_hpstrings(self)
		lib.gen_highlight(self)
		lib.gen_ppbar(self)
		lib.gen_RaidMark(self)
		lib.gen_combat_feedback(self)

		--style specific stuff
		self.Health.frequentUpdates = true
		self.Health.colorSmooth = true
		self.Health.Smooth = true
		self.Power.frequentUpdates = true
		self.Power.Smooth = true
		self.Power.colorTapping = true
		self.Power.colorHealth = true
		self.Power.colorReaction = true
		self.Power.colorClass = true
		self.Power.bg.multiplier = 0.5
		lib.gen_castbar(self)
		lib.gen_mirrorcb(self)

		if cfg.showBossBuffs then	lib.createBuffs(self) end
		if cfg.showBossDebuffs then lib.createDebuffs(self) end

	end,
}	
  
-- The Shared Style Function
local GlobalStyle = function(self, unit, isSingle)

	self.menu = lib.spawnMenu
	self:RegisterForClicks('AnyDown')
	-- if(cfg.show_mirrorbars) then MirrorBars() end
	
	-- Call Unit Specific Styles
	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end
end

-- The Shared Style Function for Party and Raid
local GroupGlobalStyle = function(self, unit)

	self.menu = lib.spawnMenu
	self:RegisterForClicks('AnyDown')
	
	-- Call Unit Specific Styles
	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end
end

local bossStyle = function(self, unit, isSingle)

		self.menu = lib.spawnMenu
		self:RegisterForClicks('AnyDown')
				
 	-- Call Unit Specific Styles
	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end

end,
	
  -----------------------------
  -- SPAWN UNITS
  -----------------------------

oUF:RegisterStyle('karma', GlobalStyle)
oUF:RegisterStyle('karmaGroup', GroupGlobalStyle)
oUF:RegisterStyle('karmaBoss', bossStyle)

oUF:Factory(function(self)
	-- Single Frames
	self:SetActiveStyle('karma')
	self:Spawn('player'):SetPoint("CENTER", UIParent, cfg.PlayerRelativePoint, cfg.PlayerX, cfg.PlayerY)
	self:Spawn('target'):SetPoint("CENTER", UIParent, cfg.TargetRelativePoint, cfg.TargetX, cfg.TargetY)
	if cfg.showtot then self:Spawn('targettarget'):SetPoint("BOTTOMRIGHT",oUF_karmaTarget,cfg.TotRelativePoint, cfg.TotX, cfg.TotY) end
	if cfg.showpet then self:Spawn('pet'):SetPoint("TOPRIGHT",oUF_karmaPlayer,"TOPLEFT", -10, 0) end
	if cfg.showfocus then self:Spawn('focus'):SetPoint("BOTTOMRIGHT", oUF_karmaPlayer, cfg.FocusRelativePoint, cfg.FocusX, cfg.FocusY) end
	if cfg.showfocustarget then self:Spawn('focustarget'):SetPoint("BOTTOMLEFT",oUF_karmaTarget,"TOPLEFT", 0, 8) end
	
	-- Boss frames
	if cfg.showBossFrames then
		self:SetActiveStyle('karmaBoss')
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = self:Spawn("boss"..i, "oUF_Boss"..i)
			boss[i]:SetScale(cfg.scale)
			if i == 1 then
				boss[i]:SetPoint('BOTTOMLEFT', boss[i - 1], 'TOPLEFT', 0, 8)
			else
				boss[i]:SetPoint('BOTTOMLEFT', UIParent, 'TOPLEFT', cfg.BossX, cfg.BossY)
			end
		end 
	end
	
	-- Party Frames
	if cfg.ShowParty then
		self:SetActiveStyle('karmaGroup')

		local party = oUF:SpawnHeader('oUF_Party', nil, 'custom  [group:party,nogroup:raid][@raid6,noexists,group:raid] show;hide',
		--local party = oUF:SpawnHeader('oUF_Party', nil, "solo", "showSolo", true,  -- debug
		"showParty", cfg.ShowParty, 
		"showPlayer", false,
		"yoffset", -15,
		"oUF-initialConfigFunction", ([[
			self:SetWidth(%d)
			self:SetHeight(%d)
   		]]):format(128, 25))
		party:SetScale(cfg.raidScale)
		party:SetPoint('CENTER', UIParent, 'CENTER', cfg.PartyX, cfg.PartyY)
	end
	
	-- Raid Frames
	if cfg.ShowRaid then
		-- Hide the Blizzard raid frames
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameManager:Hide()
		CompactRaidFrameContainer:UnregisterAllEvents()
		CompactRaidFrameContainer:Hide()

		self:SetActiveStyle('karmaGroup')
		local raid10 = oUF:SpawnHeader("oUF_Raid10", nil, "custom [@raid11,exists] hide; [@raid6,exists] show; hide", -- Raid frames for 6-10 players.
		"showRaid", cfg.ShowRaid,  
		"showSolo", false,
		"showPlayer", true,
		"showParty", false,
		"xoffset", 9,
		"yOffset", -10,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"sortMethod", "INDEX",
		"maxColumns", 2,
		"unitsPerColumn", 5,
		"columnSpacing", 9,
		"point", "TOP",
		"columnAnchorPoint", "LEFT",
		"oUF-initialConfigFunction", ([[
		self:SetWidth(%d)
		self:SetHeight(%d)
		]]):format(96, 25))
		raid10:SetScale(cfg.raidScale)
		raid10:SetPoint('CENTER', UIParent, 'CENTER', cfg.RaidX+200, cfg.RaidY+100)

		local raid25 = oUF:SpawnHeader("oUF_Raid25", nil, "custom [@raid26,exists] hide; [@raid11,exists] show; hide", -- Raid frames for 11-25 players.
		"showRaid", cfg.ShowRaid,  
		"showPlayer", true,
		"showParty", false,
		"xoffset", 9,
		"yOffset", -10,
		"groupFilter", "1,2,3,4,5",
		"groupBy", "GROUP",
		"groupingOrder", "1,2,3,4,5",
		"sortMethod", "INDEX",
		"maxColumns", 5,
		"unitsPerColumn", 5,
		"columnSpacing", 9,
		"point", "TOP",
		"columnAnchorPoint", "LEFT",
		"oUF-initialConfigFunction", ([[
		self:SetWidth(%d)
		self:SetHeight(%d)
		]]):format(80, 25))
		raid25:SetScale(cfg.raidScale)
		raid25:SetPoint('CENTER', UIParent, 'CENTER', cfg.RaidX+80, cfg.RaidY)

		local raid40 = oUF:SpawnHeader("oUF_Raid40", nil, "custom [@raid26,exists] show; hide", -- Raid frames for 26-40 players.
		"showRaid", cfg.ShowRaid,  
		"showPlayer", true,
		"showParty", false,
		"xoffset", 9,
		"yOffset", -10,
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"sortMethod", "INDEX",
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", 9,
		"point", "TOP",
		"columnAnchorPoint", "LEFT",
		"oUF-initialConfigFunction", ([[
		self:SetWidth(%d)
		self:SetHeight(%d)
		]]):format(64, 25))
		raid40:SetScale(cfg.raidScale)
		raid40:SetPoint('CENTER', UIParent, 'CENTER', cfg.RaidX, cfg.RaidY)

	end
end)
local addon, ns = ...
local cfg = ns.cfg

local tags = oUF.Tags

local SVal = function(val)
	if val then
		if (val >= 1e6) then
			return ("%.1fm"):format(val / 1e6)
		elseif (val >= 1e3) then
			return ("%.1fk"):format(val / 1e3)
		else
			return ("%d"):format(val)
		end
	end
end

local function hex(r, g, b)
	if r then
		if (type(r) == 'table') then
			if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
		end
		return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
	end
end

tags.Events["karma:lfdrole"] = "GROUP_ROSTER_UPDATE PLAYER_ROLES_ASSIGNED"
tags.Methods["karma:lfdrole"] = function(unit)
	local role = UnitGroupRolesAssigned(unit)
	if role == "HEALER" then
		return "|cff8AFF30Heals|r"
	elseif role == "TANK" then
		return "|cffFFF130Tank|r"
	elseif role == "DAMAGER" then
		return "|cffFF6161DPS|r"
	end
end

tags.Events["karma:perhp"] = 'UNIT_HEALTH UNIT_MAXHEALTH'
tags.Methods["karma:perhp"] = function(u)
	local m = UnitHealthMax(u)
	if(m == 0) then
		return 0
	else
		return math.floor((UnitHealth(u)/m*100+.05)*10)/10
	end
end

tags.Events['karma:hp'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
tags.Methods['karma:hp']  = function(u) 
  	if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
		return _TAGS["karma:DDG"](u)
	else
		local per = _TAGS["karma:perhp"](u).."%" or 0
		local min, max = UnitHealth(u), UnitHealthMax(u)
		if u == "player" or u == "target" then
			if min~=max then 
				return "|cFFFFAAAA"..SVal(min)--.."|r/"..SVal(max).." | "..per
			else
				return SVal(max)--.." | "..per
			end
		else
			return per
		end
	end
end

tags.Events['karma:raidhp'] = 'UNIT_HEALTH'
tags.Methods['karma:raidhp']  = function(u) 
  if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
    return oUF.Tags['karma:DDG'](u)
  else
	local per = oUF.Tags['perhp'](u).."%" or 0
    return per
  end
end

tags.Events['karma:color'] = 'UNIT_REACTION UNIT_HEALTH UNIT_HAPPINESS'
tags.Methods['karma:color'] = function(u, r)
		local _, class = UnitClass(u)
	local reaction = UnitReaction(u, "player")
	
	if UnitIsDead(u) or UnitIsGhost(u) or not UnitIsConnected(u) then
		return "|cffA0A0A0"
	elseif (UnitIsTapped(u) and not UnitIsTappedByPlayer(u)) then
		return hex(oUF.colors.tapped)
	elseif (u == "pet") then
		return hex(oUF.colors.class[class])
	elseif (UnitIsPlayer(u)) then
		return hex(oUF.colors.class[class])
	elseif reaction then
		return hex(oUF.colors.reaction[reaction])
	else
		return hex(1, 1, 1)
	end
end

tags.Events["karma:afkdnd"] = 'PLAYER_FLAGS_CHANGED UNIT_POWER UNIT_MAXPOWER'
tags.Methods["karma:afkdnd"] = function(unit) 
	return UnitIsAFK(unit) and "|cffCFCFCF <afk>|r" or UnitIsDND(unit) and "|cffCFCFCF <dnd>|r" or ""
end

tags.Events['karma:DDG'] = 'UNIT_HEALTH'
tags.Methods['karma:DDG'] = function(u)
	if UnitIsDead(u) then
		return "|cffCFCFCF Dead|r"
	elseif UnitIsGhost(u) then
		return "|cffCFCFCF Ghost|r"
	elseif not UnitIsConnected(u) then
		return "|cffCFCFCF D/C|r"
	end
end

tags.Events['karma:power'] = 'UNIT_POWER UNIT_MAXPOWER'
tags.Methods['karma:power']  = function(u) 
	local min, max = UnitPower(u), UnitPowerMax(u)
	if min~=max then 
		return SVal(min).."/"..SVal(max)
	else
		return SVal(max)
	end
end

tags.Events['karma:pp'] = 'UNIT_POWER UNIT_MAXPOWER'
tags.Methods['karma:pp'] = function(u)
    if u == "player" or u == "target" and UnitLevel(u) < 0 then 
		local _, str = UnitPowerType(u)
		if str then
			return hex(oUF.colors.power[str] or {250/255,  75/255,  60/255})..SVal(UnitPower(u))
		end
	end
end


-- Level
tags.Events["karma:level"] = "UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED"
tags.Methods["karma:level"] = function(unit)
	
	local c = UnitClassification(unit)
	local l = UnitLevel(unit)
	local d = GetQuestDifficultyColor(l)
	
	local str = l
		
	if l <= 0 then l = "??" end
	
	if c == "worldboss" then
		str = string.format("|cff%02x%02x%02xBoss|r",250,20,0)
	elseif c == "eliterare" then
		str = string.format("|cff%02x%02x%02x%s|r|cff0080FFR|r+",d.r*255,d.g*255,d.b*255,l)
	elseif c == "elite" then
		str = string.format("|cff%02x%02x%02x%s|r+",d.r*255,d.g*255,d.b*255,l)
	elseif c == "rare" then
		str = string.format("|cff%02x%02x%02x%s|r|cff0080FFR|r",d.r*255,d.g*255,d.b*255,l)
	else
		if not UnitIsConnected(unit) then
			str = "??"
		else
			if UnitIsPlayer(unit) then
				str = string.format("|cff%02x%02x%02x%s",d.r*255,d.g*255,d.b*255,l)
			elseif UnitPlayerControlled(unit) then
				str = string.format("|cff%02x%02x%02x%s",d.r*255,d.g*255,d.b*255,l)
			else
				str = string.format("|cff%02x%02x%02x%s",d.r*255,d.g*255,d.b*255,l)
			end
		end		
	end
	
	return str
end

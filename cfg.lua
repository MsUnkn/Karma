  -----------------------------
  -- INIT
  -----------------------------

  local addon, ns = ...
  local cfg = CreateFrame("Frame")
  local mediaFolder = "Interface\\AddOns\\oUF_Karma\\media\\"	-- don't touch this ...

  -----------------------------
  -- CONFIG
  -----------------------------
  
  -- Units
  cfg.showtot = true -- show target of target frame
  cfg.showpet = true -- show pet frame
  cfg.showfocus = true -- show focus frame
  cfg.showfocustarget = true -- show focus target frame
  cfg.ShowPlayerName = false -- show player's name and level
  cfg.showBossFrame = true -- show boss frame
  
  -- Raid and Party
  cfg.ShowParty = false -- show party frames
  cfg.party_leader_icon = false -- Show Leader Icon
  cfg.ShowRaid = false -- show raid frames
  cfg.RaidShowSolo = false -- show raid frames even when solo

  -- Positioning 
  cfg.PlayerX = 0 -- Player frame's x-offset position from the relative point of the screen
  cfg.PlayerY = -180 -- Player frame's y-offset position from the relative point of the screen
  cfg.PlayerRelativePoint = "CENTER" -- Player frame's reference point of the screen used for X and Y offsets. Possible values are: "TOP"/"BOTTOM"/"LEFT"/"RIGHT"/"CENTER"/"TOPLEFT"/"ROPRIGHT"/"BOTTOMLEFT"/"BOTTOMRIGHT"
  cfg.TargetX = 280 -- Target frame's x-offset position from the relative point of the screen
  cfg.TargetY = -80 -- Target frame's y-offset position from the relative point of the screen
  cfg.TargetRelativePoint = "CENTER" -- Target frame's reference point of the screen used for X and Y offsets. Possible values are: "TOP"/"BOTTOM"/"LEFT"/"RIGHT"/"CENTER"/"TOPLEFT"/"ROPRIGHT"/"BOTTOMLEFT"/"BOTTOMRIGHT"
  cfg.TotX = 0 -- Target of target frame's x-offset position from the relative point of the screen
  cfg.TotY = 8 -- Target of target frame's y-offset position from the relative point of the screen
  cfg.TotRelativePoint = "TOPRIGHT" -- Target of target frame's reference point of the screen used for X and Y offsets. Possible values are: "TOP"/"BOTTOM"/"LEFT"/"RIGHT"/"CENTER"/"TOPLEFT"/"ROPRIGHT"/"BOTTOMLEFT"/"BOTTOMRIGHT"  cfg.PartyX = -290 -- Party Frames Horizontal Position
  cfg.FocusX = -300 -- Focus frame's x-offset position from the relative point of the screen
  cfg.FocusY = -300 -- Focus frame's y-offset position from the relative point of the screen
  cfg.FocusRelativePoint = "BOTTOM" -- Focus frame's reference point of the screen used for X and Y offsets. Possible values are: "TOP"/"BOTTOM"/"LEFT"/"RIGHT"/"CENTER"/"TOPLEFT"/"ROPRIGHT"/"BOTTOMLEFT"/"BOTTOMRIGHT"  cfg.PartyX = -290 -- Party Frames Horizontal Position
  cfg.PartyX = -290 -- Party Frames Horizontal Position
  cfg.PartyY = -60 -- Party Frames Vertical Position
  cfg.RaidX = -590 -- Party Frames Horizontal Position
  cfg.RaidY = -60 -- Party Frames Vertical Position
  cfg.BossX = -240 -- Boss Frames Horizontal Position
  cfg.BossY = -240 -- Boss Frames Vertical Position
  
  -- Auras
  cfg.showPlayerAuras = false -- use a custom player buffs/debuffs frame instead of Blizzard's default.
  cfg.showTargetBuffs = true -- show target buffs
  cfg.showTargetDebuffs = true -- show target debuffs
  cfg.showBossBuffs = true -- show target buffs
  cfg.showBossDebuffs = true -- show target debuffs
  cfg.debuffsOnlyShowPlayer = true -- only show your debuffs on target
  cfg.buffsOnlyShowPlayer = false -- only show your buffs

  -- Plugins
  cfg.enableDebuffHighlight = true -- enable *dispelable* debuff highlight for raid frames
  cfg.showRaidDebuffs = true -- enable important debuff icons to show on raid units
  cfg.showAuraWatch = true -- enable display of HoTs and important player buffs/debuffs on raid frames

  -- Misc
  cfg.showRunebar = true -- show DK's rune bar
  cfg.showHolybar = true -- show Paladin's HolyPower bar
  cfg.showEclipsebar = true -- show druid's Eclipse bar
  cfg.showShardbar = true -- show Warlock's SoulShard bar
  cfg.showTotemBar = true -- show Shaman Totem timer bar
  cfg.showVengeance = true -- show tank Vengeance bar
  cfg.showHarmonybar = true -- show Monk Harmony bar 
  cfg.showShadoworbsbar = true -- show Shadow Priest Shadow Orbs bar 
  cfg.RCheckIcon = true -- show raid check icon
  cfg.Castbars = true -- use built-in castbars
  cfg.ShowIncHeals = true -- Show incoming heals in player and raid frames
  cfg.showLFDIcons = true -- Show dungeon role icons in raid/party
  
  cfg.statusbar_texture = mediaFolder.."Statusbar"
  cfg.powerbar_texture = mediaFolder.."Minimalist"
  cfg.backdrop_texture = mediaFolder.."backdrop"
  cfg.highlight_texture = mediaFolder.."raidbg"
  cfg.debuffhighlight_texture = mediaFolder.."debuff_highlight"
  cfg.backdrop_edge_texture = mediaFolder.."backdrop_edge"
  cfg.debuffBorder = mediaFolder.."iconborder"
  cfg.spark = mediaFolder.."spark"
  cfg.font = mediaFolder.."ROADWAY.ttf"
  cfg.smallfont = mediaFolder.."Emblem.ttf"
  cfg.raidScale = 1 -- scale factor for raid and party frames
  cfg.scale = 1 -- scale factor for all other frames
  
  -----------------------------
  -- HANDOVER
  -----------------------------
  
  ns.cfg = cfg

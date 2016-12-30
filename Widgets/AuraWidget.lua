local ADDON_NAME, NAMESPACE = ...
local ADDON_NAME, NAMESPACE = ...
ThreatPlates = NAMESPACE.ThreatPlates

---------------------------------------------------------------------------------------------------
-- Imported functions and constants
---------------------------------------------------------------------------------------------------
local RGB = ThreatPlates.RGB
local DEBUG = ThreatPlates.DEBUG

---------------------------------------------------------------------------------------------------
-- Aura Widget 2.0
---------------------------------------------------------------------------------------------------

local WidgetList = {}

local AuraMonitor = CreateFrame("Frame")
local isAuraEnabled = false

local UpdateWidget
local UnitAuraList = {}

local CONFIG_LAST_UPDATE
local CONFIG_WIDE_ICONS = false
local CONFIG_MODE_BAR = false
local CONFIG_GRID_NO_ROWS = 3
local CONFIG_GRID_NO_COLS = 3
local CONFIG_GRID_SPACING_ROWS = 5
local CONFIG_GRID_SPACING_COLS = 8
local CONFIG_LABEL_LENGTH = 0
local CONFIG_AURA_LIMIT = CONFIG_GRID_NO_ROWS * CONFIG_GRID_NO_COLS
local Filter_ByAuraList

local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE_BUFF = 1
local AURA_TYPE_DEBUFF = 6

-- Get a clean version of the function...  Avoid OmniCC interference
local CooldownNative = CreateFrame("Cooldown", nil, WorldFrame)
local SetCooldown = CooldownNative.SetCooldown

local font_frame = CreateFrame("Frame", nil, WorldFrame)

local WideArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameWide"
local SquareArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameSquare"
local WideHighlightArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameHighlightWide"
local SquareHighlightArt = "Interface\\AddOns\\TidyPlates_ThreatPlates\\Widgets\\AuraWidget\\AuraFrameHighlightSquare"
local AuraFont = "FONTS\\ARIALN.TTF"

local AuraType_Index = {
	["Buff"] = 1,
	["Curse"] = 2,
	["Disease"] = 3,
	["Magic"] = 4,
	["Poison"] = 5,
	["Debuff"] = 6,
}

---------------------------------------------------------------------------------------------------
-- PolledHideIn() - Registers a callback, which polls the frame until it expires, then hides the frame and removes the callback
---------------------------------------------------------------------------------------------------

local Watcherframe = CreateFrame("Frame")
local WatcherframeActive = false

local Framelist = {}			-- Key = Frame, Value = Expiration Time
local updateInterval = .5
local PolledHideIn
local timeToUpdate = 0

local function CheckFramelist(self)
	local curTime = GetTime()
	if curTime < timeToUpdate then return end

	local framecount = 0
	timeToUpdate = curTime + updateInterval

	-- Cycle through the watchlist, hiding frames which are timed-out
	for frame, expiration in pairs(Framelist) do
    -- frame here is a single aura frame, not the aura widget frame
		-- If expired...
		if expiration < curTime and frame.AuraInfo.Duration > 0 then
      DEBUG ("Expire Aura: ", frame:GetParent().unitid, frame.AuraInfo.Name)
			if frame.Expire and frame:GetParent():IsShown() then
        frame:Expire()
      end

			frame:Hide()
			Framelist[frame] = nil
		else
      -- If still shown ... update the frame
			if frame.Poll and frame:GetParent():IsShown() then
        frame:Poll(expiration)
      end
      framecount = framecount + 1
    end
	end

	-- If no more frames to watch, unregister the OnUpdate script
	if framecount == 0 then
    Watcherframe:SetScript("OnUpdate", nil)
    WatcherframeActive = false
  end
end

local function PolledHideIn(frame, expiration)

	--frame.AuraInfo.Duration == 0
	if not expiration then
		frame:Hide()
		Framelist[frame] = nil
	else
		Framelist[frame] = expiration
		frame:Show()

    if not WatcherframeActive then
			Watcherframe:SetScript("OnUpdate", CheckFramelist)
			WatcherframeActive = true
		end
	end
end

---------------------------------------------------------------------------------------------------
-- Threat Plates functions
---------------------------------------------------------------------------------------------------

-- hides/destroys all widgets of this type created by Threat Plates
-- local function ClearAllWidgets()
	-- for _, widget in pairs(WidgetList) do
	-- 	widget:Hide()
	-- end
	-- WidgetList = {}
-- end
-- ThreatPlatesWidgets.ClearAllAuraWidgets = ClearAllWidgets

---------------------------------------------------------------------------------------------------
-- Filtering and sorting functions
---------------------------------------------------------------------------------------------------

-- Information from Widget:
-- aura.spellid, aura.name, aura.expiration, aura.stacks,
-- aura.caster, aura.duration, aura.texture,
-- aura.type, aura.reaction
-- return value: show, priority, r, g, b (color for ?)

-- Debuffs are color coded, with poison debuffs having a green border, magic debuffs a blue border, diseases a brown border,
-- urses a purple border, and physical debuffs a red border
local AURA_TYPE = { Buff = 1, Curse = 2, Disease = 3, Magic = 4, Poison = 5, Debuff = 6, }

local AURA_TYPE_COLORS = {
		Curse = RGB(255, 0, 255),
		Disease = RGB(128, 51, 0),
		Magic = RGB(0, 102, 255),
		Poison = RGB(0, 255, 0),
	}

local function GetColorForAura(aura)
	local db = TidyPlatesThreat.db.profile.AuraWidget

	local color
	if aura.effect == "HARMFUL" then
		color = db.DefaultDebuffColor
	else
		color = db.DefaultBuffColor
	end

	if db.ShowAuraType then
		color = AURA_TYPE_COLORS[aura.type] or color
	end

	return color
end

local function AuraFilterFunction(aura)
	local db = TidyPlatesThreat.db.profile.AuraWidget
	local isType, isShown

	if aura.reaction == AURA_TARGET_HOSTILE and db.ShowEnemy then
		isShown = true
	elseif aura.reaction == AURA_TARGET_FRIENDLY and db.ShowFriendly then
		isShown = true
	end

	if aura.effect == "HELPFUL" and db.FilterByType[AURA_TYPE.Buff] then
		isType = true
	elseif aura.effect == "HARMFUL" and db.FilterByType[AURA_TYPE.Debuff] then
		-- only show aura types configured in the options
		if aura.type then
			isType = db.FilterByType[AURA_TYPE[aura.type]]
		else
			isType = true
		end
	end

	local show_aura = false
	if isShown and isType then
		local mode = db.FilterMode
		local spellfound = Filter_ByAuraList[aura.name] or Filter_ByAuraList[aura.spellid]
		if spellfound then spellfound = true end
		local isMine = (aura.caster == "player") or (aura.caster == "pet")

		if mode == "whitelist" then
			show_aura = spellfound
		elseif mode == "whitelistMine" then
			if isMine then
				show_aura = spellfound
			end
		elseif mode == "all" then
			show_aura = true
		elseif mode == "allMine" then
			if isMine then
				show_aura = true
			end
		elseif mode == "blacklist" then
			show_aura = not spellfound
		elseif mode == "blacklistMine" then
			if isMine then
				show_aura = not spellfound
			end
		end
	end

	local color = GetColorForAura(aura)

	local priority = aura.expiration - aura.duration

	if db.SortOrder == "AtoZ" then
		priority = aura.name
	elseif db.SortOrder == "TimeLeft" then
	  priority = aura.expiration - GetTime()
	elseif db.SortOrder == "Duration" then
 		priority = aura.duration
	end

 	return show_aura, priority, color
end

local function PrepareFilter()
	local filter = TidyPlatesThreat.db.profile.AuraWidget.FilterBySpell
	Filter_ByAuraList = {}

	for key, value in pairs(filter) do
		-- remove comments and whitespaces from the filter (string)
		local pos = value:find("%-%-")
		if pos then value = value:sub(1, pos - 1) end
		value = value:match("^%s*(.-)%s*$")

		-- separete filter by name and ID for more efficient aura filtering
		local value_no = tonumber(value)
		if value_no then
			Filter_ByAuraList[value_no] = true
		elseif value ~= '' then
			Filter_ByAuraList[value] = true
		end
	end
end

local function AuraSortFunctionNum(a, b)
  local sort_order = TidyPlatesThreat.db.profile.AuraWidget.SortReverse

  -- handling invalid entries in the aura array (necessary to avoid memory extensive array creation)
  if not a.priority then
    return sort_order
  elseif not b.priority then
    return not sort_order
  end

  if sort_order then
    if a.duration == 0 then
      return true
    elseif b.duration == 0 then
      return false
    else
      return a.priority > b.priority
    end
  else
    if a.duration == 0 then
      return false
    elseif b.duration == 0 then
      return true
    else
      return a.priority < b.priority
    end
  end
end

local function AuraSortFunctionAtoZ(a, b)
  local db = TidyPlatesThreat.db.profile.AuraWidget

  if db.SortReverse then
    return a.priority > b.priority
  else
    return a.priority < b.priority
  end
end

-------------------------------------------------------------
-- Widget Object Functions
-------------------------------------------------------------

local function UpdateWidgetTimeIcon(frame, expiration)
	if expiration == 0 then
		frame.TimeLeft:SetText("")
	else
		local timeleft = expiration - GetTime()

		if timeleft > 60 then
			frame.TimeLeft:SetText(floor(timeleft/60).."m")
		else
			frame.TimeLeft:SetText(floor(timeleft))
			--frame.TimeLeft:SetText(floor(timeleft*10)/10)
		end
	end
end

local function UpdateWidgetTimeBar(frame, expiration)
	if frame.AuraInfo.Duration == 0 then
		frame.TimeText:SetText("")
		frame.Statusbar:SetValue(100)
	elseif expiration == 0 then
		frame.TimeText:SetText("")
		frame.Statusbar:SetValue(0)
	else
		local timeleft = expiration - GetTime()

		if timeleft > 60 then
			frame.TimeText:SetText(floor(timeleft/60).."m")
		else
			frame.TimeText:SetText(floor(timeleft))
		end
		frame.Statusbar:SetValue(timeleft * 100 / frame.AuraInfo.Duration)
	end
end

local function UpdateWidgetTime(frame, expiration)
	if CONFIG_MODE_BAR then
		UpdateWidgetTimeBar(frame, expiration)
	else
		UpdateWidgetTimeIcon(frame, expiration)
	end
end

local function UpdateAuraFrame(frame, texture, duration, expiration, stacks, color)
	if frame and texture and expiration then
		local db = TidyPlatesThreat.db.profile.AuraWidget.ModeBar

		-- Expiration
		UpdateWidgetTime(frame, expiration)

    if TidyPlatesThreat.db.profile.AuraWidget.ShowStackCount and stacks and stacks > 1 then
      frame.Stacks:SetText(stacks)
    else
      frame.Stacks:SetText("")
    end

		if CONFIG_MODE_BAR then
--      frame.Statusbar:SetWidth(db.BarWidth)

			-- Icon
			if db.ShowIcon then
				frame.Icon:SetTexture(texture)
			end

			frame.LabelText:SetWidth(CONFIG_LABEL_LENGTH - frame.TimeText:GetStringWidth())
      frame.LabelText:SetText(frame.AuraInfo.Name)
      --			if TidyPlatesThreat.db.profile.AuraWidget.ShowStackCount and stacks and stacks > 1 then
      --				frame.LabelText:SetText(frame.AuraInfo.Name .. " [" .. stacks .. "]")
      --			else
      --				frame.LabelText:SetText(frame.AuraInfo.Name)
      --			end

			-- Highlight Coloring
			frame.Statusbar:SetStatusBarColor(color.r, color.g, color.b, color.a or 1)
		else
			frame.Icon:SetTexture(texture)

			-- Highlight Coloring
			if TidyPlatesThreat.db.profile.AuraWidget.ShowAuraType then
				frame.BorderHighlight:SetVertexColor(color.r, color.g, color.b)
				frame.BorderHighlight:Show()
				frame.Border:Hide()
			else
				frame.BorderHighlight:Hide()
				frame.Border:Show()
			end

			-- [[ Cooldown
			if duration and duration > 0 and expiration and expiration > 0 then
				SetCooldown(frame.Cooldown, expiration-duration, duration+.25)
			end
			--]]
		end

		--frame:Show()
		PolledHideIn(frame, expiration)
	elseif frame then
		PolledHideIn(frame)
	end
end

local function UpdateIconGrid(frame, unitid)
  if not unitid then return end

  local unitReaction
  if UnitIsFriend("player", unitid) then
    unitReaction = AURA_TARGET_FRIENDLY
  else
    unitReaction = AURA_TARGET_HOSTILE
  end

  local aura_frames = frame.AuraFrames
  local aura_count = 1

  -- Cache displayable auras
  ------------------------------------------------------------------------------------------------------
  -- This block will go through the auras on the unit and make a list of those that should
  -- be displayed, listed by priority.
  local searchedDebuffs, searchedBuffs = false, false
  local auraFilter = "HARMFUL"

  local auraIndex = 0
  repeat
    auraIndex = auraIndex + 1
    -- Example: Gnaw , false, icon, 0 stacks, nil type, duration 1, expiration 8850.436, caster pet, false, false, 91800
    local name, _, icon, stacks, auraType, duration, expiration, caster, _, _, spellid = UnitAura(unitid, auraIndex, auraFilter)		-- UnitaAura

    -- Auras are evaluated by an external function
    -- Pre-filtering before the icon grid is populated
    if name then
      UnitAuraList[aura_count] = UnitAuraList[aura_count] or {}
      aura = UnitAuraList[aura_count]

      aura.name = name
      aura.texture = icon
      aura.stacks = stacks
      aura.type = auraType
      aura.effect = auraFilter
      aura.duration = duration
      aura.reaction = unitReaction
      aura.expiration = expiration
      aura.caster = caster
      aura.spellid = spellid
      aura.unit = unitid 		-- unitid of the plate
      aura.priority = nil

      local show, priority, color = AuraFilterFunction(aura)
      -- Store Order/Priority
      if show then
        aura.priority = priority or 10
        aura.color = color

        aura_count = aura_count + 1
        --storedAuras[storedAuraCount] = aura
      end
    else
      if auraFilter == "HARMFUL" then
        searchedDebuffs = true
        auraFilter = "HELPFUL"
        auraIndex = 0
      else
        searchedBuffs = true
      end
    end

  until (searchedDebuffs and searchedBuffs)
  aura_count = aura_count - 1

  -- invalidate all entries after storedAuraCount
  for i = aura_count + 1, #UnitAuraList do
    UnitAuraList[i].priority = nil
  end

  -- Display Auras
  ------------------------------------------------------------------------------------------------------
  local max_auras_no = min(aura_count, CONFIG_AURA_LIMIT)

  if aura_count > 0 then
    if TidyPlatesThreat.db.profile.AuraWidget.SortOrder == "AtoZ" then
      sort(UnitAuraList, AuraSortFunctionAtoZ)
    else
      sort(UnitAuraList, AuraSortFunctionNum)
    end

    -- UpdateAuraFrameGrid(aura_frames, max_auras_no, UnitAuraList)
    for index = 1, max_auras_no do
      local aura = UnitAuraList[index]

      if aura.spellid and aura.expiration then
        local aura_frame = aura_frames[index]

        aura_frame.AuraInfo.Duration = aura.duration
        aura_frame.AuraInfo.Name = aura.name

        -- Call function to display the aura
        UpdateAuraFrame(aura_frame, aura.texture, aura.duration, aura.expiration, aura.stacks, aura.color)
      end
    end

  end

  -- Clear Extra Slots
  for index = max_auras_no + 1, CONFIG_AURA_LIMIT do UpdateAuraFrame(aura_frames[index]) end
end

-- (Re)Draw grid with aura frames
local function UpdateAuraFrameGrid(frame, aura_no, aura_list)
  local aura_frames = frame.AuraFrames

--  for index = 1, aura_no do
--    local aura = UnitAuraList[index]
--
--    if aura.spellid and aura.expiration then
--      local aura_frame = aura_frames[index]
--
--      aura_frame.AuraInfo.Duration = aura.duration
--      aura_frame.AuraInfo.Name = aura.name

  for index = 1, CONFIG_AURA_LIMIT do
    local aura_frame = aura_frames[index]
    if aura_frame:IsShown() then
    -- Call function to display the aura
      UpdateAuraFrame(aura_frame, aura.texture, aura.duration, aura.expiration, aura.stacks, aura.color)
    else
      break
    end
  end

--  -- Clear Extra Slots
--    UpdateAuraFrame(aura_frames[index])
--  for index = aura_no + 1, CONFIG_AURA_LIMIT do
--  end
end

local function ExpireFunction(icon)
	-- local frame = icon.Parent
	UpdateWidget(icon:GetParent())
end

-------------------------------------------------------------
-- Watcher for auras on units (gaining and losing buffs/debuffs)
-------------------------------------------------------------

local function EventUnitAura(unitid)
  --DEBUG ("UNIT_AURA: ", unitid)

  if unitid then
    -- WidgetList contains the units that are tracked, i.e. for which currently nameplates are shown
    local frame = WidgetList[unitid]

    if frame then
      UpdateWidget(frame)
    end
  end
end

local AuraEvents = {
  --["UNIT_TARGET"] = EventUnitTarget,
  ["UNIT_AURA"] = EventUnitAura,
}

local function AuraEventHandler(frame, event, ...)
  local unitid = ...

  if event then
    local eventFunction = AuraEvents[event]
    eventFunction(...)
  end
end

local function Enable()
	AuraMonitor:SetScript("OnEvent", AuraEventHandler)

	for event in pairs(AuraEvents) do
		AuraMonitor:RegisterEvent(event)
	end
end

local function Disable()
	AuraMonitor:SetScript("OnEvent", nil)
	AuraMonitor:UnregisterAllEvents()

--	for unitid, widget in pairs(WidgetList) do
--		if frame == widget then WidgetList[unitid] = nil end
--	end
end

local function enabled()
	local active = (not TidyPlatesThreat.db.profile.debuffWidget.ON) and TidyPlatesThreat.db.profile.AuraWidget.ON

	if active then
		if not isAuraEnabled then
			Enable()
			isAuraEnabled = true
		end
	else
		if isAuraEnabled then
			Disable()
			isAuraEnabled = false
		end
	end

	return active
end

---------------------------------------------------------------------------------------------------
-- Functions for icon and bar mode
---------------------------------------------------------------------------------------------------

local function TransformWideAura(frame)
	frame:SetSize(26.5, 14.5)
	-- Icon
	frame.Icon:SetAllPoints(frame)
	frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
  frame.Border:SetPoint("CENTER", 1, -2)
  frame.Border:SetSize(32, 32)
	frame.Border:SetTexture(WideArt)
	-- Highlight
	--frame.BorderHighlight:SetAllPoints(frame.Border) -- Border is off when switching between bar and icon mode, if this statement is used
  frame.BorderHighlight:SetPoint("CENTER", 1, -2)
  frame.BorderHighlight:SetSize(32, 32)
	frame.BorderHighlight:SetTexture(WideHighlightArt)
end

local function TransformSquareAura(frame)
	frame:SetSize(16.5, 14.5)
	-- Icon
	frame.Icon:SetAllPoints(frame)
	frame.Icon:SetTexCoord(.10, 1-.07, .12, 1-.12)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
  frame.Border:SetPoint("CENTER", 0, -2)
  frame.Border:SetSize(32, 32)
	frame.Border:SetTexture(SquareArt)
	-- Highlight
	--frame.BorderHighlight:SetAllPoints(frame.Border) -- Border is off when switching between bar and icon mode, if this statement is used
  frame.BorderHighlight:SetPoint("CENTER", 0, -2)
  frame.BorderHighlight:SetSize(32, 32)
	frame.BorderHighlight:SetTexture(SquareHighlightArt)
end

local function CreateAuraFrame(parent)
	local db = TidyPlatesThreat.db.profile.AuraWidget.ModeBar

	local frame = CreateFrame("Frame", nil, parent)

	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")

	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.BorderHighlight = frame:CreateTexture(nil, "ARTWORK")

	frame.Cooldown = CreateFrame("Cooldown", nil, frame, "TidyPlatesAuraWidgetCooldown")
	frame.Cooldown:SetAllPoints(frame.Icon)
	frame.Cooldown:SetReverse(true)
	frame.Cooldown:SetHideCountdownNumbers(true)

  --  Time Text
  frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
  frame.TimeLeft:SetFont(AuraFont ,9, "OUTLINE")
  frame.TimeLeft:SetShadowOffset(1, -1)
  frame.TimeLeft:SetShadowColor(0,0,0,1)
  frame.TimeLeft:SetPoint("RIGHT", 0, 8)
  frame.TimeLeft:SetSize(26, 16)
  frame.TimeLeft:SetJustifyH("RIGHT")

  --  Stacks
  frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
--  frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
--  frame.Stacks:SetShadowOffset(1, -1)
--  frame.Stacks:SetShadowColor(0,0,0,1)
--  frame.Stacks:SetPoint("RIGHT", 0, -6)
--  frame.Stacks:SetSize(26, 16)
--  frame.Stacks:SetJustifyH("RIGHT")

  frame.Statusbar = CreateFrame("StatusBar", nil, frame)
	frame.Statusbar:SetMinMaxValues(0, 100)

	frame.Background = frame.Statusbar:CreateTexture(nil, "BACKGROUND")
	frame.Background:SetAllPoints()

	frame.LabelText = frame.Statusbar:CreateFontString(nil, "OVERLAY")
	frame.LabelText:SetFont(ThreatPlates.Media:Fetch('font', db.Font), db.FontSize)
	frame.LabelText:SetJustifyH("LEFT")
	frame.LabelText:SetShadowOffset(1, -1)
	frame.LabelText:SetMaxLines(1)

	frame.TimeText = frame.Statusbar:CreateFontString(nil, "OVERLAY")
	frame.TimeText:SetFont(ThreatPlates.Media:Fetch('font', db.Font), db.FontSize)
	frame.TimeText:SetJustifyH("RIGHT")
	frame.TimeText:SetShadowOffset(1, -1)

	frame.Expire = ExpireFunction
	frame.Poll = UpdateWidgetTime
	frame:Hide()

	return frame
end

local function UpdateAuraLayout(frame)
	-- local backdrop = {
	-- 	-- path to the background texture
	-- 	bgFile = ThreatPlates.Media:Fetch('statusbar', db.BackgroundTexture),
	-- 	-- path to the border texture
	-- 	edgeFile = ThreatPlates.Media:Fetch('border', db.BackgroundBorder),
	-- 	-- true to repeat the background texture to fill the frame, false to scale it
	-- 	tile = false,
	-- 	-- size (width or height) of the square repeating background tiles (in pixels)
	-- 	tileSize = db.BackgroundBorderEdgeSize,
	-- 	-- thickness of edge segments and square size of edge corners (in pixels)
	-- 	edgeSize = db.BackgroundBorderEdgeSize,
	-- 	-- distance from the edges of the frame to those of the background texture (in pixels)
	-- 	insets = { left = db.BackgroundBorderInset, right = db.BackgroundBorderInset, top = db.BackgroundBorderInset, bottom = db.BackgroundBorderInset }
	-- }
	-- bar.Border = CreateFrame("Frame", nil, bar)
	-- --bar.Border:SetPoint("TOPLEFT", bar, "TOPLEFT", -2, 2)
	-- --bar.Border:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 2, -2)
	-- bar.Border:SetAllPoints(true)
	-- bar.Border:SetBackdrop(backdrop)
	-- bar.Border:SetFrameLevel(bar:GetFrameLevel())
	-- --bar:SetBackdropColor(db.BackgroundColor.r, db.BackgroundColor.g, db.BackgroundColor.b, db.BackgroundColor.a)
	-- bar:SetBackdropColor(1, 1, 1, 0)
	-- bar:SetBackdropBorderColor(db.BackgroundBorderColor.r, db.BackgroundBorderColor.g, db.BackgroundBorderColor.b, db.BackgroundBorderColor.a)
	-- --bar:SetBackdrop(backdrop)

	if CONFIG_MODE_BAR then
    local db = TidyPlatesThreat.db.profile.AuraWidget.ModeBar

    -- width and position calculations
    local frame_width = db.BarWidth
    if db.ShowIcon then
      frame_width = frame_width + db.BarHeight + db.IconSpacing
    end
    frame:SetSize(frame_width, db.BarHeight)

		frame.Background:SetTexture(ThreatPlates.Media:Fetch('statusbar', db.BackgroundTexture))
		frame.Background:SetVertexColor(db.BackgroundColor.r, db.BackgroundColor.g, db.BackgroundColor.b, db.BackgroundColor.a)

		frame.LabelText:SetPoint("LEFT", frame.Statusbar, "LEFT", db.LabelTextIndent, 0)
		frame.LabelText:SetFont(ThreatPlates.Media:Fetch('font', db.Font), db.FontSize)
		frame.LabelText:SetTextColor(db.FontColor.r, db.FontColor.g, db.FontColor.b)

		frame.TimeText:SetPoint("RIGHT", frame.Statusbar, "RIGHT", - db.TimeTextIndent, 0)
		frame.TimeText:SetFont(ThreatPlates.Media:Fetch('font', db.Font), db.FontSize)
		frame.TimeText:SetTextColor(db.FontColor.r, db.FontColor.g, db.FontColor.b)

    frame.Icon:ClearAllPoints()
    frame.Statusbar:ClearAllPoints()
		if db.ShowIcon then
			--frame.Statusbar:ClearAllPoints()
			if db.IconAlignmentLeft then
				frame.Icon:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
				frame.Statusbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", db.BarHeight + db.IconSpacing, 0)
			else
        frame.Icon:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", db.BarWidth + db.IconSpacing, 0)
        frame.Statusbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
			end
      frame.Stacks:SetAllPoints(frame.Icon)
      frame.Stacks:SetSize(db.BarHeight, db.BarHeight)
      frame.Stacks:SetJustifyH("CENTER")
      frame.Stacks:SetFont(ThreatPlates.Media:Fetch('font', db.Font), db.FontSize, "OUTLINE")
      frame.Stacks:SetShadowOffset(1, -1)
      frame.Stacks:SetShadowColor(0,0,0,1)
      frame.Stacks:SetTextColor(db.FontColor.r, db.FontColor.g, db.FontColor.b)
		else
--      frame.Icon:SetAllPoints(frame)
			frame.Statusbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
		end

    frame.Statusbar:SetSize(db.BarWidth, db.BarHeight)
--    frame.Statusbar:SetWidth(db.BarWidth)
    frame.Statusbar:SetStatusBarTexture(ThreatPlates.Media:Fetch('statusbar', db.Texture))
    frame.Statusbar:GetStatusBarTexture():SetHorizTile(false)
    frame.Statusbar:GetStatusBarTexture():SetVertTile(false)
    frame.Icon:SetTexCoord(0, 1, 0, 1)
    frame.Icon:SetSize(db.BarHeight, db.BarHeight)

    frame.Statusbar:Show()
		if db.ShowIcon then
			frame.Icon:Show()
		else
			frame.Icon:Hide()
		end

		frame.Border:Hide()
		frame.BorderHighlight:Hide()
		frame.Cooldown:Hide()
		frame.TimeLeft:Hide()
	else
    local db = TidyPlatesThreat.db.profile.AuraWidget.ModeIcon

		if CONFIG_WIDE_ICONS then TransformWideAura(frame) else TransformSquareAura(frame) end

    frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
    frame.Stacks:SetShadowOffset(1, -1)
    frame.Stacks:SetShadowColor(0,0,0,1)
    frame.Stacks:ClearAllPoints()
    frame.Stacks:SetPoint("RIGHT", 0, -6)
    frame.Stacks:SetSize(26, 16)
    frame.Stacks:SetJustifyH("RIGHT")

    if TidyPlatesThreat.db.profile.AuraWidget.ShowCooldownSpiral then
			frame.Cooldown:SetDrawEdge(true)
			frame.Cooldown:SetDrawEdge(true)
		else
			frame.Cooldown:SetDrawEdge(false)
			frame.Cooldown:SetDrawSwipe(false)
		end

		frame.Statusbar:Hide()
		-- frame.Background:Hide()
		-- frame.LabelText:Hide()
		-- frame.LabelTime:Hide()

		frame.Icon:Show()
		frame.Border:Show()
		frame.BorderHighlight:Show()
		frame.TimeLeft:Show()
	end
end

---------------------------------------------------------------------------------------------------
-- Creation and update functions
---------------------------------------------------------------------------------------------------

local function UpdateWidgetConfig(widget_frame)
	widget_frame.last_update = GetTime()

  local db = TidyPlatesThreat.db.profile.AuraWidget.ModeBar

  local frame_width = 0
  if db.Enabled then
    frame_width = db.BarWidth
    if db.ShowIcon then
      frame_width = frame_width + db.BarHeight + db.IconSpacing
    end
  else
    frame_width = 16.5
    if CONFIG_WIDE_ICONS then frame_width = 26.5 end
    frame_width = frame_width * CONFIG_GRID_NO_COLS + (CONFIG_GRID_SPACING_COLS - 1) * CONFIG_GRID_NO_COLS
  end

	local aura_frame_list = widget_frame.AuraFrames
	for index = 1, CONFIG_AURA_LIMIT do
		local frame = aura_frame_list[index] or CreateAuraFrame(widget_frame)
		aura_frame_list[index] = frame

		-- anchor the frame
		frame:ClearAllPoints()
		if index == 1 then
			frame:SetPoint("LEFT", widget_frame, (widget_frame:GetWidth() - frame_width) / 2, 0)
		elseif ((index - 1) % CONFIG_GRID_NO_COLS) == 0 then
			frame:SetPoint("BOTTOMLEFT", aura_frame_list[index - CONFIG_GRID_NO_COLS], "TOPLEFT", 0, CONFIG_GRID_SPACING_ROWS)
		else
			frame:SetPoint("LEFT", aura_frame_list[index - 1], "RIGHT", CONFIG_GRID_SPACING_COLS, 0)
		end

    UpdateAuraLayout(frame)
	end

	-- if MaxBars was decreased, remove any overflow aura frames
	for index = CONFIG_AURA_LIMIT + 1, #aura_frame_list do
		local frame = aura_frame_list[index]
		aura_frame_list[index] = nil
		PolledHideIn(frame)
  end

  --UpdateAuraFrameGrid(widget_frame)
  --UpdateWidget(widget_frame)
  UpdateIconGrid(widget_frame, widget_frame.unitid)

  db = TidyPlatesThreat.db.profile.AuraWidget
  widget_frame:ClearAllPoints()
  if db.ModeBar.Enabled then
    widget_frame:SetPoint("CENTER", widget_frame:GetParent(), 0, db.y)
  else
    widget_frame:SetPoint("CENTER", widget_frame:GetParent(), db.anchor, db.x, db.y)
  end
  widget_frame:SetScale(db.scale)
end

function UpdateWidget(frame)
	if CONFIG_LAST_UPDATE > frame.last_update then
		--ThreatPlates.DEBUG_PRINT_TABLE(frame)
		ThreatPlates.DEBUG("Update Delay: ", frame.unit.name, frame.unitid)
    --ThreatPlates.DEBUG_PRINT_TABLE(frame.unit)
		UpdateWidgetConfig(frame)
	end

	UpdateIconGrid(frame, frame.unitid)
	--	if not frame.Background then
	--		frame.Background = frame:CreateTexture(nil, "BACKGROUND")
	--		frame.Background:SetAllPoints()
	--		frame.Background:SetTexture(ThreatPlates.Media:Fetch('statusbar', db.BackgroundTexture))
	--		frame.Background:SetVertexColor(0,0,0,1)
	--	end
end

-- Context Update (mouseover, target change)
local function UpdateWidgetContext(frame, unit)
	local unitid = unit.unitid
	frame.unit = unit
	frame.unitid = unitid

	-- Add to Widget List
	-- if guid then
	-- 	WidgetList[guid] = frame
	-- end

	if unitid then
    WidgetList[unitid] = frame
    --ThreatPlates.DEBUG_SIZE("#WidgetList: ", WidgetList)
	end

	-- Custom Code II
	--------------------------------------
  local db = TidyPlatesThreat.db.profile.AuraWidget
  if db.ShowTargetOnly and not unit.isTarget then
    frame:_Hide()
  else
--    frame:ClearAllPoints()
--      if db.ModeBar.Enabled then
--        frame:SetPoint("CENTER", frame:GetParent(), 0, db.y)
--      else
--        frame:SetPoint("CENTER", frame:GetParent(), db.anchor, db.x, db.y)
--      end
--    frame:SetScale(db.scale)

		--UpdateWidget(frame)
    --UpdateAuraFrameGrid(frame)
		frame:Show()
	end
	--------------------------------------
	-- End Custom Code
end

-- Load settings from the configuration which are shared across all aura widgets
-- used (for each widget) in UpdateWidgetConfig
local function ConfigAuraWidget()
	local db = TidyPlatesThreat.db.profile.AuraWidget

  CONFIG_WIDE_ICONS = (db.ModeIcon.Style == "wide")

	if db.ModeBar.Enabled then
		CONFIG_MODE_BAR = true
		CONFIG_GRID_NO_ROWS = db.ModeBar.MaxBars
		CONFIG_GRID_NO_COLS = 1
		CONFIG_GRID_SPACING_ROWS = db.ModeBar.BarSpacing
		CONFIG_GRID_SPACING_COLS = 0
		CONFIG_LABEL_LENGTH = db.ModeBar.BarWidth - db.ModeBar.LabelTextIndent - db.ModeBar.TimeTextIndent - (db.ModeBar.FontSize / 5)
	else
		CONFIG_MODE_BAR = false
		CONFIG_GRID_NO_ROWS = db.ModeIcon.Rows
		CONFIG_GRID_NO_COLS = db.ModeIcon.Columns
		CONFIG_GRID_SPACING_ROWS = db.ModeIcon.RowSpacing
		CONFIG_GRID_SPACING_COLS = db.ModeIcon.ColumnSpacing
	end
	CONFIG_AURA_LIMIT = CONFIG_GRID_NO_ROWS * CONFIG_GRID_NO_COLS

	CONFIG_LAST_UPDATE = GetTime()
end

local function ClearWidgetContext(frame)
--  for unitid, widget in pairs(WidgetList) do
--    if frame == widget then WidgetList[unitid] = nil end
--  end
  local unitid = frame.unitid
  if unitid then
    WidgetList[unitid] = nil
    frame.unitid = nil
  end
end

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(plate)
	-- Required Widget Code
	local frame = CreateFrame("Frame", nil, plate)
	--frame:Hide()
	frame:Show()

	-- Custom Code III
	--------------------------------------
	frame:SetSize(128, 32)
	frame:SetFrameLevel(plate:GetFrameLevel() + 1)
	frame.AuraFrames = {}
	frame.AuraInfos = {}
  UpdateWidgetConfig(frame)
	--------------------------------------
	-- End Custom Code

	-- Required Widget Code
  frame.Update = UpdateWidgetContext
  frame.UpdateContext = UpdateWidgetContext
	frame.UpdateConfig = UpdateWidgetConfig
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end

	return frame
end

-----------------------------------------------------
-- External
-----------------------------------------------------

ThreatPlatesWidgets.ConfigAuraWidget = ConfigAuraWidget
ThreatPlatesWidgets.PrepareFilterAuraWidget = PrepareFilter

-----------------------------------------------------
-- Register widget
-----------------------------------------------------

ThreatPlatesWidgets.RegisterWidget("AuraWidget2TPTP", CreateAuraWidget, false, enabled)

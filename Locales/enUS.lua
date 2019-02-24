﻿local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "enUS", true, true)
--local L = LibStub("AceLocale-3.0"):NewLocale("TidyPlatesThreat", "enUS", true, false)
if not L then return end

---------------------------------------------------------------------------------------------------
-- Strings which are created dynamically in the addon
---------------------------------------------------------------------------------------------------
L["Show Friendly Units"] = true
L["Players"] = true
L["NPCs"] = true
L["Totems"] = true
L["Guardians"] = true
L["Pets"] = true

L["Show Enemy Units"] = true
L["Minuss"] = "Minors"

L["Show Neutral Units"] = true

---------------------------------------------------------------------------------------------------
-- String constants in the game
---------------------------------------------------------------------------------------------------
L["  <no option>        Displays options dialog"] = true
L["  help               Prints this help message"] = true
L["  update-profiles    Migrates deprecated settings in your configuration"] = true
L[" The change will be applied after you leave combat."] = true
L[" options by typing: /tptp"] = true
L[" to DPS."] = true
L[" to tanking."] = true
L["-->>Nameplate Overlapping is now |cff00ff00ON!|r<<--"] = true
L["-->>Nameplate Overlapping is now |cffff0000OFF!|r<<--"] = true
L["-->>Threat Plates verbose is now |cff00ff00ON!|r<<--"] = true
L["-->>Threat Plates verbose is now |cffff0000OFF!|r<<-- shhh!!"] = true
L["-->>|cff00ff00Tank Plates Enabled|r<<--"] = true
L["-->>|cffff0000DPS Plates Enabled|r<<--"] = true
L["A to Z"] = true
L["About"] = true
L["Absolut Transparency"] = true
L["Absorbs Text"] = true
L["Absorbs"] = true
L["Add black outline."] = true
L["Add thick black outline."] = true
L["Additional Adjustments"] = true
L["Additionally color the healthbar based on the target mark if the unit is marked."] = true
L["Additionally color the name based on the target mark if the unit is marked."] = true
L["Additionally color the nameplate's healthbar or name based on the target mark if the unit is marked."] = true
L["All Auras"] = true
L["All on NPCs"] = true
L["All"] = true
L["Alpha multiplier of nameplates for occluded units."] = true
L["Alpha"] = true
L["Always show buffs with unlimited duration."] = true
L["Always shows the full amount of absorbs on a unit. In overabsorb situations, the absorbs bar ist shifted to the left."] = true
L["Always"] = true
L["Amount"] = true
L["Anchor Point"] = true
L["Anchor"] = true
L["Appearance"] = true
L["Arcane Mage"] = true
L["Arena 1"] = true
L["Arena 2"] = true
L["Arena 3"] = true
L["Arena 4"] = true
L["Arena 5"] = true
L["Arena Number"] = true
L["Arena Orb"] = true
L["Arena"] = true
L["Army of the Dead Ghoul"] = true
L["Art Options"] = true
L["Aura Icon"] = true
L["Auras"] = true
L["Auras, Healthbar"] = true
L["Automation"] = true
L["Background Color"] = true
L["Background Color:"] = true
L["Background Texture"] = true
L["Background Transparency"] = true
L["Background"] = true
L["Bar Border"] = true
L["Bar Height"] = true
L["Bar Limit"] = true
L["Bar Mode"] = true
L["Bar Width"] = true
L["Black List"] = true
L["Blizzard Settings"] = true
L["Blizzard"] = true
L["Bone Spike"] = true
L["Border Color:"] = true
L["Border"] = true
L["Boss Mods"] = true
L["Boss"] = true
L["Bosses"] = true
L["Bottom Inset"] = true
L["Bottom Left"] = true
L["Bottom Right"] = true
L["Bottom"] = true
L["Bottom-to-top"] = true
L["Buff Color"] = true
L["Buffs"] = true
L["By Class"] = true
L["By Custom Color"] = true
L["By Health"] = true
L["By Reaction"] = true
L["By default, the threat system works based on a mob's threat table. Some mobs do not have such a threat table even if you are in combat with them. The threat detection heuristic uses other factors to determine if you are in combat with a mob. This works well in instances. In the open world, this can show units in combat with you that are actually just in combat with another player (and not you)."] = true
L["Can Apply"] = true
L["Canal Crab"] = true
L["Castbar"] = true
L["Center Auras"] = true
L["Center"] = true
L["Change the color depending on the amount of health points the nameplate shows."] = true
L["Change the color depending on the reaction of the unit (friendly, hostile, neutral)."] = true
L["Change the scale of nameplates depending on whether a target unit is selected or not. As default, this scale is added to the unit base scale."] = true
L["Change the scale of nameplates in certain situations, overwriting all other settings."] = true
L["Change the transparency of nameplates depending on whether a target unit is selected or not. As default, this transparency is added to the unit base transparency."] = true
L["Change the transparency of nameplates for occluded units (e.g., units behind walls)."] = true
L["Change the transparency of nameplates in certain situations, overwriting all other settings."] = true
L["Changes the default settings to the selected design. Some of your custom settings may get overwritten if you switch back and forth.."] = true
L["Changing these options may interfere with other nameplate addons or Blizzard default nameplates as console variables (CVars) are changed."] = true
L["Changing these settings will alter the placement of the nameplates, however the mouseover area does not follow. |cffff0000Use with caution!|r"] = true
L["Class Icon"] = true
L["Clear and easy to use threat-reactive nameplates.\n\nCurrent version: "] = true
L["Clear"] = true
L["Clickable Area"] = true
L["Color By Class"] = true
L["Color Healthbar By Enemy Class"] = true
L["Color Healthbar By Friendly Class"] = true
L["Color Healthbar by Target Marks in Healthbar View"] = true
L["Color Name by Target Marks in Headline View"] = true
L["Color by Dispel Type"] = true
L["Color by Health"] = true
L["Color by Reaction"] = true
L["Color by Target Mark"] = true
L["Color"] = true
L["Coloring"] = true
L["Colors"] = true
L["Column Limit"] = true
L["Combat"] = true
L["Combo Points"] = true
L["Configuration Mode"] = true
L["Controls the rate at which nameplate animates into their target locations [0.0-1.0]."] = true
L["Cooldown Spiral"] = true
L["Copied!"] = true
L["Copy"] = true
L["Creation"] = true
L["Crowd Control"] = true
L["Curse"] = true
L["Custom Color"] = true
L["Custom Nameplates"] = true
L["Custom Scale"] = true
L["Custom Transparency"] = true
L["Custom"] = true
L["DPS/Healing"] = true
L["Darnavan"] = true
L["Death Knigh Rune Cooldown"] = true
L["Death Knight"] = true
L["Debuff Color"] = true
L["Debuffs"] = true
L["Default Settings (All Profiles)"] = true
L["Deficit"] = true
L["Define a custom color for this nameplate and overwrite any other color settings."] = true
L["Define a custom scaling for this nameplate and overwrite any other scaling settings."] = true
L["Define a custom transparency for this nameplate and overwrite any other transparency settings."] = true
L["Define base alpha settings for various unit types. Only one of these settings is applied to a unit at the same time, i.e., they are mutually exclusive."] = true
L["Define base scale settings for various unit types. Only one of these settings is applied to a unit at the same time, i.e., they are mutually exclusive."] = true
L["Defines the movement/collision model for nameplates."] = true
L["Deformed Fanatic"] = true
L["Determine your role (tank/dps/healing) automatically based on current spec."] = true
L["Disable threat scale for target marked, mouseover or casting units."] = true
L["Disable threat transparency for target marked, mouseover or casting units."] = true
L["Disables nameplates (healthbar and name) for the units of this type and only shows an icon (if enabled)."] = true
L["Disabling this will turn off all icons for custom nameplates without harming other custom settings per nameplate."] = true
L["Disconnected Units"] = true
L["Disease"] = true
L["Dispel Type"] = true
L["Dispellable"] = true
L["Display absorbs amount text."] = true
L["Display absorbs percentage text."] = true
L["Display health amount text."] = true
L["Display health percentage text."] = true
L["Display health text on units with full health."] = true
L["Distance"] = true
L["Do not sort auras."] = true
L["Drudge Ghoul"] = true
L["Druid"] = true
L["Duration"] = true
L["Ebon Gargoyle"] = true
L["Edge Size"] = true
L["Elite Border"] = true
L["Empowered Adherent"] = true
L["Enable Adjustments"] = true
L["Enable Arena Widget"] = true
L["Enable Auras Widget"] = true
L["Enable Boss Mods Widget"] = true
L["Enable Class Icon Widget"] = true
L["Enable Combo Points Widget"] = true
L["Enable Custom Color"] = true
L["Enable Enemy"] = true
L["Enable Friendly"] = true
L["Enable Friends"] = true
L["Enable Guild Members"] = true
L["Enable Headline View (Text-Only)"] = true
L["Enable Healer Tracker Widget"] = true
L["Enable Nameplates"] = true
L["Enable Quest Widget"] = true
L["Enable Resource Widget"] = true
L["Enable Social Widget"] = true
L["Enable Stealth Widget"] = true
L["Enable Target Highlight Widget"] = true
L["Enable Threat Coloring of Healthbar"] = true
L["Enable Threat Scale"] = true
L["Enable Threat System"] = true
L["Enable Threat Textures"] = true
L["Enable Threat Transparency"] = true
L["Enable nameplate clickthrough for enemy units."] = true
L["Enable nameplate clickthrough for friendly units."] = true
L["Enable this if you want to show Blizzards special resources above the target nameplate."] = true
L["Enable"] = true
L["Enemy Casting"] = true
L["Enemy Custom Text"] = true
L["Enemy NPCs"] = true
L["Enemy Name Color"] = true
L["Enemy Players"] = true
L["Enemy Status Text"] = true
L["Enemy Units"] = true
L["Everything"] = true
L["Faction Icon"] = true
L["Fading"] = true
L["Fanged Pit Viper"] = true
L["Filter by Spell"] = true
L["Filtered Auras"] = true
L["Five"] = true
L["Flash Time"] = true
L["Flash When Expiring"] = true
L["Font Size"] = true
L["Font"] = true
L["Force View By Status"] = true
L["Foreground Texture"] = true
L["Foreground"] = true
L["Format"] = true
L["Four"] = true
L["Frame Order"] = true
L["Friendly & Neutral Units"] = true
L["Friendly Caching"] = true
L["Friendly Casting"] = true
L["Friendly Custom Text"] = true
L["Friendly NPCs"] = true
L["Friendly Name Color"] = true
L["Friendly Names Color"] = true
L["Friendly Players"] = true
L["Friendly Status Text"] = true
L["Friendly Units in Combat"] = true
L["Friendly Units"] = true
L["Friends & Guild Members"] = true
L["Full Absorbs"] = true
L["Full Health"] = true
L["Gas Cloud"] = true
L["General Colors"] = true
L["General Nameplate Settings"] = true
L["General Settings"] = true
L["General"] = true
L["Guardians"] = true
L["Headline View Out of Combat"] = true
L["Headline View X"] = true
L["Headline View Y"] = true
L["Headline View"] = true
L["Healer Tracker"] = true
L["Health Coloring"] = true
L["Health Text"] = true
L["Health"] = true
L["Healthbar Mode"] = true
L["Healthbar Sync"] = true
L["Healthbar View X"] = true
L["Healthbar View Y"] = true
L["Healthbar View"] = true
L["Healthbar"] = true
L["Healthbar, Auras"] = true
L["Height"] = true
L["Heuristic In Instances"] = true
L["Heuristic"] = true
L["Hide Buffs"] = true
L["Hide Friendly Nameplates"] = true
L["Hide Healthbars"] = true
L["Hide Name"] = true
L["Hide Nameplate"] = true
L["Hide Nameplates"] = true
L["Hide in Combat"] = true
L["Hide in Instance"] = true
L["Hide on Attacked Units"] = true
L["Hide the Blizzard default nameplates for friendly units in instances."] = true
L["High Threat"] = true
L["Highlight Mobs on Off-Tanks"] = true
L["Highlight Texture"] = true
L["Horizontal Align"] = true
L["Horizontal Alignment"] = true
L["Horizontal Offset"] = true
L["Horizontal Overlap"] = true
L["Horizontal Spacing"] = true
L["Hostile NPCs"] = true
L["Hostile Players"] = true
L["Hostile Units"] = true
L["Icon Height"] = true
L["Icon Mode"] = true
L["Icon Style"] = true
L["Icon Width"] = true
L["Icon"] = true
L["If checked, nameplates of mobs attacking another tank can be shown with different color, scale, and transparency."] = true
L["If checked, threat feedback from boss level mobs will be shown."] = true
L["If checked, threat feedback from elite and rare mobs will be shown."] = true
L["If checked, threat feedback from minor mobs will be shown."] = true
L["If checked, threat feedback from neutral mobs will be shown."] = true
L["If checked, threat feedback from normal mobs will be shown."] = true
L["If checked, threat feedback from tapped mobs will be shown regardless of unit type."] = true
L["If checked, threat feedback will only be shown in instances (dungeons, raids, arenas, battlegrounds), not in the open world."] = true
L["If enabled, the truncated health text will be localized, i.e. local metric unit symbols (like k for thousands) will be used."] = true
L["Ignore Marked Units"] = true
L["Ignore UI Scale"] = true
L["Immortal Guardian"] = true
L["In Combat"] = true
L["In Instances"] = true
L["In combat, always show all combo points no matter if they are on or off. Off combo points are shown greyed-out."] = true
L["In combat, use alpha based on threat level as configured in the threat system. The custom alpha is only used out of combat."] = true
L["In combat, use coloring based on threat level as configured in the threat system. The custom color is only used out of combat."] = true
L["In combat, use coloring, transparency, and scaling based on threat level as configured in the threat system. Custom settings are only used out of combat."] = true
L["In combat, use scaling based on threat level as configured in the threat system. The custom scale is only used out of combat."] = true
L["Insets"] = true
L["Inside"] = true
L["Instances"] = true
L["Interrupt Overlay"] = true
L["Interrupt Shield"] = true
L["Interruptable"] = true
L["Interrupted"] = true
L["Kinetic Bomb"] = true
L["Label Text Offset"] = true
L["Large Bottom Inset"] = true
L["Large Top Inset"] = true
L["Layout"] = true
L["Left"] = true
L["Left-to-right"] = true
L["Level Text"] = true
L["Level"] = true
L["Lich King"] = true
L["Living Ember"] = true
L["Living Inferno"] = true
L["Localization"] = true
L["Look and Feel"] = true
L["Low Threat"] = true
L["Magic"] = true
L["Marked Immortal Guardian"] = true
L["Max Alpha"] = true
L["Max Distance Behind Camera"] = true
L["Max Distance"] = true
L["Max Health"] = true
L["Medium Threat"] = true
L["Min Alpha"] = true
L["Mine"] = true
L["Minions & By Status"] = true
L["Minor"] = true
L["Mode"] = true
L["Mono"] = true
L["Motion & Overlap"] = true
L["Motion Speed"] = true
L["Mouseover"] = true
L["Movement Model"] = true
L["Muddy Crawfish"] = true
L["Mult for Occluded Units"] = true
L["NPC Role"] = true
L["NPC Role, Guild"] = true
L["NPC Role, Guild, or Level"] = true
L["Name"] = true
L["Nameplate Clickthrough"] = true
L["Nameplate Color"] = true
L["Nameplate Mode for Friendly Units in Combat"] = true
L["Nameplate Style"] = true
L["Nameplate clickthrough cannot be changed while in combat."] = true
L["Names"] = true
L["Neutral NPCs"] = true
L["Neutral Units & Minions"] = true
L["Neutral Units"] = true
L["No Outline, Monochrome"] = true
L["No Target"] = true
L["No target found."] = true
L["Non-Interruptable"] = true
L["Non-Target"] = true
L["None"] = true
L["Normal Units"] = true
L["Note"] = true
L["Nothing to paste!"] = true
L["Occluded Units"] = true
L["Off Combo Point"] = true
L["Off-Tank"] = true
L["Offset X"] = true
L["Offset Y"] = true
L["Offset"] = true
L["OmniCC"] = true
L["On & Off"] = true
L["On Bosses & Rares"] = true
L["On Combo Point"] = true
L["On Enemy Units You Cannot Attack"] = true
L["On Friendly Units in Combat"] = true
L["On Target"] = true
L["One"] = true
L["Only Alternate Power"] = true
L["Only in Instances"] = true
L["Onyxian Whelp"] = true
L["Open Blizzard Settings"] = true
L["Open Options"] = true
L["Orbs"] = true
L["Out of Combat"] = true
L["Outline"] = true
L["Outline, Monochrome"] = true
L["Overlapping"] = true
L["Paste"] = true
L["Pasted!"] = true
L["Percentage amount for horizontal overlap of nameplates."] = true
L["Percentage amount for vertical overlap of nameplates."] = true
L["Percentage"] = true
L["Personal Nameplate"] = true
L["Pets"] = true
L["Pixel-Perfect UI"] = true
L["Placement"] = true
L["Poison"] = true
L["Position"] = true
L["Preview Elite"] = true
L["Preview Rare"] = true
L["Preview"] = true
L["Quest Progress"] = true
L["Quest"] = true
L["Raging Spirit"] = true
L["Rares & Bosses"] = true
L["Rares & Elites"] = true
L["Reanimated Adherent"] = true
L["Reanimated Fanatic"] = true
L["Reduce the size of the Blizzard's default large nameplates in instances to 50%."] = true
L["Render font without antialiasing."] = true
L["Reset to Defaults"] = true
L["Reset"] = true
L["Resource Bar"] = true
L["Resource Text"] = true
L["Resource"] = true
L["Resources on Targets"] = true
L["Restore Defaults"] = true
L["Retribution Paladin"] = true
L["Reverse"] = true
L["Right"] = true
L["Right-to-left"] = true
L["Rogue"] = true
L["Row Limit"] = true
L["Same as Background"] = true
L["Same as Foreground"] = true
L["Same as Name"] = true
L["Scale"] = true
L["Set Icon"] = true
L["Set Name"] = true
L["Set scale settings for different threat levels."] = true
L["Set the roles your specs represent."] = true
L["Set threat textures and their coloring options here."] = true
L["Set transparency settings for different threat levels."] = true
L["Sets your spec "] = true
L["Shadow Fiend"] = true
L["Shadow"] = true
L["Shadowy Apparition"] = true
L["Shambling Horror"] = true
L["Shorten"] = true
L["Show Blizzard Nameplates for Friendly Units"] = true
L["Show Blizzard Nameplates for Neutral and Enemy Units"] = true
L["Show Buffs"] = true
L["Show By Unit Type"] = true
L["Show Crowd Control"] = true
L["Show Debuffs"] = true
L["Show For"] = true
L["Show Health Text"] = true
L["Show Icon for Rares & Elites"] = true
L["Show Icon to the Left"] = true
L["Show Level Text"] = true
L["Show Mouseover"] = true
L["Show Name Text"] = true
L["Show Nameplate"] = true
L["Show Number"] = true
L["Show Orb"] = true
L["Show Skull Icon"] = true
L["Show Target"] = true
L["Show a tooltip when hovering above an aura."] = true
L["Show all buffs on NPCs."] = true
L["Show all buffs on enemy units."] = true
L["Show all buffs on friendly units."] = true
L["Show all crowd control auras on enemy units."] = true
L["Show all crowd control auras on friendly units."] = true
L["Show all debuffs on enemy units."] = true
L["Show all debuffs on friendly units."] = true
L["Show all nameplates (CTRL-V)."] = true
L["Show an quest icon at the nameplate for quest mobs."] = true
L["Show auras as bars (with optional icons)."] = true
L["Show auras as icons in a grid configuration."] = true
L["Show auras in order created with oldest aura first."] = true
L["Show buffs that were applied by you."] = true
L["Show buffs that you can apply."] = true
L["Show buffs that you can dispell."] = true
L["Show crowd control auras hat are shown on Blizzard's default nameplates."] = true
L["Show crowd control auras that are shown on Blizzard's default nameplates."] = true
L["Show crowd control auras that where applied by bosses."] = true
L["Show crowd control auras that you can dispell."] = true
L["Show debuffs that are shown on Blizzard's default nameplates."] = true
L["Show debuffs that were applied by you."] = true
L["Show debuffs that where applied by bosses."] = true
L["Show debuffs that you can dispell."] = true
L["Show enemy nameplates (ALT-V)."] = true
L["Show friendly nameplates (SHIFT-V)."] = true
L["Show in Headline View"] = true
L["Show in Healthbar View"] = true
L["Show shadow with text."] = true
L["Show stack count on auras."] = true
L["Show the OmniCC cooldown count instead of the built-in duration text on auras."] = true
L["Show the amount you need to loot or kill"] = true
L["Show the mouseover highlight on all units."] = true
L["Show threat feedback based on unit type or status or environmental conditions."] = true
L["Show time left on auras that have a duration."] = true
L["Show unlimited buffs in combat."] = true
L["Show unlimited buffs in instances (e.g., dungeons or raids)."] = true
L["Show unlimited buffs on bosses and rares."] = true
L["Shows a border around the castbar of nameplates (requires /reload)."] = true
L["Shows a faction icon next to the nameplate of players."] = true
L["Shows a glow based on threat level around the nameplate's healthbar (in combat)."] = true
L["Shows an icon for friends and guild members next to the nameplate of players."] = true
L["Shows resource information for bosses and rares."] = true
L["Shows resource information only for alternatve power (of bosses or rares, mostly)."] = true
L["Situational Scale"] = true
L["Situational Transparency"] = true
L["Six"] = true
L["Size"] = true
L["Skull Icon"] = true
L["Skull"] = true
L["Small Blizzard Nameplates"] = true
L["Social"] = true
L["Sort Order"] = true
L["Sort by overall duration in ascending order."] = true
L["Sort by time left in ascending order."] = true
L["Sort in ascending alphabetical order."] = true
L["Spacing"] = true
L["Spark"] = true
L["Spec Roles"] = true
L["Special Effects"] = true
L["Specialization"] = true
L["Spell Color:"] = true
L["Spell Icon Size"] = true
L["Spell Icon"] = true
L["Spell Text Alignment"] = true
L["Spell Text Boundaries"] = true
L["Spell Text"] = true
L["Spirit Wolf"] = true
L["Square"] = true
L["Squares"] = true
L["Stack Count"] = true
L["Stacking"] = true
L["Status & Environment"] = true
L["Status Text"] = true
L["Stealth"] = true
L["Striped Texture Color"] = true
L["Striped Texture"] = true
L["Style"] = true
L["Swap By Reaction"] = true
L["Switch scale values for debuffs and buffs for friendly units."] = true
L["Symbol"] = true
L["Tank"] = true
L["Tapped Units"] = true
L["Target Highlight"] = true
L["Target Marked Units"] = true
L["Target Marked"] = true
L["Target Markers"] = true
L["Target Offset X"] = true
L["Target Offset Y"] = true
L["Target Only"] = true
L["Target"] = true
L["Target-based Scale"] = true
L["Target-based Transparency"] = true
L["Text Boundaries"] = true
L["Text Height"] = true
L["Text Width"] = true
L["Texture"] = true
L["Textures & Colors"] = true
L["Textures"] = true
L["The inset from the bottom (in screen percent) that large nameplates are clamped to."] = true
L["The inset from the bottom (in screen percent) that the non-self nameplates are clamped to."] = true
L["The inset from the top (in screen percent) that large nameplates are clamped to."] = true
L["The inset from the top (in screen percent) that the non-self nameplates are clamped to."] = true
L["The max alpha of nameplates."] = true
L["The max distance to show nameplates."] = true
L["The max distance to show the target nameplate when the target is behind the camera."] = true
L["The minimum alpha of nameplates."] = true
L["The scale of all nameplates if you have no target unit selected."] = true
L["The scale of non-target nameplates if a target unit is selected."] = true
L["The size of the clickable area is always derived from the current size of the healthbar."] = true
L["The target nameplate's scale if a target unit is selected."] = true
L["The target nameplate's transparency if a target unit is selected."] = true
L["The transparency of all nameplates if you have no target unit selected."] = true
L["The transparency of non-target nameplates if a target unit is selected."] = true
L["These options allow you to control whether target marker icons are hidden or shown on nameplates and whether a nameplate's healthbar (in healthbar view) or name (in headline view) are colored based on target markers."] = true
L["These options allow you to control whether the castbar is hidden or shown on nameplates."] = true
L["These options allow you to control which nameplates are visible within the game field while you play."] = true
L["These settings will define the space that text can be placed on the nameplate. Having too large a font and not enough height will cause the text to be not visible."] = true
L["Thick Outline"] = true
L["Thick Outline, Monochrome"] = true
L["Thick"] = true
L["This allows you to save friendly player class information between play sessions or nameplates going off the screen. |cffff0000(Uses more memory)"] = true
L["This lets you select the layout style of the auras widget."] = true
L["This option allows you to control whether a spell's icon is hidden or shown on castbars."] = true
L["This option allows you to control whether a spell's name is hidden or shown on castbars."] = true
L["This option allows you to control whether a unit's health is hidden or shown on nameplates."] = true
L["This option allows you to control whether a unit's level is hidden or shown on nameplates."] = true
L["This option allows you to control whether a unit's name is hidden or shown on nameplates."] = true
L["This option allows you to control whether custom settings for nameplate style, color, transparency and scaling should be used for this nameplate."] = true
L["This option allows you to control whether headline view (text-only) is enabled for nameplates."] = true
L["This option allows you to control whether nameplates should fade in when displayed."] = true
L["This option allows you to control whether textures are hidden or shown on nameplates for different threat levels. Dps/healing uses regular textures, for tanking textures are swapped."] = true
L["This option allows you to control whether the custom icon is hidden or shown on this nameplate."] = true
L["This option allows you to control whether the icon for rare & elite units is hidden or shown on nameplates."] = true
L["This option allows you to control whether the skull icon for boss units is hidden or shown on nameplates."] = true
L["This option allows you to control whether threat affects the healthbar color of nameplates."] = true
L["This option allows you to control whether threat affects the scale of nameplates."] = true
L["This option allows you to control whether threat affects the transparency of nameplates."] = true
L["This setting will disable threat scale for target marked, mouseover or casting units and instead use the general scale settings."] = true
L["This setting will disable threat transparency for target marked, mouseover or casting units and instead use the general transparency settings."] = true
L["This widget highlights the nameplate of your current target by showing a border around the healthbar and by coloring the nameplate's healtbar and/or name with a custom color."] = true
L["This widget shows a class icon on the nameplates of players."] = true
L["This widget shows a quest icon above unit nameplates or colors the nameplate healthbar of units that are involved with any of your current quests."] = true
L["This widget shows a stealth icon on nameplates of units that can detect stealth."] = true
L["This widget shows a unit's auras (buffs and debuffs) on its nameplate."] = true
L["This widget shows auras from boss mods on your nameplates (since patch 7.2, hostile nameplates only in instances and raids)."] = true
L["This widget shows icons for friends, guild members, and faction on nameplates."] = true
L["This widget shows information about your target's resource on your target nameplate. The resource bar's color is derived from the type of resource automatically."] = true
L["This widget shows players that are healers."] = true
L["This widget shows various icons (orbs and numbers) on enemy nameplates in arenas for easier differentiation."] = true
L["This widget shows your combo points on your target nameplate."] = true
L["This will allow you to add additional scaling changes to specific mob types."] = true
L["This will allow you to disable threat art on target marked units."] = true
L["This will color the aura based on its type (poison, disease, magic, curse) - for Icon Mode the icon border is colored, for Bar Mode the bar itself."] = true
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact absorbs amounts."] = true
L["This will format text to a simpler format using M or K for millions and thousands. Disabling this will show exact health amounts."] = true
L["This will format text to show both the maximum hp and current hp."] = true
L["This will format text to show hp as a value the target is missing."] = true
L["This will toggle the auras widget to only show for your current target."] = true
L["This will toggle the auras widget to show the cooldown spiral on auras."] = true
L["Threat Detection Heuristic"] = true
L["Threat Detection"] = true
L["Threat Glow"] = true
L["Threat System"] = true
L["Threat Table"] = true
L["Three"] = true
L["Time Left"] = true
L["Time Text Offset"] = true
L["Toggle Enemy Headline View"] = true
L["Toggle Friendly Headline View"] = true
L["Toggle Neutral Headline View"] = true
L["Toggle on Target"] = true
L["Toggling"] = true
L["Tooltips"] = true
L["Top Inset"] = true
L["Top Left"] = true
L["Top Right"] = true
L["Top"] = true
L["Top-to-bottom"] = true
L["Totem Scale"] = true
L["Totem Transparency"] = true
L["Totems"] = true
L["Transparency & Scaling"] = true
L["Transparency"] = true
L["Treant"] = true
L["Two"] = true
L["Type direct icon texture path using '\\' to separate directory folders, or use a spellid."] = true
L["Typeface"] = true
L["UI Scale"] = true
L["Unable to change a setting while in combat."] = true
L["Unable to change the following console variable while in combat: "] = true
L["Unable to change transparency for occluded units while in combat."] = true
L["Undetermined"] = true
L["Uniform Color"] = true
L["Unit Base Scale"] = true
L["Unit Base Transparency"] = true
L["Unknown option: "] = true
L["Usage: /tptp [options]"] = true
L["Use Blizzard default nameplates for friendly nameplates and disable ThreatPlates for these units."] = true
L["Use Blizzard default nameplates for neutral and enemy nameplates and disable ThreatPlates for these units."] = true
L["Use Target's Name"] = true
L["Use Threat Alpha"] = true
L["Use Threat Coloring"] = true
L["Use Threat Scale"] = true
L["Use a custom color for healthbar (in healthbar view) or name (in headline view) of friends and/or guild members."] = true
L["Use a custom color for the castbar's background."] = true
L["Use a custom color for the healtbar's background."] = true
L["Use a custom color for the healtbar's border."] = true
L["Use a custom color for the healthbar of quest mobs."] = true
L["Use a custom color for the healthbar of your current target."] = true
L["Use a custom color for the name of your current target (in healthbar view and in headline view)."] = true
L["Use a heuristic instead of a mob's threat table to detect if you are in combat with a mob (see Threat System - General Settings for a more detailed explanation)."] = true
L["Use a heuristic to detect if a mob is in combat with you, but only in instances (like dungeons or raits)."] = true
L["Use a striped texture for the absorbs overlay. Always enabled if full absorbs are shown."] = true
L["Use scale settings of Healthbar View also for Headline View."] = true
L["Use target-based scale as absolute scale and ignore unit base scale."] = true
L["Use target-based transparency as absolute transparency and ignore unit base transparency."] = true
L["Use the castbar's foreground color also for the background."] = true
L["Use the healthbar's background color also for the border."] = true
L["Use the healthbar's foreground color also for the background."] = true
L["Use the healthbar's foreground color also for the border."] = true
L["Use the same color for all combo points shown."] = true
L["Use threat scale as additive scale and add or substract it from the general scale settings."] = true
L["Use threat transparency as additive transparency and add or substract it from the general transparency settings."] = true
L["Use transparency settings of Healthbar View also for Headline View."] = true
L["Uses the target-based transparency as absolute transparency and ignore unit base transparency."] = true
L["Val'kyr Shadowguard"] = true
L["Venomous Snake"] = true
L["Vertical Align"] = true
L["Vertical Alignment"] = true
L["Vertical Offset"] = true
L["Vertical Overlap"] = true
L["Vertical Spacing"] = true
L["Viper"] = true
L["Visibility"] = true
L["Volatile Ooze"] = true
L["Warlock"] = true
L["Warning Glow for Threat"] = true
L["Water Elemental"] = true
L["We're unable to change this while in combat"] = true
L["Web Wrap"] = true
L["White List"] = true
L["Wide"] = true
L["Widgets"] = true
L["Width"] = true
L["Windwalker Monk"] = true
L["X"] = true
L["Y"] = true
L["You can access the "] = true
L["You currently have two nameplate addons enabled: |cff89F559Threat Plates|r and |cff89F559%s|r. Please disable one of these, otherwise two overlapping nameplates will be shown for units."] = true
L["Your own quests that you have to complete."] = true
L["\n\nFeel free to email me at |cff00ff00threatplates@gmail.com|r\n\n--\n\nBlacksalsify\n\n(Original author: Suicidal Katt - |cff00ff00Shamtasticle@gmail.com|r)"] = true
L["options:"] = true
L["|cff00ff00High Threat|r"] = true
L["|cff00ff00Low Threat|r"] = true
L["|cff00ff00Tank|r"] = true
L["|cff00ff00tanking|r"] = true
L["|cff0faac8Off-Tank|r"] = true
L["|cff89F559Threat Plates|r is no longer a theme of |cff89F559TidyPlates|r, but a standalone addon that does no longer require TidyPlates. Please disable one of these, otherwise two overlapping nameplates will be shown for units."] = true
L["|cff89F559Threat Plates|r: DPS switch detected, you are now in your |cffff0000dpsing / healing|r role."] = true
L["|cff89F559Threat Plates|r: Role toggle not supported because automatic role detection is enabled."] = true
L["|cff89F559Threat Plates|r: Tank switch detected, you are now in your |cff00ff00tanking|r role."] = true
L["|cff89f559 role.|r"] = true
L["|cff89f559Additional options can be found by typing |r'/tptp'|cff89F559.|r"] = true
L["|cff89f559Threat Plates:|r Welcome back |cff"] = true
L["|cff89f559Welcome to |r|cff89f559Threat Plates!\nThis is your first time using Threat Plates and you are a(n):\n|r|cff"] = true
L["|cff89f559You are currently in your "] = true
L["|cffff0000DPS/Healing|r"] = true
L["|cffff0000High Threat|r"] = true
L["|cffff0000IMPORTANT: Enabling this feature changes console variables (CVars) which will change the appearance of default Blizzard nameplates. Disabling this feature will reset these CVars to the original value they had when you enabled this feature.|r"] = true
L["|cffff0000Low Threat|r"] = true
L["|cffff0000dpsing / healing|r"] = true
L["|cffffff00Medium Threat|r"] = true
L["|cffffffffGeneral Settings|r"] = true
L["|cffffffffLow Threat|r"] = true
L["|cffffffffTotem Settings|r"] = true
L['Reverse the sort order (e.g., "A to Z" becomes "Z to A").'] = true

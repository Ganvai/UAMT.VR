/*
Since ACE3_v3.12.0. - the ACE_Settings will be now handled via CBA_Settings_System:
https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

The cba_settings.sqf file of a mission is ignored by default.
If the file is present when the mission is saved in the editor,
a flag will be set and enable the mission to read the file.
This only works if CBA is present when the mission is saved.
To avoid creating a dependency, the mission maker can manually add the flag to the description.ext:

	cba_settings_hasSettingsFile = 1;

Note that this will crash the mission on a dedicated server if the file is not present in the mission.
*/

// ACE AI
force ace_ai_assignNVG = false;

// ACE Advanced Ballistics_____________________________________________________________
force force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force force ace_advanced_ballistics_bulletTraceEnabled = true;
force force ace_advanced_ballistics_enabled = true;
force force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force force ace_advanced_ballistics_simulationInterval = 0.05;

// ACE Advanced Fatigue
force force ace_advanced_fatigue_enabled = true;
force force ace_advanced_fatigue_enableStaminaBar = false;
force force ace_advanced_fatigue_fadeStaminaBar = true;
force force ace_advanced_fatigue_loadFactor = 0.7;
force force ace_advanced_fatigue_performanceFactor = 1;
force force ace_advanced_fatigue_recoveryFactor = 1.1;
ace_advanced_fatigue_swayFactor = 1;
ace_advanced_fatigue_terrainGradientFactor = 1;

// ACE Advanced Throwing
force force ace_advanced_throwing_enabled = true;
force force ace_advanced_throwing_enablePickUp = true;
force force ace_advanced_throwing_enablePickUpAttached = true;
ace_advanced_throwing_showMouseControls = true;
force force ace_advanced_throwing_showThrowArc = true;

// ACE Advanced Vehicle Damage
force force ace_vehicle_damage_enableCarDamage = false;
force force ace_vehicle_damage_enabled = true;
force force ace_vehicle_damage_removeAmmoDuringCookoff = true;

// ACE Arsenal
force force ace_arsenal_allowDefaultLoadouts = true;
force force ace_arsenal_allowSharedLoadouts = true;
ace_arsenal_camInverted = false;
force force ace_arsenal_enableIdentityTabs = true;
ace_arsenal_enableModIcons = true;
ace_arsenal_EnableRPTLog = false;
ace_arsenal_fontHeight = 4.5;

// ACE Artillery
force force ace_artillerytables_advancedCorrections = false;
force force ace_artillerytables_disableArtilleryComputer = false;
force force ace_mk6mortar_airResistanceEnabled = false;
force force ace_mk6mortar_allowCompass = true;
force force ace_mk6mortar_allowComputerRangefinder = true;
force force ace_mk6mortar_useAmmoHandling = false;

// ACE Captives
force force ace_captives_allowHandcuffOwnSide = true;
force force ace_captives_allowSurrender = false;
force force ace_captives_requireSurrender = 0;
force force ace_captives_requireSurrenderAi = false;

// ACE Casings
force force ace_casings_enabled = true;
force force ace_casings_maxCasings = 200;

// ACE Dragging
force force ace_dragging_allowRunWithLightweight = true;
force force ace_dragging_dragAndFire = true;
force force ace_dragging_skipContainerWeight = false;

// ACE Common
force force ace_common_allowFadeMusic = false;
force force ace_common_checkPBOsAction = 1;
force force ace_common_checkPBOsCheckAll = false;
force force ace_common_checkPBOsWhitelist = "[]";
ace_common_displayTextColor = [0,0,0,0.1];
ace_common_displayTextFontColor = [1,1,1,1];
ace_common_epilepsyFriendlyMode = false;
ace_common_progressBarInfo = 2;
ace_common_settingFeedbackIcons = 1;
ace_common_settingProgressBarLocation = 0;
force force ace_noradio_enabled = true;
force force ace_parachute_hideAltimeter = false;

// ACE Cook off
force force ace_cookoff_ammoCookoffDuration = 1;
force force ace_cookoff_enable = 2;
force force ace_cookoff_enableAmmobox = true;
force force ace_cookoff_enableAmmoCookoff = true;
force force ace_cookoff_enableFire = true;
force force ace_cookoff_probabilityCoef = 1;

// ACE Crew Served Weapons
force force ace_csw_ammoHandling = 1;
force force ace_csw_defaultAssemblyMode = false;
force force ace_csw_dragAfterDeploy = true;
force force ace_csw_handleExtraMagazines = false;
force force ace_csw_progressBarTimeCoefficent = 1;

// ACE Dragging
force force ace_dragging_dragAndFire = true;

// ACE Explosives
ace_explosives_customTimerDefault = 30;
force force ace_explosives_customTimerMax = 900;
force force ace_explosives_customTimerMin = 5;
force force ace_explosives_explodeOnDefuse = false;
force force ace_explosives_punishNonSpecialists = false;
force force ace_explosives_requireSpecialist = true;

// ACE Field Rations
force acex_field_rations_affectAdvancedFatigue = true;
force acex_field_rations_enabled = false;
acex_field_rations_hudShowLevel = 0;
acex_field_rations_hudTransparency = -1;
acex_field_rations_hudType = 0;
force acex_field_rations_hungerSatiated = 1;
force acex_field_rations_terrainObjectActions = true;
force acex_field_rations_thirstQuenched = 1;
force acex_field_rations_timeWithoutFood = 2;
force acex_field_rations_timeWithoutWater = 2;
force acex_field_rations_waterSourceActions = 2;

// ACE Fire
force force ace_fire_dropWeapon = 1;
force force ace_fire_enabled = false;
force force ace_fire_enableFlare = true;
force force ace_fire_enableScreams = true;

// ACE Fortify
force force ace_fortify_markObjectsOnMap = 0;
force force ace_fortify_timeCostCoefficient = 2;
force force ace_fortify_timeMin = 1.5;
force force acex_fortify_settingHint = 0;

// ACE Fragmentation Simulation
force force ace_frag_enabled = true;
force force ace_frag_maxTrack = 10;
force force ace_frag_maxTrackPerFrame = 10;
force force ace_frag_reflectionsEnabled = true;
force force ace_frag_spallEnabled = true;

// ACE G-Forces
force force ace_gforces_coef = 0.6;
force force ace_gforces_enabledFor = 1;

// ACE Goggles
ace_goggles_effects = 2;
ace_goggles_showClearGlasses = true;
ace_goggles_showInThirdPerson = false;

// ACE Grenades
force force ace_grenades_convertExplosives = true;

// ACE Headless
force force acex_headless_delay = 15;
force force acex_headless_enabled = false;
force force acex_headless_endMission = 0;
force force acex_headless_log = false;
force force acex_headless_transferLoadout = 0;

// ACE Hearing
force force ace_hearing_autoAddEarplugsToUnits = true;
ace_hearing_disableEarRinging = false;
force force ace_hearing_earplugsVolume = 0.8;
force force ace_hearing_enableCombatDeafness = true;
force force ace_hearing_enabledForZeusUnits = true;
force force ace_hearing_unconsciousnessVolume = 0.7;

// ACE Interaction
force force ace_interaction_disableNegativeRating = true;
force force ace_interaction_enableGroupRenaming = true;
force force ace_interaction_enableMagazinePassing = true;
force force ace_interaction_enableTeamManagement = true;
force force ace_interaction_enableWeaponAttachments = true;
force force ace_interaction_interactWithTerrainObjects = true;

// ACE Interaction Menu
ace_gestures_showOnInteractionMenu = 2;
ace_interact_menu_actionOnKeyRelease = true;
ace_interact_menu_addBuildingActions = false;
ace_interact_menu_alwaysUseCursorInteraction = false;
ace_interact_menu_alwaysUseCursorSelfInteraction = true;
ace_interact_menu_colorShadowMax = [0,0,0,1];
ace_interact_menu_colorShadowMin = [0,0,0,0.25];
ace_interact_menu_colorTextMax = [1,1,1,1];
ace_interact_menu_colorTextMin = [1,1,1,0.25];
ace_interact_menu_consolidateSingleChild = false;
ace_interact_menu_cursorKeepCentered = false;
ace_interact_menu_cursorKeepCenteredSelfInteraction = false;
ace_interact_menu_menuAnimationSpeed = 0;
ace_interact_menu_menuBackground = 0;
ace_interact_menu_menuBackgroundSelf = 0;
ace_interact_menu_selectorColor = [1,0,0];
ace_interact_menu_shadowSetting = 2;
ace_interact_menu_textSize = 2;
ace_interact_menu_useListMenu = true;
ace_interact_menu_useListMenuSelf = true;

// ACE Interaction Menu (Self) - More
ace_interact_menu_more__ACE_CheckAirTemperature = true;
ace_interact_menu_more__ace_csw_deploy = false;
ace_interact_menu_more__ACE_Equipment = true;
ace_interact_menu_more__ACE_Explosives = false;
ace_interact_menu_more__ace_field_rations = false;
ace_interact_menu_more__ace_fortify = false;
ace_interact_menu_more__ace_gestures = true;
ace_interact_menu_more__ace_intelitems = false;
ace_interact_menu_more__ACE_MapFlashlight = true;
ace_interact_menu_more__ACE_MapGpsHide = false;
ace_interact_menu_more__ACE_MapGpsShow = true;
ace_interact_menu_more__ACE_MapTools = true;
ace_interact_menu_more__ACE_Medical = true;
ace_interact_menu_more__ACE_Medical_Menu = true;
ace_interact_menu_more__ACE_MoveRallypoint = false;
ace_interact_menu_more__ACE_RepackMagazines = true;
ace_interact_menu_more__ace_sandbag_place = true;
ace_interact_menu_more__ACE_StartSurrenderingSelf = false;
ace_interact_menu_more__ACE_StopEscortingSelf = true;
ace_interact_menu_more__ACE_StopSurrenderingSelf = false;
ace_interact_menu_more__ACE_Tags = true;
ace_interact_menu_more__ACE_TeamManagement = true;
ace_interact_menu_more__ace_zeus_create = true;
ace_interact_menu_more__ace_zeus_delete = false;
ace_interact_menu_more__acex_sitting_Stand = true;

// ACE Interaction Menu (Self) - Move to Root
ace_interact_menu_moveToRoot__ACE_Equipment__ace_atragmx_open = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_attach_Attach = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_attach_Detach = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ACE_CheckDogtags = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ACE_Chemlights = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_dagr_menu = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_dagr_menu__ace_dagr_toggle = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_goggles_wipeGlasses = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_gunbag_actions = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_gunbag_actions__ace_gunbag_status = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_gunbag_actions__ace_gunbag_weaponOff = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_gunbag_actions__ace_gunbag_weaponSwap = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_gunbag_actions__ace_gunbag_weaponTo = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_huntir_open = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_interaction_weaponAttachments = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_kestrel4500_open = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_kestrel4500_open__ace_kestrel4500_hide = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_kestrel4500_open__ace_kestrel4500_show = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_microdagr_configure = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_microdagr_configure__ace_microdagr_close = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_microdagr_configure__ace_microdagr_show = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_minedetector_metalDetector = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_minedetector_metalDetector__ace_minedetector_activate = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_minedetector_metalDetector__ace_minedetector_connectHeadphones = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_minedetector_metalDetector__ace_minedetector_deactivate = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_minedetector_metalDetector__ace_minedetector_disconnectHeadphones = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_mk6mortar_rangetable = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_overheating_CheckTemperature = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_overheating_CheckTemperatureSpareBarrels = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_overheating_CoolWeaponWithItem = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_overheating_SwapBarrel = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_overheating_UnJam = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ACE_PutInEarplugs = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_rangecard_open = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_rangecard_open__ace_rangecard_makeCopy = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_rangecard_open__ace_rangecard_openCopy = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_reload_checkAmmo = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ACE_RemoveEarplugs = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_scopes_adjustZero = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_scopes_resetZero = false;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_spottingscope_place = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ACE_TacticalLadders = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_trenches_digEnvelopeBig = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_trenches_digEnvelopeSmall = true;
ace_interact_menu_moveToRoot__ACE_Equipment__ace_tripod_place = true;
ace_interact_menu_moveToRoot__ACE_Explosives__ACE_Cellphone = true;
ace_interact_menu_moveToRoot__ACE_Explosives__ACE_Place = true;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Advance = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_CeaseFire = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Cover = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Engage = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Follow = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Forward = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Freeze = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Go = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Hold = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Point = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Regroup = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Stop = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Up = false;
ace_interact_menu_moveToRoot__ace_gestures__ace_gestures_Warning = false;
ace_interact_menu_moveToRoot__ACE_MapTools__ACE_MapToolsAlignCompass = true;
ace_interact_menu_moveToRoot__ACE_MapTools__ACE_MapToolsAlignNorth = true;
ace_interact_menu_moveToRoot__ACE_MapTools__ACE_MapToolsHide = true;
ace_interact_menu_moveToRoot__ACE_MapTools__ACE_MapToolsShowNormal = true;
ace_interact_menu_moveToRoot__ACE_MapTools__ACE_MapToolsShowSmall = true;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_ArmLeft = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_ArmRight = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_Head = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_LegLeft = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_LegRight = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_Torso = false;
ace_interact_menu_moveToRoot__ACE_Medical__ACE_Torso__TriageCard = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_BecomeLeader = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_JoinTeamBlue = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_JoinTeamGreen = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_JoinTeamRed = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_JoinTeamYellow = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_LeaveGroup = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_LeaveTeam = false;
ace_interact_menu_moveToRoot__ACE_TeamManagement__ACE_RenameGroup = false;

// ACE Logistics
ace_cargo_carryAfterUnload = true;
force force ace_cargo_enable = true;
ace_cargo_enableRename = true;
force force ace_cargo_loadTimeCoefficient = 3;
ace_cargo_openAfterUnload = 0;
force force ace_cargo_paradropTimeCoefficent = 2.5;
force force ace_rearm_distance = 20;
force force ace_rearm_level = 0;
force force ace_rearm_supply = 0;
force force ace_refuel_hoseLength = 12;
force force ace_refuel_progressDuration = 2;
force force ace_refuel_rate = 1;
force force ace_repair_addSpareParts = true;
force force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force force ace_repair_consumeItem_toolKit = 0;
ace_repair_displayTextOnRepair = true;
force force ace_repair_engineerSetting_fullRepair = 1;
force force ace_repair_engineerSetting_repair = 1;
force force ace_repair_engineerSetting_wheel = 0;
force force ace_repair_fullRepairLocation = 0;
force force ace_repair_fullRepairRequiredItems = ["ace_repair_anyToolKit"];
force force ace_repair_locationsBoostTraining = false;
force force ace_repair_miscRepairRequiredItems = ["ace_repair_anyToolKit"];
force force ace_repair_repairDamageThreshold = 0.9;
force force ace_repair_repairDamageThreshold_engineer = 0.7;
force force ace_repair_wheelRepairRequiredItems = [];
force force ace_towing_addRopeToVehicleInventory = true;

// ACE Magazine Repack
force force ace_magazinerepack_repackAnimation = true;
force force ace_magazinerepack_repackLoadedMagazines = true;
force force ace_magazinerepack_timePerAmmo = 1.5;
force force ace_magazinerepack_timePerBeltLink = 4;
force force ace_magazinerepack_timePerMagazine = 2;

// ACE Map
force ace_map_BFT_Enabled = true;
force ace_map_BFT_HideAiGroups = true;
force ace_map_BFT_Interval = 1;
force ace_map_BFT_ShowPlayerNames = false;
force force ace_map_DefaultChannel = 1;
force force ace_map_mapGlow = true;
force force ace_map_mapIllumination = true;
force force ace_map_mapLimitZoom = false;
force force ace_map_mapShake = true;
force force ace_map_mapShowCursorCoordinates = false;
ace_markers_moveRestriction = 0;
force force ace_markers_timestampEnabled = true;
force force ace_markers_timestampFormat = "HH:MM";
force force ace_markers_timestampHourFormat = 24;

// ACE Map Gestures
ace_map_gestures_allowCurator = true;
ace_map_gestures_allowSpectator = true;
ace_map_gestures_briefingMode = 0;
ace_map_gestures_defaultColor = [1,0.88,0,0.7];
ace_map_gestures_defaultLeadColor = [1,0.88,0,0.95];
force force ace_map_gestures_enabled = true;
force force ace_map_gestures_interval = 0.03;
force force ace_map_gestures_maxRange = 7;
force force ace_map_gestures_maxRangeCamera = 14;
ace_map_gestures_nameTextColor = [0.2,0.2,0.2,0.3];
force force ace_map_gestures_onlyShowFriendlys = false;

// ACE Map Tools
ace_maptools_drawStraightLines = true;
ace_maptools_rotateModifierKey = 1;

// ACE Medical
force force ace_medical_ai_enabledFor = 2;
force force ace_medical_AIDamageThreshold = 1;
force force ace_medical_bleedingCoefficient = 0.2;
force force ace_medical_blood_bloodLifetime = 300;
force force ace_medical_blood_enabledFor = 2;
force force ace_medical_blood_maxBloodObjects = 100;
force force ace_medical_deathChance = 1;
force force ace_medical_enableVehicleCrashes = true;
force force ace_medical_fatalDamageSource = 0;
ace_medical_feedback_bloodVolumeEffectType = 0;
ace_medical_feedback_enableHUDIndicators = true;
ace_medical_feedback_painEffectType = 0;
force force ace_medical_fractureChance = 0.4;
force force ace_medical_fractures = 1;
ace_medical_gui_bloodLossColor_0 = [1,1,1,1];
ace_medical_gui_bloodLossColor_1 = [1,0.95,0.64,1];
ace_medical_gui_bloodLossColor_2 = [1,0.87,0.46,1];
ace_medical_gui_bloodLossColor_3 = [1,0.8,0.33,1];
ace_medical_gui_bloodLossColor_4 = [1,0.72,0.24,1];
ace_medical_gui_bloodLossColor_5 = [1,0.63,0.15,1];
ace_medical_gui_bloodLossColor_6 = [1,0.54,0.08,1];
ace_medical_gui_bloodLossColor_7 = [1,0.43,0.02,1];
ace_medical_gui_bloodLossColor_8 = [1,0.3,0,1];
ace_medical_gui_bloodLossColor_9 = [1,0,0,1];
ace_medical_gui_damageColor_0 = [1,1,1,1];
ace_medical_gui_damageColor_1 = [0.75,0.95,1,1];
ace_medical_gui_damageColor_2 = [0.62,0.86,1,1];
ace_medical_gui_damageColor_3 = [0.54,0.77,1,1];
ace_medical_gui_damageColor_4 = [0.48,0.67,1,1];
ace_medical_gui_damageColor_5 = [0.42,0.57,1,1];
ace_medical_gui_damageColor_6 = [0.37,0.47,1,1];
ace_medical_gui_damageColor_7 = [0.31,0.36,1,1];
ace_medical_gui_damageColor_8 = [0.22,0.23,1,1];
ace_medical_gui_damageColor_9 = [0,0,1,1];
ace_medical_gui_enableActions = 0;
ace_medical_gui_enableMedicalMenu = 1;
ace_medical_gui_enableSelfActions = true;
ace_medical_gui_interactionMenuShowTriage = 1;
force force ace_medical_gui_maxDistance = 5;
force force ace_medical_gui_openAfterTreatment = true;
force force ace_medical_gui_showBloodlossEntry = true;
force force ace_medical_ivFlowRate = 2;
force force ace_medical_limping = 1;
force force ace_medical_painCoefficient = 0.9;
force force ace_medical_painUnconsciousChance = 0.05;
force force ace_medical_playerDamageThreshold = 1;
force force ace_medical_spontaneousWakeUpChance = 0.5;
force force ace_medical_spontaneousWakeUpEpinephrineBoost = 20;
force force ace_medical_statemachine_AIUnconsciousness = false;
force force ace_medical_statemachine_cardiacArrestBleedoutEnabled = false;
force force ace_medical_statemachine_cardiacArrestTime = 3600;
force force ace_medical_statemachine_fatalInjuriesAI = 0;
force force ace_medical_statemachine_fatalInjuriesPlayer = 2;

force force ace_medical_treatment_advancedBandages = 1;
force force ace_medical_treatment_advancedDiagnose = 1;
force force ace_medical_treatment_advancedMedication = true;
force force ace_medical_treatment_allowBodyBagUnconscious = false;
force force ace_medical_treatment_allowLitterCreation = true;
force force ace_medical_treatment_allowSelfIV = 0;
force force ace_medical_treatment_allowSelfPAK = 1;
force force ace_medical_treatment_allowSelfStitch = 0;
force force ace_medical_treatment_allowSharedEquipment = 0;
force force ace_medical_treatment_clearTrauma = 1;
force force ace_medical_treatment_consumePAK = 1;
force force ace_medical_treatment_consumeSurgicalKit = 0;
force force ace_medical_treatment_convertItems = 0;
force force ace_medical_treatment_cprSuccessChanceMax = 0.8;
force force ace_medical_treatment_cprSuccessChanceMin = 0.6;
force force ace_medical_treatment_holsterRequired = 0;
force force ace_medical_treatment_litterCleanupDelay = 300;
force force ace_medical_treatment_locationEpinephrine = 0;
force force ace_medical_treatment_locationIV = 0;
force force ace_medical_treatment_locationPAK = 0;
force force ace_medical_treatment_locationsBoostTraining = true;
force force ace_medical_treatment_locationSurgicalKit = 0;
force force ace_medical_treatment_maxLitterObjects = 100;
force force ace_medical_treatment_medicEpinephrine = 0;
force force ace_medical_treatment_medicIV = 1;
force force ace_medical_treatment_medicPAK = 1;
force force ace_medical_treatment_medicSurgicalKit = 1;
force force ace_medical_treatment_timeCoefficientPAK = 1;
force force ace_medical_treatment_treatmentTimeAutoinjector = 5;
force force ace_medical_treatment_treatmentTimeBodyBag = 15;
force force ace_medical_treatment_treatmentTimeCPR = 15;
force force ace_medical_treatment_treatmentTimeIV = 12;
force force ace_medical_treatment_treatmentTimeSplint = 7;
force force ace_medical_treatment_treatmentTimeTourniquet = 7;
force force ace_medical_treatment_woundReopenChance = 0.2;
force force ace_medical_treatment_woundStitchTime = 5;

// ACE Name Tags
force force ace_nametags_ambientBrightnessAffectViewDist = 1;
ace_nametags_defaultNametagColor = [0.77,0.51,0.08,1];
ace_nametags_nametagColorBlue = [0.67,0.67,1,1];
ace_nametags_nametagColorGreen = [0.67,1,0.67,1];
ace_nametags_nametagColorMain = [1,1,1,1];
ace_nametags_nametagColorRed = [1,0.67,0.67,1];
ace_nametags_nametagColorYellow = [1,1,0.67,1];
force force ace_nametags_playerNamesMaxAlpha = 0.8;
force force ace_nametags_playerNamesViewDistance = 10;
force force ace_nametags_showCursorTagForVehicles = false;
force force ace_nametags_showNamesForAI = false;
force force ace_nametags_showPlayerNames = 1;
force force ace_nametags_showPlayerRanks = false;
force force ace_nametags_showSoundWaves = 1;
ace_nametags_showVehicleCrewInfo = true;
ace_nametags_tagSize = 2;

// ACE Nightvision
force force ace_nightvision_aimDownSightsBlur = 0;
force force ace_nightvision_disableNVGsWithSights = false;
force force ace_nightvision_effectScaling = 0.5;
force force ace_nightvision_fogScaling = 0.4;
force force ace_nightvision_noiseScaling = 0.3;
ace_nightvision_shutterEffects = true;

// ACE Overheating
force force ace_overheating_cookoffCoef = 1;
force force ace_overheating_coolingCoef = 4;
force force ace_overheating_displayTextOnJam = true;
force force ace_overheating_enabled = true;
force force ace_overheating_heatCoef = 0.5;
force force ace_overheating_jamChanceCoef = 0.4;
force force ace_overheating_overheatingDispersion = true;
force force ace_overheating_overheatingRateOfFire = true;
ace_overheating_particleEffectsAndDispersionDistance = 1000;
force force ace_overheating_showParticleEffects = true;
force force ace_overheating_showParticleEffectsForEveryone = true;
force force ace_overheating_suppressorCoef = 0.8;
force force ace_overheating_unJamFailChance = 0.2;
force force ace_overheating_unJamOnreload = true;
force force ace_overheating_unJamOnSwapBarrel = true;

// ACE Pointing
force force ace_finger_enabled = true;
ace_finger_indicatorColor = [0.83,0.68,0.21,0.75];
ace_finger_indicatorForSelf = true;
force force ace_finger_maxRange = 6;

// ACE Pylons
force force ace_pylons_enabledForZeus = true;
force force ace_pylons_enabledFromAmmoTrucks = true;
force force ace_pylons_rearmNewPylons = true;
force force ace_pylons_requireEngineer = false;
force force ace_pylons_requireToolkit = false;
force force ace_pylons_searchDistance = 15;
force force ace_pylons_timePerPylon = 5;

// ACE Quick Mount
force force ace_quickmount_distance = 3;
force force ace_quickmount_enabled = true;
ace_quickmount_enableMenu = 3;
ace_quickmount_priority = 0;
force force ace_quickmount_speed = 18;

// ACE Respawn
force force ace_respawn_removeDeadBodiesDisconnected = true;
force force ace_respawn_savePreDeathGear = true;

// ACE Repair
force force ace_repair_addSpareParts = true;
force force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force force ace_repair_consumeItem_toolKit = 0;
force force ace_repair_displayTextOnRepair = true;
force force ace_repair_enabled = true;
force force ace_repair_engineerSetting_fullRepair = 2;
force force ace_repair_engineerSetting_repair = 1;
force force ace_repair_engineerSetting_wheel = 0;
force force ace_repair_fullRepairLocation = 2;
force force ace_repair_fullRepairRequiredItems = ["ace_repair_anyToolKit"];
force force ace_repair_locationsBoostTraining = false;
force force ace_repair_miscRepairRequiredItems = ["ace_repair_anyToolKit"];
force force ace_repair_miscRepairTime = 15;
force force ace_repair_patchWheelEnabled = 0;
force force ace_repair_patchWheelLocation = ["ground","vehicle"];
force force ace_repair_patchWheelMaximumRepair = 0.104267;
force force ace_repair_patchWheelRequiredItems = ["ace_repair_anyToolKit"];
force force ace_repair_patchWheelTime = 5;
force force ace_repair_repairDamageThreshold = 0.0476004;
force force ace_repair_repairDamageThreshold_engineer = 0.0476004;
force force ace_repair_timeCoefficientFullRepair = 1;
force force ace_repair_wheelChangeTime = 10;
force force ace_repair_wheelRepairRequiredItems = [];

// ACE Scopes
force force ace_scopes_correctZeroing = true;
force force ace_scopes_deduceBarometricPressureFromTerrainAltitude = true;
force force ace_scopes_defaultZeroRange = 100;
force force ace_scopes_enabled = true;
force force ace_scopes_forceUseOfAdjustmentTurrets = false;
force force ace_scopes_overwriteZeroRange = false;
force force ace_scopes_simplifiedZeroing = false;
force force ace_scopes_useLegacyUI = true;
force force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force force ace_scopes_zeroReferenceHumidity = 0;
force force ace_scopes_zeroReferenceTemperature = 15;

// ACE Sitting
force force acex_sitting_enable = true;

// ACE Spectator
force force ace_spectator_enableAI = false;
ace_spectator_maxFollowDistance = 5;
force force ace_spectator_restrictModes = 0;
force force ace_spectator_restrictVisions = 0;

// ACE Switch Units
force force ace_switchunits_enableSafeZone = true;
force force ace_switchunits_enableSwitchUnits = false;
force force ace_switchunits_safeZoneRadius = 100;
force force ace_switchunits_switchToCivilian = false;
force force ace_switchunits_switchToEast = false;
force force ace_switchunits_switchToIndependent = false;
force force ace_switchunits_switchToWest = false;

// ACE Trenches
force force ace_trenches_bigEnvelopeDigDuration = 25;
force force ace_trenches_bigEnvelopeRemoveDuration = 15;
force force ace_trenches_smallEnvelopeDigDuration = 20;
force force ace_trenches_smallEnvelopeRemoveDuration = 12;

// ACE Uncategorized
force force ace_fastroping_autoAddFRIES = true;
force force ace_fastroping_requireRopeItems = false;
force force ace_gunbag_swapGunbagEnabled = true;
force force ace_hitreactions_minDamageToTrigger = 0.1;
force force ace_inventory_inventoryDisplaySize = 0;
force force ace_laser_dispersionCount = 2;
force force ace_laser_showLaserOnMap = 0;
force force ace_marker_flags_placeAnywhere = false;
force force ace_microdagr_mapDataAvailable = 2;
force force ace_microdagr_waypointPrecision = 3;
force force ace_noradio_enabled = true;
force force ace_optionsmenu_showNewsOnMainMenu = true;
force force ace_overpressure_distanceCoefficient = 1;
force force ace_parachute_failureChance = 0;
force force ace_parachute_hideAltimeter = false;
force force ace_tagging_quickTag = 1;

// ACE User Interface
force force ace_ui_allowSelectiveUI = true;
force force ace_ui_ammoCount = false;
ace_ui_ammoType = true;
ace_ui_commandMenu = true;
force force ace_ui_enableSpeedIndicator = true;
ace_ui_firingMode = true;
ace_ui_groupBar = false;
ace_ui_gunnerAmmoCount = true;
ace_ui_gunnerAmmoType = true;
ace_ui_gunnerFiringMode = true;
ace_ui_gunnerLaunchableCount = true;
ace_ui_gunnerLaunchableName = true;
ace_ui_gunnerMagCount = true;
ace_ui_gunnerWeaponLowerInfoBackground = true;
ace_ui_gunnerWeaponName = true;
ace_ui_gunnerWeaponNameBackground = true;
ace_ui_gunnerZeroing = true;
force force ace_ui_magCount = true;
ace_ui_soldierVehicleWeaponInfo = true;
ace_ui_staminaBar = true;
ace_ui_stance = true;
force force ace_ui_throwableCount = false;
ace_ui_throwableName = true;
ace_ui_vehicleAltitude = true;
ace_ui_vehicleCompass = true;
ace_ui_vehicleDamage = true;
ace_ui_vehicleFuelBar = true;
ace_ui_vehicleInfoBackground = true;
ace_ui_vehicleName = true;
ace_ui_vehicleNameBackground = true;
ace_ui_vehicleRadar = true;
ace_ui_vehicleSpeed = true;
ace_ui_weaponLowerInfoBackground = true;
ace_ui_weaponName = true;
ace_ui_weaponNameBackground = true;
ace_ui_zeroing = true;

// ACE Vehicle Lock
force force ace_vehiclelock_defaultLockpickStrength = 10;
force force ace_vehiclelock_lockVehicleInventory = false;
force force ace_vehiclelock_vehicleStartingLockState = -1;

// ACE Vehicles
force force ace_vehicles_hideEjectAction = false;
force force ace_vehicles_keepEngineRunning = true;
ace_vehicles_speedLimiterStep = 5;
force force ace_viewports_enabled = true;

// ACE View Distance Limiter
force force ace_viewdistance_enabled = true;
force force ace_viewdistance_limitViewDistance = 5000;
ace_viewdistance_objectViewDistanceCoeff = 0;
ace_viewdistance_viewDistanceAirVehicle = 0;
ace_viewdistance_viewDistanceLandVehicle = 0;
ace_viewdistance_viewDistanceOnFoot = 0;

// ACE View Restriction
acex_viewrestriction_mode = 0;
acex_viewrestriction_modeSelectiveAir = 0;
acex_viewrestriction_modeSelectiveFoot = 0;
acex_viewrestriction_modeSelectiveLand = 0;
acex_viewrestriction_modeSelectiveSea = 0;
acex_viewrestriction_preserveView = false;

// ACE Weapons
ace_common_persistentLaserEnabled = false;
force force ace_laserpointer_enabled = true;
ace_reload_displayText = true;
ace_reload_showCheckAmmoSelf = false;
ace_weaponselect_displayText = true;

// ACE Weather
force force ace_weather_enabled = true;
ace_weather_showCheckAirTemperature = true;
force force ace_weather_updateInterval = 60;
force force ace_weather_windSimulation = true;

// ACE Wind Deflection
force force ace_winddeflection_enabled = true;
force force ace_winddeflection_simulationInterval = 0.5;
force force ace_winddeflection_vehicleEnabled = true;

// ACE Zeus
force force ace_zeus_autoAddObjects = true;
force force ace_zeus_canCreateZeus = 0;
force force ace_zeus_radioOrdnance = false;
force force ace_zeus_remoteWind = false;
force force ace_zeus_revealMines = 0;
force force ace_zeus_zeusAscension = false;
force force ace_zeus_zeusBird = false;

// Community Base Addons
cba_diagnostic_ConsoleIndentType = -1;
force cba_diagnostic_watchInfoRefreshRate = 0.2;
force force cba_disposable_dropUsedLauncher = 2;
force force cba_disposable_replaceDisposableLauncher = true;
cba_events_repetitionMode = 0;
force force cba_network_loadoutValidation = 1;
cba_optics_usePipOptics = true;
cba_ui_notifyLifetime = 4;
cba_ui_StorePasswords = 1;
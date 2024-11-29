//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Player Init
//
//------------------------------------------------------------------
//------------------------------------------------------------------
titleText ["Preparing Mission...", "BLACK FADED", 1];

// Generating Briefing Section
[] execVM "scripts\UAMTScripts\briefing.sqf";

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Mod Check
//
// 			Checks Loaded Mods and logs Non Whitelisted
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "modcheck" == "true") then {
	_modCheckresult = call compile preprocessFile "scripts\UAMTScripts\modcheck.sqf";
	
	waitUntil {sleep 1;_modCheckresult};
	
	if (!_modCheckresult) exitWith {};
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Opening Track
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "iJName" != "") then {
	
	[] spawn {
		//Needed for fadeMusic to work
		ace_hearing_disableVolumeUpdate = true;

		//set Music to zero for FadeIn
		0 fadeMusic 0;

		// Debug Play, needed because sometimes Arme has problems starting a Track
		// that is not defined in the Missions CfGMusic.
		playMusic iJName;
		sleep 0.1;

		//Playing the OT Track with music
		playMusic [iJName,iJStart];
		iJFade fadeMusic 1;
		
		sleep (IJFade + 1);
		ace_hearing_disableVolumeUpdate = false;
	};
};
//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Mission Started Feature
//
// If active, all Players will be teleported onto the "base"-Object 
// Mostly for JiP and reconnect
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "missionstartedfeat" == "true") then {
	if (missionstarted) then {
		
		_center = getPos base;
		_spawnPos = [0,0,0];
		_spawnPos = _center findEmptyPosition [0.5, 30, "B_Soldier_F"];
		_timer = time;
		
		waitUntil {count _spawnPos == 3 || time - _timer > 20};
		
		player allowDamage false;
		player setPos _spawnPos;
		sleep 1;
		player allowDamage true;
	};
};

waitUntil{!isNull(player)};
setTerrainGrid 25;
enableEnvironment [false, true];

_welcomemessage = getMissionConfigValue "WelcomeMessage";
_missionControlCenterMessage = getMissionConfigValue "MissionControlCenterMessage";

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Dynamic Groups
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//DynamicGroups_Function Function needs to be initialized on server and client. Clients can then use action TeamSwitch ("U" by default) to access the Dynamic Groups interface.
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;			//Exec on client


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Loadout
//
//------------------------------------------------------------------
//------------------------------------------------------------------

sleep 2;
_playerLoadout = player getVariable "loadout";
_loadoutPath = format ["loadouts\%1\%2.sqf", factionVariable, _playerLoadout];
null = [] execVM _loadoutPath;


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					ACE Self Interact Menus
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//Variables needed for following access evaluation. Is more performant when defined once as private Variable.
_playerGrp = group player;
_playerGroupID = groupID group player;
_playerVar = vehicleVarName player;

//Sleep to give server time to initialise Variables
sleep 2;


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Mission Control Center
//
// Makes several Options of the Mission Control Center available
// for all Players of the Group TOC
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//						Zeus Mission Control
//------------------------------------------------------------------

// Creating a Sub Menu Category GR Base with Logo
_mission_control = ["Mission Control","Mission Control","images\Logo.paa",{}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _mission_control] call ace_interact_menu_fnc_addActionToZeus;

_start_mission = ["Missionstart","Missionstart","",{ execVM "scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionstart.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","Mission Control"], _start_mission] call ace_interact_menu_fnc_addActionToZeus;

_mission_succesful = ["End: Mission Accomplished","End: Mission Accomplished","",{ [true] execVM "scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionend.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","Mission Control"], _mission_succesful] call ace_interact_menu_fnc_addActionToZeus;

_to_be_continued = ["End: TO BE CONTINUED","End: TO BE CONTINUED","",{ [false] execVM "scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionend.sqf"; },{true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions","Mission Control"], _to_be_continued] call ace_interact_menu_fnc_addActionToZeus;

//------------------------------------------------------------------
//					Ingame Mission Control
//------------------------------------------------------------------

if (mCC) then {
	if (((mCCAccess findIf {_x == _playerVar} > -1) || (mCCAccess findIf {_x == _playerGroupID} > -1)) && mCC) then {
		// Creating the Admin Control Menu Category GR Base with Logo
		_adminmenu = ["Mission Control Center","Mission Control Center","images\Logo.paa",{}, {true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions"], _adminmenu] call ace_interact_menu_fnc_addActionToClass;
		
		if (mccHeal == "true") then {
			_fullheal = ["Full Heal","Full Heal","a3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa",{[player, cursorObject] call ace_medical_treatment_fnc_fullHeal},{true}] call ace_interact_menu_fnc_createAction;
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _fullheal] call ace_interact_menu_fnc_addActionToClass;
		};

		if (mccStart == "true") then {
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _start_mission] call ace_interact_menu_fnc_addActionToClass;
		};

		if (mccEnd == "true") then {
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _mission_succesful] call ace_interact_menu_fnc_addActionToClass;
		};

		if (mccContinue == "true") then {
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _to_be_continued] call ace_interact_menu_fnc_addActionToClass;
		};
	};
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Base Menu
//
//------------------------------------------------------------------
//------------------------------------------------------------------


//Condition in which radius around the "base"-Object the Base-Menu is available
_conBaseMenu = {player distance2D base < 100 || missionstarted == false};

// Creating a Sub Menu Category Base with Logo
_base_menu = ["Base Menu","Base Menu","images\Logo.paa",{},_conBaseMenu] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions"], _base_menu] call ace_interact_menu_fnc_addActionToClass;

//Add Armory to ACE Menu GR Base
if (allowArmory) then {
	_armory = ["Armory","Armory","a3\ui_f\data\igui\cfg\cursors\iconrearmat_ca.paa",{ execVM armoryPath; },_conBaseMenu] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _armory] call ace_interact_menu_fnc_addActionToClass;
};

//Add Teleport to ACE Base Menu 
_teleport_action = ["Teleporter","Teleporter","a3\modules_f_tacops\data\civilianpresenceunit\icon32_ca.paa",{ _teleportDialog = createDialog "teleportDialog";},_conBaseMenu] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _teleport_action] call ace_interact_menu_fnc_addActionToClass;

//Add Loadout Menu to ACE Base Menu
if (allowLoadouts) then {
	_loadout_action = ["Loadouts","Loadouts","z\ace\addons\nametags\ui\icon_position_ffv.paa",{ _loadoutDialog = createDialog "loadoutDialog";},_conBaseMenu] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _loadout_action] call ace_interact_menu_fnc_addActionToClass;
};

_reset_loadout = ["Reset Loadout","Reset Loadout","a3\modules_f\data\iconrespawn_ca.paa",{ 
	_loadoutPath = format ["loadouts\%1\%2.sqf", factionVariable, player getVariable "loadout"];
	null = [] execVM _loadoutPath;
},_conBaseMenu] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _reset_loadout] call ace_interact_menu_fnc_addActionToClass;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Supply Drop Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (supplyDropFeature) then {

	_supplyDropCon = {
		supplyDropAvailable && supplyDropCount < supplyDropMax && ((supplyDropRoles findIf {_x == vehicleVarName player;} > -1) || (supplyDropRoles findIf {_x == groupID group player;} > -1) || (supplyDropRoles findIf {_x == player getVariable "loadout";} > -1))
	};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Supply Drop (%1 left)",supplyDropMax - supplyDropCount]];
	};
	
	_supplyDropMenu = ["SupplyDrop","Supply Drop","a3\missions_f_oldman\data\img\holdactions\holdaction_box_ca.paa",{}, _supplyDropCon,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _supplyDropMenu] call ace_interact_menu_fnc_addActionToClass;
	
	_supplyDropMap = ["MapPosition","Choose Position on Map","",{ execVM "scripts\UAMTScripts\SupplyDrop\supplyDropRequest.sqf"; },_supplyDropCon] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","SupplyDrop"], _supplyDropMap] call ace_interact_menu_fnc_addActionToClass;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Transport Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
	
if (trpFeature) then {

	_transportMenuCon = {
		(trpRoles findIf {_x == vehicleVarName player;} > -1) || (trpRoles findIf {_x == groupID group player;} > -1) || (trpRoles findIf {_x == player getVariable "loadout";} > -1)
	};

	_transportCallCon = {
		transportAvailable
	};

	_transportLiftOffCon = {
		transportStartOrders
	};
	
	_transportMenu = ["Transport","Transport","\a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",{}, _transportMenuCon] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _transportMenu] call ace_interact_menu_fnc_addActionToClass;
	
	_transportCall1 = ["Call Transport","Call Transport","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",{ execVM "scripts\UAMTScripts\transport\transportRequest.sqf"; },_transportCallCon] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Transport"], _transportCall1] call ace_interact_menu_fnc_addActionToClass;
	
	_transportCall2 = ["Order Transport Take Off","Order Transport Take Off","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",{ execVM "scripts\UAMTScripts\transport\transportTakeOff.sqf"; },_transportLiftOffCon] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Transport"], _transportCall2] call ace_interact_menu_fnc_addActionToClass;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Artillery Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (artiFeature) then {

	_artiCondition = {
		(artiRoles findIf {_x == vehicleVarName player;} > -1) || (artiRoles findIf {_x == groupID group player;} > -1) || (artiRoles findIf {_x == player getVariable "loadout";} > -1)
	};


	// Creating a Sub Menu Category Base with Logo
	_artiMenuItem = ["Artillery","Artillery","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",{call artDialog_fnc_startArtillery;},_artiCondition] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _artiMenuItem] call ace_interact_menu_fnc_addActionToClass;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						CAS Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (casPlaneFeature || casHeloFeature) then {
	_casMenu = ["CAS","CAS","\a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa",{},{casPlaneFeature || casHeloFeature}] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _casMenu] call ace_interact_menu_fnc_addActionToClass;
};

if (casPlaneFeature) then {
	
	_casPlaneCondition = {
		casPlaneAvailable && (casPlaneStrikeCount < casPlaneMaxCount) && ((casPlaneRoles findIf {_x == vehicleVarName player;} > -1) || (casPlaneRoles findIf {_x == groupID group player;} > -1) || (casPlaneRoles findIf {_x == player getVariable "loadout"} > -1))
	};

	_casPlaneName = getText (configFile >> "CfgVehicles" >> casPlaneClass >> "displayName");
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
		
		_params params ["_casPlaneName"];
		//_casPlaneName = getText (configFile >> "CfgVehicles" >> casPlaneClass >> "displayName");
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["%1 (%2 left)",_casPlaneName,casPlaneMaxCount - casPlaneStrikeCount]];
	};

	_casPlaneMenu = [_casPlaneName,_casPlaneName,"\a3\ui_f\data\igui\cfg\simpletasks\types\Plane_ca.paa",{},_casPlaneCondition,{},[_casPlaneName],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS"], _casPlaneMenu] call ace_interact_menu_fnc_addActionToClass;
	
	{
		_weaponName = switch _x do {
			case 0: {"Machinegun"};
			case 1: {"Missilelauncher"};
			case 2: {"Machinegun + Missilelauncher"};
			case 3: {"Bomb"};
		};

		_casPlaneAction = {
			params ["_target", "_player", "_actionParams"];
			_actionParams params ["_weaponType"];
			[_weaponType] execVM "scripts\UAMTScripts\CAS\casPlaneRequest.sqf";
		};
		
		_casPlaneWeaponMenu = [_weaponName,_weaponName,"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",_casPlaneAction,_casPlaneCondition,{},[_x]] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","CAS",_casPlaneName], _casPlaneWeaponMenu] call ace_interact_menu_fnc_addActionToClass;
			
	} forEach casPlaneWeapons;
};

if (casHeloFeature) then {

	_casHeloCondition = {
		casHeloAvailable && (casHeloStrikeCount < casHeloMaxCount) && ((casHeloRoles findIf {_x == vehicleVarName player;} > -1) || (casHeloRoles findIf {_x == groupID group player;} > -1) || (casHeloRoles findIf {_x == player getVariable "loadout"} > -1))
	};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
				
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Helo CAS (%1 left)",casHeloMaxCount - casHeloStrikeCount]];
	};
	
	_casHeliMenu = ["Helicopter","Helicopter","\a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",{},_casHeloCondition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS"], _casHeliMenu] call ace_interact_menu_fnc_addActionToClass;
	
	{
		_casHeloClassName = _x select 0;
		_casHeloCount = _x select 1;

		_casHeloName = getText (configFile >> "CfgVehicles" >> _casHeloClassName >> "displayName");
		
		_casHeloMenuName = (str _casHeloCount) + " " + _casHeloName;

		_casHeloAction = {
			params ["_target", "_player", "_actionParams"];
			_actionParams params ["_casHeloClassName","_casHeloCount"];
			[_casHeloClassName,_casHeloCount] execVM "scripts\UAMTScripts\CAS\casHeloRequest.sqf";
		};
		
		_casHeloMenu = [_casHeloMenuName,_casHeloMenuName,"\a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",_casHeloAction,_casHeloCondition,{},[_casHeloClassName,_casHeloCount]] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","CAS","Helicopter"], _casHeloMenu] call ace_interact_menu_fnc_addActionToClass;
			
	} forEach casHeloArr;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Radio Log
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "radiocodefeature" == "true") then {

	_radioAccess = 0;
	
	if (getMissionConfigValue "EverybodyCanListen" == "true") then {
		_radioAccess = 1;
	};

	if (getMissionConfigValue "EverybodyCanSend" == "true") then {
		_radioAccess = 2;
	};
	
	if ((recipientConfigVariable findIf {_x == _playerLoadout} > -1) || (recipientConfigVariable findIf {_x == _playerGroupID} > -1)) then {
		execVM "scripts\UAMTScripts\RadioCode\RadiocodeJoinChannel.sqf";
		_radioAccess = 2;
	};	
	
	[_radioAccess] execVM "scripts\UAMTScripts\RadioCode\RadiocodeMenu.sqf";
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Supply Point
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (supplyPointFeature) then {
		_createSupplyPoints = format ["%1createSupplyPoints.sqf", supplyPath];
		execVM _createSupplyPoints;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Player Performance
//
//------------------------------------------------------------------
//------------------------------------------------------------------

_camo = 1;
_audib = 1;
_load = 1;
_damage = 1;
_perf = 1;

_unitLevel = getMissionConfigValue "unitLevel";

switch (_unitLevel) do {
	case "default" : {
		_camo = 1;
		_audib = 1;
		_damage = 1;
		_perf = 1;
	};
	case "improved" : {
		_camo = 2;
		_audib = 2;
		_damage = 1;
		_perf = 1.5;
	};
	case "special" : {
		_camo = 2.5;
		_audib = 2.5;
		_damage = 1.3;
		_perf = 1.8;
	};
	case "operator" : {
		_camo = 3;
		_audib = 3;
		_damage = 1.5;
		_perf = 2;
	};
	case "custom" : {
		_camo = getMissionConfigValue "camouflageCnfg";
		_audib = getMissionConfigValue "audibCnfg";
		_damage = getMissionConfigValue "aceDmgCnfg";
		_perf = getMissionConfigValue "acePerfCnfg";
	};
};

player setUnitTrait ["camouflageCoef",_camo,true];
player setUnitTrait ["audibleCoef ",_audib,true];

player setVariable ["ace_medical_damageThreshold", _damage, true];
player setVariable ["ace_advanced_fatigue_performanceFactor", _perf, true];


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Recolor
//
//------------------------------------------------------------------
//------------------------------------------------------------------

switch (colorgGadingVariable) do
{
	case "Night": {
		// Recolor Post-Processing - Night
		PPeffect_colorC = ppEffectCreate ["ColorCorrections",1500];
		PPeffect_colorC ppEffectAdjust [1.04,0.9,-0.00279611,[0.147043,0,0.0476897,-0.34],[1,1,0.94,1.15],[1.39,0.95,-1.34,0]];
		PPeffect_colorC ppEffectEnable true;
		PPeffect_colorC ppEffectCommit 0;		
	};
	case "Desert/Winter": {
		// Recolor Post-Processing - Desert/Winter
		"colorCorrections" ppEffectAdjust 	[1,1,-0.01,[0.0, 0.0, 0.0, 0.0],[1, 0.8, 0.6, 0.6],[0.199, 0.587, 0.114, 0.0]]; 
		"colorCorrections" ppEffectEnable true; 
		"colorCorrections" ppEffectCommit 0; 
		"filmGrain" ppEffectAdjust 	[0.04,1,1,0.1,1,false];      
		"filmGrain" ppEffectEnable true; 		
	};
	case "Winter Day": {
		// Recolor Post-Processing - Winter Day
		"colorCorrections" ppEffectAdjust  [1.1,1.2,-0.01,[0.0, 0.0, 0.0, 0.0],[0.8, 0.8, 1, 0.6],[0.199, 0.587, 0, 0.0]];  
		"colorCorrections" ppEffectEnable true;  
		"colorCorrections" ppEffectCommit 0; 
		"filmGrain" ppEffectAdjust 	[0.04,1,1,0.1,1,false];      
		"filmGrain" ppEffectEnable true;
		"filmGrain" ppEffectCommit 0; 		
	};
	case "African": {
		// Recolor Post-Processing - brownish, bright african
		PPeffect_colorC = ppEffectCreate ["ColorCorrections",1500];
		PPeffect_colorC ppEffectAdjust [1,1,-0.00279611,[0.399248,0.452746,0.307538,0.1042],[1.36009,1,0.320698,0.95],[2.50966,0.263398,3.22694,0]];
		PPeffect_colorC ppEffectEnable true;
		PPeffect_colorC ppEffectCommit 0;		
	};
	case "Jungle Rainy": {
		// Recolor Post-Processing - Jungle Rainy
		PPeffect_colorC = ppEffectCreate ["ColorCorrections",1500]; 
		PPeffect_colorC ppEffectAdjust [1,1,0,[0,1,0.3,0.04],[1,1,1,1],[0.3,0.587,0.114,0]]; 
		PPeffect_colorC ppEffectEnable true; 
		PPeffect_colorC ppEffectCommit 0;
		"filmGrain" ppEffectAdjust  [0.04,1,1,0.1,1,false];
		"filmGrain" ppEffectEnable true;		
	};
	case "Jungle": {
		// Recolor Post-Processing - Jungle
		PPeffect_colorC = ppEffectCreate ["ColorCorrections",1500]; 
		PPeffect_colorC ppEffectAdjust [1,1,0,[0,1,0.1,0.04],[1,1,1,1],[0.3,0.587,0.114,0]]; 
		PPeffect_colorC ppEffectEnable true; 
		PPeffect_colorC ppEffectCommit 0;		
	};
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Foggy Breath
//
// 		Creates little clouds in front of every players face
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "foggybreath" == "true") then {
	_units = if (!isMultiplayer) then {switchableUnits} else {playableUnits};
	{[_x, 0.03] execVM "scripts\UAMTScripts\AmbienceScripts\foggy_breath.sqf"} forEach _units;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Groundfog
//
// Creates clouds of fog slightly above the ground around the 
// Player
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "groundfog" == "true") then {
	_intensity = 0.001;
	_intensityConfig = getMissionConfigValue "groundfogstrength";
	switch (_intensityConfig) do {
		case 1: {_intensity = 0.001};
		case 2: {_intensity = 0.003};
		case 3: {_intensity = 0.005};
		case 4: {_intensity = 0.01};
		case 5: {_intensity = 0.04};
	};
	null = [_intensity] execVM "scripts\UAMTScripts\AmbienceScripts\GroundFog.sqf";
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Sandstorm Effect
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "sandstorm" == "true") then {
	[player, 0.9, 0.5, true] call BIS_fnc_sandstorm;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Mission Specific Items
//
// In this follow Up Script you can add Mission Specific Configs
// This makes Updating the UAMT to a new Version easier.
//
//------------------------------------------------------------------
//------------------------------------------------------------------
execVM "MissionSpecifics\MSInitPlayerLocal.sqf";


//------------------------------------------------------------------
//						Welcome Messages
//------------------------------------------------------------------
titleText ["Preparing Mission...", "BLACK IN", 0.2];


//Blurry Back to Visuals
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [6];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 3;

//You can of course take this out but we would appreciate if you give us a little credit for all the work
["images\Logo.paa",[0.16,0.1,0.6,0.8],10,5,2] spawn BIS_fnc_textTiles;

sleep 10;

if (_welcomemessage != "") then {
	titleText [_welcomemessage, "PLAIN",1,true,true ];
	sleep 10.5;
};

if (mcc) then {
	if ((mCCAccess findIf {_x == _playerVar} > -1) || (mCCAccess findIf {_x == _playerGroupID} > -1)) then {
		if (_MissionControlCenterMessage != "") then {
			titleText [_MissionControlCenterMessage, "PLAIN DOWN",0.8,true,true ];
			sleep 8.5;
		};
	};
};
//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Player Init
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Developer Mode
//
// Deactivates all Intros in the beginning for a "faster" Load In
//
// Should be deactivated when doing a final Mission extract.
//------------------------------------------------------------------
//------------------------------------------------------------------

_devMode = true;

if (!_devMode) then {
	titleText ["Preparing Mission...", "BLACK FADED", 1];
}
else {
	player allowDamage false;
};

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
if (!_devMode) then {
	if (getMissionConfigValue "iJName" != "") then {
		
		[] spawn {
			//Needed for fadeMusic to work
			ace_hearing_disableVolumeUpdate = true;

			//set Music to zero for FadeIn
			0 fadeMusic 0;

			// Debug Play, needed because sometimes Arme has problems starting a Track
			// that is not defined in the Missions CfGMusic.
			playMusic (getMissionConfigValue "iJName");
			sleep 0.1;

			//Playing the OT Track with music
			playMusic [getMissionConfigValue "iJName",getMissionConfigValue "iJStart"];
			(getMissionConfigValue "iJFade") fadeMusic 1;
			
			sleep (getMissionConfigValue "iJFade" + 1);
			ace_hearing_disableVolumeUpdate = false;
		};
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
	if (missionNameSpace getVariable ["missionStarted",false]) then {
		
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
_playerLoadout = player getVariable "loadout";

_loadoutArr = [_playerLoadout] call UAMT_fnc_loadoutCreate;
[player,_loadoutArr] spawn UAMT_fnc_loadoutApply;

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
//						Zeus Debug Menu
//------------------------------------------------------------------
_uamtDebugMenu = ["Debug Menu","Debug Menu","images\Logo.paa",{}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions"], _uamtDebugMenu] call ace_interact_menu_fnc_addActionToZeus;

_uDMsupplyDrop = ["Reset Supply Drop","Reset Supply Drop","a3\missions_f_oldman\data\img\holdactions\holdaction_box_ca.paa",{supplyDropStatus = 0;publicVariable "supplyDropStatus";}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions", "Debug Menu"], _uDMsupplyDrop] call ace_interact_menu_fnc_addActionToZeus;

_uDMarti = ["Reset Artillery","Reset Artillery","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",{artiStatus = 0;publicVariable "artiStatus";}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions", "Debug Menu"], _uDMarti] call ace_interact_menu_fnc_addActionToZeus;

_uDMvls = ["Reset VLS","Reset VLS","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",{vlsStatus = 0;publicVariable "vlsStatus";}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions", "Debug Menu"], _uDMvls] call ace_interact_menu_fnc_addActionToZeus;

_uDMcas = ["Reset CAS","Reset CAS","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",{casStatus = 0;publicVariable "casStatus";}, {true}] call ace_interact_menu_fnc_createAction;
[["ACE_ZeusActions", "Debug Menu"], _uDMcas] call ace_interact_menu_fnc_addActionToZeus;
//------------------------------------------------------------------
//					Ingame Mission Control
//------------------------------------------------------------------

if (getMissionConfigValue "mCC" == "true") then {
	if ((getMissionConfigValue "mccAccess" findIf {_x == _playerVar} > -1) || (getMissionConfigValue "mccAccess" findIf {_x == _playerGroupID} > -1)) then {
		// Creating the Admin Control Menu Category GR Base with Logo
		_adminmenu = ["Mission Control Center","Mission Control Center","images\Logo.paa",{}, {true}] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions"], _adminmenu] call ace_interact_menu_fnc_addActionToClass;
		
		if (getMissionConfigValue "mccHeal" == "true") then {
			_fullheal = ["Full Heal","Full Heal","a3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa",{[player, cursorObject] call ace_medical_treatment_fnc_fullHeal},{true}] call ace_interact_menu_fnc_createAction;
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _fullheal] call ace_interact_menu_fnc_addActionToClass;
		};

		if (getMissionConfigValue "mccStart" == "true") then {
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _start_mission] call ace_interact_menu_fnc_addActionToClass;
		};

		if (getMissionConfigValue "mccEnd" == "true") then {
			[(typeOf player), 1, ["ACE_SelfActions","Mission Control Center"], _mission_succesful] call ace_interact_menu_fnc_addActionToClass;
		};

		if (getMissionConfigValue "mccContinue" == "true") then {
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
if (getMissionConfigValue "allowArmory" == "true") then {
	_armory = ["Armory","Armory","a3\ui_f\data\igui\cfg\cursors\iconrearmat_ca.paa",{call UAMT_fnc_loadoutArsenal},_conBaseMenu] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _armory] call ace_interact_menu_fnc_addActionToClass;
};

//Add Teleport to ACE Base Menu 
_teleport_action = ["Teleporter","Teleporter","a3\modules_f_tacops\data\civilianpresenceunit\icon32_ca.paa",{ _teleportDialog = createDialog "teleportDialog";},_conBaseMenu] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _teleport_action] call ace_interact_menu_fnc_addActionToClass;

//Add Loadout Menu to ACE Base Menu
if (getMissionConfigValue "allowLoadouts" == "true") then {
	_loadout_action = ["Loadouts","Loadouts","z\ace\addons\nametags\ui\icon_position_ffv.paa",{ _loadoutDialog = createDialog "loadoutDialog";},_conBaseMenu] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _loadout_action] call ace_interact_menu_fnc_addActionToClass;
};

_reset_loadout = ["Reset Loadout","Reset Loadout","a3\modules_f\data\iconrespawn_ca.paa",{ 	
	private _loadoutArr = [(player getVariable ["loadout", ""])] call UAMT_fnc_loadoutCreate;
	[player,_loadoutArr] spawn UAMT_fnc_loadoutApply;
},_conBaseMenu] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions","Base Menu"], _reset_loadout] call ace_interact_menu_fnc_addActionToClass;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Supply Drop Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "supplyDropFeature" == "true") then {

	_supplyDropCon = {
		missionNameSpace getVariable ["supplyDropStatus",0] < 4 && (((getMissionConfigValue "supplyDropRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "supplyDropRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "supplyDropRoles") findIf {_x == player getVariable "loadout";} > -1))
	};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["supplyDropStatus",0]) do {
			case 1 : {_status = " (Call in Progress)";};
			case 2 : {_status = " (in Progress)";};
			case 3 : {_status = " (Preparing new Supply Drop)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Supply Drop (%1 left)%2",((getMissionConfigValue "supplyDropMax") - (missionNameSpace getVariable ["supplyDropCount",0])),_status]];
	};
	
	_supplyDropMenu = ["SupplyDrop","Supply Drop","a3\missions_f_oldman\data\img\holdactions\holdaction_box_ca.paa",{ [] spawn sdpDialog_fnc_sdpCreateDialog }, _supplyDropCon,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _supplyDropMenu] call ace_interact_menu_fnc_addActionToClass;
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Transport Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
	
if (getMissionConfigValue "chtFeature" == "true") then {

	// CAS Terminal
	_condition = { (((getMissionConfigValue "chtRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "chtRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "chtRoles") findIf {_x == player getVariable "loadout";} > -1)) };

	
	_chtTerminal = ["Heli Transport","Heli Transport","a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",{[] call chtDialog_fnc_chtCreateDialog;},_condition] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _chtTerminal] call ace_interact_menu_fnc_addActionToClass;
	
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Artillery Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "artiFeature" == "true") then {

	_artiCondition = {
		missionNameSpace getVariable ["artiStatus",4] < 4 && (((getMissionConfigValue "artiRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "artiRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "artiRoles") findIf {_x == player getVariable "loadout";} > -1))
	};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["artiStatus",4]) do {
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Artillery%1",_status]];
	};
	
	// Creating a Sub Menu Category Base with Logo
	_artiMenuItem = ["Artillery","Artillery","\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",{[] call artDialog_fnc_artCreateDialog;},_artiCondition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _artiMenuItem] call ace_interact_menu_fnc_addActionToClass;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						VLS Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "vlsFeature" == "true") then {

	// VLS Terminal
	_condition = { missionNameSpace getVariable ["vlsStatus",4] < 4 && (((getMissionConfigValue "vlsRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "vlsRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "vlsRolesCMDR") findIf {_x == player getVariable "loadout";} > -1)) };

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["vlsStatus",4]) do {
			case 1 : {_status = " (Call in Progress)";};
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["VLS Terminal%1",_status]];
	};
	
	_vlsTerminal = ["VLS Terminal","VLS Terminal","A3\ui_f\data\map\mapcontrol\Stack_CA.paa",{[] spawn vlsDialog_fnc_vlsCreateDialog;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _vlsTerminal] call ace_interact_menu_fnc_addActionToClass;
	
	// Cruise Missile Menu
	_condition = {};
	if (getMissionConfigValue "vlsNeedsLaser" == "true") then {
		if (getMissionConfigValue "vlsAllowDrones" == "true") then {
			_condition = {
							missionNameSpace getVariable ["vlsStatus",4] < 4 &&
								(( (getMissionConfigValue "vlsEquipment") findIf {currentWeapon player ==  _x } > -1 && isLaserOn player ) || ( [player,"GUNNER"] isEqualTo UAVControl getConnectedUAV player && isLaserOn getConnectedUAV player ) )  && 
							(((getMissionConfigValue "vlsRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == player getVariable "loadout";} > -1))
			};		
		}
		else {
			_condition = {
							missionNameSpace getVariable ["vlsStatus",4] < 4 &&
								( (getMissionConfigValue "vlsEquipment") findIf {currentWeapon player ==  _x } > -1 && isLaserOn player ) && 
							(((getMissionConfigValue "vlsRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == player getVariable "loadout";} > -1))
			};		
		};
	}
	else {
		if (getMissionConfigValue "vlsAllowDrones" == "true") then {
			_condition = {
							missionNameSpace getVariable ["vlsStatus",4] < 4 &&
								(( (getMissionConfigValue "vlsEquipment") findIf {currentWeapon player ==  _x } > -1) || ( [player,"GUNNER"] isEqualTo UAVControl getConnectedUAV player && isLaserOn getConnectedUAV player ) )  && 
							(((getMissionConfigValue "vlsRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == player getVariable "loadout";} > -1))
			};		
		}
		else {
			_condition = {
							missionNameSpace getVariable ["vlsStatus",4] < 4 &&
								( (getMissionConfigValue "vlsEquipment") findIf {currentWeapon player ==  _x } > -1) && 
							(((getMissionConfigValue "vlsRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "vlsRoles") findIf {_x == player getVariable "loadout";} > -1))
			};		
		};
	};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["vlsStatus",4]) do {
			case 1 : {_status = " (Call in Progress)";};
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Request VLS Strike%1",_status]];
	};
	
	_vls = ["Request VLS Strike","Request VLS Strike","A3\ui_f\data\map\mapcontrol\Stack_CA.paa",{},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _vls] call ace_interact_menu_fnc_addActionToClass;

	
	// He Missile Entry
	_condition = {missionNameSpace getVariable ["vlsStatus",4] < 4};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["HE Missile (%1 left)",missionNameSpace getVariable ["vlsHERounds",0]]];
	};
	
	_vlsHE = ["HE Missile","HE Missile","A3\ui_f\data\map\markers\military\dot_CA.paa",{[0] spawn UAMTvls_fnc_vlsCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Request VLS Strike"], _vlsHE] call ace_interact_menu_fnc_addActionToClass;
	
	
	// Cluster Missile Entry
	_condition = {missionNameSpace getVariable ["vlsStatus",4] < 4};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Cluster Missile (%1 left)",missionNameSpace getVariable ["vlsClusterRounds",0]]];
	};
	
	_vlsCluster = ["Cluster Missile","Cluster Missile","A3\ui_f\data\map\markers\military\dot_CA.paa",{[1] spawn UAMTvls_fnc_vlsCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","Request VLS Strike"], _vlsCluster] call ace_interact_menu_fnc_addActionToClass;
	
	//Deactivate current UAV Terminals to connect to the vls Turret
	player disableUAVConnectability [(missionNamespace getVariable [(getMissionConfigValue "vlsName"), objNull]), true];
	
	//Add an Eventhandler that disables the connect ability every time the terminal changes (needed for new picked up terminals)
	player addEventHandler ["SlotItemChanged", {
		params ["_unit", "_name", "_slot", "_assigned", "_weapon"];
			if (_slot == 612) then {
				player disableUAVConnectability [(missionNamespace getVariable [(getMissionConfigValue "vlsName"), objNull]), true];
			};
	}];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						CAS Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "casFeature" == "true") then {
	
	// CAS Terminal
	_condition = { missionNameSpace getVariable ["casStatus",4] < 4 && (((getMissionConfigValue "casRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == player getVariable "loadout";} > -1)) };

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["casStatus",4]) do {
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["CAS Terminal%1",_status]];
	};
	
	_casTerminal = ["CAS Terminal","CAS Terminal","a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa",{[] call casDialog_fnc_casCreateDialog;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _casTerminal] call ace_interact_menu_fnc_addActionToClass;	
	
	// CAS Menu  entry
	_condition = {};
	if (getMissionConfigValue "casNeedsLaser" == "true") then {
		if (getMissionConfigValue "casAllowDrones" == "true") then {
			_condition = {
							missionNameSpace getVariable ["casStatus",4] < 4 &&
							(( (getMissionConfigValue "casEquipment") findIf {currentWeapon player ==  _x } > -1 && isLaserOn player ) || ( [player,"GUNNER"] isEqualTo UAVControl getConnectedUAV player && isLaserOn getConnectedUAV player ) )  &&
							(((getMissionConfigValue "casRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == player getVariable "loadout";} > -1))
			};		
		}
		else {
			_condition = {
							missionNameSpace getVariable ["casStatus",4] < 4 &&
							( (getMissionConfigValue "casEquipment") findIf {currentWeapon player ==  _x } > -1 && isLaserOn player ) &&
							(((getMissionConfigValue "casRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == player getVariable "loadout";} > -1))
			};		
		};
	}
	else {
		if (getMissionConfigValue "casAllowDrones" == "true") then {
			_condition = {
							missionNameSpace getVariable ["casStatus",4] < 4 &&
							(( (getMissionConfigValue "casEquipment") findIf {currentWeapon player ==  _x } > -1) || ( [player,"GUNNER"] isEqualTo UAVControl getConnectedUAV player && isLaserOn getConnectedUAV player ) )  &&
							(((getMissionConfigValue "casRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == player getVariable "loadout";} > -1))
			};	
		}
		else {
			_condition = {
							missionNameSpace getVariable ["casStatus",4] < 4 &&
							( (getMissionConfigValue "casEquipment") findIf {currentWeapon player ==  _x } > -1)  &&
							(((getMissionConfigValue "casRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "casRolesCMDR") findIf {_x == player getVariable "loadout";} > -1))
			};		
		};
	};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["casStatus",4]) do {
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Request CAS%1",_status]];
	};
	
	_casStrikeMenu = ["CAS Strike","CAS Strike","a3\Modules_F_Curator\Data\portraitCASGunMissile_ca.paa",{},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _casStrikeMenu] call ace_interact_menu_fnc_addActionToClass;
	
	
	// CAS MG runs
	_condition = {missionNameSpace getVariable ["casStatus",4] < 4};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Machine Gun (%1 left)",(missionNameSpace getVariable ["casMGruns",0])]];
	};
	
	_casMG = ["Machine Gun","Machine Gun","A3\ui_f\data\map\markers\military\dot_CA.paa",{[0] spawn UAMTcas_fnc_casCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS Strike"], _casMG] call ace_interact_menu_fnc_addActionToClass;
	
	
	// CAS missile runs
	_condition = {missionNameSpace getVariable ["casStatus",4] < 4};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Missiles (%1 left)",(missionNameSpace getVariable ["casMisRuns",0])]];
	};
	
	_casMis = ["Missiles","Missiles","A3\ui_f\data\map\markers\military\dot_CA.paa",{[1] spawn UAMTcas_fnc_casCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS Strike"], _casMis] call ace_interact_menu_fnc_addActionToClass;

	
	// CAS Missile + MG runs
	_condition = {missionNameSpace getVariable ["casStatus",4] < 4};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_count = 0;
		if (missionNameSpace getVariable ["casMGruns",0] > missionNameSpace getVariable ["casMisRuns",0]) then {
			_count = missionNameSpace getVariable ["casMisRuns",0];
		}
		else {
			_count = missionNameSpace getVariable ["casMGruns",0];
		};
		
		_actionData set [1, format ["MG + Missiles (%1 left)",_count]];
	};
	
	_casMMG = ["MG + Missiles","MG + Missiles","A3\ui_f\data\map\markers\military\dot_CA.paa",{[3] spawn UAMTcas_fnc_casCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS Strike"], _casMMG] call ace_interact_menu_fnc_addActionToClass;	

	
	// Bomb drops
	_condition = {missionNameSpace getVariable ["casStatus",4] < 4};

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Bomb (%1 left)",(missionNameSpace getVariable ["casBombRuns",0])]];
	};
	
	_casBomb = ["Bomb","Bomb","A3\ui_f\data\map\markers\military\dot_CA.paa",{[3] spawn UAMTcas_fnc_casCall;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions","CAS Strike"], _casBomb] call ace_interact_menu_fnc_addActionToClass;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Helicopter Fire Support Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "hfsFeature" == "true") then {

	// HFS Terminal
	_condition = { missionNameSpace getVariable ["hfsStatus",4] < 4 && (((getMissionConfigValue "hfsRolesCMDR") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "hfsRolesCMDR") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "hfsRolesCMDR") findIf {_x == player getVariable "loadout";} > -1)) };

	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["hfsStatus",4]) do {
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Heli Fire Support Terminal%1",_status]];
	};
	
	_hfsTerminal = ["Heli Fire Support Terminal","Heli Fire Support Terminal","a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",{[] spawn hfsDialog_fnc_hfsCreateDialog;},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _hfsTerminal] call ace_interact_menu_fnc_addActionToClass;
	
	//Heli Fire Support Menu
	_condition = {
		 missionNameSpace getVariable ["hfsStatus",4] < 4 && 
		(((getMissionConfigValue "hfsRoles") findIf {_x == vehicleVarName player;} > -1) || ((getMissionConfigValue "hfsRoles") findIf {_x == groupID group player;} > -1) || ((getMissionConfigValue "hfsRoles") findIf {_x == player getVariable "loadout";} > -1))
	};
	
	_modifierFunc = {
		params ["_target", "_player", "_params", "_actionData"];
			
		// Getting the Status suffix for the Aactionname
		_status = "";
		switch (missionNameSpace getVariable ["hfsStatus",4]) do {
			case 2 : {_status = " (Executing Strike)";};
			case 3 : {_status = " (Preparing new Strike)";};
			default {_status = "";};
		};
		
		// Modify the action - index 1 is the display name, 2 is the icon...
		_actionData set [1, format ["Heli Fire Support%1",_status]];
	};
	
	_hfsMenu = ["Heli Fire Support","Heli Fire Support","a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",{},_condition,{},[],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _hfsMenu] call ace_interact_menu_fnc_addActionToClass;

	{
		_hfsIndex = _forEachindex;
		_hfsClassName = _x select 0;
		_hfsCount = _x select 1;
		_hfsCalls = _x select 2;

		_hfsName = getText (configFile >> "CfgVehicles" >> _hfsClassName >> "displayName");
		
		_hfsMenuName = (str _hfsCount) + " " + _hfsName;

		_condition = {true};

		_modifierFunc = {
			params ["_target", "_player", "_params", "_actionData"];
			_params params ["_hfsIndex","_hfsName"];
			
			// Modify the action - index 1 is the display name, 2 is the icon...
			_actionData set [1, format ["%1 %2 (%3 left)",(((missionNameSpace getVariable ["hfsArray",[]]) select _hfsIndex) select 1),_hfsName,(((missionNameSpace getVariable ["hfsArray",[]]) select _hfsIndex) select 2)]];
		};
		
		_function = {
			params ["_target", "_player", "_params", "_actionData"];
			_params params ["_hfsIndex"];
			
			[_hfsIndex] spawn UAMThfs_fnc_hfsCall;
		};
		
		_hfsMenuEntry = [_hfsMenuName,_hfsMenuName,"\a3\ui_f\data\igui\cfg\simpletasks\types\Heli_ca.paa",_function,_condition,{},[_hfsIndex,_hfsName],"",0,[false, false, false, false, false],_modifierFunc] call ace_interact_menu_fnc_createAction;
		[(typeOf player), 1, ["ACE_SelfActions","Heli Fire Support"], _hfsMenuEntry] call ace_interact_menu_fnc_addActionToClass;
		
		
	}forEach (missionNameSpace getVariable ["hfsArray",[]]);
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
	
	if (((getMissionConfigValue "recipientConfig") findIf {_x == _playerLoadout} > -1) || ((getMissionConfigValue "recipientConfig") findIf {_x == _playerGroupID} > -1)) then {
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
if (getMissionConfigValue "supplyPointFeature" == "true") then {
	_supplyPoints = getMissionConfigValue "supplyPoints";
	[_supplyPoints] call UAMT_fnc_supplyPointInit;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Weapon Proficiency
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "supplyPointFeature" == "true") then {

	player addEventHandler ["WeaponChanged", {
		params ["_object", "_oldWeapon", "_newWeapon", "_oldMode", "_newMode", "_oldMuzzle", "_newMuzzle", "_turretIndex"];
		
		_profWeapons = player getVariable ["profWeapons",[]];
		
		if (_newWeapon in _profWeapons) then {
			ace_common_SwayFactor = getMissionConfigValue "wPSwayPro";
			player setUnitRecoilCoefficient (getMissionConfigValue "wPRecoilPro");
		}
		else {	
			ace_common_SwayFactor = getMissionConfigValue "wPSwayDef";
			player setUnitRecoilCoefficient (getMissionConfigValue "wPRecoilDef");
		};		
	}];
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Random IED Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "rViFFeature" == "true") then {

	{
		_x addEventHandler ["ContainerOpened", {			
			params ["_container", "_unit"];
			if (_container in (missionNameSpace getVariable ["trappedVehicles",[]])) then {
				[_container,getmissionConfigValue "rVifBombType"]remoteExec ["UAMT_fnc_vehicleIEDBlowUp",2];
			};
		}];
	} forEach (missionNameSpace getVariable ["trappedVehicles",[]]);
};

if (getMissionConfigValue "riFFeature" == "true") then {
	player addEventHandler ["InventoryOpened", {
		params ["_unit", "_container"];

		if (_container in (missionNameSpace getVariable ["rifUnits",[]])) then {
			[_container] remoteExec ["UAMT_fnc_iedBlowUp",2];
		};
	}];
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

switch (getMissionConfigValue "colorgrading") do
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
if (!_devMode) then {
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

	if (getMissionConfigValue "welcomeMessage" == "true") then {
		[] call UAMT_fnc_welcomeMessage;
	};
};
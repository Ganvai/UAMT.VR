//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Dynamic Groups
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//DynamicGroups_Function Function needs to be initialized on server and client. Clients can then use action TeamSwitch ("U" by default) to access the Dynamic Groups interface.
["Initialize"] call BIS_fnc_dynamicGroups;			//Exec on Server


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Configuriung UAMT Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//						Debug Variable
//------------------------------------------------------------------
if (getMissionConfigValue "debugOn" == "true") then {
	debugOn = true;
}
else {
	debugOn = true;
};
publicVariable "debugOn";

//------------------------------------------------------------------
//						Mission Started Feature
//------------------------------------------------------------------

if (getMissionConfigValue "missionstartedfeat" == "true") then {
	missionstarted = false;
}
else {
	missionstarted = true;
};

publicVariable "missionstarted";

//------------------------------------------------------------------
//						Mission Control Center
//------------------------------------------------------------------
if (getMissionConfigValue "mCC" == "true") then {
	mCC = true;

	mccAccess = getMissionConfigValue "mccAccess";
	publicVariable "mccAccess";

	mccStart = getMissionConfigValue "mccStart";
	publicVariable "mccStart";

	mccEnd = getMissionConfigValue "mccEnd";
	publicVariable "mccEnd";

	mccContinue = getMissionConfigValue "mccContinue";
	publicVariable "mccContinue";

	mccHeal = getMissionConfigValue "mccHeal";
	publicVariable "mccHeal";
}
else {
	mCC = false;
};
publicVariable "mCC";	

if (getMissionConfigValue "missionstartedfeat" == "true") then {
	missionstarted = false;
}
else {
	missionstarted = true;
};

publicVariable "missionstarted";

//------------------------------------------------------------------
//						Intro Jingle
//------------------------------------------------------------------
iJName = getMissionConfigValue "iJName";
publicVariable "iJName";

iJStart = getMissionConfigValue "iJStart";
publicVariable "iJStart";

iJFade = getMissionConfigValue "iJFade";
publicVariable "iJFade";

//------------------------------------------------------------------
//						Loadouts
//------------------------------------------------------------------
if (getMissionConfigValue "allowLoadouts" == "true") then {
	allowLoadouts = true;
}
else {
	allowLoadouts = false;
};
publicVariable "allowLoadouts";

if (getMissionConfigValue "allowArmory" == "true") then {
	allowArmory = true;
}
else {
	allowArmory = false;
};
publicVariable "allowArmory";


factionVariable = getMissionConfigValue "faction";
publicVariable "factionVariable";

camoVariable = getMissionConfigValue "camo";
publicVariable "camoVariable";

armoryPath = format ["loadouts\%1\armory.sqf", factionVariable];
publicVariable "armoryPath";

supplyPath = format ["loadouts\%1\supplySystem\", factionVariable];
publicVariable "supplyPath";

spawnBoxPath = format ["%1spawnBox.sqf", supplyPath];
publicVariable "spawnBoxPath";

_rolessqf = format ["loadouts\%1\roles.sqf", factionVariable];
execVM _rolessqf;

_faction_equipmentsqf = format ["loadouts\%1\faction_equipment.sqf", factionVariable];
execVM _faction_equipmentsqf;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Insertion Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "insFeature" == "true") then {
	insFeature = true;
	publicVariable "insFeature";
	
	if (getMissionConfigValue "insEnableHALO" == "true") then {
		insEnableHALO = true;
	}
	else {
		insEnableHALO = false;
	};
	publicVariable "insEnableHALO";

	if (getMissionConfigValue "insEnableHeli" == "true") then {
		insEnableHeli = true;
	}
	else {
		insEnableHeli = false;
	};
	publicVariable "insEnableHeli";

	if (getMissionConfigValue "insEnableGroundV" == "true") then {
		insEnableGroundV = true;
	}
	else {
		insEnableGroundV = false;
	};
	publicVariable "insEnableGroundV";
	

	if (getMissionConfigValue "insIntro" == "true") then {
		insIntro = true;
	}
	else {
		insIntro = false;
	};
	publicVariable "insIntro";

	if (getMissionConfigValue "insPrepareTasks" == "true") then {
		insPrepareTasks = true;
	}
	else {
		insPrepareTasks = false;
	};
	publicVariable "insPrepareTasks";
	
	if (getMissionConfigValue "insCustomAudio" == "true") then {
		insCustomAudio = true;
	}
	else {
		insCustomAudio = false;
	};
	publicVariable "insCustomAudio";

	if (getMissionConfigValue "insNoBoC" == "true") then {
		insNoBoC = true;
	}
	else {
		insNoBoC = false;
	};
	publicVariable "insNoBoC";
	
	_TempinsMethodObj = getMissionConfigValue "insMethodObj";
	insMethodObj = missionNamespace getVariable [_TempinsMethodObj, objNull];
	publicVariable "insMethodObj";
	
	_TempinsHALOVeh = getMissionConfigValue "insHALOVeh";
	insHALOVeh = missionNamespace getVariable [_TempinsHALOVeh, objNull];
	publicVariable "insHALOVeh";

	insHALODoors = getMissionConfigValue "insHALODoors";
	publicVariable "insHALODoors";
	
	_TempinsHeloVeh = getMissionConfigValue "insHeloVeh";
	insHeloVeh = [];
	{
		_obj = missionNamespace getVariable [_x, objNull];		
		insHeloVeh pushback _obj;
	} forEach _TempinsHeloVeh;
	publicVariable "insHeloVeh";

	_TempinsCarVeh = getMissionConfigValue "insCarVeh";
	insCarVeh = [];
	{		
		_obj = missionNamespace getVariable [_x, objNull];
		insCarVeh pushback _obj;
	} forEach _TempinsCarVeh;
	publicVariable "insCarVeh";	

	insHeloDoors = getMissionConfigValue "insHeloDoors";
	publicVariable "insHeloDoors";
	
	insHeloLandinPosArr = [];
	publicVariable "insHeloLandinPosArr";
	
	insHeloLandinApprArr = [];
	publicVariable "insHeloLandinApprArr";
	
	insControl = 0;
	publicVariable "insControl";	

	insertionCancel = false;
	publicVariable "insertionCancel";

	insHaloExecute = false;
	publicVariable "insHaloExecute";
	
	[ 
		insMethodObj, 
		"select Insertion", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"_this distance _target < 3 && !missionstarted && insControl == 0", 
		"_caller distance _target < 3 && !missionstarted && insControl == 0", 
		{}, 
		{}, 
		{  
			_insertionDialog = createDialog "insertionDialog";
			insMethodObj say3D "msg_insertion";
		}, 
		{}, 
		[], 
		1, 
		0, 
		false, 
		false 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, insMethodObj];

	[ 
		insMethodObj, 
		"cancel Insertion", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"_this distance _target < 3 && !missionstarted && insControl == 2", 
		"_caller distance _target < 3 && !missionstarted && insControl == 2", 
		{}, 
		{}, 
		{  
			execVM "scripts\UAMTScripts\insertion\insCancel.sqf";
		}, 
		{}, 
		[], 
		1, 
		0, 
		false, 
		false 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, insMethodObj];

	if (getMissionConfigValue "insTimeFeat" == "true") then {
		_TempinsTimeObj = getMissionConfigValue "insTimeObj";
		insTimeObj = missionNamespace getVariable [_TempinsTimeObj, objNull];
		publicVariable "insTimeObj";

		[ 
			insTimeObj, 
			"select Time", 
			"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa", 
			"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa", 
			"_this distance _target < 3 && !missionstarted", 
			"_caller distance _target < 3 && !missionstarted", 
			{}, 
			{}, 
			{  
				_timeDialog = createDialog "timeDialog";
				insTimeObj say3D "msg_time";
			}, 
			{}, 
			[], 
			1, 
			0, 
			false, 
			false 
		] remoteExec ["BIS_fnc_holdActionAdd", 0, insTimeObj];
	};
	
	{
		_x lock true;
		[_x,0]remoteExec ["setFuel"];
	}forEach insHeloVeh;

	{
		_x lock true;
		[_x,0]remoteExec ["setFuel"];
	}forEach insCarVeh;

	insHALOVeh lock true;
	[insHALOVeh,0]remoteExec ["setFuel"];

	//------------------------------------------------------------------
	//------------------------------------------------------------------
	//
	//				Create Insertion System Prepare Tasks
	//
	//------------------------------------------------------------------
	//------------------------------------------------------------------
	if (insPrepareTasks) then {
		private _title = "Prepare for your Mission";
		private _description = "You are a Special Operations Team. That means you can decide about how you want to conduct the Mission. This means, you have to prepare the right way for the mission.<br/><br/>Decide which Roles you need for this Mission in your team, choose an insertion and a time of day when you want to execute the mission.";
		private _waypoint = "";

		[true, "taskInsPrep", [_description, _title, _waypoint], objNull, true] call BIS_fnc_taskCreate;

		if (allowLoadouts) then {
			private _title = "Choose Team Loadouts";
			private _description = "All Teammembers can choose their loadout, depending on what is needed for the Mission.<br/>Use ACE-Selfinteract, go to 'Base Menu' and select 'Loadouts'. There you can see all available Loadouts.";
			private _waypoint = "";

			[true, ["taskInsPrepLoadouts","taskInsPrep"], [_description, _title, _waypoint], objNull, false] call BIS_fnc_taskCreate;
		};

		private _title = "Select Insertion Method";
		private _description = "How do you want to get into the Mission AO. Go to the Flight Control and choose from three Options<br/><br/>1. HALO-Jump<br/>2. Helicopter Insertion<br/>3. Insertion by Cars<br/><br/>The Mission will start when all Team-Members are in the Vehicles.";
		private _waypoint = "";

		[true, ["taskInsPrepMethod","taskInsPrep"], [_description, _title, _waypoint], insMethodObj, false] call BIS_fnc_taskCreate;
		
		if (getMissionConfigValue "insTimeFeat" == "true") then {
			private _title = "Choose Operation Time";
			private _description = "Go to the Time Control and choose the time when you want to conduct the Mission.<br/>While darkness can give advantages over underequiped enemies, it makes the Insertion more dangerous and the enemy can be equiped with IR Equipment too.";
			private _waypoint = "";

			[true, ["taskInsPrepTime","taskInsPrep"], [_description, _title, _waypoint], insTimeObj, false] call BIS_fnc_taskCreate;
		};

	};
}
else {
	insFeature = false;
};
publicVariable "insFeature";


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Support Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//			Audio Config
//------------------------------------------------------------------

if ( getMissionConfigValue "supportMessages" == "true" ) then {
	supportMessages = true;
}
else {
	supportMessages = false;
};
publicVariable "supportMessages";

if ( getMissionConfigValue "supportCustomAudio" == "true" ) then {
	supportCustomAudio = true;
}
else {
	supportCustomAudio = false;
};
publicVariable "supportCustomAudio";

supportControlName = getMissionConfigValue "supportControlName";;
publicVariable "supportControlName";

//------------------------------------------------------------------
// 			Supply Points
//------------------------------------------------------------------

if (getMissionConfigValue "supplyPointFeature" == "true") then {
	supplyPointFeature = true;

	supplyPoints = getMissionConfigValue "supplyPoints";
	
	{
		_obj = missionNamespace getVariable [_x select 0, objNull];
		_x set [0, _obj];
	} forEach supplyPoints;
	
	
	publicVariable "supplyPoints";

}
else {
	supplyPointFeature = false;
};
publicVariable "supplyPointFeature";

//------------------------------------------------------------------
// 			Supply Drops
//------------------------------------------------------------------
if (getMissionConfigValue "supplyDropFeature" == "true") then {
	supplyDropFeature = true;

	supplyDropStatus = getMissionConfigValue "supplyDropStatus";
	publicVariable "supplyDropStatus";
	
	supplyDropRoles = getMissionConfigValue "supplyDropRoles";
	publicVariable "supplyDropRoles";

	supplyDropVehicle = getMissionConfigValue "supplyDropVehicle";
	publicVariable "supplyDropVehicle";

	supplyDropPilot = getMissionConfigValue "supplyDropPilot";
	publicVariable "supplyDropPilot";

	supplyDropDist = getMissionConfigValue "supplyDropDist";
	publicVariable "supplyDropDist";

	supplyDropMax = getMissionConfigValue "supplyDropMax";
	publicVariable "supplyDropMax";

	supplyDropDelay = getMissionConfigValue "supplyDropDelay";
	publicVariable "supplyDropDelay";

	supplyDropDelayPenalty = getMissionConfigValue "supplyDropDelayPenalty";
	publicVariable "supplyDropDelayPenalty";
	
	supplyDropCount = 0;
	publicVariable "supplyDropCount";
	
	if ( getMissionConfigValue "supplyDropDamage" == "true" ) then {
		supplyDropDamage = true;
	}
	else {
		supplyDropDamage = false;
	};
	publicVariable "supplyDropDamage";

}
else {
	supplyDropFeature = false;
};
publicVariable "supplyDropFeature";

//------------------------------------------------------------------
//				Helicopter Transport Feature
//------------------------------------------------------------------
if ( getMissionConfigValue "chtFeature" == "true" ) then {
	chtFeature = true;
	publicVariable "chtFeature";

	if ( getMissionConfigValue "chtAvailable" == "true" ) then {
		missionNameSpace setVariable ["chtAvailable",true,true];
	}
	else {
		missionNameSpace setVariable ["chtAvailable",false,true];
	};
	
	chtClasses = getMissionConfigValue "chtClasses";
	publicVariable "chtClasses";

	chtRoles = getMissionConfigValue "chtRoles";
	publicVariable "chtRoles";

	chtSpawn = getMissionConfigValue "chtSpawn";
	publicVariable "chtSpawn";

	chtDespawn = getMissionConfigValue "chtDespawn";
	publicVariable "chtDespawn";
	
	missionNameSpace setVariable ["chtCount",0,true];
}
else {
	chtFeature = false;
	publicVariable "chtFeature";
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Fire Support Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//					Artillery Feature
//------------------------------------------------------------------

if (getMissionConfigValue "artiFeature" == "true") then {

	artiFeature = true;
	publicVariable "artiFeature";
	
	fullArti = getMissionConfigValue "artillery";
	publicVariable "fullArti";
	
	artiRoles = getMissionConfigValue "artiRoles";
	publicVariable "artiRoles";
	
	artiCooldown = getMissionConfigValue "artiCooldown";
	publicVariable "artiCooldown";

	artiNoFireZones = getMissionConfigValue "artiNoFireZones";
	publicVariable "artiNoFireZones";
	
	// Availability Artillery - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["artiStatus",getMissionConfigValue "artiStatus",true];
	
	missionNameSpace setVariable ["artiStrikeCount",0,true];
};


//------------------------------------------------------------------
//					VSL Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "vlsFeature" == "true" ) then {
	vlsFeature = true;
	publicVariable "vlsFeature";

	vlsName = missionNamespace getVariable [(getMissionConfigValue "vlsName"), objNull];
	publicVariable "vlsName";

	// Availability VLS - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["vlsStatus",getMissionConfigValue "vlsStatus",true];
	
	missionNameSpace setVariable ["vlsHERounds",getMissionConfigValue "vlsHERounds",true];

	missionNameSpace setVariable ["vlsClusterRounds",getMissionConfigValue "vlsClusterRounds",true];

	vlsDelay = getMissionConfigValue "vlsDelay";
	publicVariable "vlsDelay";

	vlsCooldown = getMissionConfigValue "vlsCooldown";
	publicVariable "vlsCooldown";
	
	vlsRoles = getMissionConfigValue "vlsRoles";
	publicVariable "vlsRoles";

	vlsRolesCMDR = getMissionConfigValue "vlsRolesCMDR";
	publicVariable "vlsRolesCMDR";
	
	vlsEquipment = getMissionConfigValue "vlsEquipment";
	publicVariable "vlsEquipment";

	if ( getMissionConfigValue "vlsNeedsLaser" == "true" ) then {
		vlsNeedsLaser = true;
	}
	else {
		vlsNeedsLaser = false;
	};
	publicVariable "vlsNeedsLaser";
	
	if ( getMissionConfigValue "vlsAllowDrones" == "true" ) then {
		vlsAllowDrones = true;
	}
	else {
		vlsAllowDrones = false;
	};
	publicVariable "vlsAllowDrones";
	
	vlsNoFireZones = getMissionConfigValue "vlsNoFireZones";
	publicVariable "vlsNoFireZones";

	vlsMissile = objNull;
	publicVariable "vlsMissile";
	
	//Preparing the VLS Turret
	vlsName setVehicleReceiveRemoteTargets  false;
	vlsName setVehicleRadar 2;
	vlsName disableAI "AUTOTARGET";
	vlsName disableAI "AUTOCOMBAT";
	
	["Item_B_UavTerminal", "init", {},true,[],true] call CBA_fnc_addClassEventHandler;
	
	vlsName lockDriver true;
	vlsName lockTurret [[0],true];
	
	vlsName addEventHandler ["Fired", {
		params [
			"_unit", 
			"_weapon", 
			"_muzzle", 
			"_mode", 
			"_ammo", 
			"_magazine", 
			"_projectile"
		];
		if (isNull _projectile) then {
			_projectile = nearestObject [_unit, _ammo];
		};
		vlsMissile = _projectile;
		publicVariable "vlsMissile";
	}];
}
else {
	vlsFeature = false;
	publicVariable "vlsFeature";
};


//------------------------------------------------------------------
//					CAS Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "casFeature" == "true" ) then {
	casFeature = true;
	publicVariable "casFeature";

	// Availability CAS - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown, 4 = Not available, will not show in Menu
	missionNameSpace setVariable ["casStatus",getMissionConfigValue "casStatus",true];
	
	casClass = getMissionConfigValue "casClass";
	publicVariable "casClass";
	
	missionNameSpace setVariable ["casMGruns",getMissionConfigValue "casMGruns",true];

	missionNameSpace setVariable ["casMisRuns",getMissionConfigValue "casMisRuns",true];

	missionNameSpace setVariable ["casBombRuns",getMissionConfigValue "casBombRuns",true];

	casDelay = getMissionConfigValue "casDelay";
	publicVariable "casDelay";

	casCooldown = getMissionConfigValue "casCooldown";
	publicVariable "casCooldown";

	casPenalty = getMissionConfigValue "casPenalty";
	publicVariable "casPenalty";

	casRoles = getMissionConfigValue "casRoles";
	publicVariable "casRoles";

	casRolesCMDR = getMissionConfigValue "casRolesCMDR";
	publicVariable "casRolesCMDR";
	
	casEquipment = getMissionConfigValue "casEquipment";
	publicVariable "casEquipment";

	if ( getMissionConfigValue "casNeedsLaser" == "true" ) then {
		casNeedsLaser = true;
	}
	else {
		casNeedsLaser = false;
	};
	publicVariable "casNeedsLaser";
	
	if ( getMissionConfigValue "casAllowDrones" == "true" ) then {
		casAllowDrones = true;
	}
	else {
		casAllowDrones = false;
	};
	publicVariable "casAllowDrones";
	
	casNoFireZones = getMissionConfigValue "casNoFireZones";
	publicVariable "casNoFireZones";
}
else {
	casFeature = false;
	publicVariable "casFeature";
};


//------------------------------------------------------------------
//				Helicopter Fire Support Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "hfsFeature" == "true" ) then {
	hfsFeature = true;
	publicVariable "hfsFeature";

	// Availability HFS - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["hfsStatus",getMissionConfigValue "hfsStatus",true];
	
	hfsArray = getMissionConfigValue "hfsArray";
	publicVariable "hfsArray";

	hfsDuration = getMissionConfigValue "hfsDuration";
	publicVariable "hfsDuration";

	hfsDistance = getMissionConfigValue "hfsDistance";
	publicVariable "hfsDistance";

	hfsDelay = getMissionConfigValue "hfsDelay";
	publicVariable "hfsDelay";

	hfsCooldown = getMissionConfigValue "hfsCooldown";
	publicVariable "hfsCooldown";

	hfsPenalty = getMissionConfigValue "hfsPenalty";
	publicVariable "hfsPenalty";

	if ( getMissionConfigValue "hfsRespawn" == "true" ) then {
		hfsRespawn = true;
	}
	else {
		hfsRespawn = false;
	};
	publicVariable "hfsRespawn";
	
	hfsRoles = getMissionConfigValue "hfsRoles";
	publicVariable "hfsRoles";

	hfsRolesCMDR = getMissionConfigValue "hfsRolesCMDR";
	publicVariable "hfsRolesCMDR";
	
	hfsNoFireZones = getMissionConfigValue "hfsNoFireZones";
	publicVariable "hfsNoFireZones";	
}
else {
	hfsFeature = false;
	publicVariable "hfsFeature";
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Radio-Code Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "radioCodeFeature" == "true") then {
	
	radio1 = getMissionConfigValue "radio1M";
	publicVariable "radio1";

	radio2 = getMissionConfigValue "radio2M";
	publicVariable "radio2";

	radio3 = getMissionConfigValue "radio3M";
	publicVariable "radio3";

	radio4 = getMissionConfigValue "radio4M";
	publicVariable "radio4";

	radio5 = getMissionConfigValue "radio5M";
	publicVariable "radio5";

	radio6 = getMissionConfigValue "radio6M";
	publicVariable "radio6";

	radio7 = getMissionConfigValue "radio7M";
	publicVariable "radio7";

	radio8 = getMissionConfigValue "radio8M";
	publicVariable "radio8";

	radio9 = getMissionConfigValue "radio9M";
	publicVariable "radio9";

	radio10 = getMissionConfigValue "radio10M";
	publicVariable "radio10";

	recipientConfigVariable = getMissionConfigValue "recipientConfig";
	publicVariable "recipientConfigVariable";

	recipients = [];
	publicVariable "recipients";
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Ambient Fly By
//
//------------------------------------------------------------------
//------------------------------------------------------------------

colorgGadingVariable = getMissionConfigValue "colorgrading";
publicVariable "colorgGadingVariable";

if (getMissionConfigValue "AFBActivated" == "true") then {
	execVM "scripts\UAMTScripts\AmbienceScripts\AmbientFlyBy.sqf";
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Killed Civ Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "civKillFeature" == "true") then {

	civEscalation1 = getMissionConfigValue "civEscalation1";
	publicVariable "civEscalation1";

	civEscalation2 = getMissionConfigValue "civEscalation2";
	publicVariable "civEscalation2";

	civAbortMission = getMissionConfigValue "civAbortMission";
	publicVariable "civAbortMission";

	civAbortKillCount = getMissionConfigValue "civAbortKillCount";
	publicVariable "civAbortKillCount";
	
	civMessageSender = getMissionConfigValue "civMessageSender";
	publicVariable "civMessageSender";

	civKillcount = 0;
	publicVariable "civKillcount";

	//Adds Eventhandler to every Unit from the Class Civilian_F
	["Civilian_F", "killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		
		if (isPlayer _killer) then {
			
			_id = format ["civscriptid%1",_unit];
			_text = format ["Civilian casualty. Suspected Shooter: %1.", name  _killer];
			
			_mrkr = createMarker [_id,getPosASL _unit];
			_mrkr setMarkerShape "ICON";
			_mrkr setMarkerType "hd_warning";
			_mrkr setMarkerText _text;
			_mrkr setMarkerColor "colorRed";
			_mrkr setMarkerAlpha 0.5;

			civKillcount = civKillCount + 1;
			publicVariable "civKillcount";
			
			[[_killer],"Scripts\UAMTScripts\killedCivs\civKilledMessage.sqf"]remoteExec ["execVM"];
			
			if (civAbortMission == "true") then {
			
				if (civKillcount >= civAbortKillCount) then {	
					"Scripts\UAMTScripts\killedCivs\abortMission.sqf" remoteExec ["execVM",2];
				}
			};

		};
	}] call CBA_fnc_addClassEventHandler;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Load Cargo Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "loadCargoFeature" == "true") then {

	["ReammoBox_F", "init", {

	[(_this select 0 ),	[
		"Load into Vehicle",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			
			_vehiclesArr = nearestObjects [_target, ["Car", "Plane", "Helicopter"], 10];
			_vehicle = _vehiclesArr # 0;

			if (! vehicleCargoEnabled _vehicle ) exitWith {
				hint "Vehicle cannot transport cargo";
			};
			
			_check = _vehicle canVehicleCargo _target;
			
			if (_check isEqualTo [true,true]) then {
				_vehicle setVehicleCargo _target;
			}
			else {
				if (_check select 1) then {
					hint "Vehicle has not enough free space for cargo.";
				}
				else {
					hint "Cargo is to large for this vehicle.";
				};
			};
		},
		nil,
		99,
		true,
		true,
		"",
		"isNull (isVehicleCargo _target) && nearestObjects [_target, ['Car', 'Plane', 'Helicopter'], 10] isNotEqualTo [];",
		5,
		false,
		"",
		""
	]] remoteExec ["addAction",0,true];


	}, true, [], true] call CBA_fnc_addClassEventHandler;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				End Mission when all Players Dead
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "endAllDead" == "true") then {
	_nul = [] spawn {
		if (!isServer or !isMultiplayer) exitWith {};
		private _pass = TRUE;
		while {_pass} do {
			uisleep 1;
			if ( (playableUnits findIf {!(toLowerANSI lifeState _x in ["incapacitated","dead","dead-respawn"])} == -1)||(playableUnits findIf {!(_x getVariable ["ais_unconscious",false])} == -1) ) then {
				uisleep 6;
				_pass = FALSE;

				if ( (playableUnits findIf {!(toLowerANSI lifeState _x in ["incapacitated","dead","dead-respawn"])} == -1)||(playableUnits findIf {!(_x getVariable ["ais_unconscious",false])} == -1) ) exitWith { 
					["end3",false,true,true,true] remoteExec ["BIS_fnc_endMission"];
				};
				_pass = TRUE;
			};  
		};
	};
};


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//							Fortify Tool
//
//				Available Items via Fortify Tool
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//Fortify Items Object, Buildtime
//Buildtime Calculation: (x * 8) + 20, meaning Buildtime "1" is 28 seconds, "2" ist 36, "0.5" is 24 and "-1" is 12 seconds

//Woodland
if isClass (configFile >> "CfgPatches" >> "ace_main") then
{
	if (getMissionConfigValue "FortifyToolCamo" == "wood") then {
		[west, -1, [

		["RoadCone_L_F",-2],
		["PortableHelipadLight_01_red_F",-2],
		
		["RoadBarrier_F",0],
		["Land_PortableLight_double_F",0],
		["Land_Plank_01_4m_F",0],

		["Land_Razorwire_F",1],
		["Land_Plank_01_8m_F",1],
		
		["Land_CzechHedgehog_01_new_F",2],
		
		["Land_SandbagBarricade_01_half_F",3],
		
		["Land_SandbagBarricade_01_F",4],
		["Land_SandbagBarricade_01_hole_F",4],
		["Land_BarGate_F",4],
		
		//Woodland Specific
		["Land_BagFence_01_long_green_F",4],
		["Land_BagFence_01_round_green_F",4],
		
		["Land_BagBunker_01_small_green_F",15],
		
		["CamoNet_BLUFOR_F",5],
		["CamoNet_BLUFOR_open_F",5],
		["CamoNet_BLUFOR_big_F",5],
		
		//This Tent turns into an ACE Medical Facility when build, 
		["Land_MedicalTent_01_NATO_generic_open_F",5]
		]] call acex_fortify_fnc_registerObjects;
	}
	else {
		[west, -1, [

		["RoadCone_L_F",-2],
		["PortableHelipadLight_01_red_F",-2],
		
		["RoadBarrier_F",0],
		["Land_PortableLight_double_F",0],
		["Land_Plank_01_4m_F",0],

		["Land_Razorwire_F",1],
		["Land_Plank_01_8m_F",1],
		
		["Land_CzechHedgehog_01_new_F",2],
		
		["Land_SandbagBarricade_01_half_F",3],
		
		["Land_SandbagBarricade_01_F",4],
		["Land_SandbagBarricade_01_hole_F",4],
		["Land_BarGate_F",4],
		
		//Woodland Specific
		["Land_BagFence_Long_F",4],
		["Land_BagFence_Round_F",4],
		
		["Land_BagBunker_Small_F",15],
		
		["CamoNet_OPFOR_F",5],
		["CamoNet_OPFOR_open_F",5],
		["CamoNet_OPFOR_big_F",5],
		
		["Land_MedicalTent_01_NATO_tropic_generic_open_F",5]
		]] call acex_fortify_fnc_registerObjects;	
	};
	
	// These Eventhandlers transform the Tents of these type into Medical Tents. This is needed for the Tents build by the Fortify Tool to be at least somewhat useful.
	["Land_MedicalTent_01_NATO_generic_open_F", "init", {_this setVariable ["ace_medical_isMedicalFacility", true, true];}, true, [], true] call CBA_fnc_addClassEventHandler;
	["Land_MedicalTent_01_NATO_tropic_generic_open_F", "init", {_this setVariable ["ace_medical_isMedicalFacility", true, true];}, true, [], true] call CBA_fnc_addClassEventHandler;

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
execVM "MissionSpecifics\MSInitServer.sqf";


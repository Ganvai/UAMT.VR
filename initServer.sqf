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
//						Mission Started Feature
//------------------------------------------------------------------

if (getMissionConfigValue "missionstartedfeat" == "true") then {
	missionNameSpace setVariable ["missionStarted",false,true];
}
else {
	missionNameSpace setVariable ["missionStarted",true,true];
};


//------------------------------------------------------------------
//						Loadouts
//------------------------------------------------------------------
if (getMissionConfigValue "supplyPointFeature" == "true") then {
	_createSupplyCrates = format ["loadouts\%1\createSupplyCrates.sqf",getMissionConfigValue "factionPath"];
	execVM _createSupplyCrates;
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Insertion Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "insFeature" == "true") then {
	
	[ 
		missionNameSpace getVariable [(getMissionConfigValue "insMethodObj"),objNull], 
		"select Insertion", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa", 
		"_this distance _target < 3 && !missionstarted", 
		"_caller distance _target < 3 && !missionstarted", 
		{}, 
		{}, 
		{  
			[] call UAMTins_fnc_insDialogCallDialog;
		}, 
		{}, 
		[], 
		1, 
		0, 
		false, 
		false 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, missionNameSpace getVariable [(getMissionConfigValue "insMethodObj"),objNull]];

	
	// Prepare all Insertion Helicopters
	{
		_vehicle = missionNameSpace getVariable [_x,objNull];
		_vehicle lock true;
		[_vehicle,0]remoteExec ["setFuel"];
		
		{
			if (!isPlayer _x) then {
				_x disableAI "AUTOTARGET";
				_x disableAI "TARGET";
				_x disableAI "WEAPONAIM";
				_x disableAI "AUTOCOMBAT";
				_x disableAI "SUPPRESSION";
				_x disableAI "COVER";
			};
		}forEach (crew _vehicle);
	}forEach getMissionConfigValue "insHeloVeh";

	// Prepare Insertion Cars
	{
		_vehicle = missionNameSpace getVariable [_x,objNull];
		_vehicle lock true;
		[_vehicle,0]remoteExec ["setFuel"];
	}forEach getMissionConfigValue "insCarVeh";
	
	// Prepare HALO vehicle
	_haloVeh = missionNameSpace getVariable ["insHALOVeh",objNull];
	_haloVeh lock true;
	{
		if (!isPlayer _x) then {
			_x setCaptive true;
		};
	}forEach (crew _haloVeh);

	_haloVeh allowDamage false;
	[_haloVeh,0]remoteExec ["setFuel"];

	//------------------------------------------------------------------
	//------------------------------------------------------------------
	//
	//				Create Insertion System Prepare Tasks
	//
	//------------------------------------------------------------------
	//------------------------------------------------------------------
	if (getMissionConfigValue "insPrepareTasks" == "true") then {
		private _title = "Prepare for your Mission";
		private _description = "Decide how you want to conduct the Mission. This means, you have to prepare the right way for the mission.<br/><br/>Decide which Roles you need for this Mission in your team, choose an insertion and a time of day when you want to execute the mission.";
		private _waypoint = "";

		[true, "taskInsPrep", [_description, _title, _waypoint], objNull, true] call BIS_fnc_taskCreate;

		if (getMissionConfigValue "allowLoadouts" == "true") then {
			private _title = "Choose Team Loadouts";
			private _description = "All Teammembers can choose their loadout, depending on what is needed for the Mission.<br/>Use ACE-Selfinteract, go to 'Base Menu' and select 'Loadouts'. There you can see all available Loadouts.";
			private _waypoint = "";

			[true, ["taskInsPrepLoadouts","taskInsPrep"], [_description, _title, _waypoint], objNull, false] call BIS_fnc_taskCreate;
		};

		private _title = "Select Insertion Method";
		private _description = "How do you want to get into the Mission AO. Go to the Flight Control and choose from three Options<br/><br/>1. HALO-Jump<br/>2. Helicopter Insertion<br/>3. Insertion by Cars<br/><br/>The Mission will start when all Team-Members are in the Vehicles.";
		private _waypoint = "";

		[true, ["taskInsPrepMethod","taskInsPrep"], [_description, _title, _waypoint], missionNameSpace getVariable [(getMissionConfigValue "insMethodObj"),objNull], false] call BIS_fnc_taskCreate;
		
		if (getMissionConfigValue "insTimeFeat" == "true") then {
			private _title = "Choose Operation Time";
			private _description = "Go to the Time Control and choose the time when you want to conduct the Mission.<br/>While darkness can give advantages over underequiped enemies, it makes the Insertion more dangerous and the enemy can be equiped with IR Equipment too.";
			private _waypoint = "";

			[true, ["taskInsPrepTime","taskInsPrep"], [_description, _title, _waypoint], missionNameSpace getVariable [(getMissionConfigValue "insTimeObj"),objNull], false] call BIS_fnc_taskCreate;
		};

	};
};


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

	// Form Helicopter Array
	_chtClasses = getMissionConfigValue "chtClasses";
	_chtHeliArray = [];
	{
		_chtHeliArray pushback [_x,true];
	} forEach _chtClasses;
	
	missionNameSpace setVariable ["chtHeliArray",_chtHeliArray,true];
	
	chtRoles = getMissionConfigValue "chtRoles";
	publicVariable "chtRoles";

	chtSpawn = getMissionConfigValue "chtSpawn";
	publicVariable "chtSpawn";

	chtDespawn = getMissionConfigValue "chtDespawn";
	publicVariable "chtDespawn";

	chtCivil = getMissionConfigValue "chtCivil";
	publicVariable "chtCivil";

	chtDamage = getMissionConfigValue "chtDamage";
	publicVariable "chtDamage";
	
	missionNameSpace setVariable  ["chtStatus",getMissionConfigValue "chtStatus",true];
	
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
	vlsName setVehicleReceiveRemoteTargets false;
	vlsName setVehicleAmmo 0;
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
		
		missionNameSpace setVariable ["vlsMissile",_projectile,true];
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
//						Ambient Fly By
//
//------------------------------------------------------------------
//------------------------------------------------------------------

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

if (getMissionConfigValue "cFcivil" == "true") then {

	{
		_x addEventHandler ["Killed", {
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
				
				[_killer] remoteExec ["UAMT_fnc_cFCivMessage",2];
			};
		}];
	}forEach units civilian;
};

if (getMissionConfigValue "cFfriendlies" == "true") then {

	_sides = getMissionConfigValue "cFFriendlySides";
	
	if ("west" in _sides) then {
		{
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _killer) then {
					
					_id = format ["cFscriptid%1",_unit];
					_text = format ["Friendly casualty. Suspected Shooter: %1.", name  _killer];
					
					_mrkr = createMarker [_id,getPosASL _unit];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerType "hd_warning";
					_mrkr setMarkerText _text;
					_mrkr setMarkerColor "colorRed";
					_mrkr setMarkerAlpha 0.5;
					
					[_killer] remoteExec ["UAMT_fnc_cFFriendlyMessage",2];
				};
			}];
		}forEach units west;
	};

	if ("east" in _sides) then {
		{
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _killer) then {
					
					_id = format ["cFscriptid%1",_unit];
					_text = format ["Friendly casualty. Suspected Shooter: %1.", name  _killer];
					
					_mrkr = createMarker [_id,getPosASL _unit];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerType "hd_warning";
					_mrkr setMarkerText _text;
					_mrkr setMarkerColor "colorRed";
					_mrkr setMarkerAlpha 0.5;
					
					[_killer] remoteExec ["UAMT_fnc_cFFriendlyMessage",2];
				};
			}];
		}forEach units east;
	};

	if ("independent" in _sides) then {
		{
			_x addEventHandler ["Killed", {
				params ["_unit", "_killer", "_instigator", "_useEffects"];

				if (isPlayer _killer) then {
					
					_id = format ["cFscriptid%1",_unit];
					_text = format ["Friendly casualty. Suspected Shooter: %1.", name  _killer];
					
					_mrkr = createMarker [_id,getPosASL _unit];
					_mrkr setMarkerShape "ICON";
					_mrkr setMarkerType "hd_warning";
					_mrkr setMarkerText _text;
					_mrkr setMarkerColor "colorRed";
					_mrkr setMarkerAlpha 0.5;
					
					[_killer] remoteExec ["UAMT_fnc_cFFriendlyMessage",2];
				};
			}];
		}forEach units independent;
	};
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
//				Random Vehicle IED Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------

if (getMissionConfigValue "rifFeature" == "true") then {
	_rifFactions = getMissionConfigValue "rifFactions";
	_rifChance = getMissionConfigValue "rifChance";
	_rifBombType = getMissionConfigValue "rifBombType";
	
	{
		_vehClass = typeOf _x;
		
		_fac = getText (configFile >> "CfgVehicles" >> _vehClass >> "faction");
		
		if (_fac in _rifFactions) then {

			_rnd = random 1;
			
			if (_rnd < _rifChance) then {
				[_x,_rifBombType] call  UAMT_fnc_vehicleIED;
			}
			else {
				[_x,3] call  UAMT_fnc_vehicleIED;
			};
		}
	}forEach entities "CAR";
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
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
//------------------------------------------------------------------
//
//						Insertion Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "insFeature" == "true") then {
	
	[ 
		missionNameSpace getVariable [(getMissionConfigValue "insMethodObj"),objNull], 
		"Setup/Cancel Insertion", 
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
				if (getMissionConfigValue "paperInterface" == "true") then {
					_display = createDialog ["timeDialogPaper"];
				}
				else {
					_display = createDialog ["timeDialogTablet"];
				};
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
	
	// Prepare all Insertion Helicopters
	{
		_vehicle = missionNameSpace getVariable [_x,objNull];
		_vehicle lock true;
		_vehicle setVariable ["IEDFree",true,true];
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
		_vehicle setVariable ["IEDFree",true,true];
		[_vehicle,0]remoteExec ["setFuel"];
	}forEach getMissionConfigValue "insCarVeh";
	
	// Prepare HALO vehicle
	_haloVeh = missionNameSpace getVariable ["insHALOVeh",objNull];
	_haloVeh lock true;
	_haloVeh setVariable ["IEDFree",true,true];
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
//						Supply Points
//------------------------------------------------------------------
if ( getMissionConfigValue "supplyPointFeature" == "true" ) then {
	_sppArray = getMissionConfigValue "supplyPoints";
	{
		_supplyPoint = missionNameSpace getVariable [(_x select 0),objNull];
		_sppDis = _x select 1;
		_sppDir = _x select 2;

		[ 
			_supplyPoint, 
			"open Supply Point", 
			"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", 
			"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa", 
			"_this distance _target < 6", 
			"_caller distance _target < 6", 
			{}, 
			{}, 
			{	
				params ["_target", "_caller", "_actionId", "_arguments"];
				_arguments params ["_supplyPoint","_sppDis","_sppDir"];
				[_supplyPoint,_sppDis,_sppDir] call sppDialog_fnc_createDialog;
			}, 
			{}, 
			[_supplyPoint,_sppDis,_sppDir], 
			1, 
			9999, 
			false, 
			false 
		] remoteExec ["BIS_fnc_holdActionAdd", 0, _supplyPoint];
	}forEach _sppArray;
};

//------------------------------------------------------------------
//				Supply Drop Feature
//------------------------------------------------------------------
if ( getMissionConfigValue "supplyDropFeature" == "true" ) then {
	missionNameSpace setVariable ["supplyDropStatus",getMissionConfigValue "supplyDropStatus",true];
};

//------------------------------------------------------------------
//				Helicopter Transport Feature
//------------------------------------------------------------------
if ( getMissionConfigValue "chtFeature" == "true" ) then {

	// Form Helicopter Array
	_chtHelis = getMissionConfigValue "chtHelis";
	_chtHeliArray = [];
	{
		_chtHeliArray pushback [_x,true];
	} forEach _chtHelis;
	
	missionNameSpace setVariable ["chtHeliArray",_chtHeliArray,true];
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
	
	missionNameSpace setVariable ["fullArti",(getMissionConfigValue "artillery"),true];
	
	// Availability Artillery - 0 = Available, 1 = In Use (deprecated), 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["artiStatus",getMissionConfigValue "artiStatus",true];
};


//------------------------------------------------------------------
//					VSL Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "vlsFeature" == "true" ) then {

	// Availability VLS - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["vlsStatus",getMissionConfigValue "vlsStatus",true];
	
	missionNameSpace setVariable ["vlsHERounds",getMissionConfigValue "vlsHERounds",true];

	missionNameSpace setVariable ["vlsClusterRounds",getMissionConfigValue "vlsClusterRounds",true];
	
	_vlsName = missionNamespace getVariable [(getMissionConfigValue "vlsName"), objNull];
	//Preparing the VLS Turret
	_vlsName setVehicleReceiveRemoteTargets false;
	_vlsName setVehicleRadar 2;
	_vlsName disableAI "AUTOTARGET";
	_vlsName disableAI "AUTOCOMBAT";
	_vlsName disableAI "FIREWEAPON";
	
	_vlsName lockDriver true;
	_vlsName lockTurret [[0],true];
	
	_vlsName addEventHandler ["Fired", {
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
};

//------------------------------------------------------------------
//					CAS Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "casFeature" == "true" ) then {

	// Availability CAS - 0 = Available, 1 = In Use (deprecated), 2 = In Firemission, 3 = in Cooldown, 4 = Not available, will not show in Menu
	missionNameSpace setVariable ["casStatus",getMissionConfigValue "casStatus",true];
	
	missionNameSpace setVariable ["casMGruns",getMissionConfigValue "casMGruns",true];

	missionNameSpace setVariable ["casMisRuns",getMissionConfigValue "casMisRuns",true];

	missionNameSpace setVariable ["casBombRuns",getMissionConfigValue "casBombRuns",true];
};


//------------------------------------------------------------------
//				Helicopter Fire Support Feature
//------------------------------------------------------------------

if ( getMissionConfigValue "hfsFeature" == "true" ) then {

	// Availability HFS - 0 = Available, 1 = In Use, 2 = In Firemission, 3 = in Cooldown
	missionNameSpace setVariable ["hfsStatus",getMissionConfigValue "hfsStatus",true];
	
	missionNameSpace setVariable ["hfsArray",getMissionConfigValue "hfsArray",true];
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

if (getMissionConfigValue "rVifFeature" == "true") then {

	// Get Mission Config Values
	_rVifFactions = getMissionConfigValue "rVifFactions";
	_rVifChance = getMissionConfigValue "rVifChance";
	_rVifBombType = getMissionConfigValue "rVifBombType";
	
	// Loop over all vehicles of type CAR in the mission
	{
		//get class of CAR
		_vehClass = typeOf _x;
		
		// Get the faction the CAR belongs to
		_fac = getText (configFile >> "CfgVehicles" >> _vehClass >> "faction");
		
		if (_fac in _rVifFactions && !(_x getvariable ["IEDFree",false])) then {
			
			// Get the random value 
			_rnd = random 1;
			
			// Random Value vs configured chance
			if (_rnd < _rVifChance) then {
				[_x,_rVifBombType] call  UAMT_fnc_vehicleIED;
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
//				Random IED Feature
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (getMissionConfigValue "rifFeature" == "true") then {

	_iedFactions = getMissionConfigValue "rifFactions";
	_iedChance = getMissionConfigValue "rifChance";
	
	{
		_vehClass = typeOf _x;
		
		_fac = getText (configFile >> "CfgVehicles" >> _vehClass >> "faction");
		
		if (_fac in _iedFactions && !(_x getvariable ["IEDFree",false])) then {

			_rnd = random 1;
			
			if (_rnd < _iedChance) then {
				[_x] call UAMT_fnc_iedUnit;
			};
		}		
	}forEach entities "CAManBase";
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
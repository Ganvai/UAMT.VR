/*	
	by SmartGun
		
 	Description:	
	get values from CfgFactionEquipment + CfgLoadouts, create Loadout-Array and return it
	
 	Paramameters:	
		_this select 0: unitLoadout	(STRING) -> Name of Loadout; -> "loadout" variable in player init = Loadout Class in CfgLoadouts		
		
	Return values:
		loadout (ARRAY) -> Format is unitLoadoutArray -> https://community.bistudio.com/wiki/Unit_Loadout_Array	
	
	example:
	_loadoutArray = ["rifleman"] call UAMT_fnc_loadoutCreate;
	
*/
params ["_unitLoadOut"]; // DefaultLoadout

// no config for this Role -> use defaultLoadout 
if (!(isClass(missionConfigFile >> "CfgLoadouts" >> _unitLoadOut))) then {
	systemchat format ["Missing Loadout Config for Role: %1 !",_unitLoadOut];
	_unitLoadOut = "DefaultLoadout";	
};

// Array -> item will be selected by random
_helmet = 	selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "helmet", [""]] call BIS_fnc_returnConfigEntry);
_facewear = selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "facewear", [""]] call BIS_fnc_returnConfigEntry);
_uniforms = selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "uniforms", [""]] call BIS_fnc_returnConfigEntry);
_vests = 	selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "vests", [""]] call BIS_fnc_returnConfigEntry);
_backpack = selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "backpack", [""]] call BIS_fnc_returnConfigEntry);

//  Array in format weapon-Array
// [classname, suppressor, pointer, optics, muzzle 1's magazine and ammunition, muzzle 2's magazine and ammunition, bipod]
_primary = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "primary", []] call BIS_fnc_returnConfigEntry;
_handgun = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "handgun", []] call BIS_fnc_returnConfigEntry;
_secondary = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "secondary", []] call BIS_fnc_returnConfigEntry;

// default slotted items 
_map = 		[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "map", ""] call BIS_fnc_returnConfigEntry;
_gps = 		[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "terminal", ""] call BIS_fnc_returnConfigEntry;
_radio = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "radio", ""] call BIS_fnc_returnConfigEntry;
_compass = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "compass", ""] call BIS_fnc_returnConfigEntry;
_watch = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "watch", ""] call BIS_fnc_returnConfigEntry;
_nvgs = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "nvgs", ""] call BIS_fnc_returnConfigEntry;
_binocs = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "binocs", ""] call BIS_fnc_returnConfigEntry;

// inventory containers
_itemsUniform 	= [_unitLoadOut,"itemsUniform",[]] call UAMT_fnc_loadoutGetValue;
_itemsVest 		= [_unitLoadOut,"itemsVest",[]] call UAMT_fnc_loadoutGetValue;
_itemsBackpack 	= [_unitLoadOut,"itemsBackPack",[]] call UAMT_fnc_loadoutGetValue;

// handle backpack
if (_backpack in ["backpack_std","backpack_med","backpack_big"]) then {
	_backpack = selectRandom ([missionConfigFile >> "CfgFactionEquipment" >> _backpack] call BIS_fnc_returnConfigEntry);	
};

// handle NVGs
if (_nvgs != "") then {
	_itemsUniform pushBack [_nvgs,1];
	_nvgs = "";
};

// handle terminal
if (_gps != "") then {
	if (_gps in ["terminal_t1","terminal_t2","terminal_t3"]) then {	
		if (isClass(configFile >> "cfgPatches" >> "cTab")) then {
			_gps = format ["ctab_%1",_gps];		
		};
		_gps = ([missionConfigFile >> "CfgFactionEquipment" >> _gps] call BIS_fnc_returnConfigEntry);
	};
};

// handle SR radios
if (_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
		_radio = ([missionConfigFile >> "CfgFactionEquipment" >> "tfar_radio"] call BIS_fnc_returnConfigEntry);
	};
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		_radio = ([missionConfigFile >> "CfgFactionEquipment" >> "acre_radio"] call BIS_fnc_returnConfigEntry);
	};
};

// handle LR radios
_longrangeAvailable = ([missionConfigFile >> "CfgFactionEquipment" >> "lrAvailable"] call BIS_fnc_returnConfigEntry);
if (_longrangeAvailable > 0) then {
	_lrRoles = ([missionConfigFile >> "CfgFactionEquipment" >> "lrRoles"] call BIS_fnc_returnConfigEntry);
	if (_unitLoadOut in _lrRoles) then {
		// vanilla
		_backpack = ([missionConfigFile >> "CfgFactionEquipment" >> "lrRadio"] call BIS_fnc_returnConfigEntry);
		// TFAR
		if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
			_backpack = ([missionConfigFile >> "CfgFactionEquipment" >> "tfar_lrRadio"] call BIS_fnc_returnConfigEntry);
		};
		// ACRE
		if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {			
			_lrRadio = ([missionConfigFile >> "CfgFactionEquipment" >> "acre_lrRadio"] call BIS_fnc_returnConfigEntry);
			_itemsBackpack pushBack [_lrRadio,1]; // ACRE LR_Radio == Item??
		};
	};
};

// check inventory-container space at this point ??

// https://community.bistudio.com/wiki/Unit_Loadout_Array
_newLoadout = [[	
	_primary,				
	_secondary,
	_handgun,
	[_uniforms, _itemsUniform],
	[_vests, _itemsVest],
	[_backpack, _itemsBackpack],
	_helmet, _facewear, [_binocs, "", "", "", [], [], ""],
	[_map, _gps, _radio, _compass, _watch, _nvgs]
],true];



//------------------------------------------------------------------
// debug stuff below this line -> delete
//------------------------------------------------------------------

//copytoclipboard str _personal;
//systemchat str _ars;

player addAction ["Open Arsenal", {
	_unitLoadOut = player getVariable ["UAMT_unitLoadout", "DefaultLoadout"]; 
	[player, (missionNamespace getVariable format ["UAMT_%1ArsenalArray",_unitLoadOut]), false] call ace_arsenal_fnc_addVirtualItems;
	[player, player, false] call ace_arsenal_fnc_openBox;
}];

_newLoadout;
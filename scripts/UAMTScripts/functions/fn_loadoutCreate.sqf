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

// create inventory-containers
private _uniformArr = [];
private _vestArr 	= [];
private _packArr 	= [];

// inventory item-arrays
private _itemsUniform 	= [];
private _itemsVest 		= [];
private _itemsPack 		= [];

// Array -> item will be selected by random
private _helmet 	= selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "helmet", [""]] call BIS_fnc_returnConfigEntry);
private _facewear 	= selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "facewear", [""]] call BIS_fnc_returnConfigEntry);
private _uniform 	= selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "uniforms", [""]] call BIS_fnc_returnConfigEntry);
private _vest 		= selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "vests", [""]] call BIS_fnc_returnConfigEntry);
private _pack		= selectRandom ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "backpack", [""]] call BIS_fnc_returnConfigEntry);

//  Array in format weapon-Array
// [classname, suppressor, pointer, optics, muzzle 1's magazine and ammunition, muzzle 2's magazine and ammunition, bipod]
private _primary = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "primary", []] call BIS_fnc_returnConfigEntry;
private _handgun = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "handgun", []] call BIS_fnc_returnConfigEntry;
private _secondary = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "secondary", []] call BIS_fnc_returnConfigEntry;

// default slotted items 
private _map = 		[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "map", ""] call BIS_fnc_returnConfigEntry;
private _gps = 		[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "terminal", ""] call BIS_fnc_returnConfigEntry;
private _radio = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "radio", ""] call BIS_fnc_returnConfigEntry;
private _compass = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "compass", ""] call BIS_fnc_returnConfigEntry;
private _watch = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "watch", ""] call BIS_fnc_returnConfigEntry;
private _nvgs = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "nvgs", ""] call BIS_fnc_returnConfigEntry;
private _binocs = 	[missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "binocs", ""] call BIS_fnc_returnConfigEntry;

// handle uniform-container
if (_uniform isEqualType "") then {
	if (_uniform != "") then {
		_itemsUniform = [_unitLoadOut,"itemsUniform",[]] call UAMT_fnc_loadoutGetValue;
		_uniformArr = [_uniform, _itemsUniform];		
	};
};

// handle vest-container
if (_vest isEqualType "") then {
	if (_vest != "") then {
		_itemsVest = [_unitLoadOut,"itemsVest",[]] call UAMT_fnc_loadoutGetValue;
		_vestArr = [_vest, _itemsVest];
	};
};

// handle backpack-container and LR radios
if (_pack isEqualType "") then {

	// check for backpackpacks in CfgFactionEquipment
	if (_pack in ["backpack_std","backpack_med","backpack_big"]) then {
		_pack = selectRandom ([missionConfigFile >> "CfgFactionEquipment", _pack,  [""]] call BIS_fnc_returnConfigEntry);	
	};
	
	// LR radios enabled?
	private _longrangeAvailable = ([missionConfigFile >> "CfgFactionEquipment" >> "lrAvailable"] call BIS_fnc_returnConfigEntry);		
	if (_longrangeAvailable > 0) then {	
		// available for this role?
		private _lrRoles = ([missionConfigFile >> "CfgFactionEquipment" >> "lrRoles"] call BIS_fnc_returnConfigEntry);
		if (_unitLoadOut in _lrRoles) then {			
			// ACRE -> add LR radio item to existing backpack
			if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {			
				private _lrRadio = ([missionConfigFile >> "CfgFactionEquipment" >> "acre_lrRadio"] call BIS_fnc_returnConfigEntry);			
				_itemsPack pushBack [_lrRadio,1]; // ACRE LR_Radio == Item??			
			} else {		
				// Vanilla -> replace existing backpack with radio-backpack
				_pack = ([missionConfigFile >> "CfgFactionEquipment" >> "lrRadio"] call BIS_fnc_returnConfigEntry);		
				// TFAR -> replace existing backpack with radio-backpack
				if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
					_pack = ([missionConfigFile >> "CfgFactionEquipment" >> "tfar_lrRadio"] call BIS_fnc_returnConfigEntry);				
				};				
			};		
		};
	};	
	
	// add Items to pack
	if (_pack != "") then {		
		_itemsPack append ([_unitLoadOut,"itemsBackPack",[]] call UAMT_fnc_loadoutGetValue);
		_packArr = [_pack, _itemsPack];
	} else {
		if (_longrangeAvailable > 0) then {	
			systemchat "[Loadoutsystem] Longrange Radios are enableded but not found in CfgFactionEquipment!";
		};
	};
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

// check inventory-container space at this point ??

// https://community.bistudio.com/wiki/Unit_Loadout_Array
private _newLoadout = [[	
	_primary,				
	_secondary,
	_handgun,
	_uniformArr,
	_vestArr,
	_packArr,
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
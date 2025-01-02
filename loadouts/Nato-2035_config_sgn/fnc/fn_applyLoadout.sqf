// [player] spawn UAMT_fnc_applyLoadout;

params ["_unit","_loadoutArray"];	

/*
// get loadout name from player object
//private _unitLoadOut	= _unit getVariable ["UAMT_unitLoadout", "DefaultLoadout"];	
private _unitLoadOut	= _unit getVariable ["loadout", "DefaultLoadout"];	

// get loadout array from missionnamespace
private _loadoutArray = missionnamespace getVariable format ["UAMT_%1Array", _unitLoadOut];
*/

// apply unitLoadout
_unit setUnitLoadout _loadoutArray;

// apply insignia
private _insignia = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "insignia", [""]] call BIS_fnc_returnConfigEntry;
if ((count _insignia) > 0) then {
	player setVariable ["BIS_fnc_setUnitInsignia_class", nil];	
	[player, selectRandom _insignia] call BIS_fnc_setUnitInsignia;
};

// apply ACE traits
private _ace_isMedic 	= [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isMedic", 0] call BIS_fnc_returnConfigEntry;
private _ace_isEngineer = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isEngineer", 0] call BIS_fnc_returnConfigEntry;
private _ace_isEOD 		= [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isEOD", false] call BIS_fnc_returnConfigEntry;
player setVariable ["ACE_medical_medicClass",_ace_isMedic,true];
player setVariable ["ACE_isEngineer",_ace_isEngineer,true];
player setVariable ["ACE_isEOD",_ace_isEOD,true];

// put weapon on safe && in lowered position
if (isplayer _unit) then {		
	if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {			
		[ACE_player, currentWeapon ACE_player, true] call ace_safemode_fnc_setWeaponSafety;
	};		
	[] spawn { sleep 0.6; player action ["WeaponOnBack", player]; };
};

// ToDo: Abfrage ob arsenal array bereits existiert

// create armory-array for this role
_arsenalVar = format ["UAMT_%1ArsenalArray",_unitLoadOut];

// create array from current loadout
_playerItems = flatten (getUnitLoadout player);
_playerItems = (_playerItems arrayIntersect _playerItems) select {_x isEqualType "" && {_x != ""}};

// get role-specific arsenal-items from config
_arsenalItems = [_unitLoadOut,"arsenal",""] call UAMT_fnc_getCfgValue;

// combine them to one array
{ _playerItems pushBackUnique _x; } forEach _arsenalItems;

// save arsenal-array
missionNamespace setVariable [_arsenalVar, _playerItems];
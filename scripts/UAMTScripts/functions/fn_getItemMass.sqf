//----------------------------------------------------------------
//----------------------------------------------------------------
//
//				Get Item Mass
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//
// Searches all viable Arma  Configs for the class to return
// the weight if the Item. Used for UAMT Supply Points
//
// Attributes:
// _itemClass : <STRING> Classname of Item
//
// Return:
// _mass : <NUMBER> Weight of the given item
//
// Call:
// ["_itemClassName"] call UAMT_fnc_getItemMass
//
//----------------------------------------------------------------
//----------------------------------------------------------------


params ["_itemClass"];

_mass = -1;

if (typeName _itemClass ==  "STRING") then {
	_mass = [configFile >> "CfgMagazines" >> _itemClass, "mass",-1] call BIS_fnc_returnConfigEntry;
	if (_mass > 0) exitWith {_mass;};

	_mass = [configFile >> "CfgWeapons" >> _itemClass >> "ItemInfo", "mass",-1] call BIS_fnc_returnConfigEntry;
	if (_mass > 0) exitWith {_mass;};

	_mass = [configFile >> "CfgWeapons" >> _itemClass >> "WeaponSlotsInfo", "mass",-1] call BIS_fnc_returnConfigEntry;
	if (_mass > 0) exitWith {_mass;};

	_mass = [configFile >> "CfgVehicles" >> _itemClass, "mass",-1] call BIS_fnc_returnConfigEntry;
	if (_mass > 0) exitWith {_mass;};

	_mass = [configFile >> "CfgGlasses" >> _itemClass, "mass",-1] call BIS_fnc_returnConfigEntry;
	if (_mass > 0) exitWith {_mass;};
};

_mass;
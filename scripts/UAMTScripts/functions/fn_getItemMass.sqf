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
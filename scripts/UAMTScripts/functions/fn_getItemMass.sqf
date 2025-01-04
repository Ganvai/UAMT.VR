params ["_itemClass"];

_mass = -1;

_mass = [configFile >> "CfgMagazines" >> _x,"mass"] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith {_mass;};

_mass = [configFile >> "CfgWeapons" >> _x >> "ItemInfo","mass"] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith {_mass;};

_mass = [configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo","mass"] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith {_mass;};

_mass = [configFile >> "CfgVehicles" >> _x,"mass"] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith {_mass;};

_mass = [configFile >> "CfgGlasses" >> _x,"mass"] call BIS_fnc_returnConfigEntry;
if (_mass > 0) exitWith {_mass;};

_mass;
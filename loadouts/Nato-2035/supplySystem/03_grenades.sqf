/* 03 Grenades

Aufruf im Editor mit: null = [this] execVM "loadouts\lima\03_zug_grenades.sqf";

*/

if (! isServer) exitWith {};

_box = _this select 0;

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

{
	_box addMagazineCargoGlobal [_x select 0, _x select 1];
} forEach grenadeCrateArr;
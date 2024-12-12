/* 05 Launcher Light

Aufruf im Editor mit: null = [this] execVM "loadouts\lima\05_zug_launcher_light.sqf";

*/

if (! isServer) exitWith {};

_box = _this select 0;

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

{
	_box addItemCargoGlobal [_x select 0, _x select 1];
} forEach atLightCrateArr;
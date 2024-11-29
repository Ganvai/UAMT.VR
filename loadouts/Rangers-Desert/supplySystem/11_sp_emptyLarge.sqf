/* Grosse Transportkiste für Heli Transport

Aufruf im Editor mit: null = [this] execVM "loadouts\lima\17_sp_emptyLarge.sqf";

*/

if (! isServer) exitWith {};

_box = _this select 0;

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

[_box, 20] call ace_cargo_fnc_setSpace;
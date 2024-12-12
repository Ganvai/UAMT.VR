/* 16 Grenades

Aufruf im Editor mit: null = [this] execVM "loadouts\lima\16_sp_empty.sqf";

*/

if (! isServer) exitWith {};

_box = _this select 0;

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;
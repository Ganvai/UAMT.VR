//----------------------------------------------------------------
//----------------------------------------------------------------
//
//			Spawn Supply Crate
//
// Spawns a Supply crate with the items in the given array
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//
//----------------------------------------------------------------
//----------------------------------------------------------------

if (! isServer) exitWith {};

params ["_boxSpawnObj","_distance","_direction","_boxType","_boxArr"];

_boxPos = _boxSpawnObj getRelPos [_distance,_direction];

_box = _boxType createVehicle _boxPos;
_box setPosATL [_boxPos select 0,_boxPos select 1,(_boxPos select 2) + 1];

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

{
	_box addItemCargoGlobal [_x select 0, _x select 1];
	_box addBackpackCargoGlobal [_x select 0, _x select 1];
} forEach (missionNameSpace getVariable [_boxArr,[]]);

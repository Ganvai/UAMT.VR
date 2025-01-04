if (! isServer) exitWith {};

params ["_box","_itemArray"];

clearWeaponCargoGlobal _box; 
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

{
	_box addItemCargoGlobal [_x select 0, _x select 1];
	_box addBackpackCargoGlobal [_x select 0, _x select 1];
} forEach _itemArray;

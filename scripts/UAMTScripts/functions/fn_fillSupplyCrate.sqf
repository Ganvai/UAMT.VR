//----------------------------------------------------------------
//----------------------------------------------------------------
//
//				Fill Supply Crate
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//
// Gets a created box and the Items to be put in and filles them
// into the box.
//
// Attributes:
// _box : <OBJECT> player who killed the civilian unit
// _itemArray : <ARRAY> Array containing array of format ["itemClass",Amount]
//
// Call:
// [_box, [["itemClass",NUMBER]]] call UAMT_fnc_fillSupplyCrate
//
//----------------------------------------------------------------
//----------------------------------------------------------------

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

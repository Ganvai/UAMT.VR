//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//
//					Door Keypads
//
// This function allows you to create keypads on doors with the help of Tablet Assetts
//
// Place a Rugged Tablet or a "civilian" Tablet next to a door of a building and 
// add the Function in the init Field.
//
// The function will lock any door you have specified until the correct code is given.
//
// Placement of Tablets:
// Rugged Tablet: In Rotation X to 180 and Y to 90
// Tablet : In Rotation Y to 90
//
// Disable simulation and damage in the Editor or init. Does not work with 
// Simple Object or Local Only!
// 
// Be carefull when placing the Tablets! Make sure the user can get close enough 
// to use the hold Action.
// The "civilian" Tablet has the habit of not showing the Hold Action when it is 
// to "deeply" inserted into the Building. Most of the time it needs to "hover" 
// a bit in front of the Building wall. 
//
// Don't place it on a door. The tablet will stay at its position when the door 
// opens and that looks stupid.
//
// You can lock any door of that building. Going in Eden Editor into Special States 
// helps you finding the Door Numbers you want to lock.
//
// Atttributes:
// pad: Object / The Pad the Keypad will work from
// code: String / The Code that will unlock all defined doors
// doors: Array of Numbers / Optional / The Door numbers you want to lock with the Keypad
// objectType: String / Optional / Default "HouseBase" / The object type the function will 
//						search for to lock the doors and attach the keypad function. 
//
// Usage
// -----------------------------------------
// 
// example in initServer.sqf
// [pad_2,"1234",[1,4]] call UAMT_fnc_createKeypad;
//
// When you do this in any script, you have to give the Pad a variable name. 
// See in this example how I only close Door 1 and 4 with the doors array.
//
// -----------------------------------------
//
// example in Init
// [this,"1234"] call UAMT_fnc_createKeypad;
//
// When in the init of a Tablet, use 'this' to give the object. 
// With no door array given, only door 1 will be locked as default
//
// -----------------------------------------
// 
// IMPORTANT TO KNOW:
//
// Please pay attention to the surroundings on the map. There are a lot of
// objects that are inheriting from the Class "HouseBase" even though they are
// definetly not houses (like Street lamps for example). If these objects are closer
// to the keypad than the actual object (the distance is measured from the middle of
// the object, so even when you have a keypad in  the wall of the house, when there
// is a street lamp directly in front, the function will attach to the street lamp.
// Sadly, this will not throw an error. If you have the keypad working but the doors
// of the house are not locked, it is often because there is another object from the
// given objectType closer to the keypad. In this case, try to give the exact class
// of the house so the function will attach to the right object.
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------


if (!isServer) exitWith {};

params ["_pad","_code",["_doors",[1]],["_objectType","HouseBase"]];

_house = nearestObject [_pad,_objectType];

{
	_doorName = format ["bis_disabled_Door_%1",_x];
	_house setVariable [_doorName,1,true];
}forEach _doors;

_pad setObjectTextureGlobal [0,"Dialogs\keypad_locked_CO.paa"];

[ 
	_pad, 
	"open Keypad", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa", 
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa", 
	"_this distance2D _target < 2", 
	"_caller distance2D _target < 2", 
	{}, 
	{},
	{ 
		params ["_target", "_caller", "_actionId", "_arguments"];
		_arguments params ["_pad","_house","_code","_doors"];
		[_pad,_house,_code,_doors,_target,_actionID] call doorKeypad_fnc_keypadInput;
	}, 
	{}, 
	[_pad,_house,_code,_doors], 
	1, 
	100, 
	false, 
	false 
] remoteExec ["BIS_fnc_holdActionAdd",0,_pad];
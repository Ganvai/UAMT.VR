disableSerialization;

// Get all items with fitting roles and config elements
_itemHM = call sppDialog_fnc_getAllItems;

// Create the Supply Point dialog
_groupArr = [];
_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
{
	_groupArr pushBackUnique group _x;
}forEach  allPlayers;

player setVariable ["sppGroups",_groupArr];

_display = createDialog ["sppDialog"];

_ctrlGroupFil = _display displayCtrl 101;
_ctrlGroupFil lbAdd "All Groups";
_ctrlGroupFil lbSetValue [0,999];

{
	_ctrlGroupFil lbAdd (groupID _x);
	_ctrlGroupFil lbSetValue [_forEachIndex + 1,_forEachIndex];
}forEach _groupArr;

_ctrlGroupFil lbSetCurSel 0;


// TODO init KeyboardShortcuts = ARROWLEFT + 1 / SHIFT+ARROWLEFT + 10 / ARROWRIGHT - 1 / SHIFT+ARROWRIGHT - 10

// TODO call sppDialog_fnc_Boxes

// Create Empty Default Box in Background


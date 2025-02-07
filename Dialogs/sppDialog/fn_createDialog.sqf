disableSerialization;

// Get all items with fitting roles and config elements
_itemHM = call sppDialog_fnc_getAllItems;

// Create the Supply Point dialog
_groupArr = [];
_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
{
	_groupArr pushBackUnique group _x;
}forEach  allPlayers;

uiNamespace setVariable ["sppGroups",_groupArr];

_display = createDialog ["sppDialog"];

_ctrlGroupFil = _display displayCtrl 101;
_ctrlGroupFil lbAdd "All Groups";
_ctrlGroupFil lbSetValue [0,999];

{
	_ctrlGroupFil lbAdd (groupID _x);
	_ctrlGroupFil lbSetValue [_forEachIndex + 1,_forEachIndex];
}forEach _groupArr;

_ctrlGroupFil lbSetCurSel 0;

// TODO call sppDialog_fnc_Boxes
_ctrlBox = _display displayCtrl 105;

_boxArray = ["Box_NATO_Ammo_F","Box_NATO_Grenades_F","Box_NATO_Wps_F","Box_NATO_WpsLaunch_F","Box_NATO_WpsSpecial_F","Box_NATO_Support_F","Box_NATO_Equip_F","Box_NATO_Uniforms_F","B_supplyCrate_F","Box_NATO_AmmoVeh_F"];

{
	_index = _ctrlBox lbAdd (getText (configFile >> "CfgVehicles" >> _x >> "displayName"));
	_ctrlBox lbSetData [_index,_x];
	_ctrlBox lbSetPictureColor [_index, [1,1,1,1]];
	_ctrlBox lbSetPictureColor [_index, [1,1,1,1]];
	_ctrlBox lbSetPicture [_index, (getText (configFile >> "CfgVehicles" >> _x >> "editorPreview"))];
}forEach _boxArray;

_ctrlBox lbSetCurSel 0;


// TODO init KeyboardShortcuts = ARROWLEFT + 1 / SHIFT+ARROWLEFT + 10 / ARROWRIGHT - 1 / SHIFT+ARROWRIGHT - 10


// Create Empty Default Box in Background


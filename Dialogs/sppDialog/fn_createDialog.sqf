disableSerialization;

// Get all items with fitting roles and config elements
_itemHM = call sppDialog_fnc_getAllItems;

// Create the Supply Point dialog
_groupArr = [];
_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
{
	_role  = _x getVariable "loadout";

	_group = group _x;
	if (_groupArr select {_group in _x} isNotEqualTo []) then {
		for "_i" from 0 to (count _groupArr) do {
			if (((_groupArr select _i) select 0) == _group) exitWith {
				((_groupArr select _i) select 0) pushback _role;
			};
		};
	}
	else {
		_groupArr pushBackUnique [(group _x),[_role]];
	};
	
}forEach  allPlayers;

_display = createDialog ["sppDialog"];

_ctrlGroupFil = _display displayCtrl 101;
_ctrlGroupFil lbAdd "All Groups";
_ctrlGroupFil lbSetData [0,"all"];

{
	_ctrlGroupFil lbAdd (groupID (_x select 0));
	_ctrlGroupFil lbSetValue [(_forEachIndex + 1),_forEachIndex];
}forEach _groupArr;

_ctrlGroupFil lbSetCurSel 0;

_ctrlRoleFil = _display displayCtrl 102;
_ctrlRoleFil lbAdd "All Roles";
_ctrlRoleFil lbSetData [0,"all"];

{
	_index = _ctrlRoleFil lbAdd (_x select 0);
	_ctrlRoleFil lbSetValue [_index,_forEachIndex];
	_ctrlRoleFil lbSetData [_index,(_x select 1)];
}forEach _allRoles;

_ctrlRoleFil lbSetCurSel 0;

_ctrlArsenalLB = _display displayCtrl 104;

{
	[_ctrlArsenalLB,_y select 0,_y select 1,_y select 2] call sppDialog_fnc_addArsenalItem;
}forEach _itemHM;

lbSort _ctrlArsenalLB;
// TODO init KeyboardShortcuts = ARROWLEFT + 1 / SHIFT+ARROWLEFT + 10 / ARROWRIGHT - 1 / SHIFT+ARROWRIGHT - 10



// TODO call sppDialog_fnc_getAllGroups + fill Combobox

// TODO call sppDialog_fnc_getAllRoles + fill Combobox

// TODO [GrpFilter,RoleFilter,ItemFilter]call sppDialog_fnc_fillList

// TODO call sppDialog_fnc_Boxes

// Create Empty Default Box in Background


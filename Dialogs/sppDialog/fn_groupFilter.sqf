disableSerialization;

_display = findDisplay 99100;

_ctrlRoleFil = _display displayCtrl 102;
_ctrlGroupFil = _display displayCtrl 101;

lbClear _ctrlRoleFil;

_groupArr = player getVariable ["sppGroups",[]];
_rolesArr = [];
_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
_roleNameTag = "All Roles";
_unitRolesArr = [];

if (lbCurSel _ctrlGroupFil != 0) then {
	{
		_unitRolesArr pushBackUnique (_x getVariable "loadout");
	}forEach units (_groupArr select (_ctrlGroupFil lbValue (lbCurSel _ctrlGroupFil)));
	
	{
		if ((_x select 1) in _unitRolesArr) then {
			_rolesArr pushBackUnique _x;
		};
	}forEach _allRoles;
	
	_roleNameTag = "All Group Roles";
}
else {
	_rolesArr = _allRoles;
};


_ctrlRoleFil lbAdd _roleNameTag;
_ctrlRoleFil lbSetData [0,str _rolesArr];

{
	_ctrlRoleFil lbAdd (_x select 0);
	_ctrlRoleFil lbSetData [_forEachIndex + 1,(_x select 1)];
}forEach _rolesArr;

_ctrlRoleFil lbSetCurSel 0;
_groups = [];

{
	_groups pushBackUnique (group _x);
}forEach allPlayers;

_ctrl = displayCtrl 1000;
_ctrl setVariable ["groups", _groups];

{
	_ctrl lbAdd (groupID _x);
	_ctrl lbSetData [_forEachIndex, str _x];
} forEach _groups;

/*
{ 
	_groupID = groupID group _x;
	_allGroupsWithPlayers pushBackUnique _groupID;
} forEach allPlayers;

{
	lbAdd [1000, _x];
	lbSetData [1000, _forEachIndex, _allGroupsWithPlayers select _forEachIndex];	 	
} forEach _allGroupsWithPlayers;
*/
_groups = [];

{
	_groups pushBackUnique (group _x);
}forEach allPlayers;

displayCtrl 1000 setVariable ["groups", _groups];

{
	lbAdd [1000, (groupID _x)];
	lbSetData [1000, _forEachIndex, str _x];
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
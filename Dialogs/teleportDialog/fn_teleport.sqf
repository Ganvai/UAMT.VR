_index = lbCurSel 1000;

// Get the group Variable from String from listbox
_group = displayCtrl 1000 getVariable "groups" select _index;

//Get a unit from the group to teleport to
_target = units _group select 0;

//Check if you are the target
if (_target == player) then {
	if (count (units _group) < 2) then {
		hint "You are the only member of this group. Select another Group";
	}
	else {
		_target = units _group select 1;
	};
};


if (vehicle _target == _target) then {
	_centre = getPos _target;
	_teleportLocation = [];
	_max_distance = 2;
	while { count _teleportLocation < 1 } do
	{
		_teleportLocation = _centre findEmptyPosition [1, _max_distance];
		_max_distance = _max_distance + 2;
	};
	
	player setPos _teleportLocation;
}
else {
	if ((vehicle _target) emptyPositions "cargo"== 0) then
		{hint "No room in vehicle. Wait until your Group dismounted."}
	else {
		player moveincargo vehicle _target;
	};
};
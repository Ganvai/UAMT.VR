//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//
//			Manage Garisson
//
// Function to manage Garrisson Behaviour of groups
//
// Attributes:
// _group: Group to manage <ARRAY of Units>
// _chance: Chance units are handled with doStop in Percent <NUMBER>
//
// [_group,30] call UAMT_fnc_randomHold
//
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
params ["_group","_chance"];

{
	_rnd = random 100;
	
	if (_rnd < _chance) then {
		doStop  _x;
	}
	else {
		_x disableAI "PATH";
	};
}forEach units _group;
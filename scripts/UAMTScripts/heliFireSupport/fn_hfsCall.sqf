params ["_hfsIndex"];

if (((hfsArray select _hfsIndex) select 1 == 0 ) || ((hfsArray select _hfsIndex) select 2 == 0 )) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Helicopters are not available anymore!</t>", "PLAIN", 2, true, true];
};

_firezoneCheck = false;

{	
	_fireZoneCheck = (getPos player) inArea _x;
}forEach hfsNoFireZones;

if (_fireZoneCheck) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Heli Fire Support not allowed in this area!</t>", "PLAIN", 2, true, true];
};

_pos = getPos player;
_dir = (getDir player) + 180;
_side = side player;

[[_pos,_dir,_side, _hfsIndex, true],UAMThfs_fnc_hfsExecute] remoteExec ["spawn",2];
params ["_center",["_minDist",500],["_objectDist",1]];

_center = player;
_pos = [];
_searching = true;
_maxDist = _minDist + 50;
_count = 1;

while {_searching} do {
	_pos = [];

	while {count _pos < 1} do {
		_pos = [_center, _minDist, _maxDist, _objectDist, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	_pos set [2,2];
	_break = false;
	{
		if ((getPos _x distance2D _pos) < _minDist ) exitWith {
			_increase = _minDist - (getPos _x distance2D _pos);
			
			_minDist = _minDist + _increase + 50;
			_maxDist = _maxDist + _increase + 50;
			_break = true;
		};

		if ([objNull,"VIEW"] checkVisibility [eyepos _x, (AGLtoASL _pos)] > 0) exitWith {
			_minDist = _minDist + 100;
			_maxDist = _maxDist + 100;
			_break = true;
		};
	}forEach (allPlayers - entities "HeadlessClient_F");
	
	_count = _count + 1;
	if (!_break) exitWith{_searching = false;_pos set [2,0]};
	if (_count > 200) exitWith{_searching = false;_pos = []};
};

_pos;
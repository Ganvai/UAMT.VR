//----------------------------------------------------------------
//----------------------------------------------------------------
//
//			No Vis Safe Pos
//
// Searches for a Position that is not Visible by any Player and 
// returns it.
//
// Attributes:
// _center : <POS ARRAY or OBJECT> Center where the Safe Pos is searched
// _MinDist : <NUMBER> Default 500 - Minimum Distance to EVERY Player
// _objectDist : <NUMBER> Default 1 - Minimum Size of the Safe Pos
//
// Return: _pos <POS Array AGL> Is [] if no valid position was found
// Call:
// [player,400,1] call UAMT_fnc_noVisSafePos;
//
//----------------------------------------------------------------
//----------------------------------------------------------------
params ["_center",["_minDist",500],["_objectDist",1]];

//Preparing all variables needed
_pos = [];
_searching = true;
_maxDist = _minDist + 50;
_count = 1;

// Searching until a safe Pos was found or 200 loops have been made (debug function to avoid endless running)
while {_searching} do {
	//Resetting _pos if the position was not safe
	_pos = [];

	// Loop until BIS_fnc_findSafePos has found a position
	while {count _pos < 1} do {
		_pos = [_center, _minDist, _maxDist, _objectDist, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	// Setting the Height of the Position to something near Eye Level
	_pos set [2,2];
	
	// Resetting _break variable for the loop
	_break = false;
	
	// Loop to check for every player if the found position is visible to them
	{
		// Checking if the position is not closer than the minimum Distance
		if ((getPos _x distance2D _pos) < _minDist ) exitWith {
			// If the Position is to close to the PLayer increase search radius
			_increase = _minDist - (getPos _x distance2D _pos);
			
			_minDist = _minDist + _increase + 50;
			_maxDist = _maxDist + _increase + 50;
			
			// Set _break to true so the main loop will run again and search for another position
			_break = true;
		};

		// Checking if the Position is visible to a Player
		if ([objNull,"VIEW"] checkVisibility [eyepos _x, (AGLtoASL _pos)] > 0) exitWith {
			// If the Position is visible increase the search radius 
			_minDist = _minDist + 100;
			_maxDist = _maxDist + 100;
			
			// Set _break to true so the main loop will run again and search for another position
			_break = true;
		};
	}forEach (allPlayers - entities "HeadlessClient_F");
	
	// _count + 1 to check how many times the loop has run
	_count = _count + 1;
	
	// If _break was still false (so if the Position was valid)  exit the loop and set the position height to 0
	if (!_break) exitWith{_searching = false;_pos set [2,0]};
	
	// If the loop has been running for 200 times, end this function so the server does not die by an endless loop
	if (_count > 200) exitWith{_searching = false;_pos = []};
};

// Return the found position
_pos;
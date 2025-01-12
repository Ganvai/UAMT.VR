if (!isServer) exitWith {};

params ["_insHeloArray",["_insHeloDoors",[]],["_side",west],["_introSequence","none"],["_uamtMsg","true"],["_uamtAudio","false"]];

_insHeloVeh = [];

{
	_insHeloVeh pushback (_x select 0);
}forEach _insHeloArray;

{
	// Unlock Helos
	_x lock false;
	
	_helo = _x;
	{
		_helo animateDoor [_x,1];
		_helo animate [_x,1];
	} forEach (getMissionConfigValue "insHeloDoors");
} forEach _insHeloVeh;

waitUntil {sleep 1; {vehicle _x in _insHeloVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || missionNameSpace getVariable ["insertionCancel",false]};

// Close helicopter doors
{
	_helo = _x;
	{
		_helo animateDoor [_x,0];
		_helo animate [_x,0];
	} forEach (getMissionConfigValue "insHeloDoors");
} forEach _insHeloVeh;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {};

if (_uamtMsg == "true") then {
	if (_uamtAudio == "true") then {
		["Lift Off, Gentlemen. Fasten your seatbelts.","Pilot","msg_heloLift",_side] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["Lift Off, Gentlemen. Fasten your seatbelts.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg"];
	};
};
		
{
	[_x,_uamtMsg,_uamtAudio,_side]spawn {
		params ["_insHeloArray","_uamtMsg","_uamtAudio","_side"];
		
		// Extract Variables from _insHeloArray
		_helo = _insHeloArray select 0;
		_heloWPs = _insHeloArray select 2;
		_startPos = getPos _helo;
		
		if (count _heloWPs < 1) exitWith {
			sleep 30;
			deleteVehicleCrew _helo;
			deleteVehicle _helo;
		};
		
		// Get the LZ position
		_lzIndex = (count _heloWPs) - 1;
		_tempDestPos = getMarkerPos (_heloWPs select _lzIndex);
		
		_destPos = [];
		_max_distance = 30;
		_heliClass = typeOf _helo;
		while { count _destPos < 1 } do
		{
			_destPos = _tempDestPos findEmptyPosition [20, _max_distance, _heliClass];
			_max_distance = _max_distance + 20;
		};
		
		// Organise Group
		_grpHelo = group _helo;	
		_grpHelo setBehaviour "CARELESS";
		
		// Set Landingpad on LZ position
		
		_lzPad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		_lzPad setPosASL _destPos;
		
		// Give helicopter fuel
		[_helo,1]remoteExec ["setFuel",_helo];
		
		// If there are multiple Waypoints, fly through them
		{
			_wpPos = getMarkerPos _x;
			_wp = _grpHelo addWaypoint [_wpPos , -1];
			
			if (_forEachIndex == _lzIndex) then {
				_wp setWaypointType "LOAD";
				_wp setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
				_wp setWaypointBehaviour "careless";
			}
			else {
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "careless";
			};

		}forEach _heloWPs;		
						
		waitUntil {sleep 1; _helo distance2D _destPos < 100 || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		if (_uamtMsg == "true") then {
			if (_uamtAudio == "true") then {
				["We're closing in on the LZ. Get ready!","Pilot","msg_heloLZ",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
			}
			else {
				["We're closing in on the LZ. Get ready!","Pilot","Radio",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
			};
		};
		
		waitUntil {sleep 0.1; ((velocity  _helo select 2) > -0.2 && (getPosATL _helo select 2) <  1) || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		if (_uamtMsg == "true") then {
			if (_uamtAudio == "true") then {
				["Touchdown. Get out, Gentlemen. Good luck out there!","Pilot","msg_heloTouchdown",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
			}
			else {
				["Touchdown. Get out, Gentlemen. Good luck out there!","Pilot","Radio",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
			};
		};

	
		{
			_helo animateDoor [_x,1];
			_helo animate [_x,1];
		} forEach (getMissionConfigValue "insHeloDoors");	
		
		waitUntil {sleep 1; (crew _helo) findif {isPlayer _x} == -1};
		
		{
			_helo animateDoor [_x,0];
			_helo animate [_x,1];
		} forEach (getMissionConfigValue "insHeloDoors");	
		
		_wp2 = _grpHelo addWaypoint [_startPos, 10];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointStatements ["true", ""];
		_wp2 setWaypointBehaviour "careless";
		
		waitUntil {sleep 1; _helo distance2D _startPos < 100 || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		deleteVehicleCrew _helo;
		deleteVehicle _helo;
	};
	
	sleep 3;
}forEach _insHeloArray;

sleep 3;

if (_introSequence != "none" && _introSequence != "") then {
	_introSequence remoteExec ["execVM",[0, -2] select isDedicated];	
};
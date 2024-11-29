if (!isServer) exitWith {};

params [["_side",west]];

insControl = 2;
publicVariable "insControl";

_customAudio = insCustomAudio;

_heloMarkers = [];
private _title = "Board Helicopter";
private _description = "Board Insertion Helicopter to start the Mission.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], insHeloVeh select 0, true] call BIS_fnc_taskCreate;

for "_i" from 0 to ((count insHeloVeh) - 1) do{

	_markerName = format ["Insertion Helo %1",(_i + 1)];
	_tempMarker = createMarker [_markerName, insHeloVeh select _i];
	_tempMarker setMarkerType "hd_dot";
	_tempMarker setMarkerText _markerName;
	
	_heloMarkers pushback _markerName;
};

{
	_helo = _x;
	{
		_helo animateDoor [_x,1];
		_helo animate [_x,1];
	} forEach insHeloDoors;
	
	_x lock false;
	[_x,1]remoteExec ["setFuel"];
} forEach insHeloVeh;

if (_customAudio) then {
	["Helicopters are standing by and waiting for you.","Pilot","msg_heloReady",_side] remoteExec ["UAMT_fnc_quickMsg",side player];
}
else {
	["Helicopters are standing by and waiting for you.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",side player];
};

waitUntil {sleep 1; {vehicle _x in insHeloVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || insertionCancel};

{
	deleteMarker _x;
} forEach _heloMarkers;


{
	_helo = _x;
	{
		_helo animateDoor [_x,0];
		_helo animate [_x,0];
	} forEach insHeloDoors;
} forEach insHeloVeh;

if (insertionCancel) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;

	insertionCancel = false;
	publicVariable "insertionCancel";
	
	insControl = 0;
	publicVariable "insControl";
	
	{
		deleteMarker _x;
	} forEach insHeloLZs;

	{
		_x lock true;
		[_x,1]remoteExec ["setFuel"];
	}forEach insHeloVeh;	
	
	["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >Helicopter Insertion was cancelled!</t>", "PLAIN", 0.6, true, true]remoteExec ["titletext"];
};

missionstarted = true;
publicVariable "missionstarted";

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

for "_i" from 0 to ((count insHeloVeh) - 1) do {

	sleep 3;
	
	[_i,_customAudio,_side]spawn {
		params ["_index","_customAudio","_side"];
		
		_helo = insHeloVeh select _index;
		_heloDest = insHeloLZs select _index;
		
		_startPos = getPos _helo;
		_destPos = getMarkerPos _heloDest;
		_dir = _startPos getDir _destPos;
		_grpHelo = group _helo;
		
		_grpHelo setBehaviour "CARELESS";
		
		_lzPad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		_lzPad setPosASL _destPos;
		_lzPad setDir _dir;
		
		[_helo,1]remoteExec ["setFuel"];
		
		_wp1 = _grpHelo addWaypoint [_destPos, 10];
		_wp1 setWaypointType "LOAD";
		_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
		_wp1 setWaypointBehaviour "careless";
		
		sleep 5;
		
		if (_customAudio) then {
			["Lift Off, Gentlemen. Fasten your seatbelts.","Pilot","msg_heloLift",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		}
		else {
			["Lift Off, Gentlemen. Fasten your seatbelts.","Pilot","Radio",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		};
		
		waitUntil {sleep 1; _helo distance2D _destPos < 100 || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		if (_customAudio) then {
			["We're closing in on the LZ. Get ready!","Pilot","msg_heloLZ",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		}
		else {
			["We're closing in on the LZ. Get ready!","Pilot","Radio",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		};
		
		waitUntil {sleep 0.1; ((velocity  _helo select 2) > -0.2 && (getPosATL _helo select 2) <  1) || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		if (_customAudio) then {
			["Touchdown. Get out, Gentlemen. Good luck out there!","Pilot","msg_heloTouchdown",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		}
		else {
			["Touchdown. Get out, Gentlemen. Good luck out there!","Pilot","Radio",side _grpHelo] remoteExec ["UAMT_fnc_quickMsg",crew _helo arrayIntersect allPlayers];
		};

	
		{
			_helo animateDoor [_x,1];
			_helo animate [_x,1];
		} forEach insHeloDoors;	
		
		waitUntil {sleep 1; (crew _helo) findif {isPlayer _x} == -1};
		
		{
			_helo animateDoor [_x,0];
			_helo animate [_x,1];
		} forEach insHeloDoors;	
		
		_wp2 = _grpHelo addWaypoint [_startPos, 10];
		_wp2 setWaypointType "LOAD";
		_wp2 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
		_wp2 setWaypointBehaviour "careless";
		
		waitUntil {sleep 1; _helo distance2D _startPos < 100 || !alive _helo};
		
		if (!alive _helo) exitWith{};
		
		deleteVehicleCrew _helo;
		deleteVehicle _helo;
	};
};

sleep 2;

if (insIntro) then {
	_line1 = getMissionConfigValue "introM";
	_line2 = getMissionConfigValue "backgroundM";
	_line3 = getMissionConfigValue "missionM";
	_titleHeader = getMissionConfigValue "titleHeader";
	_title = getMissionConfigValue "title";
	_tickerCountry = getMissionConfigValue "tickerCountry";
	_tickerLocation = getMissionConfigValue "tickerLocation";

	[[_line1, _line2, _line3, _titleHeader, _title, _tickerCountry, _tickerLocation],"scripts\UAMTScripts\insertion\insIntroHelis.sqf"] remoteExec ["execVM",[0, -2] select isDedicated];	
};
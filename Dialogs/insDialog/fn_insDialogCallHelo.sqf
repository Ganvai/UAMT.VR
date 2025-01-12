//Check if every Helicopter has waypoints and give a warning if not.

if (missionNameSpace getVariable ["insertionActual",""] != "") exitWith {
	["An Insertion Method was already setup. All inputs have been ignored.<br/><br/>Coordinate with your Team and avoid multiple Insertion requests!", "Error"] spawn BIS_fnc_guiMessage;
	call UAMTins_fnc_insDialogCloseHelo;
};

_insHeloArray = player getVariable ["insHeloArray",[]];
if ((count _insHeloArray) == 0) exitWith {
	private _result = ["Something went wrong. Please try again.", "Error in Helicopter Insertion Setup?"] call BIS_fnc_guiMessage;
};

_heliNoTicket = [];
{
	if (count (_x select 2) == 0) then {
		_heliNoTicket pushback (_x select 1);
	};
}forEach _insHeloArray;

_result = true;

if (count _heliNoTicket > 0) then {
	
	_result = false;
	
	_heliString = "";
	{
		_heliString = _heliString + _x + "<br/>";
	}forEach _heliNoTicket;
	
	_resultText = format ["There are Insertion helicopters without a landing zone.<br/><br/>Helicopters:<br/>%1<br/>Do you want to continue?",_heliString];
	_result = [_resultText, "Helicopters without LZs?", true, true] call BIS_fnc_guiMessage;
};

if (!_result) exitWith {};

_result = false;
_result = ["You are ordering an insertion via Helicopter. Do you acknowledge?", "Confirm Helicopter Insertion", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};

closeDialog 0;

missionNameSpace setVariable ["insertionActual","Helo",true];

for "_i" from 0 to ((count _insHeloArray) - 1) do {

	{
		_pos = getMarkerPos str _x;
		_markerName = str _x;
		deleteMarkerLocal str _x;
		createMarker [_markerName,_pos];
		
		if (_forEachIndex == ((count (_insHeloArray select 2)) - 1)) then {
			_markerName = format ["Heli %1 - LZ",(_i + 1)];
			_markerName setMarkerText _markerName;
			_markerName setMarkerType "hd_end_noShadow";
		}
		else {
			_markerName setMarkerText _markerName;
			_markerName setMarkerType "hd_dot_noShadow";
		};
	}forEach (_insHeloArray select 2);
};


// Create Task for Players
private _title = "Board Helicopter";
private _description = "Board Insertion Helicopter to start the Mission.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], ((_insHeloArray select 0) select 0), true] call BIS_fnc_taskCreate;


// Create Helo Markers on Map
_heloMarkers = [];

{
	_markerName = format ["Insertion Helo %1",(_forEachIndex + 1)];
	createMarker [_markerName, _x select 0];
	_markerName setMarkerType "hd_dot";
	_markerName setMarkerText _markerName;
	
	_heloMarkers pushback _markerName;
}forEach _insHeloArray;

_introSequence = "none";
if (getMissionConfigValue "insIntro" == "true") then {
	_introSequence = "scripts\UAMTScripts\insertion\insIntroHelis.sqf"
};

// Call Control Function for Insertion on Server in scheduled snvironment
[_insHeloArray,_heloMarkers,side player] remoteExec ["UAMTins_fnc_insDialogHeloControl",2];

// Execute Helo Insertion on Server in scheduled environment
[[_insHeloArray,getMissionConfigValue "insHeloDoors",side player,_introSequence,getMissionConfigValue "supportMessages",getMissionConfigValue "supportControlName",getMissionConfigValue "supportCustomAudio"],"scripts\UAMTScripts\insertion\heloExecute.sqf"] remoteExec ["execVM",2];
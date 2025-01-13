//Check if every Helicopter has waypoints and give a warning if not.

if (missionNameSpace getVariable ["insertionActual",""] != "") exitWith {
	["An Insertion Method was already setup. All inputs have been ignored.<br/><br/>Coordinate with your Team and avoid multiple Insertion requests!", "Error"] spawn BIS_fnc_guiMessage;
	call UAMTins_fnc_insDialogHeloClose;
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
onMapSingleClick "";

missionNameSpace setVariable ["insertionActual","Helicopter",true];

// Make all Markers Global and rename the last WPs to LZ
{
	_wpArray = _x select 2;
	_end = (count _wpArray) - 1;
	_heliNr = _forEachIndex + 1;
	
	{		
		if (_forEachIndex < _end) then {
			_x setMarkerType "hd_dot_noShadow";
		}
		else {
			_markerName = format ["Heli %1 - LZ",_heliNr];
			_x setMarkerText _markerName;
			_x setMarkerType "hd_end_noShadow";
		};		
	}forEach _wpArray;
}forEach _insHeloArray;

// Call Control Function for Insertion on Server in scheduled snvironment
[_insHeloArray,side player] remoteExec ["UAMTins_fnc_insDialogHeloControl",2];
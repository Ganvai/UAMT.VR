if (missionNameSpace getVariable ["insertionActual",""] != "") exitWith {
	["An Insertion Method was already setup. All inputs have been ignored.<br/><br/>Coordinate with your Team and avoid multiple Insertion requests!", "Error"] call BIS_fnc_guiMessage;
	call UAMTins_fnc_insDialogHALOClose;
};

_haloPos = getMarkerPos "insHALOMrk";

if (_haloPos isEqualTo [0,0,0]) exitWith {
	["No Helo Drop position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
_result = ["You are ordering an insertion via HALO. Do you acknowledge?", "Confirm HALO Insertion", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};

_haloDir = getMarkerPos "insHALODirMrk";

[_haloPos,_haloDir,side player]remoteExec ["UAMTins_fnc_insDialogHALOControl",2];

call UAMTins_fnc_insDialogHALOClose;
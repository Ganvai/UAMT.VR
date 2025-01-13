_insMethod = missionNameSpace getVariable "insertionActual";

_msg = format ["You are about to cancel the Insertion by %1. Do you acknowledge?",_insMethod];

_result = false;
_result = [_msg, "Confirm Insertion CANCEL", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};

missionNameSpace setVariable ["insertionCancel",true,true];

missionNameSpace setVariable ["insertionActual","",true];

waitUntil {missionNameSpace getVariable ["insExecuteCancelled",false] && missionNameSpace getVariable ["insControlCancelled",false]};

missionNameSpace setVariable ["insertionCancel",false,true];
missionNameSpace setVariable ["insExecuteCancelled",false,true];
missionNameSpace setVariable ["insControlCancelled",false,true];

closeDialog 0;

_msg = format ["Insertion by %1 was cancelled. Coordinate with your team and setup a new Insertion Method.",_insMethod];
[_msg, "Insertion Cancelled"] call BIS_fnc_guiMessage;


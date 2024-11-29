sleep 0.5;

_result = false;
private _result = ["Do you want to cancel the Insertion and choose a new one?", "Cancel Insertion", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

insertionCancel = true;
publicVariable "insertionCancel";

insControl = 0;
publicVariable "insControl";	
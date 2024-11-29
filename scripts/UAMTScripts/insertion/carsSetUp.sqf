_result = false;
private _result = ["Do you want to insert by Car?", "Insertion", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

closeDialog 0;

[[side player],"scripts\UAMTScripts\insertion\carsExecute.sqf"] remoteExec ["execVM",2];
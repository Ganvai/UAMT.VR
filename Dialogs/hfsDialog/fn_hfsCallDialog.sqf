params ["_heliIndex","_dir"];

_hfsTargetPos = getMarkerPos (player getVariable ["hfsMrkLocal",""]);

if (_hfsTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are sending Helicopter Fire Support to the designated coordinates. Do you confirm?", "Confirm Helicopter Firesupport?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
closeDialog 0;

deleteMarkerLocal (player getVariable ["hfsMrkLocal",""]);
deleteMarkerLocal (player getVariable ["hfsDirMrkLocal",""]);

[_hfsTargetPos,_dir, side player,_heliIndex,true] remoteExec ["UAMThfs_fnc_hfsExecute",2];
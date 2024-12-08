params ["_heliIndex","_dir"];

_hfsTargetPos = getMarkerPos "hfsMrk";

if (_hfsTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are sending Helicopter Fire Support to the designated coordinates. Do you confirm?", "Confirm Helicopter Fire Support?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
closeDialog 0;

[[_hfsTargetPos,_dir, side player,_heliIndex,false],UAMThfs_fnc_hfsExecute] remoteExec ["spawn",2];
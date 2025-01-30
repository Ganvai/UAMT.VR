params ["_ammoIndex"];

_vlsTargetPos = getMarkerPos (player getVariable ["vlsMrkLocal",""]);

if (_vlsTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_firezoneCheck = false;

{	
	_fireZoneCheck = _vlsTargetPos inArea _x;
}forEach getMissionConfigValue "vlsNoFireZones";

if (_fireZoneCheck) exitWith {
	["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
};
	
_result = false;
private _result = ["You are calling a Cruise Missile Strike to the designated coordinates. These Missiles cost $3 million. Do you confirm?", "Confirm VLS Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

[_vlsTargetPos,side player,_ammoIndex,true] remoteExec ["UAMTvls_fnc_vlsExecute",2];

onMapSingleClick "";
closeDialog 0;
deleteMarker (player getVariable ["vlsMrkLocal",""]);

params ["_dir"];

_sdpTargetPos = getMarkerPos "sdpMrk";

if (_sdpTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are calling a Supply Drop to the designated Coordinates. Do you confirm?", "Confirm Supply Drop?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
deleteMarker "sdpMrk";
deleteMarker "sdpDirMrk";
closeDialog 0;

supplyDropCount = supplyDropCount + 1;
publicVariable "supplyDropCount";

[[_sdpTargetPos,_dir, supplyDropVehicle,supplyDropPilot,supplyDropDist,side player,true,[],supplyDropDamage,supportMessages,supportCustomAudio,supportControlName,true],UAMT_fnc_supplyDrop] remoteExec ["spawn",2];
params ["_dir"];

_sdpTargetPos = getMarkerPos "sdpMrk";

if (_sdpTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are calling a Supply Drop to the designated Coordinates. Do you confirm?", "Confirm Supply Drop?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
deleteMarkerLocal "sdpMrk";
deleteMarkerLocal "sdpDirMrk";
closeDialog 0;


_supplyDropCount = missionNameSpace getVariable ["supplyDropCount",0];
missionNameSpace setVariable ["supplyDropCount",(_supplyDropCount + 1),true];

_supplyDropDamage = true;
if ((getmissionConfigValue "supplyDropDamage") == "false") then {
	_supplyDropDamage = false;
};

_uamtAudio = true;
if ((getmissionConfigValue "supportMessages") == "false") then {
	_uamtAudio = false;
};

_uamtCustomAudio = true;
if ((getmissionConfigValue "supportCustomAudio") == "false") then {
	_uamtCustomAudio = false;
};


_supplyDropVehicle = getmissionConfigValue "supplyDropVehicle";

[[_sdpTargetPos,_dir, _supplyDropVehicle,getmissionConfigValue "supplyDropPilot",getmissionConfigValue "supplyDropDist",side player,true,[],_supplyDropDamage,_uamtAudio,_uamtCustomAudio,getmissionConfigValue "supportControlName",true],UAMT_fnc_supplyDrop] remoteExec ["spawn",2];
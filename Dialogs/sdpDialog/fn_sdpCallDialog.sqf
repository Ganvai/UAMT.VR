params ["_dir"];

_supplyDropStatus = missionNameSpace getVariable ["supplyDropStatus",0];

if (_supplyDropStatus > 1) exitWith {
	switch _supplyDropStatus do {
		case 2: {["Supply Drop NOT available. A supply drop is currently in progress.", "Error"] call BIS_fnc_guiMessage;};
		case 3: {["Supply Drop NOT available. A new Supply Drop is currently being prepared.", "Error"] call BIS_fnc_guiMessage;};
		case 4: {["No Supply Drops available.", "Error"] call BIS_fnc_guiMessage;};
	};
};

_sdpTargetPos = getMarkerPos (player getVariable ["sdpMrkLocal",""]);

if (_sdpTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are calling a Supply Drop to the designated Coordinates. Do you confirm?", "Confirm Supply Drop?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
deleteMarkerLocal (player getVariable ["sdpMrkLocal",""]);
deleteMarkerLocal (player getVariable ["sdpDirMrkLocal",""]);
closeDialog 0;


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
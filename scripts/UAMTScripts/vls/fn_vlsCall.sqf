params ["_ammoID"];

if (vlsStatus > 0) exitWith {
	switch vlsStatus do {
		case 1 : {["No VLS Call available. Another Element is currently ordering a VLS Strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["No VLS Call available. VLS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["No VLS Call available. Readying missile array after firemission.", "Error"] call BIS_fnc_guiMessage;};
	};
};

_checkAmmo = false;

if (_ammoID == 0) then {
	if (vlsHERounds > 0) then {
		_checkAmmo = true;
	};
}
else {
	if (vlsClusterRounds > 0) then {
		_checkAmmo = true;
	};
};

if (!_checkAmmo) exitWith {
	["VLS not available. No missiles left.", "Error"] call BIS_fnc_guiMessage;
};

_vlsTargetPos = [];

_target = "";

if ([player,"GUNNER"] isEqualTo UAVControl getConnectedUAV player) then {
	_drone = getConnectedUAV player;
	_target = laserTarget _drone;
}
else {
	_target = laserTarget player;
};


if(isNull _target) then
{
    _vlsTargetPos = screenToWorld [0.5,0.5];
}
else
{
    _vlsTargetPos = getPos _target;
};

_vlsTargetPos set [2,0];

_firezoneCheck = false;

{	
	_fireZoneCheck = _vlsTargetPos inArea _x;
}forEach vlsNoFireZones;

if (_fireZoneCheck) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Coordinates for Cruise Missile Strike are in No Fire Zone!</t>", "PLAIN", 2, true, true];
};

casStatus = 1;
publicVariable "casStatus";

_result = false;
private _result = ["You are calling a Cruise Missile Strike on the Designated coordinates. Do you confirm?", "Confirm vls Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>vls Strike was cancelled</t>", "PLAIN", 2, true, true];
	casStatus = 0;
	publicVariable "casStatus";
};

[[_vlsTargetPos, side player,_ammoID],UAMTvls_fnc_vlsExecute] remoteExec ["spawn",2];
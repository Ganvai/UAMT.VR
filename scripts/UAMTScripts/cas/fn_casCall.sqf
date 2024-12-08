params ["_runID"];

_casTargetPos = [];

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
    _casTargetPos = screenToWorld [0.5,0.5];
}
else
{
    _casTargetPos = getPos _target;
};

_casTargetPos set [2,0];

_firezoneCheck = false;

{	
	_fireZoneCheck = _casTargetPos inArea _x;
}forEach casNoFireZones;

if (_fireZoneCheck) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>Coordinates for CAS are in No Fire Zone!</t>", "PLAIN", 2, true, true];
};

_runName = "Machine Gun";

switch _runID do {
	case 1 : {_runName = "Missiles";};
	case 2 : {_runName = "Machine Gun and Missiles";};
	case 3 : {_runName = "Bomb drop";};
};
_resultText = format ["You are calling a CAS Strike on the designated coordinates with %1. Do you confirm?",_runName];

_result = false;
private _result = [_resultText, "Confirm CAS Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>CAS Strike was cancelled</t>", "PLAIN", 2, true, true];
};

_dir = getDir player;

[[_casTargetPos,_dir, side player,_runID],UAMTcas_fnc_casExecute] remoteExec ["spawn",2];
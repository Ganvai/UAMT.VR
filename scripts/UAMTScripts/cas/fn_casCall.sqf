params ["_runID"];

if (casStatus > 0) exitWith {
	switch casStatus do {
		case 1 : {["CAS not available. Another Element is currently requesting a CAS Strike", "Error"] call BIS_fnc_guiMessage;};
		case 2 : {["CAS not available. CAS strike in progress", "Error"] call BIS_fnc_guiMessage;};
		case 3 : {["CAS not available. Rerouting plane for new strike.", "Error"] call BIS_fnc_guiMessage;};
	};
};

_exit = false;
switch _runID do {
	case 0 : {if (casMGruns <= 0) then {_exit = true;};};
	case 1 : {if (casMisRuns <= 0) then {_exit = true;};};
	case 2 : {if (casMGruns <= 0 || casMisRuns <= 0) then {_exit = true;};};
	case 3 : {if (casBombRuns <= 0) then {_exit = true;};};
};

if (_exit) exitWith {
	["CAS not possible. No ammo left for this strike.", "Error"] call BIS_fnc_guiMessage;
};


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

missionNameSpace setVariable ["casStatus",1,true];

_result = false;
private _result = [_resultText, "Confirm CAS Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	missionNameSpace setVariable ["casStatus",0,true];
};

_dir = getDir player;

[[_casTargetPos,_dir, side player,_runID],UAMTcas_fnc_casExecute] remoteExec ["spawn",2];
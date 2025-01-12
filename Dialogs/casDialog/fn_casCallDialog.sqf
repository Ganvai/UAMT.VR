params ["_weaponID","_dir"];

if (missionNameSpace getVariable ["casStatus",0] >= 2) exitWith{
	["A CAS Strike is currently in progress. Wait until CAS is available again.", "Error"] call BIS_fnc_guiMessage;
};


_casTargetPos = getMarkerPos "casStrikeMrk";

if (_weaponID == -1) exitWith{
	["No Weapons selected", "Error"] call BIS_fnc_guiMessage;
};

if (_casTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] call BIS_fnc_guiMessage;
};

_firezoneCheck = false;

{	
	_fireZoneCheck = _casTargetPos inArea _x;
}forEach casNoFireZones;

if (_fireZoneCheck) exitWith {
	["Target is in No Fire Zone!", "Error"] call BIS_fnc_guiMessage;
};
	
_runName = "Machine Gun";
_ammo = 1;

switch _weaponID do {
	case 0 : {_runName = "Machine Gun";_ammo = casMGruns;};
	case 1 : {_runName = "Missiles";_ammo = casMisRuns;};
	case 2 : {_runName = "Machine Gun and Missiles";if (casMGruns == 0 || casMisRuns == 0) then {_ammo = 0};};
	case 3 : {_runName = "Bomb drop";_ammo = casBombRuns;};
};

if (_ammo == 0) exitWith {
	["Out of Ammo", "Error"] call BIS_fnc_guiMessage;
};

_resultText = format ["You are calling a CAS Strike on the designated coordinates with %1. Do you acknowledge?",_runName];

_result = false;
private _result = [_resultText, "Confirm CAS Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
closeDialog 0;
deleteMarkerLocal "casStrikeMrk";
deleteMarkerLocal "casDirMrk";

[[_casTargetPos,_dir, side player,_weaponID,true],UAMTcas_fnc_casExecute] remoteExec ["spawn",2];
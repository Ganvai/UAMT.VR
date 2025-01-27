params ["_weaponID","_dir"];

if (missionNameSpace getVariable ["casStatus",0] >= 2) exitWith{
	["A CAS Strike is currently in progress. Wait until CAS is available again.", "Error"] spawn BIS_fnc_guiMessage;
};


_casTargetPos = getMarkerPos (player getVariable ["casStrikeMrkLocal",""]);

if (_weaponID == -1) exitWith{
	["No Weapons selected", "Error"] spawn BIS_fnc_guiMessage;
};

if (_casTargetPos isEqualTo [0,0,0]) exitWith{
	["No Target position set!", "Error"] spawn BIS_fnc_guiMessage;
};

_firezoneCheck = false;

{	
	_fireZoneCheck = _casTargetPos inArea _x;
}forEach getMissionConfigValue "casNoFireZones";

if (_fireZoneCheck) exitWith {
	["Target is in No Fire Zone!", "Error"] spawn BIS_fnc_guiMessage;
};
	
_runName = "Machine Gun";
_ammo = 1;

switch _weaponID do {
	case 0 : {_runName = "Machine Gun";_ammo = missionNameSpace getVariable ["casMGruns",0];};
	case 1 : {_runName = "Missiles";_ammo = missionNameSpace getVariable ["casMisRuns",0];};
	case 2 : {_runName = "Machine Gun and Missiles";if (missionNameSpace getVariable ["casMGruns",0] == 0 || missionNameSpace getVariable ["casMisRuns",0] == 0) then {_ammo = 0};};
	case 3 : {_runName = "Bomb drop";_ammo = missionNameSpace getVariable ["casBombRuns",0];};
};

if (_ammo == 0) exitWith {
	["Out of Ammo", "Error"] spawn BIS_fnc_guiMessage;
};

_resultText = format ["You are calling a CAS Strike on the designated coordinates with %1. Do you acknowledge?",_runName];

_result = false;
private _result = [_resultText, "Confirm CAS Firemission?", true, true] spawn BIS_fnc_guiMessage;

if (!_result) exitWith {};

onMapSingleClick "";
closeDialog 0;
deleteMarkerLocal (player getVariable ["casStrikeMrkLocal",""]);
deleteMarkerLocal (player getVariable ["casStrikeDirMrkLocal",""]);

[[_casTargetPos,_dir, side player,_weaponID,true],UAMTcas_fnc_casExecute] remoteExec ["spawn",2];
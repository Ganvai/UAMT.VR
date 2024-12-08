params ["_ammoID"];

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

_result = false;
private _result = ["You are calling a Cruise Missile Strike on the Designated coordinates. Do you confirm?", "Confirm vls Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	cutText ["<t color='#ff0000' size='2' shadow = '2'>vls Strike was cancelled</t>", "PLAIN", 2, true, true];
};

[[_vlsTargetPos, side player,_ammoID],UAMTvls_fnc_vlsExecute] remoteExec ["spawn",2];
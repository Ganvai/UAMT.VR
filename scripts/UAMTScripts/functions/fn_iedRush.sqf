params ["_unit","_target"];

_rushGroup = createGroup side _unit;

[_unit] joinSilent _rushGroup;

// orders
_rushGroup setSpeedMode "FULL";
_rushGroup setFormation "WEDGE";
_rushGroup enableAttack false;
_unit disableAI "FSM";
_unit disableAI "AUTOCOMBAT";
_unit disableAI "SUPPRESSION";
_unit disableAI "COVER";
_unit enableAI "MOVE";
_unit enableAI "PATH";
dostop _unit;
playSound3D ["A3\Dubbing_Radio_F\data\PER\Male01PER\RadioProtocolPER\Combat\200_CombatShouts\EndangeredE_2.ogg",_unit,false,getPosASL _unit,3];
_unit setunitpos "UP";
_unit moveTo (getposATL _target);

// Hunting loop
while {alive _unit && _unit distance2D _target > 12} do {

    // performance
    sleep 1;
    
	_unit setunitpos "UP";
	_unit moveTo (getposATL _target);
};

if (alive _unit) then {
	playSound3D ["A3\Dubbing_Radio_F\data\PER\Male01PER\RadioProtocolPER\Combat\200_CombatShouts\CombatGenericE_4.ogg",_unit,false,getPosASL _unit,3];
	sleep 1;
	{_x setDamage 1} forEach attachedObjects _unit;
	sleep 0.5;
	{deleteVehicle _x;}forEach attachedObjects _unit;
	deleteVehicle _unit;
};
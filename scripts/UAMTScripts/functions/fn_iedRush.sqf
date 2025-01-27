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

// Hunting loop
while {alive _unit && _unit distance2D _target > 12} do {

    // performance
    sleep 1;
    
	_unit setunitpos "UP";
	_unit moveTo (getposATL _target);
};

if (alive _unit) then {
	{_x setDamage 1} forEach attachedObjects _unit;
	sleep 0.5;
	{deleteVehicle _x;}forEach attachedObjects _unit;
	deleteVehicle _unit;
};
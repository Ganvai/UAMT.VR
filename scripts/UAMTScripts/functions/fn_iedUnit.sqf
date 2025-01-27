//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//
//				IED Function
//
// Rigs Units with an IED that explodes when accessing their inventory or hitting it with bullets 
// in the body (so headshots needed to kill them without explosion).
//
// Attributes:
// _unit : Unit Object the IED will be attached to <OBJECT>
//
// [this] call UAMT_fnc_iedUnit;
//
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

params ["_unit"];

_iedUnits = missionNameSpace getVariable ["rifUnits",[]];
_iedUnits pushbackUnique _unit;
missionNameSpace setVariable ["rifUnits",_iedUnits,true];

_expl1 = "DemoCharge_F" createVehicle position _unit;
_expl1 attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis",true];
_expl1 setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
_expl2 = "DemoCharge_F" createVehicle position _unit;
_expl2 attachTo [_unit, [0, 0.15, 0.15], "Pelvis",true];
_expl2 setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
_expl3 = "DemoCharge_Remote_Ammo" createVehicle position _unit;
_expl3 attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis",true];
_expl3 setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];				

_vestItems = vestItems _unit;
removeVest _unit;
_unit addVest selectRandom ["V_Pocketed_coyote_F","V_Pocketed_olive_F","V_CarrierRigKBT_01_Olive_F"];
{_unit addItemtoVest _x}forEach _vestItems;

_unit addEventHandler ["hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	
	if (isPlayer _instigator) then {
		if (_unit getHitPointDamage "hitbody" > 0) then {
			[_unit] spawn {
				params ["_unit"];
				{_x setDamage 1} forEach attachedObjects _unit;
				sleep 0.5;
				{deleteVehicle _x;}forEach attachedObjects _unit;
				deleteVehicle _unit;
			};
		};
	};
}];

_unit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_targets = _unit targets [true, 30];
	if (count _targets > 0) then {
		_target = _targets select 0;
		[_unit,_target]spawn UAMT_fnc_iedRush;
		_unit removeEventHandler [_thisEvent,_thisEventHandler];
	};
}];
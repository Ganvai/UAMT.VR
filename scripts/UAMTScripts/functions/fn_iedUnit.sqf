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

_expl1 = "DemoCharge_F" createVehicle position _x;
_expl1 attachTo [_x, [-0.1, 0.1, 0.15], "Pelvis",true];
_expl1 setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
_expl2 = "DemoCharge_F" createVehicle position _x;
_expl2 attachTo [_x, [0, 0.15, 0.15], "Pelvis",true];
_expl2 setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
_expl3 = "DemoCharge_Remote_Ammo" createVehicle position _x;
_expl3 attachTo [_x, [0.1, 0.1, 0.15], "Pelvis",true];
_expl3 setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];				

_vestItems = vestItems _x;
removeVest _x;
_x addVest selectRandom ["V_Pocketed_coyote_F","V_Pocketed_olive_F","V_CarrierRigKBT_01_Olive_F"];
_unit = _x;
{_unit addItemtoVest _x}forEach _vestItems;

_x addEventHandler ["hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
	
	if (isPlayer _instigator) then {
		if (_unit getHitPointDamage "hitbody" > 0) then {
			_expl = attachedObjects _unit;
			{_x setDamage 1} forEach _expl;
		};
	};
}];
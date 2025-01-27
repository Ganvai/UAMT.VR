//----------------------------------------------------------------
//----------------------------------------------------------------
//
//			IED Blow Up
//
// Blows Up an IED on a Unit. Is triggered by EventHandler.
// Plays a beeping sound befor eit blows up.
// Unit gets deleted after the IED exploded
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//	
// Attributes:
// _vehicle : <OBJECT> Vehicle that is getting blown up
//
// Call:
//
//----------------------------------------------------------------
//----------------------------------------------------------------
params ["_vehicle"];

_unit = objNull;
if (_vehicle isKindOf "CAManBase") then {
	_unit = _vehicle
}
else {
	_unit = getCorpse _vehicle;
};

// Playing Beeping Sounds for 4 seconds until Unit explodes
for "_i" from 1 to 4 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_unit,false,getPosASL _unit,2,1.3,0];
	sleep 0.5;
};
for "_i" from 1 to 5 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_unit,false,getPosASL _unit,2,1.5,0];
	sleep 0.2;
};
for "_i" from 1 to 10 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_unit,false,getPosASL _unit,2,1.7,0];
	sleep 0.1;
};

{_x setDamage 1} forEach attachedObjects _unit;

sleep 0.5;
{deleteVehicle _x;}forEach attachedObjects _unit;
deleteVehicle _unit;

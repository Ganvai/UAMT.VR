//----------------------------------------------------------------
//----------------------------------------------------------------
//
//			Vehicle IED Blow Up
//
// Detonates an IED rigged vehicle.
//
// From the UAMT Random Vehicle IED Feature.
//
// UAMT exlusive feature. Only works together with several UAMT
// specific dependencies in other files. Not to be used out of
// UAMT context.
//	
//----------------------------------------------------------------
//----------------------------------------------------------------

params ["_vehicle",["_bombType",0]];

for "_i" from 1 to 4 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle,false,getPosASL _vehicle,2,1.3,0];
	sleep 0.5;
};
for "_i" from 1 to 5 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle,false,getPosASL _vehicle,2,1.5,0];
	sleep 0.2;
};
for "_i" from 1 to 10 do {
	playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle,false,getPosASL _vehicle,2,1.7,0];
	sleep 0.1;
};

switch _bombtype do {
	case 0: { _demo = "DemoCharge_Remote_Ammo" createVehicle (getPos _vehicle); _demo setDamage 1; [_vehicle,1] remoteExec ["setDamage",_vehicle]; };
	case 1: { "Bo_Mk82_MI08" createVehicle (getpos _vehicle); _vehicle setDamage 1; };
	case 2: { "Bo_GBU12_LGB_MI10" createVehicle (getpos _vehicle); _vehicle setDamage 1; };
	default { _demo = "DemoCharge_Remote_Ammo" createVehicle (getPos _vehicle); _demo setDamage 1; [_vehicle,1] remoteExec ["setDamage",_vehicle]; };
};
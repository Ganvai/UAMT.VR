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

// Playing Beeping Sounds for 4 seconds until Unit explodes
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

// Spawn Explosive charge and detonate it
_expl1 = "DemoCharge_Remote_Ammo" createVehicle position _vehicle;
_expl1 setDamage 1;

// Deletes the _vehicle to clean up
deleteVehicle _vehicle;
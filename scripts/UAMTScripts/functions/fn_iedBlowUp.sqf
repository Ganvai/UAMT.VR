params ["_vehicle"];

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

_expl1 = "DemoCharge_Remote_Ammo" createVehicle position _vehicle;
_expl1 setDamage 1;

deleteVehicle _vehicle;
if (!isServer) exitWith {};

haloCargo = createVehicle ["B_supplyCrate_F",[0,0,0]];

haloCargo setPos (getPos insNoBoCPos);

clearWeaponCargoGlobal haloCargo; 
clearItemCargoGlobal haloCargo; 
clearMagazineCargoGlobal haloCargo; 
clearBackpackCargoGlobal haloCargo;

_haloCargoSmoke = createVehicle ["SmokeShellGreen", [0,0,0], [], 0, "NONE"];
_haloCargoSmoke attachTo [haloCargo,[0,0,0]];

_haloCargoLight = createVehicle ["Chemlight_green", [0,0,0], [], 0, "NONE"];
_haloCargoLight attachTo [haloCargo,[0,0,0]];

for "_i" from 1 to 8 do {
	_rndDir = random 360;
	_rndDis = random 5;
	
	_haloCargoLight = createVehicle ["Chemlight_green", [0,0,0], [], 0, "NONE"];
	_haloCargoLight setPos (haloCargo getRelPos [_rndDis,_rndDir]);	
};

[  
 haloCargo,  
 "store Backpack and get Parachute",  
 "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
 "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
 "_this distance _target < 3 && !insHaloExecute",  
 "_caller distance _target < 3",  
 {},  
 {},  
 { execVM "scripts\UAMTScripts\insertion\backpackSave.sqf"; },  
 {},  
 [],  
 1,  
 1000,  
 false,  
 false  
] remoteExec ["BIS_fnc_holdActionAdd", 0, haloCargo]; 


[  
 haloCargo,  
 "store Parachute and get Backpack",  
 "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
 "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
 "_this distance _target < 3 && insHaloExecute",  
 "_caller distance _target < 3",  
 {},  
 {},  
 { execVM "scripts\UAMTScripts\insertion\backpackLoad.sqf"; },  
 {},  
 [],  
 1,  
 1000,  
 false,  
 false  
] remoteExec ["BIS_fnc_holdActionAdd", 0, haloCargo];  

waitUntil {sleep 1; insHALOExecute || insertionCancel};

if (insertionCancel) exitWith {
	deleteVehicle haloCargo;
};

haloCargo setPos getMarkerPos "Halo Drop Position";

for "_i" from 1 to 8 do {
 _rndDir = random 360;
 _rndDis = random 5;
 
 _haloCargoLight = createVehicle ["Chemlight_green", [0,0,0], [], 0, "NONE"];
 _haloCargoLight setPos (haloCargo getRelPos [_rndDis,_rndDir]); 
};

waitUntil {sleep 1; insHALOVeh distance2D getMarkerPos "Halo Drop Position" < 1000};

for "_i" from 1 to 10 do {
	_haloCargoSmoke = createVehicle ["SmokeShellGreen", [0,0,0], [], 0, "NONE"];
	_haloCargoSmoke attachTo [haloCargo,[0,0,0]];
	sleep 60;	
};
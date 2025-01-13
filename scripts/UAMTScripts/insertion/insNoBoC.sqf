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
	"_this distance _target < 3 && (missionNameSpace getVariable ['insHaloExecute',false]) == false",  
	"_caller distance _target < 3",  
	{},  
	{},  
	{ 
		if (backpack player != "B_Parachute") then {
			player setVariable ["savedItems",backpackItems player];
			player setVariable ["savedBackpack",backpack player];
			removeBackpack player;
			player addBackpack "B_Parachute";
			titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >Backpack was stored. Parachute recieved!</t>", "PLAIN DOWN", 1.5, true, true];
		}
		else {
			titletext ["<t color='#ffffff' size='1.5' font='RobotoCondensed' shadow = '2' >You already have a Parachute! Nothing was stored.</t>", "PLAIN DOWN", 1.5, true, true];
		}; 
	},  
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
	"_this distance _target < 3 && (missionNameSpace getVariable ['insHaloExecute',false]) == true",  
	"_caller distance _target < 3",  
	{},  
	{},  
	{
		execVM "scripts\UAMTScripts\insertion\backpackLoad.sqf"; 
	},  
	{},  
	[],  
	1,  
	1000,  
	false,  
	false  
] remoteExec ["BIS_fnc_holdActionAdd", 0, haloCargo];  

waitUntil {sleep 1; missionNameSpace getVariable ["insHaloExecute",false] || missionNameSpace getVariable ["insertionCancel",false] };

if (missionNameSpace getVariable ["insertionCancel",false] ) exitWith {
	deleteVehicle haloCargo;
};

haloCargo setPos getMarkerPos "insHALOMrk";

for "_i" from 1 to 8 do {
 _rndDir = random 360;
 _rndDis = random 5;
 
 _haloCargoLight = createVehicle ["Chemlight_green", [0,0,0], [], 0, "NONE"];
 _haloCargoLight setPos (haloCargo getRelPos [_rndDis,_rndDir]); 
};

_haloVeh = missionNameSpace getVariable [(getMissionConfigValue "insHALOVeh"),objNull];

waitUntil {sleep 1; _haloVeh distance2D getMarkerPos "insHALOMrk" < 1000};

for "_i" from 1 to 10 do {
	_haloCargoSmoke = createVehicle ["SmokeShellGreen", [0,0,0], [], 0, "NONE"];
	_haloCargoSmoke attachTo [haloCargo,[0,0,0]];
	sleep 60;	
};
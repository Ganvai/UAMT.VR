if (!isServer) exitWith {};

params ["_haloVeh","_haloVehDoors","_dropPos","_dir","_timeToTransit","_haloCrate",["_side",west],["_intro","none"],["_pilotTalking","true"],["_uamtAudio","false"]];

// Setting height for HALO vehicle depending on if its a heli or a plane
_height = 4000;
_distance = 7000;
if (_haloVeh isKindOf "plane") then {
	_height = 7000;
	_distance = 12000;
};

// Preparing all values needed later
_grpHalo = group _haloVeh;
_approachPos = _dropPos getPos [_distance, (_dir + 180)];
_approachPos set [2,_height];
_despawnPos = _dropPos getpos [5000, _dir];
_wpRadius = 300;
{
	if (!isPlayer _x) then {
		_x setCaptive true;
	};
}forEach (crew _haloVeh);

_haloVeh allowDamage false;

// Setting the Fake Waypoint to which the Vehicle will fly. 
// Use this for cutscenes.
_fakeWP = _haloVeh getPos [10000,getDir _haloVeh];

// Opening the Doors of the HALO vehicle
{
	_haloVeh animateDoor [_x,1];
	_haloVeh animate [_x,1];
} forEach _haloVehDoors;

_BoC = false;
if (isClass(configFile >> "cfgPatches" >> "BackpackOnChest")) then {
	_BoC = true;
	_haloCrate addBackpackCargoGlobal [(getMissionConfigValue "insHALOParachutes"), getMissionConfigValue ("insHALOParachutesCount")];
}
else {
	// Add the Function to save the current Backpack and get a parachute
	[  
		_haloCrate,  
		"open HALO Drop Crate",
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",  
		"_this distance _target < 4",  
		"_caller distance _target < 4",  
		{},  
		{},  
		{
			createDialog "insDialogCrate";
		},
		{},  
		[],  
		1,  
		1000,  
		false,  
		false  
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _haloCrate]; 
};

waitUntil {sleep 1; ({(_x in _haloVeh)} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers)) || missionNameSpace getVariable ["insertionCancel",false] };

{
	_haloVeh animateDoor [_x,0];
	_haloVeh animate [_x,0];
}forEach _haloVehDoors;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {deleteVehicle _haloCrate;};

missionNameSpace setVariable ["insHaloExecute",true,true];

if (_pilotTalking == "true") then {
	if (_uamtAudio == "true") then {
		["All personal aboard. Starting Engines. Prepare for lift off.","Pilot","msg_HALOStart",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["All personal aboard. Starting Engines. Prepare for lift off","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

[_haloVeh,1] remoteExec ["setFuel"];

_haloVeh engineOn true;

_wp = _grpHalo addWaypoint [_fakeWP , -1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "careless";

//  Start the Intro if one given
if (_intro != "none" && _intro != "") then {
	"scripts\UAMTScripts\insertion\insIntroHalo.sqf" remoteExec ["execVM",[0, -2] select isDedicated];	
};

// Sleep until the Intro is over
sleep _timeToTransit;

if (_pilotTalking == "true") then {
	if (_uamtAudio == "true") then {
		["Okay, listen up. We will now start our climb to the jump height of 3000 meters. This will be a rapid pressure change, so be ready to pop your ears.","Pilot","msg_HALOClimbStart",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Okay, listen up. We will now start our climb to the jump height of 3000 meters. This will be a rapid pressure change, so be ready to pop your ears.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

// Sleep to wait until Pilot is done talking
sleep  4;

// Black Fade transition to mask timejump and move to approach position
"scripts\UAMTScripts\insertion\insTimeJump.sqf" remoteExec ["execVM"];

// Wait until Player Screens are black
sleep 3;

// Skip the time
[30 / 60] call BIS_fnc_setDate;

[_grpHalo] call CBA_fnc_clearWaypoints;

//  Prepare the Pilot Agent
_driverClass = typeOf (driver _haloVeh);
_Pilot = CreateAgent [_driverClass, [0,0,0], [], 0, "NONE"];

// Delete the actual Pilot and place the Agent
deleteVehicle driver _haloVeh;
_Pilot MoveInDriver _haloVeh;

// AI fuckery for Pilot Agent
_Pilot setRank "SERGEANT";
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
_Pilot setSpeedMode "FULL";
_Pilot disableAI "FSM";

// Move the Vehicle to the approach Position
_haloVeh setPos _approachPos;
_haloVeh setDir _dir;

// Giving the Pilot the Waypoint for the Drop Pos
_Pilot MoveTo _dropPos;

//Setting the Flight Height for the Vehicle
_haloVeh flyInHeight _height;

// Giving Planes a much higher speed. Is needed to avoid crashes
if (_haloVeh isKindOf "plane") then {
	private _vel = velocity _haloVeh;
	private _dir = direction _haloVeh;
	private _speed = 200; 
	_haloVeh setVelocity [
		(_vel select 0) + (sin _dir * _speed), 
		(_vel select 1) + (cos _dir * _speed), 
		0
	];
};

// Move _noBoC crate
if (!_BoC) then {
	deleteVehicle _noBoCLight1;
	deleteVehicle _noBoCLight2;

	[_dropPos,_haloCrate] spawn {
		params  ["_dropPos","_haloCrate"];
		_centre = _dropPos getPos [(random 400), (random 360)];
		_drop_point = [];
		_max_distance = 30;
		
		while { count _drop_point < 1 } do
		{
			_drop_point = _centre findEmptyPosition [20, _max_distance, "B_supplyCrate_F"];
			_max_distance = _max_distance + 20;
		};

		_haloCrate setPos _drop_point;		

		for "_i" from 1 to 8 do {
			 _rndDir = random 360;
			 _rndDis = random 5;
			 
			 _haloCargoLight = createVehicle ["Chemlight_green", [0,0,0], [], 0, "NONE"];
			 _haloCargoLight setPos (_haloCrate getRelPos [_rndDis,_rndDir]); 
		};
	};
};

sleep 10;

if (_pilotTalking == "true") then {
	if (_uamtAudio == "true") then {
		["Setting course to Drop Zone. We will open the ramp one klick away. You coordinate your jump.","Pilot","msg_HALODropZone",_side] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["Setting course to Drop Zone. We will open the ramp one klick away. You coordinate your jump.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

WaitUntil {sleep 0.1; (_dropPos distance2D _haloVeh < 1300)};

if (_pilotTalking == "true") then {
	if (_uamtAudio == "true") then {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","msg_HALOOpening",_side] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

{
	_haloVeh animateDoor [_x,1];
	_haloVeh animate [_x,1];
}forEach _haloVehDoors;

WaitUntil {sleep 0.1; (_dropPos distance2D _haloVeh < 800)};

if (_pilotTalking == "true") then {
	if (_uamtAudio == "true") then {
		["Let's go, gentlemen!","Pilot","letsGo",_side] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["Let's go, gentlemen!","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

if (!_BoC) then {
	[_haloCrate] spawn {
		params ["_haloCrate"];
		
		for "_i" from 1 to 15 do {
			_haloCargoSmoke = createVehicle ["SmokeShellGreen", [0,0,0], [], 0, "NONE"];
			_haloCargoSmoke attachTo [_haloCrate,[0,0,0]];
			sleep 60;	
		};
	};
};

WaitUntil {sleep 0.1; (_dropPos distance2D _haloVeh < 300)};

_Pilot MoveTo _despawnPos;

WaitUntil {sleep 0.1; (_dropPos distance2D _haloVeh > 600)};

{
	if (isPlayer _x) then {
		_x moveOut _haloVeh;
	};
}forEach crew _haloVeh;

WaitUntil {sleep 0.1; ( _despawnPos distance2D _haloVeh < 500)};

deleteVehicleCrew _haloVeh;
deleteVehicle _haloVeh;

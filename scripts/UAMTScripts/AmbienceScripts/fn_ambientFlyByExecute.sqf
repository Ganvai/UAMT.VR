if !(isServer) exitWith {};

params ["_vehicle","_startPos","_endPos","_AFBHeight","_speed"];

_dir = ([_startPos,_endPos] call BIS_fnc_DirTo);
// Spawning the Vehicle
_AFBVehicle = createVehicle [_Vehicle, _startPos, [], 0, "FLY"];
_AFBVehicle setPos [(getpos _AFBVehicle # 0),(getpos _AFBVehicle # 1), _AFBHeight];
_AFBVehicle setDir _dir;
_AFBVehicle AllowDamage false;

// Spawning the Pilot
_Pilot = CreateAgent ["B_Fighter_Pilot_F", [0,0,0], [], 0, "NONE"];
_Pilot MoveInDriver _AFBVehicle;
_Pilot setRank "SERGEANT";
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
_Pilot setSpeedMode "FULL";
_Pilot disableAI "FSM";

//Setting the Flight Height for the Vehicle
_AFBVehicle flyInHeight _AFBHeight;

_Pilot setCaptive true;

//Give Speed
_vel = velocity _AFBVehicle;
_AFBVehicle setVelocity [
	(_vel select 0) + (sin _dir * _speed), 
	(_vel select 1) + (cos _dir * _speed), 
	(_vel select 2)
];

//Setting the Waypoint for the FlyBy
_Pilot MoveTo _endPos;

//Suspending until the Vehicle reached the Despawn Position
WaitUntil {sleep 2; (_endPos distance2D _AFBVehicle < 200)};

//Deleting Crew and Vehicle
DeleteVehicleCrew _AFBVehicle;
DeleteVehicle _AFBVehicle;	
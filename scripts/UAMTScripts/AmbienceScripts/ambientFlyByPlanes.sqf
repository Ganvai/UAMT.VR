//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Ambient Fly By for Planes
//
// Spawns a vehicle randomly chosen from a List and lets them
// fly over a randomly chosen Players position.
// Planes are set to captive, won't engage anything and won't be
// engaged.
//
// Script is en enhancement / combination of AmbientFlyBy Scripts
// by Spiderman, SmartGun from TOB and R3vo from the BI Forums
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

if (!isServer) exitWith {};

_AFBPHeightPlane = getMissionConfigValue "AFBPHeight";
_AFBPHeight = 50;
_speed = 20;
_AFBmaxTime = getMissionConfigValue "AFBmaxTime";
_AFBmidTime = getMissionConfigValue "AFBmidTime";
_AFBminTime = getMissionConfigValue "AFBminTime";
_distance = getMissionConfigValue "AFBdistance";
_vehicles = getMissionConfigValue "AFBVehicles";


while {sleep 60, true} do {
	_wait = random [_AFBminTime, _AFBmidTime, _AFBmaxTime];
	
	sleep _wait;
	
	_players = allPlayers - entities "HeadlessClient_F";
	
	_target = selectRandom _players;
	
	_Vehicle = selectRandom _Vehicles;

	if (_Vehicle isKindOf "plane") then {
		_AFBPHeight = _AFBPHeightPlane;
		_speed = 300;
	}
	else {
		_AFBPHeight = 50;
		_speed 50;
	}
	
	_startPos = _target getPos [_distance,selectRandom [90,270]];
	_playerPos = _target getPos [random [25,100,200],selectRandom [0,0]];
	_dir = _startPos getDir _playerPos;
	_endPos = _playerPos getPos [_distance,_dir];
	
	// Spawning the Vehicle
	_AFBVehicle = createVehicle [_Vehicle, _startPos, [], 0, "FLY"];
	_AFBVehicle setPos [(getpos _AFBVehicle # 0),(getpos _AFBVehicle # 1), _AFBPHeight];
	_AFBVehicle setDir ([_startPos,_playerPos] call BIS_fnc_DirTo);
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
	_AFBVehicle flyInHeight _AFBPHeight;

	_Pilot setCaptive true;
	
	//Give Speed - IFA DEBUG
	private _vel = velocity _AFBVehicle;
	private _dir = direction _AFBVehicle;
	private _speed = 300; comment "Added speed";
	_AFBVehicle setVelocity [
		(_vel select 0) + (sin _dir * _speed), 
		(_vel select 1) + (cos _dir * _speed), 
		(_vel select 2)
	];

	//Setting the Waypoint for the Supply Drop Delivery
	_Pilot MoveTo _endPos;
	
	//Suspending until the Vehicle reached the Despawn Position
	WaitUntil {sleep 2; (_endPos distance2D _AFBVehicle < 200)};

	//Deleting Crew and Vehicle
	DeleteVehicleCrew _AFBVehicle;
	DeleteVehicle _AFBVehicle;	
};
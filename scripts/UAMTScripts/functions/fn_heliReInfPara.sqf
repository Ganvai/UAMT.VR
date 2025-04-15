//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//
//							Heli Reinforcements Paradrop
//
// Spawns a Helicopter at the spawn position, flying to the drop position and dropping there
// the given units with parachute
//
// Units can simply move to a target position or stalk a player group
//
// PARAMETERS
// _heli : STRING, Vehicle Class / Classname of helicopter to spawn
//
// _unitsArr : ARRAYS of unit classnames / An Array with all the units you want to spawn.
//											If you want to spawn five rifleman, you have to
//											add five array elements with the classname of the
//											rifleman unit you want to spawn
//
// _side : SIDE / Side to which the spawned units and the helicopter will belong
//
// _spawnPos : Position (ARRAY), Markername (STRING) / The helicopter will spawn at this location
//
// _dropPos : Position (ARRAY), Markername (STRING) / Position where the units will jump of the
//														helicopter
//
// _target : Postion (ARRAY), Markername (STRING), OBJECT (UNIT) / Target to which the paratroopers wil move
//															If _target is a player, the group will chase
//															this player over the map.
//
//
//
// EXAMPLES:
// ["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,"_spawnMarker",[5736.49,6995.88,0],player] call UAMT_fnc_heliReInfPara;
//
// Spawns a Kasatka helicopter that will fly from Spawn Marker to the drop position and drop three 
// CSAT Rifleman soldiers. The soldiers will stalk the player after they were dropped.
//
// ["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,"_spawnMarker",[5736.49,6995.88,0],getPos player] call UAMT_fnc_heliReInfPara;
//
// Spawns a Kasatka helicopter that will fly from Spawn Marker to the drop position and drop three 
// CSAT Rifleman soldiers. Other than in the example before, this time the troops will only go to the position
// where the player was when the function was called and will not stalk the player.
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------

params ["_heli","_unitsArr","_side","_spawnPos","_dropPos","_target","_code"];

if (typeName _spawnPos == "STRING") then {
	_spawnPos = getMarkerPos _spawnPos;
};

if (typeName _dropPos == "STRING") then {
	_dropPos = getMarkerPos _dropPos;
};

[_heli,_unitsArr,_side,_spawnPos,_dropPos,_target,_code] spawn {
	params["_helicopter","_unitsArr","_side","_spawnPos","_dropPos","_target","_code"];
	
	_dir = _spawnPos getDir _dropPos;

	_despawnPos = _dropPos getPos [5000,_dir];

	// Spawning the Vehicle
	_heli = createVehicle [_helicopter, _spawnPos, [], 0, "FLY"];
	_heli setPos [(_spawnPos select 0),(_spawnPos select 1), 100];
	_heli setDir _dir;
	_heli AllowDamage true;

	// Spawning the Pilot
	_Pilot = CreateAgent ["O_Pilot_F", [0,0,0], [], 0, "NONE"];
	_Pilot MoveInDriver _heli;
	_Pilot setRank "SERGEANT";
	_Pilot SetBehaviour "CARELESS";
	_Pilot setCombatMode "BLUE";
	group _Pilot setSpeedMode "FULL";
	_Pilot disableAI "FSM";

	//Setting the Flight Height for the Vehicle
	_heli flyInHeight 100;

	//Give Speed - IFA DEBUG
	private _vel = velocity _heli;
	private _dir = direction _heli;
	private _speed = 80;
	_heli setVelocity [
		(_vel select 0) + (sin _dir * _speed), 
		(_vel select 1) + (cos _dir * _speed), 
		(_vel select 2)
	];

	_Pilot MoveTo _dropPos;

	//Check if all units fit into the Helicopter and delete if they don't fit
	_cargoSpace = _heli emptyPositions "Cargo";

	if (_cargoSpace < count _unitsArr) then  {
		_unitsArr resize _cargoSpace;
	};

	//Create Parachute Group
	_grpParatroopers = [[0,0,0], _side,_unitsArr] call BIS_fnc_spawnGroup;

	//Move all units into the Helicopter
	{
		_x assignAsCargo _heli; 
		_x moveInCargo _heli;
		_x call _code;
	} foreach units _grpParatroopers;

	//Suspending until the Vehicle reached the Drop Position
	WaitUntil {sleep 2; (_dropPos distance2D _heli < 300) || !alive _heli};

	if (!alive _heli) exitWith {};

	{
		diag_log format ["unitgo: %1",[_x,_x in _heli]];
		unassignVehicle _x;

		_x allowDamage false;

		_x setPos (_heli modelToWorld [(random 4) - (random 4),-4,-2]);

		_vel = velocity _heli;

		_x setVelocity [(_vel select 0)/2,(_vel select 1)/2,-1];

		_x disableCollisionWith _heli;

		waitUntil
			{
			sleep 0.01;
			(_x == (vehicle _x))
			};

		[_x,_heli,_dir] spawn
			{
			_unit = _this select 0;
			_heli = _this select 1;
			_dir = _this select 2;
			
			waitUntil
				{
				sleep (0.15 + (random 0.5));
				((_heli distance _unit) > 25)
				};
			
			_chute = createVehicle ["Steerable_Parachute_F", position _unit, [], (_dir + 175 + (random 10)), "FLY"];
			_chute disableCollisionWith _heli;
			_chute setPos (position _unit);
			_vel = velocity _unit;
			_unit moveInDriver _chute;
			_chute setVelocity _vel;
			
			_unit allowDamage true;
			};
			
		sleep (0.75 + (random 0.25));
	} foreach units _grpParatroopers;
	
	_Pilot MoveTo _despawnPos;

	_targetPos = _target;

	if  (typeName _target == "OBJECT") then {
		_targetPos = getPos _target;
		if (isPlayer _target) then {
			[_grpParatroopers, group _target] spawn BIS_fnc_stalk;
		}
		else {
			_wp1 = _grpParatroopers addWaypoint [_targetPos, -1,-1];
			_wp1 setWaypointType "SAD";
			_wp1 setWaypointCombatMode "RED";
			_wp1 setWaypointBehaviour "AWARE";		
		};
	}
	else {
		if  (typeName _target == "STRING") then {
			_targetPos = getMarkerPos _target;
		}
		else {
			_targetPos = _target;
		};
		_wp1 = _grpParatroopers addWaypoint [_targetPos, -1,-1];
		_wp1 setWaypointType "SAD";
		_wp1 setWaypointCombatMode "RED";
		_wp1 setWaypointBehaviour "AWARE";		
	};

	WaitUntil {sleep 2; (_despawnPos distance2D _heli < 100) || !alive _heli};

	if (!alive _heli) exitWith {};

	//Deleting Crew and Vehicle
	DeleteVehicleCrew _heli;
	DeleteVehicle _heli;
};
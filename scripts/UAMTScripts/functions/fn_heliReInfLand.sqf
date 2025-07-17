//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
//
//							Helicopter Reinforcements Landing
//
// Spawns a Helicopter at the spawn position, flying to the drop position, landing there and
// delivering a group of units.
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
// _dropPos : Position (ARRAY), Markername (STRING) / Position where the heli will land
//
// _target : Postion (ARRAY), Markername (STRING), OBJECT (UNIT) / Target to which the paratroopers wil move
//															If _target is a player, the group will chase
//															this player over the map.
//
//
// _smoke : BOOLEAN, Option, default true / Drops four smoke grenades around the helicopter before
//											the units disembark
//
// _code : CODE, Optional, default NONE / Applies code to every unit that is spawned. Can be used to change loadouts.
//
// EXAMPLES:
// ["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,"_spawnMarker",[5736.49,6995.88,0],player,false,{hint str _this}] call UAMT_fnc_heliReInfLand;
//
// Spawns a Kasatka helicopter that will fly from Spawn Marker to the drop position and drop three 
// CSAT Rifleman soldiers. The soldiers will stalk the player after they were dropped.
//
// ["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,"_spawnMarker",[5736.49,6995.88,0],getPos player,true] call UAMT_fnc_heliReInfLand;
//
// Spawns a Kasatka helicopter that will fly from Spawn Marker to the drop position and drop three 
// CSAT Rifleman soldiers. Other than in the example before, this time the troops will only go to the position
// where the player was when the function was called and will not stalk the player. When the helicopter has
// landed, smoke grenades will spawn around it for a nice effect.
//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------

params ["_heli","_unitsArr","_side","_spawnPos","_dropPos","_target",["_smoke",true],["_code",""]];

if (typeName _spawnPos == "STRING") then {
	_spawnPos = getMarkerPos _spawnPos;
};

if (typeName _dropPos == "STRING") then {
	_dropPos = getMarkerPos _dropPos;
};

[_heli,_unitsArr,_side,_spawnPos,_dropPos,_target,_smoke,_code] spawn {
	params["_helicopter","_unitsArr","_side","_spawnPos","_dropPos","_target","_smoke","_code"];
	
	_dir = _spawnPos getDir _dropPos;

	"Land_HelipadEmpty_F" createVehicle _dropPos;
	
	// Set position for spawn to 100 meter height
	_spawnPos set [2,100];
	
	// Get direction to spawn heli
	_dir = _spawnPos getDir _dropPos;
	
	// Spawn the heli
	_heliArr = [_spawnPos, _dir, _helicopter, _side] call BIS_fnc_spawnVehicle;

	_heliGrp = _heliArr select 2;
	_heliVeh = _heliArr select 0;
	
	_crew = count (crew _heliVeh);
	
	// Move Helicopter to the exact location
	_heliVeh setPos _spawnPos;

	//Setting the Flight Height for the Vehicle
	_heliVeh flyInHeight 100;

	_wp1 = _heliGrp addWaypoint [_dropPos, 0];
	_wp1 setWaypointType "LOAD";
	_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
	_wp1 setWaypointBehaviour "CARELESS";

	//Check if all units fit into the Helicopter and delete if they don't fit
	_cargoSpace = _heliVeh emptyPositions "Cargo";

	if (_cargoSpace < count _unitsArr) then  {
		_unitsArr resize _cargoSpace;
	};

	//Create Parachute Group
	_grpParatroopers = [[0,0,0], _side,_unitsArr] call BIS_fnc_spawnGroup;

	//Move all units into the Helicopter
	{
		_x assignAsCargo _heliVeh; 
		_x moveInCargo _heliVeh;
		if (_code isNotEqualTo "") then {
			_x call _code;
		};
	} foreach units _grpParatroopers;

	//Suspending until the Vehicle reached the Drop Position
	waitUntil {sleep 1;(velocity _heliVeh select 2) > -0.2 && (getPosATL _heliVeh select 2) <  0.5};
	
	if (!alive _heliVeh) exitWith {};
	
	if (_smoke) then {
		for "_i" from 1 to 4 do {
			_pos = _heliVeh getPos [20, (70 * _i)];
			_smoke = createVehicle ["SmokeShell", _pos, [], 0, "NONE"];
			_smoke setPos _pos;
		};	
		sleep 10;
	};
	
	{
		unassignVehicle _x;		
	} foreach units _grpParatroopers;

	_targetPos = [0,0,0];
	
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
	
	waitUntil {sleep 1; (count (crew _heliVeh) <= _crew)};
	
	_wp1 = _heliGrp addWaypoint [_spawnPos, 0];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "CARELESS";

	WaitUntil {sleep 1; (_spawnPos distance2D _heliVeh < 50) || !canMove _heliVeh};

	deleteVehicleCrew _heliVeh;
	deleteVehicle _heliVeh;
};
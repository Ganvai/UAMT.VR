/*
_heloClass = "B_Heli_Light_01_dynamicLoadout_F";
_heloCount = 2;
_duration = 30;
_targetPos = [422.946,2634.92,0];
_spawnPos = [-1588.54,2635.34,0];
_audioMessages = true;
_customAudio = false;
_supportControlName = "BLA";
_side = west;
_createMarker = true;

[_heloClass,_heloCount,_duration,_targetPos,_spawnPos,_audioMessages,_customAudio,_supportControlName,_side,_createMarker] spawn UAMThfs_fnc_hfsScripted;
*/

if (!isServer) exitWith {};

params ["_heloClass","_heloCount","_duration","_targetPos","_spawnPos","_audioMessages","_customAudio","_supportControlName",["_side",west],["_createMarker",false]];

_heloArr = [];
_heloVehArr = [];
_heloGrpArr = [];
_dir =  _spawnPos getDir  _targetPos;

if (_createMarker) then {
	createMarker ["hfsMrk",_targetPos];
	"hfsMrk" setMarkerType "hd_destroy_noShadow";
	"hfsMrk" setMarkerText "Heli Target";
};

if (_audioMessages) then {
	if (_customAudio) then {
		["Be advised: Helicopters are en route to your position.",_supportControlName,"msg_hfsEnRoute",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: Helicopters are en route to your position",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

// Spawning Helicopters
for "_i" from 1 to _heloCount do {
	_heloSpawnArr = [_spawnPos,_dir,_heloClass,_side] call bis_fnc_spawnVehicle;
	
	_heloArr pushback _heloSpawnArr;
	_heloVehArr pushback (_heloSpawnArr select 0);
	_heloGrpArr pushback (_heloSpawnArr select 2);
	
	_wp1 = _heloSpawnArr select 2 addWaypoint [_targetPos, 50];
	_wp1 setWaypointType "SAD";
	_wp1 setWaypointBehaviour "AWARE";
	
	sleep 5;
};

waitUntil {sleep 0.5; {_x distance2D _targetPos < 1000} count _heloVehArr > 0  || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	if (_audioMessages) then {
		if (_customAudio) then {
			["All Units: Helicopters were destroyed.",_supportControlName,"msg_hfsDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units: Helicopters were destroyed.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

if (_audioMessages) then {
	if (_customAudio) then {
		["Be advised: Helicopters arriving at target area.",_supportControlName,"msg_hfsArrive",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: Helicopters arriving at target area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

_timer = time;

waitUntil {sleep 1; time - _timer > _duration || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;			
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	if (_audioMessages) then {
		if (_customAudio) then {
			["All Units: Helicopters were destroyed.",_supportControlName,"msg_hfsDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units: Helicopters were destroyed.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

if (_audioMessages) then {
	if (_customAudio) then {
		["Be advised: Helicopter-Element is Bingo fuel and RTB.",_supportControlName,"msg_hfsBingo",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: Helicopter-Element is Bingo fuel and RTB.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

{
	if (alive (_x select 0)) then {
		[_x,_spawnPos] spawn {
			params ["_heloArrActual","_spawnPos"];
			
			_heloVehicle = _heloArrActual select 0;
			_heloCrew = _heloArrActual select 1;
			_heloGrp = _heloArrActual select 2;


			{				
				_x SetBehaviour "CARELESS";
				_x setCombatMode "BLUE";			
			}forEach _heloCrew;
				
			_wp2 = _heloGrp addWaypoint [_spawnPos, 50];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointCombatMode "BLUE";
			_wp2 setWaypointBehaviour "CARELESS";
			
			deleteWaypoint [_heloGrp, 0];
			
			_y = count waypoints _heloGrp;
			
			_heloGrp setCurrentWaypoint [_heloGrp, _y - 1];
		};
	};
} forEach _heloArr;

waituntil {sleep 1; {_x distance2D _spawnPos < 100} count _heloVehArr > 0 || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	if (_audioMessages) then {
		if (_customAudio) then {
			["All Units: Helicopters were destroyed.",_supportControlName,"msg_hfsDestroyed",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units: Helicopters were destroyed.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	};
};

{
	deleteVehicleCrew (_x select 0);
	deleteVehicle (_x select 0);
	deleteGroup (_x select 2);
} forEach _heloArr;

if (_createMarker) then {
	deleteMarker "hfsMrk";
};
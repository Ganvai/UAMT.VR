if (!isServer) exitWith {};

params ["_pos","_dir","_side","_hfsIndex",["_createMarker",true]];

hfsStatus = 2;
publicVariable "hfsStatus";

_heloClass = (hfsArray select _hfsIndex) select 0;
_heloCount = (hfsArray select _hfsIndex) select 1;
_duration = hfsDuration;
_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;
_penalty = false;

(hfsArray select _hfsIndex) set [2,(((hfsArray select _hfsIndex) select 2) - 1 )];

_heloCfg = configfile >> "cfgvehicles" >> _heloClass;
_heloPos = _pos getPos [hfsDistance,_dir];
_heloArr = [];
_heloVehArr = [];
_heloGrpArr = [];

if (_createMarker) then {
	createMarker ["hfsMrk",_pos];
	"hfsMrk" setMarkerAlpha 0;
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

sleep (2 + hfsDelay);

// Spawning Helicopters
for "_i" from 1 to _heloCount do {
	_heloSpawnArr = [_heloPos,(_dir + 180),_heloClass,_side] call bis_fnc_spawnVehicle;
	
	_heloArr pushback _heloSpawnArr;
	_heloVehArr pushback (_heloSpawnArr select 0);
	_heloGrpArr pushback (_heloSpawnArr select 2);
	
	_wp1 = _heloSpawnArr select 2 addWaypoint [_pos, 0];
	_wp1 setWaypointType "SAD";
	_wp1 setWaypointBehaviour "AWARE";
	
	sleep 5;
};

waitUntil {sleep 0.5; {_x distance2D _pos < 1000} count _heloVehArr > 0  || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (!hfsRespawn) then {
			(hfsArray select _hfsIndex) set [1,(((hfsArray select _hfsIndex) select 1) - 1 )];
			
			if (((hfsArray select _hfsIndex) select 1) == 0) then {
				(hfsArray select _hfsIndex) set [2,0];
			};
			
			publicVariable  "hfsArray";
		};
		
		_penalty = true;
		
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

if (_audioMessages) then {
	if (_customAudio) then {
		["All units: Helicopters arriving at target area.",_supportControlName,"msg_hfsArrive",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All units: Helicopters arriving at target area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

_timer = time;

waitUntil {sleep 1; time - _timer > _duration || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (!hfsRespawn) then {
			(hfsArray select _hfsIndex) set [1,(((hfsArray select _hfsIndex) select 1) - 1 )];

			if (((hfsArray select _hfsIndex) select 1) == 0) then {
				(hfsArray select _hfsIndex) set [2,0];
			};
			
			publicVariable  "hfsArray";
		};
		
		_penalty = true;
		
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

hfsStatus = 3;
publicVariable "hfsStatus";

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
		[_x,_heloPos] spawn {
			params ["_heloArrActual","_heloPos"];
			
			_heloVehicle = _heloArrActual select 0;
			_heloCrew = _heloArrActual select 1;
			_heloGrp = _heloArrActual select 2;


			{				
				_x SetBehaviour "CARELESS";
				_x setCombatMode "BLUE";			
			}forEach _heloCrew;
				
			_wp2 = _heloGrp addWaypoint [_heloPos, 0];
			_wp2 setWaypointType "MOVE";
			_wp2 setWaypointCombatMode "BLUE";
			_wp2 setWaypointBehaviour "CARELESS";
			
			deleteWaypoint [_heloGrp, 0];
			
			_y = count waypoints _heloGrp;
			
			_heloGrp setCurrentWaypoint [_heloGrp, _y - 1];
		};
	};
} forEach _heloArr;

waituntil {sleep 1; {_x distance2D _heloPos < 100} count _heloVehArr > 0 || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (!hfsRespawn) then {
			(hfsArray select _hfsIndex) set [1,(((hfsArray select _hfsIndex) select 1) - 1 )];
		
			if (((hfsArray select _hfsIndex) select 1) == 0) then {
				(hfsArray select _hfsIndex) set [2,0];
			};
			
			publicVariable  "hfsArray";
		};
		
		_penalty = true;
		
		_heloVehArr deleteAt _forEachIndex;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

{
	deleteVehicleCrew (_x select 0);
	deleteVehicle (_x select 0);
	deleteGroup (_x select 2);
} forEach _heloArr;

_cooldown = hfsCooldown;
if (_penalty) then {
	_cooldown = _cooldown + hfsPenalty;
};

sleep _cooldown;

hfsStatus = 0;
publicVariable "hfsStatus";

if (_audioMessages) then {
	if (_customAudio) then {
		["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"msg_hfsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

deleteMarker "hfsMrk";
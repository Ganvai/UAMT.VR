if (!isServer) exitWith {};

params ["_pos","_dir","_side","_hfsIndex",["_createMarker",true]];

missionNameSpace setVariable ["hfsStatus",2,true];

_hfsArray = missionNameSpace getVariable ["hfsArray",0];

_heloClass = (_hfsArray select _hfsIndex) select 0;
_heloCount = (_hfsArray select _hfsIndex) select 1;
_duration = getMissionConfigValue "hfsDuration";
_audioMessages = getMissionConfigValue "supportMessages";
_customAudio = getMissionConfigValue "supportCustomAudio";
_supportControlName = getMissionConfigValue "supportControlName";
_penalty = false;

(_hfsArray select _hfsIndex) set [2,(((_hfsArray select _hfsIndex) select 2) - 1 )];

_heloCfg = configfile >> "cfgvehicles" >> _heloClass;
_heloPos = _pos getPos [getMissionConfigValue "hfsDistance",_dir];
_heloArr = [];
_heloVehArr = [];
_heloGrpArr = [];

_hfsCount = (missionnamespace getVariable  ["hfsCount",0]) + 1;
missionNameSpace setVariable ["hfsCount",_hfsCount,true];

_hfsMrk = format ["hfsMrk%1",_hfsCount];

if (_createMarker) then {
	createMarker [_hfsMrk,_pos];
	_hfsMrk setMarkerAlpha 0;
	_hfsMrk setMarkerType "hd_destroy_noShadow";
	_hfsMrk setMarkerText "Heli Target";
};

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["Be advised: Helicopters are en route to your position.",_supportControlName,"msg_hfsEnRoute",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: Helicopters are en route to your position",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

sleep (2 + getMissionConfigValue "hfsDelay");

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

_deleteArray = [];
{
	if (not canMove _x) then {
		deleteMarker _hfsMrk;
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (getMissionConfigValue "hfsRespawn" == "false") then {
			(_hfsArray select _hfsIndex) set [1,(((_hfsArray select _hfsIndex) select 1) - 1 )];
			
			if (((_hfsArray select _hfsIndex) select 1) == 0) then {
				(_hfsArray select _hfsIndex) set [2,0];
			};
		};
		
		_penalty = true;
		
		_deleteArray pushback _forEachIndex;
	};
} forEach _heloVehArr;

_heloVehArr deleteAt _deleteArray;

missionNameSpace setVariable ["hfsArray",_hfsArray,true];

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["All units: Helicopters arriving at target area.",_supportControlName,"msg_hfsArrive",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All units: Helicopters arriving at target area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

_timer = time;

waitUntil {sleep 1; time - _timer > _duration || {canMove _x} count _heloVehArr == 0};

_deleteArray = [];

{
	if (not canMove _x) then {
		deleteMarker _hfsMrk;
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (getMissionConfigValue "hfsRespawn" == "false") then {
			(_hfsArray select _hfsIndex) set [1,(((_hfsArray select _hfsIndex) select 1) - 1 )];

			if (((_hfsArray select _hfsIndex) select 1) == 0) then {
				(_hfsArray select _hfsIndex) set [2,0];
			};
		};
		
		_penalty = true;
		
		_deleteArray pushback _forEachIndex;
	};
} forEach _heloVehArr;

_heloVehArr deleteAt _deleteArray;

missionNameSpace setVariable ["hfsArray",_hfsArray,true];

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

missionNameSpace setVariable ["hfsStatus",3,true];

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
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

_deleteArray = [];

{
	if (not canMove _x) then {
		deleteMarker _hfsMrk;
		deleteVehicleCrew _x;
		_x setDamage 1;
		
		if (getMissionConfigValue "hfsRespawn" == "false") then {
			(_hfsArray select _hfsIndex) set [1,(((_hfsArray select _hfsIndex) select 1) - 1 )];
		
			if (((_hfsArray select _hfsIndex) select 1) == 0) then {
				(_hfsArray select _hfsIndex) set [2,0];
			};
		};
		
		_penalty = true;
		
		_deleteArray pushback _forEachIndex;
	};
} forEach _heloVehArr;

_heloVehArr deleteAt _deleteArray;

missionNameSpace setVariable ["hfsArray",_hfsArray,true];

if ({alive _x} count _heloVehArr == 0) exitWith {
	[_hfsIndex,_side] spawn UAMThfs_fnc_hfsDestroyed;
};

{
	deleteVehicleCrew (_x select 0);
	deleteVehicle (_x select 0);
	deleteGroup (_x select 2);
} forEach _heloArr;

_cooldown = getMissionConfigValue "hfsCooldown";
if (_penalty) then {
	_cooldown = _cooldown + getMissionConfigValue "hfsPenalty";
};

sleep _cooldown;

missionNameSpace setVariable ["hfsStatus",0,true];

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"msg_hfsAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units be advised: Helicopters are standing by for fire support.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

deleteMarker _hfsMrk;
if (!isServer) exitWith {};

params ["_heloClass","_heloCount","_pos","_approachPos","_duration",["_customAudio",true],["_supportControlName","TOC"],["_side",west]];

_heloCfg = configfile >> "cfgvehicles" >> _heloClass;
_dir = [_approachPos,_pos] call BIS_fnc_dirTo;
_dis = 4000;
_heloPos = [_approachPos,_dis,_dir + 180] call bis_fnc_relpos;
_heloArr = [];
_heloVehArr = [];
_heloGrpArr = [];

for "_i" from 1 to _heloCount do {
	_heloSpawnArr = [_heloPos,_dir,_heloClass,_side] call bis_fnc_spawnVehicle;
	
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
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) exitWith {
	casHeloReturn = 1;
	publicVariable "casHeloReturn";
};

if (_customAudio) then {
	["Be advised: CAS arriving at stagin area.",_supportControlName,"msg_CASHeloArrive",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Be advised: CAS arriving at stagin area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

_timer = time;

waitUntil {sleep 1; time - _timer > _duration || {canMove _x} count _heloVehArr == 0};

{
	if (not canMove _x) then {
		deleteVehicleCrew _x;
		_x setDamage 1;
	};
} forEach _heloVehArr;

if ({alive _x} count _heloVehArr == 0) then {
	casHeloReturn = 2;
	publicVariable "casHeloReturn";
}
else {

	if (_customAudio) then {
		["Be advised: CAS Element is Bingo fuel and RTB.",_supportControlName,"msg_CASHeloRTB",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: CAS Element is Bingo fuel and RTB.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
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
				
				//_heloCrew select 0 moveTo _heloPos
				
				_wp2 = _heloGrp addWaypoint [_heloPos, 0];
				_wp2 setWaypointType "MOVE";
				_wp2 setWaypointCombatMode "BLUE";
				_wp2 setWaypointBehaviour "CARELESS";
				
				deleteWaypoint [_heloGrp, 0];
				
				_y = count waypoints _heloGrp;
				
				_heloGrp setCurrentWaypoint [_heloGrp, _y - 1];
				
				waituntil {sleep 0.5; _heloVehicle distance2D _heloPos < 300 || !alive _heloVehicle};
				
				deleteVehicle _heloVehicle;
				{deleteVehicle _x;} forEach _heloCrew select 1;
				deleteGroup _heloGrp;
			};
		};
	} forEach _heloArr;

	waitUntil {sleep 1; {alive _x} count _heloVehArr == 0};
	
	casHeloReturn = 4;
	publicVariable "casHeloReturn";
};
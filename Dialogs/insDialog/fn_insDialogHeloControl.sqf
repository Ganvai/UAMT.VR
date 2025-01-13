if (!isServer) exitWith {};

params ["_insHeloArray","_heloMarkers",["_side",west]];

_insHeloVeh = [];

{
	_insHeloVeh pushback (_x select 0);
}forEach _insHeloArray;

if (getMissionConfigValue "supportMessages" == "true") then {
	if (getMissionConfigValue "supportCustomAudio" == "true") then {
		["Helicopters are standing by and waiting for you.","Pilot","msg_heloReady",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Helicopters are standing by and waiting for you.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

waitUntil {sleep 1; {vehicle _x in _insHeloVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || missionNameSpace getVariable ["insertionCancel",false]};

{
	deleteMarker _x;
}forEach _heloMarkers;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;

	missionNameSpace setVariable ["insertionCancel",false,true];
	
	{
		deleteMarker _x;
	} forEach insHeloLZs;

	{
		// save current heli
		_veh = _x;
		
		// move all players out of the vehicle
		{
			if (isPlayer _x) then {
				_x moveOut _veh;
			};
		} forEach (crew _x);
		
		// close all doors of the heli
		{
			_veh animateDoor [_x,0];
			_veh animate [_x,0];
		} forEach (getMissionConfigValue "insHeloDoors");

		// lock the heli
		_veh lock true;
	}forEach _insHeloVeh;
	
	["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >Helicopter Insertion was cancelled!</t>", "PLAIN", 0.6, true, true]remoteExec ["titletext"];
};

missionstarted = true;
publicVariable "missionstarted";

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

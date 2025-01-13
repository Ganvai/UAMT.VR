if (!isServer) exitWith {};

params ["_insHeloArray",["_side",west]];

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

// Create Task for Players
private _title = "Board Helicopter";
private _description = "Board Insertion Helicopter to start the Mission. ALL Soldiers have to be on one of the helicopters.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], ((_insHeloArray select 0) select 0), true] call BIS_fnc_taskCreate;

_heloMarkers = [];

{
	_markerName = format ["Insertion Helo %1",(_forEachIndex + 1)];
	createMarker [_markerName, _x select 0];
	_markerName setMarkerType "hd_dot";
	_markerName setMarkerText _markerName;
	
	_heloMarkers pushback _markerName;
}forEach _insHeloArray;

_introSequence = "none";
if (getMissionConfigValue "insIntro" == "true") then {
	_introSequence = "scripts\UAMTScripts\insertion\insIntroHelis.sqf"
};

[[_insHeloArray,getMissionConfigValue "insHeloDoors",side player,_introSequence,getMissionConfigValue "supportMessages",getMissionConfigValue "supportControlName",getMissionConfigValue "supportCustomAudio"],"scripts\UAMTScripts\insertion\heloExecute.sqf"] remoteExec ["execVM",2];

waitUntil {sleep 1; {vehicle _x in _insHeloVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || missionNameSpace getVariable ["insertionCancel",false]};

{
	deleteMarker _x;
}forEach _heloMarkers;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;
	
	{
		_waypoints = _x select 2;
		
		{
			deleteMarker _x;
		}forEach _waypoints;
	}forEach _insHeloArray;

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
	
	missionNameSpace setVariable ["insControlCancelled",true,true];
};

missionstarted = true;
publicVariable "missionstarted";

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

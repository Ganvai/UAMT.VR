if (!isServer) exitWith {};

params ["_haloPos","_haloDir",["_side",west]];

_haloVeh = missionNameSpace getVariable [(getMissionConfigValue "insHALOVeh"),objNull];
_grpHalo = group _haloVeh;
_dir = _haloDir getDir _haloPos;

createMarker ["insHALOMrk",_haloPos];
"insHALOMrk" setMarkerAlpha 1;
"insHALOMrk" setMarkerType "hd_destroy_noShadow";
"insHALOMrk" setMarkerText "HALO Drop Pos";

createMarkerLocal ["insHALODirMrk",_haloDir];
"insHALODirMrk" setMarkerAlpha 1;
"insHALODirMrk" setMarkerType "hd_arrow_noShadow";
"insHALODirMrk" setMarkerText "HALO Approach Vector";

"insHALODirMrk" setMarkerDir _dir;

_haloVeh lock false;


_grpHalo setBehaviour "CARELESS";

private _title = "Board HALO Aircraft";
private _description = "Board the Aircraft for HALO Jump to start the Mission. ALL soldiers must be in the HALO aircraft.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], _haloVeh, true] call BIS_fnc_taskCreate;

_haloMarker = createMarker ["HALO Aircraft", _haloVeh];
_haloMarker setMarkerText "HALO Aircraft";
_haloMarker setMarkerType "hd_pickup_noShadow";

if (getMissionConfigValue "supportMessages" == "true") then {
	if (getMissionConfigValue "supportCustomAudio" == "true") then {
		["HALO Aircraft is ready and waiting for you. Get your parachutes and board the Aircraft.","Pilot","msg_HALOReady",_side] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["HALO Aircraft is ready and waiting for you. Get your parachutes and board the Aircraft.","Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

_haloCrate = missionNameSpace getVariable [(getMissionConfigValue "parachuteCrate"),objNull];

if (isClass(configFile >> "cfgPatches" >> "BackpackOnChest")) then {
	_insNoBoC = "";
	private _title = "Pack a Parachute";
	private _description = "Grab a Parachute from the crate. Put your backpack on chest before!";
	private _waypoint = "";

	[true, "taskinsParachute", [_description, _title, _waypoint], _haloCrate, true] call BIS_fnc_taskCreate;
}else {
	private _title = "Parachute at the Drop Crate";
	private _description = "Your equipment is to heavy to jump with it. Store it in the deployed crate and exchange it for a Parachute.<br/><br/>The crate will be dropped in the Drop Zone. There you can retrieve your gear.";
	private _waypoint = "";

	[true, "taskinsParachute", [_description, _title, _waypoint], _haloCrate, true] call BIS_fnc_taskCreate;
};

[[_haloVeh,getMissionConfigValue "insHaloDoors",_haloPos,_dir,52,_haloCrate,_side,"scripts\UAMTScripts\insertion\insIntroHalo.sqf",getMissionConfigValue "supportMessages",getMissionConfigValue "supportCustomAudio"],"scripts\UAMTScripts\insertion\haloexecute.sqf"] remoteExec ["execVM",2];

waitUntil {sleep 1; {vehicle _x in _haloVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || missionNameSpace getVariable ["insertionCancel",false]};

deleteMarker _haloMarker;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;
	["taskinsParachute",true,true] call BIS_fnc_deleteTask;

	missionNameSpace setVariable ["insertionCancel",false,true];
	
	deleteMarker "insHALOMrk";
	deleteMarker "insHALODirMrk";

	{
		_haloVeh animateDoor [_x,0];
		_haloVeh animate [_x,0];
	} forEach (getMissionConfigValue "insHALODoors");
	
	{
		if (isPlayer _x) then {
			_x moveOut _haloVeh;
		};
	} forEach (crew _haloVeh);
	
	_haloVeh lock true;
	
	missionNameSpace setVariable ["insControlCancelled",true,true];
};

missionNameSpace setVariable ["missionStarted",true,true];

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskinsParachute", "SUCCEEDED"] call BIS_fnc_taskSetState;

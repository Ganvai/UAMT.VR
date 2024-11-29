if (!isServer) exitWith {};

params [["_side",west]];

insControl = 2;
publicVariable "insControl";

insHALOVeh lock false;

_grpHalo = group insHALOVeh;

_grpHalo setBehaviour "CARELESS";

_customAudio = insCustomAudio;

private _title = "Board HALO Aircraft";
private _description = "Board the Aircraft for HALO Jump to start the Mission.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], insHALOVeh, true] call BIS_fnc_taskCreate;

if (insNoBoC) then {
	execVM "scripts\UAMTScripts\insertion\insNoBoC.sqf";
	
	sleep 2;
	
	private _title = "Parachute at the Drop Crate";
	private _description = "Your equipment is to heavy to jump with it. Store it in the crate at the heck of the HALO Aircraft and exchange it for a Parachute.<br/><br/>The crate will be dropped in the Drop Zone. There you can retrieve your gear.";
	private _waypoint = "";

	[true, "haloCargoCrate", [_description, _title, _waypoint], insNoBoCPos, true] call BIS_fnc_taskCreate;
};


_haloMarker = createMarker ["HALO Aircraft", insHALOVeh];
_haloMarker setMarkerType "hd_pickup_noShadow";

{
	insHALOVeh animateDoor [_x,1];
	insHALOVeh animate [_x,1];
} forEach insHALODoors;

if (_customAudio) then {
	["HALO Aircraft is ready and waiting for you. Get your parachutes and board the Aircraft.","Pilot","msg_HALOReady",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
}
else {
	["HALO Aircraft is ready and waiting for you. Get your parachutes and board the Aircraft.","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
};

waitUntil {sleep 1; ({(_x in insHALOVeh)} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers)) || insertionCancel };

deleteMarker _haloMarker;

{
	insHALOVeh animateDoor [_x,0];
	insHALOVeh animate [_x,0];
}forEach insHALODoors;

if (insertionCancel) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;
	["haloCargoCrate",true,true] call BIS_fnc_deleteTask;
	
	insertionCancel = false;
	publicVariable "insertionCancel";
	
	insControl = 0;
	publicVariable "insControl";
	
	insHALOVeh lock true;
	
	deleteMarker "Halo Drop Position";
	deleteMarker "Halo Approach Vector";
	["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >HALO Insertion was cancelled!</t>", "PLAIN", 0.6, true, true]remoteExec ["titletext"];
};

missionstarted = true;
publicVariable "missionstarted";

insHaloExecute = true;
publicVariable "insHaloExecute";

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

if (_customAudio) then {
	["All personal aboard. Starting Engines. Prepare for lift off.","Pilot","msg_HALOStart",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
}
else {
	["All personal aboard. Starting Engines. Prepare for lift off","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
};

// Setting up Variables
_HALOVeh = insHALOVeh;
_grpHalo = group _HALOVeh;
_approachPos = getMarkerPos "Halo Approach Vector";
_dropPos = getMarkerPos "Halo Drop Position";
_dir = _approachPos getDir _dropPos;
_despawnPos = _dropPos getpos [5000, _dir];
_wpRadius = 100;

//Adding Flightroute
if (_HALOVeh isKindOf "plane") then {
	_wp1Dir = getDir _HALOVeh;
	_startingPos = _HALOVeh getPos [8000,_wp1Dir];
	_wpRadius = 400;
	_grpHalo addWaypoint [_startingPos,_wpRadius];
	_wp2Dir = _approachPos getDir _dropPos;
	_wp2Dir = _wp2Dir + 180;
	_addApproachPos = _HALOVeh getPos [2000,_wp2Dir];
	_grpHalo addWaypoint [_addApproachPos,_wpRadius];
	[_grpHalo, 1] setWaypointSpeed "LIMITED";
};

_grpHalo addWaypoint [_approachPos,_wpRadius];
_grpHalo addWaypoint [_dropPos,_wpRadius];
_grpHalo addWaypoint [_despawnPos,_wpRadius];

_HALOVeh flyInHeight 3000;

[_HALOVeh,1] remoteExec ["setFuel"];

[_customAudio, _HALOVeh,_side] execVM "scripts\UAMTScripts\insertion\HALOflightattendant.sqf";

if (insIntro) then {
	_target = insHALOVeh;
	_line1 = getMissionConfigValue "introM";
	_line2 = getMissionConfigValue "backgroundM";
	_line3 = getMissionConfigValue "missionM";
	_titleHeader = getMissionConfigValue "titleHeader";
	_title = getMissionConfigValue "title";
	_tickerCountry = getMissionConfigValue "tickerCountry";
	_tickerLocation = getMissionConfigValue "tickerLocation";

	[[_line1, _line2, _line3, _titleHeader, _title, _tickerCountry, _tickerLocation],"scripts\UAMTScripts\insertion\insIntroHalo.sqf"] remoteExec ["execVM",[0, -2] select isDedicated];	
};

WaitUntil {sleep 0.1; (ASLToAGL eyePos driver _HALOVeh) select 2  > 2900};


WaitUntil {sleep 0.2; (_approachPos distance2D _HALOVeh < _wpRadius);};


if (_customAudio) then {
	["Setting course to Drop Zone. We will open the ramp one klick away. You coordinate your jump.","Pilot","msg_HALODropZone",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
}
else {
	["Setting course to Drop Zone. We will open the ramp one klick away. You coordinate your jump.","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
};

WaitUntil {sleep 0.1; (_dropPos distance2D _HALOVeh < 1500)};

if (_HALOVeh isKindOf "plane") then {
	if (_customAudio) then {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","msg_HALOOpening",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

{
	_HALOVeh animateDoor [_x,1];
	_HALOVeh animate [_x,1];
}forEach insHALODoors;

WaitUntil {sleep 0.1; (_dropPos distance2D _HALOVeh < 1000)};

if (_HALOVeh isKindOf "plane") then {
	if (_customAudio) then {
		["Let's go, gentlemen!","Pilot","letsGo",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["Let's go, gentlemen!","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	};
}
else {
	if (_customAudio) then {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","msg_HALOOpening",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["One Klick to the Drop Zone. Opening the Ramp... get ready to jump! (Double-Tab V).","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

WaitUntil {sleep 0.1; (_dropPos distance2D _HALOVeh < 500)};

if !(_HALOVeh isKindOf "plane") then {
	if (_customAudio) then {
		["Let's go, gentlemen!","Pilot","letsGo",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	}
	else {
		["Let's go, gentlemen!","Pilot","Radio",side _grpHalo] remoteExec ["UAMT_fnc_quickMsg"];
	};
};

WaitUntil {sleep 0.1; ( _despawnPos distance2D _HALOVeh < 500)};

deleteVehicleCrew _HALOVeh;
deleteVehicle _HALOVeh;

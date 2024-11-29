if (!isServer) exitWith {};

params ["_side"];

insControl = 2;
publicVariable "insControl";

_customAudio = insCustomAudio;

_carMarkers = [];

private _title = "Get into Vehicles";
private _description = "Get into the vehicles to start the mission.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], insCarVeh select 0, true] call BIS_fnc_taskCreate;

if (_customAudio) then {
	["Vehicles are fueled up and ready to go.","TOC","msg_carsReady",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Vehicles are fueled up and ready to go.","TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

for "_i" from 0 to ((count insCarVeh) - 1) do{

	_markerName = format ["Insertion Car %1",(_i + 1)];
	_tempMarker = createMarker [_markerName, insCarVeh select _i];
	_tempMarker setMarkerType "hd_dot";
	_tempMarker setMarkerText _markerName;
	
	_carMarkers pushback _markerName;
};

{
	_x lock false;
	[_x,1]remoteExec ["setFuel"];
}forEach insCarVeh;

waitUntil {sleep 1; {vehicle _x in insCarVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || insertionCancel};

{
	deleteMarker _x;
} forEach _carMarkers;

if (insertionCancel) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;

	insertionCancel = false;
	publicVariable "insertionCancel";
	
	insControl = 0;
	publicVariable "insControl";

	{
		_x lock true;
		[_x,0]remoteExec ["setFuel"];
	}forEach insCarVeh;
	
	["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >Ground Vehicle Insertion was cancelled!</t>", "PLAIN", 0.6, true, true]remoteExec ["titletext"];
};

missionstarted = true;
publicVariable "missionstarted";

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

if (insIntro) then {
	
	_line1 = getMissionConfigValue "introM";
	_line2 = getMissionConfigValue "backgroundM";
	_line3 = getMissionConfigValue "missionM";
	_titleHeader = getMissionConfigValue "titleHeader";
	_title = getMissionConfigValue "title";
	_tickerCountry = getMissionConfigValue "tickerCountry";
	_tickerLocation = getMissionConfigValue "tickerLocation";

	[[_line1, _line2, _line3, _titleHeader, _title, _tickerCountry, _tickerLocation],"scripts\UAMTScripts\insertion\insIntroCars.sqf"] remoteExec ["execVM",[0, -2] select isDedicated];	
};
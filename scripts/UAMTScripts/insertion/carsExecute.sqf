if (!isServer) exitWith {};

params ["_side"];

_supportMessages = getMissionConfigValue "supportMessages";
_supportControlName = getMissionConfigValue "supportControlName";
_supportCustomAudio = getMissionConfigValue "supportCustomAudio";

missionNameSpace setVariable ["insertionActual","GroundVehicles",true];

_insCarVehStrings = getMissionConfigValue "insCarVeh";
_insCarVeh = [];

{
	_insCarVeh pushback (missionNameSpace getVariable [_x,objnull]);
}forEach _insCarVehStrings;

_carMarkers = [];

private _title = "Get into Vehicles";
private _description = "Get into the vehicles to start the mission. Once all Players are in the vehicles, the vehicles will be fuelled up and the mission will start.";
private _waypoint = "";

[true, "task00boardVehicle", [_description, _title, _waypoint], _insCarVeh select 0, true] call BIS_fnc_taskCreate;

if (_supportMessages == "true") then {
	if (_supportCustomAudio == "true") then {
		["Vehicles are fueled up and ready to go.",_supportControlName,"msg_carsReady",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Vehicles are fueled up and ready to go.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

for "_i" from 0 to ((count _insCarVeh) - 1) do{

	_markerName = format ["Insertion Car %1",(_i + 1)];
	_tempMarker = createMarker [_markerName, _insCarVeh select _i];
	_tempMarker setMarkerType "hd_dot";
	_tempMarker setMarkerText _markerName;
	
	_carMarkers pushback _markerName;
};

{
	_x lock false;
	[_x,1]remoteExec ["setFuel"];
}forEach _insCarVeh;

waitUntil {sleep 1; {vehicle _x in _insCarVeh} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers) || missionNameSpace getVariable ["insertionCancel",false]};

{
	deleteMarker _x;
} forEach _carMarkers;

if (missionNameSpace getVariable ["insertionCancel",false]) exitWith {
	["task00boardVehicle",true,true] call BIS_fnc_deleteTask;

	missionNameSpace setVariable ["insertionCancel",false,true];
	
	missionNameSpace setVariable ["insertionActual","",true];

	{
		_x lock true;
		[_x,0]remoteExec ["setFuel"];
	}forEach _insCarVeh;
	
	["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >Ground Vehicle Insertion was cancelled!</t>", "PLAIN", 0.6, true, true]remoteExec ["titletext"];
};

missionNameSpace setVariable ["missionstarted",true,true];

["task00boardVehicle", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrep", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepLoadouts", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepMethod", "SUCCEEDED"] call BIS_fnc_taskSetState;
["taskInsPrepTime", "SUCCEEDED"] call BIS_fnc_taskSetState;

if (getMissionConfigValue "insIntro" == "true") then {
	
	_line1 = getMissionConfigValue "introM";
	_line2 = getMissionConfigValue "backgroundM";
	_line3 = getMissionConfigValue "missionM";
	_titleHeader = getMissionConfigValue "titleHeader";
	_title = getMissionConfigValue "title";
	_tickerCountry = getMissionConfigValue "tickerCountry";
	_tickerLocation = getMissionConfigValue "tickerLocation";

	[[_line1, _line2, _line3, _titleHeader, _title, _tickerCountry, _tickerLocation],"scripts\UAMTScripts\insertion\insIntroCars.sqf"] remoteExec ["execVM",[0, -2] select isDedicated];	
};
params ["_heli","_destination",["_startMode",0],["_engineOn",true],["_voicelines",true],["_startMapMarker",""],["_destMapMarker",""]];

_heliGrp = group _heli;
_heli allowDamage false;
_heli setCaptive true;

"Land_HelipadEmpty_F" createVehicle _destination;

if (_engineOn) then {
	[_heli,1]remoteExec ["setFuel",_heli];
	_heli engineOn true;
};

if (_startMode == 1) then {
	_heli setVariable ["_startOrders",false];

	_heli addAction [
		"Start Heli",
		"(_this select 0) setVariable ['_startOrders',true];",
		"",
		1,
		false,
		true,
		"",
		"(_target getVariable ['_startOrders',false]) == false",
		10
	];

	waitUntil {sleep 1; _heli getVariable ["_startOrders",false];};
};

if (_startmode == 2) then {
	waitUntil {sleep 1; {vehicle _x in _heli} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers)};
};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\038_cut_in_helicopter\showcase_future_038_cut_in_helicopter_PILOT_0.ogg",_heli,false,getPos _heli, 5, 1, 50];
	sleep 2;
	playSound3D ["a3\dubbing_f_aow\showcase_future\038_cut_in_helicopter\showcase_future_038_cut_in_helicopter_PILOT_2.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

[_heli,1]remoteExec ["setFuel",_heli];

{
	_x enableAI "MOVE";
	_x enableAI "PATH";
} forEach units _heliGrp;

_wp1 = _heliGrp addWaypoint [_destination, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

waitUntil {sleep 1;_destination distance2D _heli <  50};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\001_int_helicopter_insertion\showcase_future_001_int_helicopter_insertion_PILOT_1.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

_timer = time;

waitUntil {sleep 1;_destination distance2D _heli <  8 || time - _timer > 180};

if (time - _timer > 180) then {
	[_heliGrp] call CBA_fnc_clearWaypoints;

	_wp1 = _heliGrp addWaypoint [_destination, 0];
	_wp1 setWaypointType "LOAD";
	_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
	_wp1 setWaypointBehaviour "CARELESS";
};

waitUntil {sleep 1;(velocity  _heli select 2) > -0.2 &&	(getPosATL _heli select 2) <  0.5};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_gamma\showcase_armed_assault\05_InsertionFinished\showcase_armed_assault_05_insertionfinished_ALP_0.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

if (_startMapMarker != "") then {
	deleteMarker _startMapMarker;
};

if (_destMapMarker != "") then {
	deleteMarker _destMapMarker;
};

[_heli,0]remoteExec ["setFuel",_heli];

{
	_x enableAI "MOVE";
	_x enableAI "PATH";
} forEach units _heliGrp;

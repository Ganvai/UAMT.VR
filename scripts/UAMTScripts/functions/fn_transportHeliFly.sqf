params ["_heliVeh", "_heliGrp", "_pickupPos", "_destPos", "_despawnPos", ["_voiceLines",true], "_pickUpMapMarker", "_destMapMarker"];

_crew = count (crew _heliVeh);

_wp1 = _heliGrp addWaypoint [_pickupPos, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

waitUntil {sleep  1;(velocity  _heliVeh select 2) > -0.2 &&	(getPosATL _heliVeh select 2) <  0.5};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_epa\a_in\10_All_In\a_in_10_all_in_ICO_0.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
	sleep 2;
	playSound3D ["a3\dubbing_f_epa\a_in\05_Load_Up\a_in_05_load_up_ICO_0.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
};

_heliVeh setVariable ["_startOrders",false];

_heliVeh addAction [
	"Order Helicopter start",
	"(_this select 0) setVariable ['_startOrders',true];",
	"",
	100,
	true,
	true,
	"",
	"((_target getVariable ['_startOrders',false]) == false) && (vehicle player == _target)",
	10
];

waitUntil {sleep 1; _heliVeh getVariable ["_startOrders",false];};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\001_int_helicopter_insertion\showcase_future_038_cut_in_helicopter_PILOT_0.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
	sleep 2;
	playSound3D ["a3\dubbing_f_aow\showcase_future\001_int_helicopter_insertion\showcase_future_038_cut_in_helicopter_PILOT_2.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
};

_wp1 = _heliGrp addWaypoint [_destPos, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

waitUntil {sleep 1;_destPos distance2D _heliVeh <  20};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\001_int_helicopter_insertion\showcase_future_001_int_helicopter_insertion_PILOT_1.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
};

waitUntil {sleep 1;(velocity  _heliVeh select 2) > -0.2 &&	(getPosATL _heliVeh select 2) <  0.5};

deleteMarker _pickUpMapMarker;
deleteMarker _destMapMarker;

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_gamma\showcase_armed_assault\05_InsertionFinished\showcase_armed_assault_05_insertionfinished_ALP_0.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
};

if (_despawnPos isEqualTo [0,0,0]) exitWith {
	[_heliVeh,0]remoteExec ["setFuel",_heliVeh];
};

waitUntil {sleep 1; (count (crew _heliVeh) <= _crew)};

_wp1 = _heliGrp addWaypoint [_despawnPos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];

WaitUntil {sleep 1; (_despawnPos distance2D _heliVeh < 50) || !canMove _heliVeh};

deleteVehicleCrew _heliVeh;
deleteVehicle _heliVeh;
params ["_heliIndex","_pickUpMrk", "_dropOffMrk","_side"];

_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;

_heliclass = chtClasses select _heliIndex;
_heliPassengers = [];

_spawnPos = getMarkerPos chtSpawn;
_pickupPos = getMarkerPos _pickUpMrk;
_destPos = getMarkerPos _dropOffMrk;

_despawnPos = getMarkerPos chtDespawn;

//Spawn invisible helipads
_pad1 = "Land_HelipadEmpty_F" createVehicle _pickupPos;
_pad2 = "Land_HelipadEmpty_F" createVehicle _destPos;

// Set position for spawn to 100 meter height
_spawnPos set [2,100];

// Get direction to spawn heli
_dir = _spawnPos getDir _pickupPos;

// Spawn the heli
_transVeh = [_spawnPos, _dir, _heliclass, _side] call BIS_fnc_spawnVehicle;

// Get Variables for later use
_heliGrp = _transVeh select 2;
_heliCrew = _transVeh select 1;
_heliVeh = _transVeh select 0;
_crew = count _heliCrew;

// Move Helicopter to the exact location
_heliVeh setPos _spawnPos;

_heliVeh allowDamage false;

// AI Behaviour
{
	_x disableAI "AUTOCOMBAT";
	_x disableAI "COMBAT";
	_x disableAI "AUTOTARGET";
	_x disableAI "TARGET";
	_x disableAI "COVER";
	_x disableAI "SUPPRESSION";
}forEach _heliCrew;

if (_audioMessages) then {
	_msg = "This is Helo Airtaxi. Pickup location recieved. We are on our way.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportConfirm",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

_wp1 = _heliGrp addWaypoint [_pickupPos, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

waitUntil {sleep  1;(velocity  _heliVeh select 2) > -0.2 &&	(getPosATL _heliVeh select 2) <  0.5};

if (_audioMessages) then {
	_msg = "Helo Airtaxi touchdown. Board the chopper. Give the orders when everybody is on board.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportPickup",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

_heliVeh setVariable ["_startOrders",false];

[_heliVeh, [
	"<img image='\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa'/><br/><t>Start Heli</t>",
	"_result = false;private _result = ['Everybody on board? Do you want the Helicopter to start?', 'Give starting order to Helicopter', true, true] call BIS_fnc_guiMessage;if (!_result) exitWith {};(_this select 0) setVariable ['_startOrders',true,true];[_this select 0, _this select 2] remoteExec ['removeAction']",
	"",
	1000,
	true,
	true,
	"",
	"(_target getVariable ['_startOrders',false]) == false && vehicle _this == _target",
	10]] remoteExec ["addAction",0,_heliVeh];



// AI Behaviour
sleep 5;
{
	_x disableAI "MOVE";
}forEach _heliCrew;

waitUntil {sleep 1; _heliVeh getVariable ["_startOrders",false];};

// AI Behaviour
{
	_x enableAI "MOVE";
}forEach _heliCrew;

_heliPassengers = crew _heliVeh arrayIntersect allPlayers;

if (_audioMessages) then {
	_msg = "All ground personal on board. Ge ready for Lif-Off.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportLiftOff",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	};
};

_wp1 = _heliGrp addWaypoint [_destPos, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

waitUntil {sleep 1;_destPos distance2D _heliVeh <  20};

waitUntil {sleep 1;(velocity  _heliVeh select 2) > -0.2 &&	(getPosATL _heliVeh select 2) <  0.5};

if (_audioMessages) then {
	_msg = "Touchdown on designated Coordinates. Everybody get out. Good luck out there.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportArrival",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	};
};

deleteMarker _pickUpMrk;
deleteMarker _dropOffMrk;

sleep 5;

// AI Behaviour
{
	_x disableAI "MOVE";
}forEach _heliCrew;

waitUntil {sleep 1; (count (crew _heliVeh) <= _crew)};

deleteVehicle _pad1;
deleteVehicle _pad2;
// AI Behaviour
{
	_x enableAI "MOVE";
}forEach _heliCrew;

_wp1 = _heliGrp addWaypoint [_despawnPos, 0];
_wp1 setWaypointType "MOVE";

WaitUntil {sleep 1; (_despawnPos distance2D _heliVeh < 50) || !canMove _heliVeh};

deleteVehicleCrew _heliVeh;
deleteVehicle _heliVeh;
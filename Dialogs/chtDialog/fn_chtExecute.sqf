params ["_heliclass","_heliIndex","_pickupPos", "_destPos","_pickUpPosText","_dropOffPosText","_chtNumber","_player"];

_audioMessages = supportMessages;
_customAudio = supportCustomAudio;
_supportControlName = supportControlName;

_heliPassengers = [];

_side = side _player;

_spawnPos = getMarkerPos chtSpawn;

_despawnPos = getMarkerPos chtDespawn;

_chtPickUpMrkName = format ["chtPickUpMrk%1",_chtNumber];
createMarker [_chtPickUpMrkName,_pickupPos];
_chtPickUpMrkName setMarkerAlpha 0;
_chtPickUpMrkName setMarkerType "hd_pickup_noShadow";
_chtPickUpMrkName setMarkerText _pickUpPosText;

_chtDropOffMrkName = format ["chtDropOffMrk%1",_chtNumber];
createMarker [_chtDropOffMrkName,_destPos];
_chtDropOffMrkName setMarkerAlpha 0;
_chtDropOffMrkName setMarkerType "hd_end_noShadow";
_chtDropOffMrkName setMarkerText _dropOffPosText;

//Spawn invisible helipads
_pad1 = "Land_HelipadEmpty_F" createVehicle _pickupPos;
_pad2 = "Land_HelipadEmpty_F" createVehicle _destPos;

// Set position for spawn to 100 meter height
_spawnPos set [2,100];

// Get direction to spawn heli
_dir = _spawnPos getDir _pickupPos;

// Spawn the heli
_heliSide = _side;
if (getMissionConfigValue "chtCivil" == "true") then {
	_heliside = civilian;
};

_transVeh = [_spawnPos, _dir, _heliclass, _heliSide] call BIS_fnc_spawnVehicle;

// Get Variables for later use
_heliGrp = _transVeh select 2;
_heliCrew = _transVeh select 1;
_heliVeh = _transVeh select 0;
_crew = count _heliCrew;

// Move Helicopter to the exact location
_heliVeh setPos _spawnPos;

if (getMissionConfigValue "chtDamage" == "false") then {
	_heliVeh allowDamage false;
	{_x allowDamage false;} forEach _crew;
};

// AI Behaviour
{
	_x disableAI "AUTOCOMBAT";
	_x disableAI "AUTOTARGET";
	_x disableAI "TARGET";
	_x disableAI "COVER";
	_x disableAI "SUPPRESSION";
	_x setskill ["Courage",1.0];
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
sleep 10;
{
	_x disableAI "MOVE";
}forEach _heliCrew;

_timer = time;

waitUntil {sleep 1; time - _timer > 600 || count (crew _heliVeh) > _crew || !canMove _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

if (count (crew _heliVeh) == _crew) then {
	["The Transport Helicopter is at it the Pickup Zone but it can only wait for another five Minutes. If no personal is there, it will return to base.","TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_player];
};

waitUntil {sleep 1; time - _timer > 900 || count (crew _heliVeh) > _crew || !canMove _heliVeh};

if  (time - _timer > getMissionConfigValue "chtTimeOut"  && count (crew _heliVeh) == _crew && canMove _heliVeh) exitWith {

	if (count (crew _heliVeh) == _crew) then {
		["Nobody showed up. The Transport Helicopter is returning to base.","TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_player];
	};
	
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
};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

waitUntil {sleep 1; _heliVeh getVariable ["_startOrders",false] || !canMove _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

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

waitUntil {sleep 1;_destPos distance2D _heliVeh <  20 || !canMove _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

waitUntil {sleep 1;(velocity  _heliVeh select 2) > -0.2 &&	(getPosATL _heliVeh select 2) <  0.5 || !canMove  _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

if (_audioMessages) then {
	_msg = "Touchdown on designated Coordinates. Everybody get out. Good luck out there.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportArrival",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	};
};

deleteMarker _chtPickUpMrkName;
deleteMarker _chtDropOffMrkName;

sleep 10;

// AI Behaviour
{
	_x disableAI "MOVE";
}forEach _heliCrew;

waitUntil {sleep 1; (count (crew _heliVeh) <= _crew) || !canMove _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

if (_audioMessages) then {
	_msg = "Everybody is out. We are on our way back.";

	if (_customAudio) then {
		[_msg,"Pilot","msg_transportBack",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	}
	else {
		[_msg,"Pilot","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_heliPassengers];
	};
};

deleteVehicle _pad1;
deleteVehicle _pad2;
// AI Behaviour
{
	_x enableAI "MOVE";
}forEach _heliCrew;

_wp1 = _heliGrp addWaypoint [_despawnPos, 0];
_wp1 setWaypointType "MOVE";

WaitUntil {sleep 1; (_despawnPos distance2D _heliVeh < 50) || !canMove _heliVeh};

if (!canMove _heliVeh) exitWith {
	waitUntil { sleep 1; {isPlayer _x} count (crew _heliVeh) == 0 };
	[_heliVeh,_heliIndex,_side]call chtDialog_fnc_chtDestroyed;
};

deleteVehicleCrew _heliVeh;
deleteVehicle _heliVeh;

if (_audioMessages) then {
	_msg = "All personal be advised: Transport helicopter is back at base.";

	if (_customAudio) then {
		[_msg,"TOC","msg_transportAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

sleep 5;

if (_audioMessages) then {
	_msg = "Preparing Helicopter for new transport request.";

	if (_customAudio) then {
		[_msg,"TOC","msg_transportRefuel",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};	

_cooldown = parseNumber getMissionConfigValue "chtCooldown";

sleep _cooldown;

_heliTempArray = missionNameSpace getVariable "chtHeliArray";
(_heliTempArray select _heliIndex) set [1,true];

missionNameSpace setVariable ["chtHeliArray",_heliTempArray,true];

if (_audioMessages) then {
	_msg = "All personal be advised: Transport helicopter is fueled up and standing by.";

	if (_customAudio) then {
		[_msg,"TOC","msg_transportAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,"TOC","Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};
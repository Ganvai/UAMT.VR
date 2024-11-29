//-------------------------------------------------------------------
//-------------------------------------------------------------------
//
//					Transport Scripts
//					
// With this script you can call a Transport to the given Coordinates
// The Transport Helo will be spawned at the first location, wait 
// until the responsible Player gives the Orders and then fly to
// the destination.
//
// You can choose if you want custom Audio messages from the UAMT
// or if you want just random radio noise with a text.
//
// You can also decided if you want the Helicopter to be damageble
// or not. Consider that sometimes AI Pilots can fly a bit shitty
// and crash while landing. 
//
// example for Call:
// [[_pickUpPos,_destinationPos,_spawnPos,_trpVehicleClass,_trpAllowDamage,_customAudio,_supportControlName,side player],"Scripts\UAMTScripts\transport\transportFly.sqf"]remoteExec ["execVM",2];
//
// _pickUpPos = AGL Position Array
// _destinationPos = AGL Position Array
// _spawnPos = AGL Position Array
// _trpVehicleClass = Vehicle className
// _trpAllowDamage = Boolean Default: true (OPTIONAL)
// _customAudio = Boolean Default: true (OPTIONAL)
// _supportControlName = String Default: "Airtaxi"(OPTIONAL) - Name that is written in the Audio Message Subtitles - 
// _callerSide = side Default: west - Defines the color of the _supportControlName in the Subtitles of the messages
//
// This Script needs the UAMT_fnc_quickMsg
//
// Defines a publicVariable "transportReturn" that gives return Codes
// that can be handled:
// 1: Transport was destroyed
// 2: Transport Successfull and despawned
//
//-------------------------------------------------------------------
//-------------------------------------------------------------------
if (!isServer) exitWith {};

params ["_pickup","_transportPos","_spawnPos",["_vehicle","B_Heli_Transport_03_unarmed_F"],["_allowDmg",true],["_customAudio",true],["_callerID","Airtax"],["_callerSide",west]];

//Preping Script Variables
orderHeliStart = false;
publicVariable "orderHeliStart";

transportStartOrders = false;
publicVariable "transportStartOrders";

_dir = _spawnPos getDir _pickup;
_dir2 = _pickup getDir _transportPos;

//Prepare Pickup and Transport Positions
_pickupPad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
_pickupPad setPosASL _pickup;
_pickupPad setDir _dir;

_transportPad = "Land_HelipadEmpty_F" createVehicle [0,0,0];
_transportPad setPosASL _transportPos;
_transportPad setDir _dir2;

// Spawning the Helicopter
_transVeh = [_spawnPos, _dir, _vehicle, _callerSide] call BIS_fnc_spawnVehicle;
_transportGroup = _transVeh select 2;
transportVehicle = _transVeh select 0;
publicVariable "transportVehicle";
transportVehicle allowDamage false;

_crew = count crew transportVehicle;

//Set the first Waypoint for the Helicopter
_wp1 = _transportGroup addWaypoint [_pickup, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "transportVehicle land ""GET IN"";"];
_wp1 setWaypointBehaviour "careless";

// Place a visual marker for the Players on the Pick Up position
_smokey1 = "SmokeShellGreen" createVehicle [(getPos _pickupPad select 0),(getPos _pickupPad select 1),0.2];
_cl1 = "Chemlight_green" createVehicle  [(getPos _pickupPad select 0),(getPos _pickupPad select 1),0.2];

if (_customAudio) then {
	["This is Helo Airtaxi 1-0-7. Pickup Location recieved. We are on our way.","Airtaxi","msg_transportConfirm",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];	
}
else {
	["This is Helo Airtaxi 1-0-7. Pickup Location recieved. We are on our way.","Airtaxi","Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];	
};

waitUntil {sleep 0.1; ((velocity  transportVehicle select 2) > -0.2 && (getPosATL transportVehicle select 2) <  1) || !canMove transportVehicle};

if (!canMove transportVehicle) exitWith {
	
	if (alive transportVehicle) then {
		deleteVehicleCrew transportVehicle;
		transportVehicle setDamage 1;
	};

	transportReturn = 1;
	publicVariable "transportReturn";
	
	if (_customAudio) then {
		["Transport Helicopter was destroyed.",_callerID,"msg_transportDestroyed",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["Transport Helicopter was destroyed.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
	
	deleteVehicle _pickupPad;
	deleteVehicle _transportPad;
};

if (_customAudio) then {
	["Helo-Airtaxi 1-0-7, touchdown. Board the Chopper and give the orders when everybody is on board.","Airtaxi","msg_transportPickup",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["Helo-Airtaxi 1-0-7, touchdown. Board the Chopper and give the orders when everybody is on board.","Airtaxi","Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};

// Activates the Option for the responsible Player to order the Helicopter Lift Off
transportStartOrders = true;
publicVariable "transportStartOrders";


waitUntil {sleep 1; orderHeliStart || !canMove transportVehicle};

if (!canMove transportVehicle) exitWith {

	if (alive transportVehicle) then {
		deleteVehicleCrew transportVehicle;
		transportVehicle setDamage 1;
	};

	transportReturn = 1;
	publicVariable "transportReturn";
	
	if (_customAudio) then {
		["Transport Helicopter was destroyed.",_callerID,"msg_transportDestroyed",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["Transport Helicopter was destroyed.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
	
	deleteVehicle _pickupPad;
	deleteVehicle _transportPad;
};


if (_customAudio) then {
	["All ground personal on board. Get ready for Lift-Off.","Airtaxi","msg_transportLiftOff",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["All ground personal on board. Get ready for Lift-Off.","Airtaxi","Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};

// Resets all Variables needed for Helicopter Lift Off
orderHeliStart = false;
publicVariable "orderHeliStart";

transportStartOrders = false;
publicVariable "transportStartOrders";

// Add Waypoint for Destination
_wp2 = _transportGroup addWaypoint [_transportPos, 0];
_wp2 setWaypointType "UNLOAD";
_wp2 setWaypointStatements ["true", "transportVehicle land ""GET IN"";"];

sleep 10;

waitUntil {((velocity  transportVehicle select 2) > -0.2 &&	(getPosATL transportVehicle select 2) <  1) || (count (crew transportVehicle) <= _crew) || !canMove transportVehicle};

if (!canMove transportVehicle) exitWith {

	if (alive transportVehicle) then {
		deleteVehicleCrew transportVehicle;
		transportVehicle setDamage 1;
	};

	transportReturn = 1;
	publicVariable "transportReturn";
	
	if (_customAudio) then {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"msg_transportDestroyed",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
	
	deleteVehicle _pickupPad;
	deleteVehicle _transportPad;
};

if (count (crew transportVehicle) > _crew) then {
	if (_customAudio) then {
		["Touchdown on designated coordinates. Everybody get out. Good luck out there.","Airtaxi","msg_transportArrival",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["Touchdown on designated coordinates. Everybody get out. Good luck out there.","Airtaxi","Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
};

// Wait until everybody is out
waitUntil {sleep 1; (count (crew transportVehicle) <= _crew) || !canMove transportVehicle};

if (!canMove transportVehicle) exitWith {

	if (alive transportVehicle) then {
		deleteVehicleCrew transportVehicle;
		transportVehicle setDamage 1;
	};
	
	transportReturn = 1;
	publicVariable "transportReturn";
	
	if (_customAudio) then {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"msg_transportDestroyed",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
	
	deleteVehicle _pickupPad;
	deleteVehicle _transportPad;
};

if (_customAudio) then {
	["Everybody is out. We are on our way back.","Airtaxi","msg_transportBack",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["Everybody is out. We are on our way back.","Airtaxi","Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};


_wp2 = _transportGroup addWaypoint [_spawnPos, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointStatements ["true", "transportVehicle land ""GET IN"";"];

WaitUntil {sleep 1; (_spawnPos distance2D transportVehicle < 200) || !canMove transportVehicle};

if (!canMove transportVehicle) exitWith {

	if (alive transportVehicle) then {
		deleteVehicleCrew transportVehicle;
		transportVehicle setDamage 1;
	};
	
	transportReturn = 1;
	publicVariable "transportReturn";
	
	if (_customAudio) then {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"msg_transportDestroyed",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["All personal be advised: Transport Helicopter was destroyed.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
	
	deleteVehicle _pickupPad;
	deleteVehicle _transportPad;
};


//Deleting Crew and Vehicle
DeleteVehicleCrew transportVehicle;
DeleteVehicle transportVehicle;

transportReturn = 2;
publicVariable "transportReturn";

if (_customAudio) then {
	["All personal be advised: Transport Helicopter is back at Base.",_callerID,"msg_transportBase",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["All personal be advised: Transport Helicopter is back at Base.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};
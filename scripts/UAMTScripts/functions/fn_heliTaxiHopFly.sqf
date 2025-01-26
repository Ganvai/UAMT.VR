//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//
//		Heli Taxi Hop Fly
//
// Lets an existing Helicopter fly to a Position on the map and land there.
// The Helicopter will then stay at this position.
//	
// Attributes:
// _heli : <OBJECT> Helicopter Object
// _destination : <POS> Position where the helicopter should land
// _startMode : <NUMBER> Mode how the Helicopter will start:
//							0: Helicopter will start immediatly
//							1: All players in the Helicopter will have an addAction to start the Helicopter. A GUI Question will pop up and ask if all Players are on board before it starts.
//							2: Waits until ALL Players on the map are in the Helicopter
// _engineOn : <BOOLEAN> Default true - If true, the helicopter will start the engine while waiting. If false, the helicopter will start the engine when it is about to lift off
// _voicelines : <BOOLEAN> Default true - Will Play english voice lines when starting and landing
// _startMapMarker : <STRING> Default "" - If you have a Marker at the startposition of the Helicopter, you can give it's name here and the function will automatically delete it when the helicopter arrives its destination.
// _destMapMarker : <STRING> Default "" - If you have a Marker at the destination of the Helicopter, you can give it's name here and the function will automatically delete it when the helicopter arrives its destination.
//
// Call:
// [helicopter1,[1,1,1],1,true,true,"StartMarker","DestMarker"] call UAMT_fnc_heliTaxiHopFly;
//
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

params ["_heli","_destination",["_startMode",0],["_engineOn",true],["_voicelines",true],["_startMapMarker",""],["_destMapMarker",""]];

//Setting up the Helicopter

// Getting the helicopters group for Waypoints
_heliGrp = group _heli;
// No Damage for Helicopters because AI Pilots
_heli allowDamage false;
// Making Helicopter Captive so it doesn't get shot
_heli setCaptive true;
// Saving Helicopter Crew to later know if Heli is Empty 
_crew = crew _heli;

// Disabling AI for all AI Crew
{
	_x disableAI "AUTOCOMBAT";
	_x disableAI "COMBAT";
	_x disableAI "AUTOTARGET";
	_x disableAI "TARGET";
	_x disableAI "COVER";
	_x disableAI "SUPPRESSION";	
}forEach _crew;

// Creating a landing Pad at the destination
_pad = "Land_HelipadEmpty_F" createVehicle _destination;

// Giving fuel and starting Engine for the Helicopter
if (_engineOn && isEngineOn _heli == false) then {
	[_heli,1]remoteExec ["setFuel",_heli];
	_heli engineOn true;
};

// Managing the Start Mode

if (_startMode == 1) then {
	// Start Mode 1 : Starting via AddAction
	
	// Creating a Variable for the Helicopter to start
	_heli setVariable ["_startOrders",false];

	// Creating Add Action only visible if you are sitting in the Helicopter
	[_heli, [
		"<img image='\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa'/><br/><t>Start Heli</t>",
		"_result = false;private _result = ['Everybody on board? Do you want the Helicopter to start?', 'Give starting order to Helicopter', true, true] call BIS_fnc_guiMessage;if (!_result) exitWith {};(_this select 0) setVariable ['_startOrders',true,true];[_this select 0, _this select 2] remoteExec ['removeAction']",
		"",
		1000,
		true,
		true,
		"",
		"(_target getVariable ['_startOrders',false]) == false && vehicle _this == _target",
		10]] remoteExec ["addAction",0,_heli];
	
	// Waiting until _startOrders is true
	waitUntil {sleep 1; _heli getVariable ["_startOrders",false];};
};

// Start Mode 2 : Wait until ALL Players on the Map are on board
if (_startmode == 2) then {
	waitUntil {sleep 1; {vehicle _x in _heli} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers)};
};

// Pilots call out the start
if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\038_cut_in_helicopter\showcase_future_038_cut_in_helicopter_PILOT_0.ogg",_heli,false,getPos _heli, 5, 1, 50];
	sleep 3.5;
	playSound3D ["a3\dubbing_f_aow\showcase_future\038_cut_in_helicopter\showcase_future_038_cut_in_helicopter_PILOT_2.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

// Setting Fuel to 1 if Missionmaker did set it to 0 to make Helicopter stay on position
[_heli,1]remoteExec ["setFuel",_heli];

// Enabling AI for Helicopter AI crew if this was disabled by Missionmaker to make Helicopter stay on position
{
	_x enableAI "MOVE";
	_x enableAI "PATH";
} forEach units _heliGrp;

// Add the Waypoint to the destination
_wp1 = _heliGrp addWaypoint [_destination, 0];
_wp1 setWaypointType "LOAD";
_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
_wp1 setWaypointBehaviour "CARELESS";

// Wait until Helicopter is only 50 meters away from destination
waitUntil {sleep 1;_destination distance2D _heli <  50};

// Pilots make callout they are arriving at destination
if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_aow\showcase_future\001_int_helicopter_insertion\showcase_future_001_int_helicopter_insertion_PILOT_1.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

// Debug Timer
_timer = time;

// Wait until helicopter is only 8 meters away from Landingpad or if 3 minutes since the last waitUntil have passed (Debug to see if landing script bugged out)
waitUntil {sleep 1;_destination distance2D _heli <  8 || time - _timer > 180};

// If Landing Script bugged out, clear all waypoints and create new Waypoint
if (time - _timer > 180) then {
	[_heliGrp] call CBA_fnc_clearWaypoints;

	// Set a new waypoint with a larger radius
	_wp1 = _heliGrp addWaypoint [_destination, 30];
	_wp1 setWaypointType "LOAD";
	_wp1 setWaypointStatements ["true", "vehicle this land ""GET IN"";"];
	_wp1 setWaypointBehaviour "CARELESS";
};

// Wait until the helicopter has landed
waitUntil {sleep 1;(velocity  _heli select 2) > -0.2 &&	(getPosATL _heli select 2) <  0.5};

// Pilots call out landing
if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_gamma\showcase_armed_assault\05_InsertionFinished\showcase_armed_assault_05_insertionfinished_ALP_0.ogg",_heli,false,getPos _heli, 5, 1, 50];
};

// The Map Marker for the Start Position of the helicopter gets deleted
if (_startMapMarker != "") then {
	deleteMarker _startMapMarker;
};

// The Map Marker for the Destination Position of the helicopter gets deleted
if (_destMapMarker != "") then {
	deleteMarker _destMapMarker;
};

// Fuel of the helicopter gets set to 0 so it doesn't fly away
[_heli,0]remoteExec ["setFuel",_heli];

// Landing Pad gets create to not leave to much garbage on the map
deleteVehicle _pad;
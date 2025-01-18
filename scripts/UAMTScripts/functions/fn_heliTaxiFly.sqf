//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// 			Heli Taxi Fly
//
// Makes a Helicopter fly to the _pickUpPos where it lands and waits until player activate a "Start Heli" addAction added to the vehicle. It then flies
// to the _destPos where it lands and waits until all Players are out. If a _despawnPos is given, it then flies to this Position where it gets despawned.
// If no despawnPos is given, it just stays at the _destPos.
//
// Is controlled by HeliTaxiCall that handles multiple Helicopters or different inputs (like Markernames instead of positions). HeliTaxiCall will also spawn helicopters.
// This function is meant to be used for existing helicopters or as sub function from HeliTaxiCall.
//
//	
// Attributes:
//
// _heliVeh : <OBJECT> Helicopter to fly
// _heliGrp : <GROUP> Group of helicopter.
// _pickUpPos : <POSAGL> First landing position to pick up players
// _destPos : <POSAGL> Second landing position to drop off players
// _despawnPos : <POSAGL> (OPTIONAL, Default : []) Position to fly after dropOff where helicopter despawns.
// _pickUpMapMarker : <STRING> (OPTIONAL, Default : "") If Map markers for LZs where created, you can give them here and they will be deleted automatically after the helicopter dropped off the Players
// _voiceLines: <BOOL> If true, the function playes voicelines for the players to give information about their status. Needs UAMT sounds config for this.
//
// Call:
// [_heliVeh,_heliGrp,_pickupPos,_destPosMrk,_despawnPos,_pickUpMapMarker,_destMapMarker,_voiceLines] call UAMT_fnc_heliTaxiFly;
//
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

params ["_heliVeh", "_heliGrp", "_pickupPos", "_destPos", ["_despawnPos",[]], ["_pickUpMapMarker",""], ["_destMapMarker",""], ["_voiceLines",true]];

_crew = count (crew _heliVeh);

//Spawn invisible helipads
_pad1 = "Land_HelipadEmpty_F" createVehicle _pickupPos;
_pad2 = "Land_HelipadEmpty_F" createVehicle _destPos;

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

if (_pickUpMapMarker != "") then {
	deleteMarker _pickUpMapMarker;
};

if (_destMapMarker != "") then {
	deleteMarker _destMapMarker;
};

if (_voiceLines) then {
	playSound3D ["a3\dubbing_f_gamma\showcase_armed_assault\05_InsertionFinished\showcase_armed_assault_05_insertionfinished_ALP_0.ogg",_heliVeh,false,getPos _heliVeh, 5, 1, 50];
};

if (count _despawnPos == 0) exitWith {
	[_heliVeh,0]remoteExec ["setFuel",_heliVeh];
};

waitUntil {sleep 1; (count (crew _heliVeh) <= _crew)};

_wp1 = _heliGrp addWaypoint [_despawnPos, 0];
_wp1 setWaypointType "MOVE";

deleteVehicle _pad1;
deleteVehicle _pad2;

WaitUntil {sleep 1; (_despawnPos distance2D _heliVeh < 50) || !canMove _heliVeh};

deleteVehicleCrew _heliVeh;
deleteVehicle _heliVeh;
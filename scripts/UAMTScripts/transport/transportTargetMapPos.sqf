params ["_pos","_mapCloseHandle"];

playsound "click";

Player onMapSingleClick "";

_tempPos = _pos findEmptyPosition [18, 500];

titleText ["<t color='#ffffff' size='2'>Searching for safe landing zone...</t>", "PLAIN", 1, true, true];

_timer = time;
waitUntil {sleep 0.5;(_tempPos isNotEqualTo [] || time - _timer > 60)};

titleText ["", "PLAIN", 1, true, true];

if (_tempPos isEqualTo []) exitWith {
	openMap false;
	
	transportPosReturn = 4;
	publicVariable "transportPosReturn";
};

_markerName = "Transport Destination";
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_objective";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText "Transport Destination";

_supplyDropMessage = "You are setting the Transport Destination to the marked position. Do you want to proceed?";

_result = false;
private _result = [_supplyDropMessage, "Confirm Transport Pickup?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {

	deleteMarker _markerName;
	
	transportPosReturn = 3;
	publicVariable "transportPosReturn";
		
	terminate _mapCloseHandle;
	
	openMap false;
};

transportPosReturn = 2;
publicVariable "transportPosReturn";

terminate _mapCloseHandle;

openMap false;
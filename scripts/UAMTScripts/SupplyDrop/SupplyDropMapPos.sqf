params ["_pos","_mapCloseHandle"];

playsound "click";

Player onMapSingleClick "";

_markerName = format ["Supply Drop %1",supplyDropCount + 1];
createMarker [_markerName, _pos];
_markerName setMarkerType "loc_container";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;

supplyDropMarkerName = _markerName;
publicVariable "supplyDropMarkerName";

_supplyDropMessage = "You are calling a Supply Drop on the marked position. Do you want to proceed?";

_result = false;
private _result = [_supplyDropMessage, "Confirm Supply Drop Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {

	deleteMarker _markerName;
	
	supplyDropPosReturn = 3;
	publicVariable "supplyDropPosReturn";
		
	terminate _mapCloseHandle;
	
	openMap false;
};

supplyDropPosReturn = 1;
publicVariable "supplyDropPosReturn";
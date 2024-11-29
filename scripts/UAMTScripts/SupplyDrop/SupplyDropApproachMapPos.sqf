params ["_pos","_mapCloseHandle"];

playsound "click";
Player onMapSingleClick "";

_markerName = format ["Supply Drop Approach Vektor %1",supplyDropCount + 1];
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_arrow";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;
_dir = _pos getDir getMarkerPos supplyDropMarkerName;
_markerName setMarkerDir _dir;

supplyDropApproachMarker = _markerName;
publicVariable "supplyDropApproachMarker";

_casPlaneMessage = "You are setting the Supply Drop Approach Vektor from the marked position. Do you want to proceed?";

_result = false;
private _result = [_casPlaneMessage, "Confirm Supply Drop Approach Vektor?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	deleteMarker _markerName;
	
	supplyDropPosReturn = 3;
	publicVariable "supplyDropPosReturn";
	
	terminate _mapCloseHandle;
	
	openMap false;
};

supplyDropPosReturn = 2;
publicVariable "supplyDropPosReturn";

openMap false;
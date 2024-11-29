params ["_pos","_mapCloseHandle"];

playsound "click";
Player onMapSingleClick "";

_markerName = format ["CAS Approach Vektor %1",casPlaneStrikeCount + 1];
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_arrow";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;
_dir = [_pos,getMarkerPos casPlaneMarkerName] call BIS_fnc_dirTo;
_markerName setMarkerDir _dir;

casPlaneApproachMarker = _markerName;
publicVariable "casPlaneApproachMarker";

_casPlaneMessage = "You are setting the CAS Approach Vektor from the marked position. Do you want to proceed?";

_result = false;
private _result = [_casPlaneMessage, "Confirm CAS Approach Vektor?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	deleteMarker _markerName;
	
	casPlanePosReturn = 3;
	publicVariable "casPlanePosReturn";
	
	terminate _mapCloseHandle;
	
	openMap false;
};

casPlanePosReturn = 2;
publicVariable "casPlanePosReturn";

openMap false;
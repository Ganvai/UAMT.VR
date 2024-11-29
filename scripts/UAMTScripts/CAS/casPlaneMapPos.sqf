params ["_pos","_mapCloseHandle"];

playsound "click";

Player onMapSingleClick "";

//Check if Position is in an NoFireZone

_fireZoneCheck = false;

{	
	_fireZoneCheck = _pos inArea _x;
	if (_fireZoneCheck) exitWith {};
}forEach casPlaneNoCASZones;

if (_fireZoneCheck) exitWith {	
    cutText ["<t color='#ff0000' size='2' shadow = '2'>Coordinates for CAS are in No Fire Zone!</t>", "PLAIN", 2, true, true];

	casPlanePosReturn = 4;
	publicVariable "casPlanePosReturn";
	
	terminate _mapCloseHandle;
	
	openMap false;
};

_markerName = format ["CAS Strike %1",casPlaneStrikeCount + 1];
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_destroy_noShadow";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;

casPlaneMarkerName = _markerName;
publicVariable "casPlaneMarkerName";

_casPlaneMessage = "You are calling a CAS Strike on the marked position. Do you want to proceed?";

_result = false;
private _result = [_casPlaneMessage, "Confirm CAS Firemission?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {

	deleteMarker _markerName;
	
	casPlanePosReturn = 3;
	publicVariable "casPlanePosReturn";
		
	terminate _mapCloseHandle;
	
	openMap false;
};

casPlanePosReturn = 1;
publicVariable "casPlanePosReturn";
params ["_pos","_mapCloseHandle"];

playsound "click";
Player onMapSingleClick "";

_markerName = "Halo Drop Position";
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_objective_noShadow";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;

_msg = "You are setting the HALO Drop Position. Do you want to proceed?";

_result = false;
private _result = [_msg, "Confirm Drop Position?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	deleteMarker _markerName;
	
	[_mapCloseHandle] onMapSingleClick {
		params ["_mapCloseHandle"];
		[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\HALOMapPos.sqf";
	};

	playsound "addItemFailed";
	titleText ["<t color='#ffffff' size='2' shadow = '2'>HALO Drop Position was cancelled.<br/>Choose a new Drop Position.<br/>Cancel HALO by exiting the map.</t>", "PLAIN DOWN", 1, true, true];
};

insHALOSetReturn = 1;
publicVariable "insHALOSetReturn";
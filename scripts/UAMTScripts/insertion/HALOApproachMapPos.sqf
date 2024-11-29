params ["_pos","_mapCloseHandle"];

playsound "click";
Player onMapSingleClick "";

if (_pos distance2D getMarkerPos "Halo Drop Position" < 2000) exitWith {
	
	[_mapCloseHandle] onMapSingleClick {
		params ["_mapCloseHandle"];
		[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\HALOApproachMapPos.sqf";
	};
	
	playsound "addItemFailed";
	titleText ["<t color='#ffffff' size='2' shadow = '2'>The Apporach Position must be at least 2000m away from the Drop Zone!<br/>Choose a new Apporach Vector.<br/>Cancel HALO by exiting the map.</t>", "PLAIN DOWN", 1, true, true];
};


_markerName = "Halo Approach Vector";
createMarker [_markerName, _pos];
_markerName setMarkerType "hd_arrow_noShadow";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerText _markerName;
_dir = _pos getDir getMarkerPos "Halo Drop Position";
_markerName setMarkerDir _dir;

_msg = "You are setting the CAS Approach Vektor from the marked position. Do you want to proceed?";

_result = false;
private _result = [_msg, "Confirm CAS Approach Vektor?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {
	deleteMarker _markerName;
	
	[_mapCloseHandle] onMapSingleClick {
		params ["_mapCloseHandle"];
		[_pos,_mapCloseHandle] execVM "Scripts\UAMTScripts\insertion\HALOApproachMapPos.sqf";
	};
	
	playsound "addItemFailed";
	titleText ["<t color='#ffffff' size='2' shadow = '2'>Approach Vector was cancelled.<br/>Choose a new Apporach Vector.<br/>Cancel HALO by exiting the map.</t>", "PLAIN DOWN", 1, true, true];
};

insHALOSetReturn = 2;
publicVariable "insHALOSetReturn";

terminate _mapCloseHandle;

openMap false;
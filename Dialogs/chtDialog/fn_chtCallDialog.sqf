params ["_heliIndex"];

_display = findDisplay 99006;

_pickUpMrk = _display getVariable ["chtCallPUMrk",""];

if (_pickUpMrk == "") exitWith {
	["Something went wrong with the Pick Up Map Marker. Please restart the Interface", "Error"] call BIS_fnc_guiMessage;
};


_dropOffMrk = _display getVariable ["chtCallDOMrk",""];

if (_dropOffMrk == "") exitWith {
	["Something went wrong with the Drop Off Map Marker. Please restart the Interface", "Error"] call BIS_fnc_guiMessage;
};


if (_heliIndex == -1) exitWith {
	["No Helicopter selected", "Error"] call BIS_fnc_guiMessage;
};

_pickUp = getMarkerPos _pickUpMrk;
if (_pickUp isEqualTo [0,0,0]) exitWith {
	["No Pickup Position selected", "Error"] call BIS_fnc_guiMessage;
};

_dropOff = getMarkerPos _dropOffMrk;
if (_dropOff isEqualTo [0,0,0]) exitWith {
	["No Drop-Off Position selected", "Error"] call BIS_fnc_guiMessage;
};

[[_heliIndex, _pickUpMrk, _dropOffMrk, side player],chtDialog_fnc_chtExecute]remoteExec ["spawn",2];

closeDialog 0;

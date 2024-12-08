if (!isServer) exitWith{};

params ["_heliClass","_pickUpMrk","_dropOffMrk"];

if (_heliClass == objNull) exitWith {
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

_dir = _pickUp getDir _dropOff;

_spawnPosMrk = _pickUp getPos [4000,(_dir + 180)];
_despawnPosMrk = _dropOff getPos [4000,_dir];
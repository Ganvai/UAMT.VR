params ["_lbCurSel"];

_display = findDisplay 99006;

_pickUpMrk = player getVariable ["CHT_CallPUMrk",""];

if (_pickUpMrk == "") exitWith {
	["Something went wrong with the Pick Up Map Marker. Please restart the Interface", "Error"] call BIS_fnc_guiMessage;
};


_dropOffMrk = player getVariable ["CHT_CallDOMrk",""];

if (_dropOffMrk == "") exitWith {
	["Something went wrong with the Drop Off Map Marker. Please restart the Interface", "Error"] call BIS_fnc_guiMessage;
};

if (_lbCurSel == -1) exitWith {
	["No Helicopter selected", "Error"] call BIS_fnc_guiMessage;
};

_pickUp = getMarkerPos _pickUpMrk;
if (_pickUp isEqualTo [0,0,0]) exitWith {
	["No Pickup Position set", "Error"] call BIS_fnc_guiMessage;
};

_dropOff = getMarkerPos _dropOffMrk;
if (_dropOff isEqualTo [0,0,0]) exitWith {
	["No Drop-Off Position set", "Error"] call BIS_fnc_guiMessage;
};
_heliIndex = _display displayCtrl 9900601 lbValue _lbCurSel;

if ((((missionNameSpace getVariable "chtHeliArray") select _heliIndex) select 1) == false) exitWith {
	["The Helicopter you wanted to call is currently in use. Coordinate with your group and call another one.", "Error"] call BIS_fnc_guiMessage;
};

_result = false;
private _result = ["You are calling a Helicopter Transport? Do you acknowledge?", "Confirm Helicopter Transport Call?", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

_heliclass = ((missionNameSpace getVariable "chtHeliArray") select _heliIndex) select 0;

_heliTempArray = missionNameSpace getVariable "chtHeliArray";
(_heliTempArray select _heliIndex) set [1,false];

missionNameSpace setVariable ["chtHeliArray",_heliTempArray,true];

[[_heliclass, _heliIndex,getMarkerPos _pickUpMrk, getMarkerPos _dropOffMrk, player],chtDialog_fnc_chtExecute]remoteExec ["spawn",2];

deleteMarkerLocal _pickUpMrk;
deleteMarkerLocal _dropOffMrk;
closeDialog 0;
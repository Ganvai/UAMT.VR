_index = lbCurSel 112;
_index2 = lbdata[112, _index];

_result = false;
private _result = ["Do you want to change the time?", "Time", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

closeDialog 0;

_hour = parseNumber _index2;
_now = date;
_now set [3, _hour];
_now set [4, 00];

[_now, true, true] call BIS_fnc_setDate;
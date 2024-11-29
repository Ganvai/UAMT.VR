_result = false;
private _result = ["Do you want the Transport to start?", "Give starting order to Helicopter", true, true] call BIS_fnc_guiMessage;

if (!_result) exitWith {};

orderHeliStart = true;
publicVariable "orderHeliStart";

transportStartOrders = false;
publicVariable "transportStartOrders";
disableSerialization;

params ["_amount"];

_currBox = uiNamespace getVariable ["sppBox",objNull];

if (_currBox isEqualTo objNull) exitWith {};

_item = "";
_display = findDisplay 99100;

_ctrlArsenalLB = _display displayCtrl 104;
_ctrlInventoryLB = _display displayCtrl 108;

if ((lbCurSel _ctrlArsenalLB) > -1) then {
	_item = _ctrlArsenalLB lbData (lbCurSel _ctrlArsenalLB);
}
else {
	_item = _ctrlInventoryLB lbData (lbCurSel _ctrlInventoryLB);
};

if (([configFile >> "CfgVehicles" >> _item, "isbackpack",0] call BIS_fnc_returnConfigEntry) == 1) then {
	_currBox addBackpackCargoGlobal [_item, _amount];
}
else {
	_currBox addItemCargoGlobal [_item, _amount];
};


call sppDialog_fnc_updateInventory;
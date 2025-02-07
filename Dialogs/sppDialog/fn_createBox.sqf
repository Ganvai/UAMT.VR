disableSerialization;

_display = findDisplay 99100;

_ctrlBox = _display displayCtrl 105;

_currBox = uiNamespace getVariable ["sppBox",objNull];

_items = [];

if (_currBox isNotEqualTo objNull) then {
	_items = [_currBox] call sppDialog_fnc_getBoxCargo;
	
	deleteVehicle _currBox;
};

_currBox = (_ctrlBox lbData (lbCurSel _ctrlBox)) createVehicle [0,0,-100];

clearWeaponCargoGlobal _currBox; 
clearMagazineCargoGlobal _currBox;
clearItemCargoGlobal _currBox;
clearBackpackCargoGlobal _currBox;

if (count (_items select 0) > 0) then {
	
	for "_i" from 0 to (count (_items select 0)) do {
		_currBox addItemCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
		_currBox addBackpackCargoGlobal [((_items select 0) select _i), ((_items select 1) select _i)];
	};
};

uiNamespace setVariable ["sppBox",_currBox];

call sppDialog_fnc_updateLoad;
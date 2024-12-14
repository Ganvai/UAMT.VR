params ['_lbCurSel'];

_lbControl = findDisplay 99001 displayCtrl 9900102;

lbClear _lbControl;

_ammoArray = (fullArti select _lbCurSel) select 2;

{
	_entry = format ["%1 - %2 Rounds",_x select 1,_x select 2];
	_lbControl lbAdd _entry;
	_lbControl lbSetData [_forEachIndex, str _forEachIndex];
} forEach _ammoArray;
	
_lbControl lbSetCurSel 0;

[0] call artDialog_fnc_artManageRounds;
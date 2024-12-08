params ['_lbCurSel'];

lbClear 9900102;

_ammoArray = (fullArti select _lbCurSel) select 2;

{
	_entry = format ["%1 - %2 Rounds",_x select 1,_x select 2];
	lbAdd [9900102, _entry];
	lbSetData [9900102, _forEachIndex, str _forEachIndex];
} forEach _ammoArray;
	
lbSetCurSel [9900102,0];

[0] call artDialog_fnc_artManageRounds;
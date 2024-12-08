params ['_control', '_lbCurSel', '_lbSelection'];

_ammoArray = (fullArti select _lbCurSel) select 2;

{
	_entry = format ["%1 - %2 Rounds",_x select 1,_x select 2];
	lbAdd [9900104, _entry];
	lbSetData [9900104, _forEachIndex, str _forEachIndex];
} forEach _ammoArray;
	

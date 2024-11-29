//params [_index,_index2];

_index = lbCurSel 100;
_index2 = lbdata[100, _index];

_loadouts = format ["loadouts\%1\%2", factionVariable, _index2];
call compile preprocessFileLineNumbers _loadouts;	
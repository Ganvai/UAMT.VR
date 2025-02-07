_currBox = uiNamespace getVariable ["sppBox",objNull];

_point = uiNamespace getVariable "SupplyPoint";
_dis = uiNamespace getVariable "sppDis";
_dir = uiNamespace getVariable "sppDir";

_spPos = _point getRelPos [_dis,_dir];

_currBox setPos [_spPos select 0, _spPos select 1, 1];

uiNamespace setVariable ["sppBox",objNull];

closeDialog 0;
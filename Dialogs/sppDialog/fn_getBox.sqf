_currBox = uiNamespace getVariable ["sppBox",objNull];

_point = uiNamespace getVariable "SupplyPoint";
_dis = uiNamespace getVariable "sppDis";
_dir = uiNamespace getVariable "sppDir";

_spPos = _point getRelPos [_dis,_dir];

_currBox setPos [_spPos select 0, _spPos select 1, 1];
playSound3D ["a3\sounds_f\vehicles\noises\Turn_in_out.wss",_currBox];


uiNamespace setVariable ["sppBox",objNull];

closeDialog 0;
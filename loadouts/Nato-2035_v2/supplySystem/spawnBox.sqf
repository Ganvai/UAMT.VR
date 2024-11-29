if (! isServer) exitWith {};

_boxSpawnObj = _this select 0;
_distance = _this select 1;
_direction = _this select 2;
_boxType = _this select 3;
_boxScript = _this select 4;

_boxPos = _boxSpawnObj getRelPos [_distance,_direction];

_box = _boxType createVehicle _boxPos;
_box setPosATL [_boxPos select 0,_boxPos select 1,(_boxPos select 2) + 1];

_boxPath = format ["%1%2",supplyPath,_boxScript];
[_box] execvm _boxPath;

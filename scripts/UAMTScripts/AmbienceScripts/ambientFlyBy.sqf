//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Ambient Fly By for Planes
//
// Spawns a vehicle randomly chosen from a List and lets them
// fly over a randomly chosen Players position.
// Planes are set to captive, won't engage anything and won't be
// engaged.
//
// Script is en enhancement / combination of AmbientFlyBy Scripts
// by Spiderman, SmartGun from TOB and R3vo from the BI Forums
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

if (!isServer) exitWith {};

_AFBHeightPlane = getMissionConfigValue "AFBPHeight";
_AFBmaxTime = getMissionConfigValue "AFBmaxTime";
_AFBmidTime = getMissionConfigValue "AFBmidTime";
_AFBminTime = getMissionConfigValue "AFBminTime";
_distance = getMissionConfigValue "AFBdistance";
_vehicles = getMissionConfigValue "AFBVehicles";
_rndMax = getMissionConfigValue "AFBAmount";


while {true} do {
	_wait = random [_AFBminTime, _AFBmidTime, _AFBmaxTime];
	
	sleep _wait;
	
	_players = allPlayers - entities "HeadlessClient_F";
	
	_targetPos = position (selectRandom _players);
	
	_vehicle = selectRandom _vehicles;

	_AFBHeight = 50;
	_speed = 50;
	
	if (_Vehicle isKindOf "plane") then {
		_AFBHeight = _AFBHeightPlane;
		_speed = 300;
	};
	
	_dir = random 360;
	_startPos = _targetPos getPos [_distance,_dir];
	_endPos = _startPos getPos [(_distance * 2),(_dir + 180)];

	_amount = round random [1,(_rndMax / 2),_rndMax];
	
	for "_i" from 1 to _amount do {
	
		[_vehicle,_startPos,_endPos,_AFBHeight] spawn UAMTafb_fnc_ambientFlyByExecute;
		
		sleep 2;
	};
};
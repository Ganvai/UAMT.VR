//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//
//		Transport Heli Simple
//
// Makes one or more Helicopters fly to a position and land there.
//
// The helicopters will stay at the landing position with fuel set to 0 and "MOVE" and "PATH" AI disabled 
// to make sure they really stay there.
//
// If you give more than one Helicopter Object, it needs the same amount of destinations
// to work!
//
// PARAMETERS:
// _heli : vehicle OBJECT or ARRAY of Objects / Variable Names of the Helicopters you want to fly
//
// _destination : Position Array [x,y,z] or Marker Name ("String") or ARRAY with ONE(!) of the two types
//
// _startMode : NUMBER / OPTIONAL, default 0
//							0: Helicopters start immediatly
//							1: Every Helicopter gets an action to order it to start
//							2: The Helicopters wait until EVERY Player is in one of the given vehicles
//
// _engineOn : BOOLEAN / OPTIONAL, default true / Helicopters start engine when the function is called. 
//													If false, they will start the engines when the startMode condition is fulfilled
//
// _markers : BOOLEAN / OPTIONAL, default true / Creates Markers for the helicopters starting Position and Target LZ. 
//													Markers get deleted after the helicopter has landed.
//
// _voicelines : BOOLEAN / OPTIONAL, default true / Plays Arma Vanilla Voicelines for start, approach and landing. Only English!
//
// Examples:
//
// Simple Call with one helicopter:
// [heli_1,"destinationMarker"] spawn UAMT_fnc_transportHeliSimple;
//
// Simple call for one Helicopter to a markers position. The helicopters will start IMMEDIATLY when this function is called.
// This means the missionmaker must make sure, that all needed players are in the helicopters! Markers will be placed and
// voicelines will be played.
//
// Multiple Helicopters with position Arrays:
// [[heli_1,heli_2,heli_3],[[0,0,0],[1,1,1],[1,1,1]],1,true,true,false] spawn UAMT_fnc_transportHeliSimple;
//
// Calls three helicopters with Position instead of Markers. Every helicopter will have an action to order it to start
// that the players need to activate manually. Helicopters will start the engines directly when the function is called.
// Markers on their position and their destinations will be placed on the map. 
// No voicelines will be played.
//
// Multiple Helicopters with marker Strings:
// [[heli_1,heli_2,heli_3],["destinationMarker_1","destinationMarker_2","destinationMarker_3"],1,true,true,false] spawn UAMT_fnc_transportHeliSimple;
//
// Same as before but with an array of strings with marker names as destinations.
//
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------

params ["_heli","_destination",["_startMode",0],["_engineOn",true],["_markers",true],["_voicelines",true]];

_heliArr = [];
_destPosArr = [];
_heliCount = 0;
_destCount = 0;
_startMarkerArr = [];
_destMarkerArr = [];

if (typeName _heli == "ARRAY") then {
	_heliArr = _heli;
}
else {
	_heliArr pushback _heli;
};


if (typeName _destination ==  "ARRAY") then { 
	if (typeName (_destination select 0) ==  "ARRAY") then { 
		_destPosArr = _destination; 
	}
	else { 
		if (typeName (_destination select 0) ==  "SCALAR") then { 
			_destPosArr pushback _destination;
		}
		else {
			{_destPosArr pushback (getMarkerPos _x); }forEach _destination;
		};
	};
}
else {
	_destPosArr pushback (getMarkerPos _destination); 
};


if (_markers) then {
	for "_i" from 0 to ((count _heliArr) - 1) do {
		_startMapMarker = format ["Transport Heli %1",(_i + 1)];
		createMarker [_startMapMarker, getPos (_heliArr select _i)];
		_startMapMarker setMarkerText _startMapMarker;
		_startMapMarker setMarkerType "hd_dot";
		_startMarkerArr pushback _startMapMarker;
		
		_destMapMarker = format ["Target LZ %1",(_i + 1)];
		createMarker [_destMapMarker, (_destPosArr select _i)];
		_destMapMarker setMarkerText _destMapMarker;
		_destMapMarker setMarkerType "hd_start";
		_destMarkerArr pushback _destMapMarker;
	};
};

if (_engineOn) then {
	{
		[_x,1]remoteExec ["setFuel",_x];
		_x engineOn true;
	}forEach _heliArr;
};

if (_startmode == 2) then {
	waitUntil {sleep 1; {vehicle _x in _heliArr} count (call BIS_fnc_listPlayers) == count(call BIS_fnc_listPlayers)};
	_startMode = 0;
};

for "_i" from 0 to (count _heliArr) - 1 do
{
	_heli = _heliArr select _i;
	_destPos = _destPosArr select _i;
	_startMapMarker = "";
	_destMapMarker = "";
	
	if (_markers) then {
		_startMapMarker = _startMarkerArr select _i;
		_destMapMarker = _destMarkerArr select _i;
	};
	
	[_heli,_destPos,_startMode,_engineOn,_voicelines,_startMapMarker,_destMapMarker] spawn UAMT_fnc_transportHeliSimpleFly;
};
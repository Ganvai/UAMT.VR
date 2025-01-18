//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//
// 			Heli Taxi Call
//
// Spawns one (or more) Helicopter that flies to the _pickUpMrk, lands there,
// waits until a player executes the "Start Heli" option and then
// flies to the _destMrk, lands there and waits until every player
// has left the vehicle. Then flies to the _despawnPosMrk where it gets
// deleted.
//
// A control function that controls and submits fitting values to UAMT_fnc_heliTaxiFly 
//	
// Attributes:
// _spawnPosMrk : <ARRAY POSAGL> or <STRING> or Array of POSAGL or Strings. Position where the Helicopter is spawned. Can be position AGL, a String for a Marker name 
//					or an Array of several of these types. If multiple positions or markers are given, it spawns the amount of Helicopters. Must always be one of a type!
//					Don't mix position arrays with marker Names!
//
// _pickUpMrk : SAME as _spawnPosMrk. Where the helicopter lands and waits for players to give starting orders.
//				If multiple positions/markers are given, it needs to be of the same amount of _spawnPosMrk
//
// _destMrk:	SAME as _spawnPosMrk. Position where Helis land and wait until every player is out.
//
// _despawnPosMrk:	SAME as _spawnPosMrk. Position where the helicopter flies after all players left the vehicle at _destMrk. When reaching the position, it gets deleted
//
// _class: <STRING> Classname of Helicopter to spawn
//
// _voiceLines: <BOOL> If true, the function playes voicelines for the players to give information about their status. Needs UAMT sounds config for this. If not available,
//
// _marker: <BOOL> If true, markers for the helicopters will be drawn on the map.
//
// Call:
// [_spawnPosMrk,_pickUpMrk,_destMrk,_despawnPosMrk,_class,_voiceLines,_marker] call UAMT_fnc_heliTaxiCall;
//
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
params ["_spawnPosMrk","_pickUpMrk", "_destMrk","_despawnPosMrk", "_class", ["_voiceLines", true], ["_marker", true]];

//Variables
_pickUpMapMarker = "";
_destMapMarker = "";
_spawnPosArr = [];
_pickUpPosArr = [];
_destPosArr = [];
_despawnPosArr = [];

// Is the return Array, giving back all helicopters
_vehicleArr = [];


//Bringing _spawnPosMrk into right format
if (_spawnPosMrk isEqualType []) then {
	if (_spawnPosMrk select 0 isEqualType "") then {
		{
			_spawnPosArr pushback (getMarkerPos _x);
		}forEach _spawnPosMrk;
	}
	else {
		if (_spawnPosMrk select 0 isEqualType 1) then {
			_spawnPosArr pushback _spawnPosMrk;
		}
		else {
			_spawnPosArr = _spawnPosMrk;
		};
	};
}
else {
	_spawnPosArr pushback (getMarkerPos _spawnPosMrk);
};

_amount = (count _spawnPosArr) - 1;

//Bringing _pickUpMrk into right format
if (typename _pickUpMrk == "ARRAY") then {
	if (typeName (_pickUpMrk select 0) == "STRING") then {
		{
			_pickUpPosArr pushback (getMarkerPos _x);
		}forEach _pickUpMrk;
	}
	else {
		if (typeName (_pickUpMrk select 0) == "SCALAR") then {
			_pickUpPosArr pushback _pickUpMrk;
		}
		else {
			_pickUpPosArr = _pickUpMrk;
		};
	};
}
else {
	_pickUpPosArr pushback (getMarkerPos _pickUpMrk);
};

//Bringing _destMrk into right format
if (typename _destMrk == "ARRAY") then {
	if (typeName (_destMrk select 0) == "STRING") then {
		{
			_destPosArr pushback (getMarkerPos _x);
		}forEach _destMrk;
	}
	else {
		if (typeName (_destMrk select 0) == "SCALAR") then {
			_destPosArr pushback _destMrk;
		}
		else {
			_destPosArr = _destMrk;
		};
	};
}
else {
	_destPosArr pushback (getMarkerPos _destMrk);
};

//Bringing _despawnPosMrk into right format
if  (count _despawnPosMrk > 0 ) then {
	if (typename _despawnPosMrk == "ARRAY") then {
		if (typeName (_despawnPosMrk select 0) == "STRING") then {
			{
				_despawnPosArr pushback (getMarkerPos _x);
			}forEach _despawnPosMrk;
		}
		else {
			if (typeName (_despawnPosMrk select 0) == "SCALAR") then {
				_despawnPosArr pushback _despawnPosMrk;
			}
			else {
				_despawnPosArr = _despawnPosMrk;
			};
		};
	}
	else {
		_despawnPosArr pushback (getMarkerPos _despawnPosMrk);
	};
};

// Catching some Errors early because damn, that could fuck up the rest XD
if (count _pickUpMrk != count _destMrk) exitWith {
	diag_log text "ERROR in Transport Helicopter Call. Not the same amount of PickUp and Destination Markers given.";
};

if (count _pickUpMrk != count _spawnPosMrk) exitWith {
	diag_log text "ERROR in Transport Helicopter Call. Not the same amount of PickUp and Spawn Markers given.";
};

// Loop to spawn multiple Helicopters and send them flying.
for "_i" from 0 to _amount do {

	// Get all positions
	_spawnPos = _spawnPosArr select _i;
	_pickupPos = _pickUpPosArr select _i;
	_destPos = _destPosArr select _i;

	// If there is no despawn position, the helicopters will stay on the target lz.
	// But the following function needs to recognize this, so default value is [0,0,0].
	_despawnPos = [];
	if (count _despawnPosArr > 0) then {
		_despawnPos = _despawnPosArr select _i;
	};

	// Create map marker
	if (_marker) then {
		_pickUpMapMarker = format ["Pickup LZ %1",(_i + 1)];
		createMarker [_pickUpMapMarker, _pickupPos];
		_pickUpMapMarker setMarkerText _pickUpMapMarker;
		_pickUpMapMarker setMarkerType "hd_pickup";
		
		_destMapMarker = format ["Drop-Off LZ %1",(_i + 1)];
		createMarker [_destMapMarker, _destPos];
		_destMapMarker setMarkerText _destMapMarker;
		_destMapMarker setMarkerType "hd_pickup";
	}
	else {
		_pickUpMapMarker = "";
		_destMapMarker = "";
	};
	
	// Set position for spawn to 100 meter height
	_spawnPos set [2,100];
	
	// Get direction to spawn heli
	_dir = _spawnPos getDir _pickupPos;
	
	// Spawn the heli
	_transVeh = [_spawnPos, _dir, _class, civilian] call BIS_fnc_spawnVehicle;

	// Get Variables for later use
	_heliGrp = _transVeh select 2;
	_heliVeh = _transVeh select 0;
	
	// Move Helicopter to the exact location
	_heliVeh setPos _spawnPos;
	
	// Add helicopter to return Array
	_vehicleArr pushback _transVeh;
	
	// These AI pilots...
	_heliVeh allowDamage false;
		
	[_heliVeh, _heliGrp, _pickupPos, _destPos, _despawnPos, _pickUpMapMarker, _destMapMarker, _voiceLines] spawn UAMT_fnc_heliTaxiFly;
};

_vehicleArr;
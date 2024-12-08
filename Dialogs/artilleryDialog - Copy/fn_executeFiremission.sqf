params ["_fullArtiIndex","_ammoIndex","_rounds","_dist","_targetPos","_customAudio","_supportControlName","_side"];

//Needed Resources from Artillery Config
_artillery = (fullArti select _fullArtiIndex) select 1;
_artiAmmo = (((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 0;

// Remove Ammo from Ammopool for Artillery
_artiAmmoRemaining = (((fullArti select _fullArtiIndex) select 2) select _ammoIndex) select 2;
_artiNewAmmoCount = _artiAmmoRemaining - _rounds;
(((fullArti select _fullArtiIndex) select 2) select _ammoIndex) set [2,_artiNewAmmoCount];

// Set ArtiStatus for Interface Control
artiStatus = 2;
publicVariable "artiStatus";

// Count up ArtiStrikeCount
artiStrikeCount = artiStrikeCount + 1;
publicVariable "artiStrikeCount";

// Make Objects from the String Array of Artillery Classnames
_artiArr = [];
{
	_obj = missionNamespace getVariable [_x, objNull];
	_artiArr pushback _obj;
} forEach _artillery;

// Calculating ETA Timer for ETA Message
_artiETA = _artiArr select 0 getArtilleryETA [_targetPos, _artiAmmo];

// Confirm Firemission Message
_artiMessage = format ["All Units be advised: Artillery Coordinates recieved. Starting Firemission. Splash ETA: %1 Seconds", round _artiETA];

if (_customAudio) then {
	[_artiMessage,_supportControlName,"msg_ArtilleryStarting",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	[_artiMessage,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

sleep 3;

// Set Timer for ETA Message
_timer = time;

if (_dist <= 20) then {

	// Higher firerate with small area of effect

	// Building Shots Array to distribute Rounds evenly on all Artillery Elements
	_shotsArray = [];
	_shotsArray resize [count _artiArr,0];

	_rotator = 0;

	for "_i" from 1 to _rounds do {
		_shotsArray set [_rotator,(_shotsArray select _rotator) + 1];

		_rotator = _rotator + 1;
		
		if (_rotator > (count _shotsArray) - 1) then {
			_rotator = 0;
		};
	};

	// Spawn Fire execution
	0 = [_artiArr,_artiAmmo,_targetPos,_shotsArray] spawn {
		
		params ["_artiArr","_artiAmmo","_targetPos","_shotsArray"];
		_ETAControl = false;
		
		{		
			// Set the right Ammo for Firemission
			_x setVehicleAmmo 1;
			
			// Execute Firemission
			[_x, [_targetPos, _artiAmmo, _shotsArray select _forEachIndex]] remoteExec ["doArtilleryFire", _x];
			
			_sleepy = random [0.1,0.3,0.5];
			sleep _sleepy;
			
		}forEach _artiArr;
		
	};

	waitUntil {sleep 2; unitReady (_artiArr select 0)};
}
else {
	_rotator = 0;
	
	for "_i" from 1 to _rounds do {
		
		_arti = _artiArr select _rotator;
		
		_arti setVehicleAmmo 1;
		
		_pos = _targetPos getPos [_dist * sqrt random 1, random 360];
		
		//Has to wait until Artillery Unit is ready. Doesn't fire if this is taken out.
		waitUntil {sleep 2; unitReady _arti};
		
		[_arti, [_targetPos, _artiAmmo, 1]] remoteExec ["doArtilleryFire", _arti];

		// Add one to Rotator
		_rotator = _rotator + 1;
		
		// Check if rotator needs reset
		if (_rotator > (count _artiArr) - 1) then {
			_rotator = 0;
		};			
	};
	
	waitUntil {sleep 2; unitReady (_artiArr select 0)};
};

// Send All Rounds Out Messsage
if (_customAudio) then {
	["Be advised: All rounds out.",_supportControlName,"msg_ArtilleryRounds",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Be advised: All rounds out.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

sleep 3;

if (time < (_timer + _artiETA)) then {
	waitUntil {sleep 1; time > _timer + _artiETA};
	
	if (_customAudio) then {
		["Be advised: Splash.",_supportControlName,"msg_ArtillerySplash",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["Be advised: Splash.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep 3;
};

artiStatus = 3;
publicVariable "artiStatus";

deleteMarker artiMarker;

artiMarker = "";
publicVariable "artiMarker";

_cooldown = artiCooldown;
_cooldownMike = ceil (artiCooldown / 60);

_msg = format ["All Units: Fire Mission done. Preparing new Strike. ETA: %1 mike.",_cooldownMike];

if (_customAudio) then {
	[_msg,_supportControlName,"msg_ArtilleryEnd",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};	

sleep _cooldown;

if (_customAudio) then {
	["Be advised: New Artillery Strike is available.",_supportControlName,"msg_ArtilleryAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["Be advised: New Artillery Strike is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};	
		

artiStatus = 0;
publicVariable "artiStatus";

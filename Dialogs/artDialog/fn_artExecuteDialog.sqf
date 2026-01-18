params ["_targetPos", "_artIndex", "_ammoIndex", "_rounds", "_pattern", "_radius","_side",["_createMarker",true]];

_audioMessages = getMissionConfigValue "supportMessages";
_customAudio = getMissionConfigValue "supportCustomAudio";
_supportControlName = getMissionConfigValue "supportControlName";

//Firemode Code Variable for Pattern Fire Modes
_fireMode = {};
_artiETA = 0;

_fullArti = missionNameSpace getVariable "fullArti";
//Needed Resources from Artillery Config
_artillery = (_fullArti select _artIndex) select 1;
_artiAmmo = (((_fullArti select _artIndex) select 2) select _ammoIndex) select 0;

// Remove Ammo from Ammopool for Artillery
_artiAmmoRemaining = (((_fullArti select _artIndex) select 2) select _ammoIndex) select 2;
_artiNewAmmoCount = _artiAmmoRemaining - _rounds;
(((_fullArti select _artIndex) select 2) select _ammoIndex) set [2,_artiNewAmmoCount];
missionNameSpace setVariable ["fullArti",_fullArti,true];

// Set ArtiStatus for Interface Control
missionNameSpace setVariable ["artiStatus",2,true];

_artCount = (missionnamespace getVariable ["artiStrikeCount",0]) + 1;
missionnamespace setVariable ["artiStrikeCount",_artCount,true];

if (_createMarker) then {
	
	_mrkName = format ["_USER_DEFINED artMrk%1",_artCount];
	_mrkRadName = format ["_USER_DEFINED artRadMrk%1",_artCount];
	_mrkText = format ["Artillery Strike %1",_artCount];
	
	createMarker [_mrkName,_targetPos];
	_mrkName setMarkerAlpha 1;
	_mrkName setMarkerType "hd_destroy_noShadow";
	_mrkName setMarkerText _mrkText;

	createMarker [_mrkRadName,_targetPos];
	_mrkRadName setMarkerAlpha 1;
	_mrkRadName setMarkershape "ELLIPSE";
	_mrkRadName setMarkersize [_radius,_radius];
};
// Make Objects from the String Array of Artillery Classnames
_artiArr = [];
{
	_obj = missionNamespace getVariable [_x, objNull];
	_artiArr pushback _obj;
} forEach _artillery;

// Calculating ETA Timer for ETA Message
_artiETA = _artiArr select 0 getArtilleryETA [_targetPos, _artiAmmo];

// Confirm Firemission Message
if (_audioMessages == "true") then {
	_artiMessage = format ["All Units be advised: Artillery Coordinates recieved. Starting Firemission. Splash ETA: %1 Seconds", round _artiETA];

	if (_customAudio == "true") then {
		[_artiMessage,_supportControlName,"msg_ArtilleryStarting",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		[_artiMessage,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};
	
	sleep 3;
};

// Set Timer for ETA Message
_timer = time;

switch _pattern do {
	case 1 : { _fireMode = {_pos = _targetPos getPos [_radius * random [- 1, 0, 1], random 180]} ; }; // Normal Distribution
	case 2 : { _fireMode = {_pos = _targetPos getPos [_radius * sqrt random 1, random 360]} ; }; //Random Area
	case 3 : { _fireMode = {_pos = _targetPos getPos [_radius * (1 - abs random [- 1, 0, 1]), random 360]} ; }; // Inverted normal distribution, random radius
	case 4 : { _fireMode = {_pos = _targetPos getPos [sqrt (_innerRadius^2 + random (_radius^2 - _innerRadius^2)), random 360]} ; }; // Random Area Ring
};

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
	
if (_pattern == 0) then {
	// Rapid Fire Mode
	
	_artiCount = count _artiArr;
	
	
	// Spawn Fire execution
	0 = [_artiArr,_artiAmmo,_targetPos,_shotsArray] spawn {
		
		params ["_artiArr","_artiAmmo","_targetPos","_shotsArray"];
		
		{		
			// Set the right Ammo for Firemission
			_x setVehicleAmmo 1;
			
			// Execute Firemission
			if ((_shotsArray select _forEachIndex) > 0) then {
				[_x, [_targetPos, _artiAmmo, (_shotsArray select _forEachIndex)]] remoteExec ["doArtilleryFire", _x];
			};
			
		}forEach _artiArr;
	};
	
	sleep 10;
	
	waitUntil {sleep 2; unitReady (_artiArr select -1)};
}
else {
	//All other Fire Modes
	_spawnHandles = [];
	{
		_artiSpawn = [_x,_targetPos,_artiAmmo,_fireMode,(_shotsArray select _forEachIndex),_radius] spawn {
			params ["_arti","_targetPos","_ammo","_fireMode","_condition","_radius"];
			_pos = [0,0,0];
			
			for "_i" from 1 to _condition do {
				_innerRadius = _radius - 20;
				[_targetPos,_radius,_innerRadius] call _fireMode;
				
				[_arti, [_pos, _ammo, 1]] remoteExec ["doArtilleryFire", _arti];
				
				waitUntil {sleep 0.2; unitReady _arti;};
				
				if (!(canFire _arti)) then {diag_log format["Can not fire %1).", name _arti];};
				_arti setVehicleAmmo 1;	
			};
		};
		_spawnHandles pushBack _artiSpawn;
	}forEach _artiArr;
	
	waitUntil {sleep 1; {scriptDone _x} count _spawnHandles == count _artiArr};
};

// Send All Rounds Out Messsage
if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["Be advised: All rounds out.",_supportControlName,"msg_ArtilleryRounds",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		["Be advised: All rounds out.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};

	sleep 3;
};

if (_audioMessages == "true") then {
	if (time < (_timer + _artiETA)) then {
		waitUntil {sleep 1; time > _timer + _artiETA};
		
		if (_customAudio == "true") then {
			["Be advised: Splash.",_supportControlName,"msg_ArtillerySplash",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		}
		else {
			["Be advised: Splash.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
		};
		
		sleep 3;
	};
};

missionNameSpace setVariable ["artiStatus",3,true];

_cooldown = getMissionConfigValue "artiCooldown";


if (_audioMessages == "true") then {

	// Calculate Minutes for ETA message
	_cooldownMike = ceil (getMissionConfigValue "artiCooldown" / 60);
	
	_msg = format ["All Units: Fire Mission done. Preparing new Strike. ETA: %1 mike.",_cooldownMike];

	if (_customAudio == "true") then {
		[_msg,_supportControlName,"msg_ArtilleryEnd",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};	
};

sleep _cooldown;

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["Be advised: New Artillery Strike is available.",_supportControlName,"msg_ArtilleryAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	}
	else {
		["Be advised: New Artillery Strike is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",2];
	};
};

missionNameSpace setVariable ["artiStatus",0,true];
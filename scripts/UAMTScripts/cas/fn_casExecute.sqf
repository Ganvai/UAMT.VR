if (!isServer) exitWith {};

params ["_targetPos","_dir","_side","_weaponTypesID",["_createMarker",true]];

missionNameSpace setVariable ["casStatus",2,true];

_casCount = (missionnamespace getVariable ["casCount",0]) + 1;
missionnamespace setVariable ["casCount",_casCount,true];

if (_createMarker) then {
	
	_mrkName = format ["_USER_DEFINED casStrikeMrk%1",_casCount];
	_mrkText = format ["CAS %1 Target",_casCount];
	_mrkDirName = format ["_USER_DEFINED casStrikeDirMrk%1",_casCount];
	_mrkDirText = format ["CAS %1 Approach Vektor",_casCount];

	createMarker [_mrkName,_targetPos];
	_mrkName setMarkerAlpha 1;
	_mrkName setMarkerType "hd_destroy_noShadow";
	_mrkName setMarkerText _mrkText;

	createMarker [_mrkDirName,(_targetPos getPos [500,_dir])];
	_mrkDirName setMarkerAlpha 1;
	_mrkDirName setMarkerType "hd_arrow_noShadow";
	_mrkDirName setMarkerText _mrkDirText;
	_mrkDirName setMarkerDir (_dir + 180);
};

// Getting the global variable config values
_planeClass = getMissionConfigValue "casClass";
_audioMessages = getMissionConfigValue "supportMessages";
_customAudio = getMissionConfigValue "supportCustomAudio";
_supportControlName = getMissionConfigValue "supportControlName";

if (_audioMessages == "true") then {
	_delayMike = ceil (getMissionConfigValue "casDelay" / 60);

	_msg = format ["All Units be advised: CAS Aircraft is rerouted to your coordinates. ETA: %1 mike", _delayMike];

	if (_customAudio == "true") then {
		[_msg,_supportControlName,"msg_CASReroute",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
	
	sleep 10;
};

switch _weaponTypesID do {
	case 0 : { missionNameSpace setVariable ["casMGruns",(missionNameSpace getVariable "casMGruns") - 1,true]; };
	case 1 : { missionNameSpace setVariable ["casMisRuns",(missionNameSpace getVariable "casMisRuns") - 1,true]; };
	case 2 : { missionNameSpace setVariable ["casMGruns",(missionNameSpace getVariable "casMGruns") - 1,true]; missionNameSpace setVariable ["casMisRuns",(missionNameSpace getVariable "casMisRuns") - 1,true]; };
	case 3 : { missionNameSpace setVariable ["casBombRuns",(missionNameSpace getVariable "casBombRuns") - 1,true]; };
};

_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {["Vehicle class '%1' not found",_planeClass] call bis_fnc_error; false};

//--- Detect gun
_weaponTypes = switch _weaponTypesID do {
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun","missilelauncher"]};
	case 3: {["bomblauncher"]};
	default {[]};
};

_weapons = [];
{
	if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
		_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
		if (count _modes > 0) then {
			_mode = _modes select 0;
			if (_mode == "this") then {_mode = _x;};
			_weapons set [count _weapons,[_x,_mode]];
		};
	};
} foreach (_planeClass call bis_fnc_weaponsEntityType);//getarray (_planeCfg >> "weapons");

if (count _weapons == 0) exitwith {if (_createMarker) then {deleteMarker _mrkName;deleteMarker _mrkDirName;};["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};

//_posATL = getposatl _logic;
_pos = +_targetPos;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];

_dis = 3000;
_alt = 1000;
_pitch = atan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

sleep (getMissionConfigValue "casDelay");

//--- Create plane
_planePos = [_pos,_dis,_dir] call bis_fnc_relpos;
//_planePos = _spawnPos;
_planePos set [2,(_pos select 2) + _alt];
_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
_plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir + 180] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";
_plane lockDriver true;

_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setvectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
_vectorUp = vectorup _plane;

//--- Remove all other weapons;
_currentWeapons = weapons _plane;
{
	if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
		_plane removeweapon _x;
	};
} foreach _currentWeapons;

//--- Cam shake
_ehFired = _plane addeventhandler [
	"fired",
	{
		_this spawn {
			_plane = _this select 0;
			_plane removeeventhandler ["fired",_plane getvariable ["ehFired",-1]];
			_projectile = _this select 6;
			waituntil {isnull _projectile};
			[[0.005,4,[_plane getvariable ["logic",objnull],200]],"bis_fnc_shakeCuratorCamera"] call bis_fnc_mp;
		};
	}
];
_plane setvariable ["ehFired",_ehFired];

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["All Units be advised: CAS Aircraft is inbound.",_supportControlName,"msg_CASInbound",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units be advised: CAS Aircraft is inbound.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

//--- Approach
_fire = [] spawn {waituntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
waituntil {
	_fireProgress = _plane getvariable ["fireProgress",0];

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setvelocity velocity _plane;

	//--- Fire!
	if ((getposasl _plane) distance _pos < 1000 && _fireNull) then {


		//--- Create laser target
		private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
		//_target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
		_target = ((_pos nearEntities [_targetType,250])) param [0,objnull];
		if (isnull _target) then {
			//_target = createvehicle [_targetType,position _logic,[],0,"none"];
			_target = createvehicle [_targetType,_pos,[],0,"none"];
		};
		_plane reveal lasertarget _target;
		_plane dowatch lasertarget _target;
		_plane dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_plane,_weapons,_target,_weaponTypesID] spawn {
			_plane = _this select 0;
			_planeDriver = driver _plane;
			_weapons = _this select 1;
			_target = _this select 2;
			_weaponTypesID = _this select 3;
			_duration = 3;
			_time = time + _duration;
			waituntil {
				{
					_planeDriver fireattarget [_target,(_x select 0)];
				} foreach _weapons;
				_plane setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || _weaponTypesID == 3 || isnull _plane //--- Shoot only for specific period or only one bomb
			};
			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire || !canMove _plane
};

if (!canMove _plane) exitWith {

	_plane setDamage 1;
	
	if (_audioMessages == "true") then {
		if (_customAudio == "true") then {
			["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"msg_CASLostFire",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units be advised: CAS Element was lost during Firemission.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};

		sleep 5;
	};
	
	if (getMissionConfigValue "casPenalty" > 0 ) then {
		_cooldown = getMissionConfigValue "casCooldown" + getMissionConfigValue "casPenalty";

		missionNameSpace setVariable ["casStatus",3,true];
		
		sleep _cooldown;
		
		missionNameSpace setVariable ["casStatus",0,true];
		
		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["Be advised: New CAS is available.",_supportControlName,"msg_CASAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["Be advised: New CAS is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	}
	else {
		missionNameSpace setVariable ["casStatus",0,true];

		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"msg_CASNoCAS",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	};
};

_plane setvelocity velocity _plane;
_plane flyinheight _alt;

//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
	for "_i" from 0 to 1 do {
		driver _plane forceweaponfire ["CMFlareLauncher","Burst"];
		_time = time + 1.1;
		waituntil {time > _time || isnull _plane};
	};
};

if (_audioMessages == "true") then {
	if (_customAudio == "true") then {
		["CAS Firemission done. Aircraft is leaving the staging area.",_supportControlName,"msg_CASDone",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["CAS Firemission done. Aircraft is leaving the staging area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

waituntil {_plane distance _pos > _dis || !canMove _plane};

//--- Delete plane
if (canMove _plane) then {
	_group = group _plane;
	_crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;

	if (missionnamespace getVariable ["casMGruns",0] > 0 || missionnamespace getVariable ["casMisRuns",0] > 0 || missionnamespace getVariable ["casBombRuns",0] > 0) then {

		missionNameSpace setVariable ["casStatus",3,true];

		_cooldownMike = ceil (getMissionConfigValue "casCooldown" / 60);
		
		if (_audioMessages == "true") then {
			_msg = format ["Be advised: CAS Aircraft is returning to holding pattern and preparing for new strike. ETA: %1 mike",_cooldownMike];
			
			if (_customAudio == "true") then {
				[_msg,_supportControlName,"msg_CASPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				[_msg,_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
			
			sleep 10;
		};
		
		sleep getMissionConfigValue "casCooldown";
		
		missionNameSpace setVariable ["casStatus",0,true];

		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["Be advised: New CAS is available.",_supportControlName,"msg_CASAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["Be advised: New CAS is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	}
	else {
	
		missionNameSpace setVariable ["casStatus",0,true];

		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["Be advised: Aircraft is bingo ammo and RTB. No more CAS Strikes available.",_supportControlName,"msg_CASLastCAS",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["Be advised: Aircraft is bingo ammo and RTB. No more CAS Strikes available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	};
} 
else {
	if (_audioMessages == "true") then {
		if (_customAudio == "true") then {
			["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"msg_CASLostExtract",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Units be advised: CAS Element was lost on extraction.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};
	
		sleep 5;
	};
	
	if (getMissionConfigValue "casPenalty" > 0 ) then {
		_cooldown = getMissionConfigValue "casCooldown" + getMissionConfigValue "casPenalty";

		missionNameSpace setVariable ["casStatus",3,true];
		
		sleep _cooldown;		
		
		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["Be advised: New CAS is available.",_supportControlName,"msg_CASAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["Be advised: New CAS is available.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	}
	else {

		missionNameSpace setVariable ["casStatus",0,true];

		if (_audioMessages == "true") then {
			if (_customAudio == "true") then {
				["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"msg_CASNoCAS",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["No other CAS Aircrafts available. You are on your own now.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	};
};
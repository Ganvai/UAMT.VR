if (!isServer) exitWith {};

params ["_paramPlaneClass","_weaponTypesID","_posATL","_spawnPos",["_customAudio",true],["_supportControlName","TOC"],["_side",west]];

_planeClass = _paramPlaneClass;
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

if (count _weapons == 0) exitwith {["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};

//_posATL = getposatl _logic;
_pos = +_posATL;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];
_dir = [_spawnPos,_posATL] call BIS_fnc_dirTo;

_dis = 3000;
_alt = 1000;
_pitch = atan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
//_planePos = _spawnPos;
_planePos set [2,(_pos select 2) + _alt];
_planeSide = (getnumber (_planeCfg >> "side")) call bis_fnc_sideType;
_planeArray = [_planePos,_dir,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
_plane = _planeArray select 0;
_plane setposasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableai "move";
_plane disableai "target";
_plane disableai "autotarget";
_plane setcombatmode "blue";

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

if (_customAudio) then {
	["All Units be advised: CAS Aircraft is inbound.",_supportControlName,"msg_CASInbound",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["All Units be advised: CAS Aircraft is inbound.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
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
	scriptdone _fire || isnull _plane
};

if (!alive _plane) exitWith {
	casPlaneReturn = 2;
	publicVariable "casPlaneReturn";
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

if (_customAudio) then {
	["CAS Firemission done. Aircraft is leaving the staging area.",_supportControlName,"msg_CASDone",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
}
else {
	["CAS Firemission done. Aircraft is leaving the staging area.",_supportControlName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
};

waituntil {_plane distance _pos > _dis || !alive _plane};

//--- Delete plane
if (alive _plane) then {
	_group = group _plane;
	_crew = crew _plane;
	deletevehicle _plane;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;

	casPlaneReturn = 4;
	publicVariable "casPlaneReturn";
} 
else {
	casPlaneReturn = 3;
	publicVariable "casPlaneReturn";
};
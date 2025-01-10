//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//
//				Vehicle IED Function
//
// Rigs Vehicles with an IED that explosed when opening the cargo or getting in.
// 
// When one of this happens, the players will hear a beeping sound and after 4 seconds, the 
// vehicle will explode.
//
// Also, for EODs, an Hold Action is added to inspect the Vehicle and if it is registered
// as trapped vehicle, to defuse it.
//
// Attributes:
// _vehicle : Vehicle Object the IED will be attached to <OBJECT>
// _bombType : Defining size of Explosion. 0 = small, 1 = med, 2 = large | Default 0 <NUMBER>
//
// [this,0] call UAMT_fnc_vehicleIED;
//
// Is compatible with the random IED Feature
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
params ["_vehicle",["_bombType",0]];

//Register vehicle as trapped

if (_bombType < 3) then {
	_trappedVehicles = missionNameSpace getVariable ["trappedVehicles",[]];
	_trappedVehicles pushbackUnique _vehicle;
	missionNameSpace setVariable ["trappedVehicles",_trappedVehicles,true];
};

// Add Option for EODs to search for Trap
[
	_vehicle,
	"check for Boobie Traps",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 7 && ([_this] call ace_common_fnc_isEOD)",
	"_caller distance _target < 7",
	{},
	{},
	{
		// Check if Vehicle is trapped
		if (_this select 0 in (missionNameSpace getVariable ["trappedVehicles",[]])) then {

			titleText ["<t color='#ff0000' size='2' font='RobotoCondensed' shadow = '2' >The vehicle is rigged with an IED</t>", "PLAIN", 1, true, true];
			
			// Add Vehicle to known Traps
			_vehArr = missionNameSpace getVariable ["knownTraps",[]];
			_vehArr pushback (_this select 0);
			missionNameSpace setVariable ["knownTraps",_vehArr,true];
			
			//Add Defuse Action for EODs
			[
				_this select 0,
				"defuse booby trap",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"_this distance _target < 7 && ([_this] call ace_common_fnc_isEOD)",
				"_caller distance _target < 7",
				{},
				{},
				{
					titleText ["<t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >IED Defused. Vehicle is clean.</t>", "PLAIN", 1, true, true];

					_defArr = missionNameSpace getVariable ["defusedTraps",[]];
					_defArr pushback (_this select 0);
					missionNameSpace setVariable ["defusedTraps",_defArr,true];

					[_this select 0, _this select 2] remoteExecCall ["removeAction", 0];
				},
				{},
				[],
				1,
				1000,
				false,
				false
			] remoteExec ["BIS_fnc_holdActionAdd",0, true];

		}
		else {
			titleText ["<t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >No IED found. Vehicle is clean.</t>", "PLAIN", 1, true, true];
		};
		
		// Remove the check booby trap action
		[_this select 0, _this select 2] remoteExecCall ["removeAction", 0];

	},
	{},
	[],
	1,
	1000,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];



if ( _bombType == 0 ) then {
	_vehicle addEventHandler ["ContainerOpened", {
		params ["_container", "_unit"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_container in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
			[_container] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				_vehicle setDamage 1;
			}
		};

		_container removeEventHandler [_thisEvent, _thisEventHandler];
	}];

	_vehicle addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_vehicle in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
		
			[_vehicle] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				_vehicle setDamage 1;
			}
			
		};

		_vehicle removeEventHandler [_thisEvent, _thisEventHandler];
	}];
};

if ( _bombType == 1 ) then {
	_vehicle addEventHandler ["ContainerOpened", {
		params ["_container", "_unit"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_container in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
			[_container] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				"Bo_Mk82_MI08" createVehicle (getpos _vehicle);
				_vehicle setDamage 1;
			}
		};

		_container removeEventHandler [_thisEvent, _thisEventHandler];
	}];

	_vehicle addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_vehicle in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
		
			[_vehicle] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				"Bo_Mk82_MI08" createVehicle (getpos _vehicle);
				_vehicle setDamage 1;
			}
			
		};

		_vehicle removeEventHandler [_thisEvent, _thisEventHandler];
	}];
};

if ( _bombType == 2 ) then {
	_vehicle addEventHandler ["ContainerOpened", {
		params ["_container", "_unit"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_container in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
			[_container] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				"Bo_GBU12_LGB_MI10" createVehicle (getpos _vehicle);
				_vehicle setDamage 1;
			}
		};

		_container removeEventHandler [_thisEvent, _thisEventHandler];
	}];

	_vehicle addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit", "_turret"];
		
		["Bomb EH"]remoteExec ["hint"];
		
		if (_vehicle in (missionNameSpace getVariable ["defusedTraps",[]])) then {} else {
		
			[_vehicle] spawn {
				params ["_vehicle"];
				
				for "_i" from 1 to 2 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.5;
				};
				for "_i" from 1 to 5 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.2;
				};
				for "_i" from 1 to 10 do {
					playSound3D ["\a3\sounds_f\sfx\beep_target.wss",_vehicle];
					sleep 0.1;
				};
				"Bo_GBU12_LGB_MI10" createVehicle (getpos _vehicle);
				_vehicle setDamage 1;
			}
			
		};

		_vehicle removeEventHandler [_thisEvent, _thisEventHandler];
	}];
};

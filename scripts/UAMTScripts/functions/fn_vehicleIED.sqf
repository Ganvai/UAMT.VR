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

// Add Option for EODs to search for IED
[
	_vehicle,
	"check for IED",
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
			
			//Add Defuse Action for EODs
			[
				_this select 0,
				"defuse IED",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"_this distance _target < 7 && ([_this] call ace_common_fnc_isEOD)",
				"_caller distance _target < 7",
				{},
				{},
				{
					titleText ["<t color='#ffffff' size='2' font='RobotoCondensed' shadow = '2' >IED Defused. Vehicle is clean.</t>", "PLAIN", 1, true, true];

					_defArr = missionNameSpace getVariable ["trappedVehicles",[]];
					_defArr = _defArr - [(_this select 0)];
					missionNameSpace setVariable ["trappedVehicles",_defArr,true];

					[_this select 0, _this select 2] remoteExecCall ["removeAction", 0];
				},
				{},
				[],
				1,
				1000,
				false,
				false
			] remoteExec ["BIS_fnc_holdActionAdd",0, _this select 0];

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

_vehicle addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	if (isPlayer _unit && _vehicle in (missionNameSpace getVariable ["trappedVehicles",[]])) then {
		[_vehicle,getmissionConfigValue "rVifBombType"] remoteExec ["UAMT_fnc_vehicleIEDBlowUp",2];
	};
}];

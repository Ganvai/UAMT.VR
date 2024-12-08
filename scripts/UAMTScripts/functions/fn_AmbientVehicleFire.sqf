//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------
//
//			Ambient Vehicle Fire
//
// Lets any vehicle shoot its main weapon in angle and height you define.
// With _salvo, it is able to shoot multiple rounds (for AAs or even flame tanks).
//
// Call:
// [[vehicles],_angleH,_angleV,_salvo,_firepause,_cond] call UAMT_fnc_ambientVehicleFire;
//
// PARAMETERS
// _vehicles : OBJECT or ARRAY of OBJECTS / the vehicles you want to let fire
//
// _angleH : NUMBER, Optional, default 90 / Horizontal Angle in which the turret is moved
//											Should be somewhat narrow for Tanks (like 90)
//											For AAs even 360 is valid
//
// _angleV : NUMBER, Optional, default 50 / Vertical Angle in which the turret will move
//											This is the min Height in which the vehicle will aim
//											as well as the random amount that will be added on top
//
// _salvo : NUMBER, Optional, default 1 / Amount of Shots that are fired in one salvo. For slow firing
//										  Vehicles like tanks this should always be 1. AA or Fire tanks
//										  can use larger numbers. Will get a slight random value +- 30 %
//
// _firepause : Number, Optional, default 20 / Defines length of Pause between two salvos. Has a slight
//												random value added +- 30%
//
// _cond : CODE, Optional, default {alive _vehicle} / Condition under which the vehicle fires. Must return bool!
//
// EXAMPLES:
//
// [tank] call UAMT_fnc_ambientVehicleFire;
// Vehicle named "tank" fires with default values
//
// [aa,360,100,10,5,aaFire] call UAMT_fnc_ambientVehicleFire;
// Vehicle named "AA" fires in 360 degree salvos of 10 rounds with 5 seconds delay between salvo. Ends when the public variable
// aaFire is set to false
//
// Credits
// Script by Jan
// Based on AmbientVehicleFire Script by IndeedPete
//-------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------

params [["_vehicles",[]],["_angleH",90],["_angleV",50],["_salvo",1],["_firePause",20],["_cond",{alive _vehicle}]];

_vehicleArr = [];

if (typeName _vehicles == "OBJECT") then {
	_vehicleArr pushback _vehicles;
}
else {
	_vehicleArr = _vehicles;
};

{
	[_x,_angleH,_angleV,_salvo,_firepause,_cond] spawn {
	
		params ["_vehicle","_angleH","_angleV","_salvo","_firePause","_cond"];
	
		_shots = 1;
		
		while _cond do {
			_vehicle setVehicleAmmo 1;
			
			_dir = getDir _vehicle;
			_dir = _dir + random [((_angleH / 2) * -1) ,0,(_angleH / 2)];
			_pos = _vehicle getPos [100,_dir];
			_height = _angleV + (random _angleV);
			_pos set [2,_height];

			_vehicle doWatch _pos;
			
			if (_salvo > 1) then {
				_shots = ceil random [(_salvo * 0.7),_salvo,(_salvo * 1.3)];
			};
			
			_sleepy = random [(_firePause * 0.7),_firePause,(_firePause * 1.3)];
			sleep _sleepy;
			
			for "_i" from 1 to _shots do {
				_vehicle fire (weapons _vehicle select 0);
				sleep 0.1;
			};
		};
	};
}forEach _vehicleArr;

//reloadTime = 0.x (eg. configfile >> "CfgWeapons" >> "arifle_Katiba_F" >> "Single" >> "reloadTime": 0.075) 
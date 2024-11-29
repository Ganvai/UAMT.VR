params ["_deliveryPos","_approachPos","_supplyDropMinDistSpawnConfig","_supplyDropVehicleConfig","_supplyDropPilotConfig","_customLoad",["_damage",true],["_customAudio",true],["_callerID","TOC"],["_callerSide",west]];

//Private Variables needed in the Script
_pos = [0,0,0];
_SignalClass = "SmokeShellGreen";
_ChuteClass = "B_Parachute_02_F";

//Calculate Coordinates for Spawn and Despawn with Approach Vektor Position
_dir = _approachPos getDir _deliveryPos;
_supplyDropSpawn =  _deliveryPos getPos [_supplyDropMinDistSpawnConfig, _dir + 180];
_supplyDropDeSpawn =  _deliveryPos getPos [_supplyDropMinDistSpawnConfig, _dir];

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"};

// Spawning the Vehicle
_supplyDropVehicle = createVehicle [_supplyDropVehicleConfig, _supplyDropSpawn, [], 0, "FLY"];
_supplyDropVehicle setPos [(getpos _supplyDropVehicle # 0),(getpos _supplyDropVehicle # 1), 150];
_supplyDropVehicle setDir _dir;
_supplyDropVehicle AllowDamage _damage;

// Spawning the Pilot
_Pilot = CreateAgent [_supplyDropPilotConfig, [0,0,0], [], 0, "NONE"];
_Pilot MoveInDriver _supplyDropVehicle;
_Pilot setRank "SERGEANT";
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
_Pilot disableAI "FSM";

//Setting the Waypoint for the Supply Drop Delivery
_Pilot MoveTo _deliveryPos;

//Setting the Flight Height for the Vehicle
_supplyDropVehicle flyInHeight 150;

if (_customAudio) then {
	["Coordinates recieved. Supply Drop is on the way.",_callerID,"msg_supplyDropConfirm",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];	
}
else {
	["Coordinates recieved. Supply Drop is on the way.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];	
};

		
//Wait until the Vehicle is close to the Drop Position
WaitUntil {sleep 0.5; (_deliveryPos distance2D _supplyDropVehicle < 200) || !alive _supplyDropVehicle};

if (!alive _supplyDropVehicle) exitWith {

	supplyDropReturn = 1;
	publicVariable "supplyDropReturn";
	
	if (_customAudio) then {
		["Supply Helicopter was destroyed before it could reach the dropzone.",_callerID,"msg_SupplyDropDestroyedBefore",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["Supply Helicopter was destroyed before it could reach the dropzone.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
};

//Setting a Waypoint for the Vehicle to the Despawn position
_Pilot MoveTo _supplyDropDeSpawn;

// Create box and Chute and make it fall
_Box = CreateVehicle ["B_CargoNet_01_ammo_F", [0,0,0], [], 0, "NONE"];
_Box disableCollisionWith _supplyDropVehicle;

if (_customAudio) then {
	["All Units: Supply Drop is out. Helicopter is RTB.",_callerID,"msg_supplyDropOut",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["All Units: Supply Drop is out. Helicopter is RTB.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};

//Make Cargo Container Empty. Only Supply Drop Spawn Function for Cargo
clearWeaponCargoGlobal _Box;
clearItemCargoGlobal _Box;
clearMagazineCargoGlobal _Box;
clearBackpackCargoGlobal _Box;

// Fill the Supply Crate with items from _customLoad Array or attach Supply Point Function
// custom load array should be format [[itemClass,itemCount],[itemClass,itemCount]]
if (count _customLoad == 0) then {
	_supplyPointInitPath = format ["%1supplyPointInit.sqf",supplyPath];
	[[_box, 2, 0],_supplyPointInitPath] remoteExec ["execVM"];
}
else {
	{
		if (getNumber (configFile >> "CfgVehicles" >> _x select 0 >> "isbackpack") == 1) then {
			_Box addBackpackCargoGlobal [_x select 0,_x select 1];
		}
		else {
			_Box addItemCargoGlobal [_x select 0,_x select 1];
		};
		
	}forEach _customLoad;
};


_Box HideObjectGlobal True;
_Chute = CreateVehicle [_ChuteClass, [0,0,0], [], 0, "NONE"];
_Chute AllowDamage False;
_Chute disableCollisionWith _supplyDropVehicle;
_Chute disableCollisionWith _Box;
_Box attachTo [_Chute,[0,0,0]];
_Chute HideObjectGlobal True;
_Temp = _supplyDropVehicle getPos [50, GetDir _supplyDropVehicle];
//_Temp = [_supplyDropVehicle, 50, (GetDir _supplyDropVehicle)] call BIS_fnc_relPos;
_Temp = [_Temp select 0, _Temp select 1, 140];
_Chute SetPosATL _Temp;
_Chute SetDir (getDir _supplyDropVehicle);
_PitchBank = _Chute call BIS_fnc_getPitchBank;
[_Chute,15,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
sleep 0.7;
_Box HideObjectGlobal False;
_Chute HideObjectGlobal False;
_Chute setVelocity [((Velocity _supplyDropVehicle) select 0), ((Velocity _supplyDropVehicle) select 1),-5];
[_Chute] spawn { For "_i" from 1 to 10 do { Params ["_Chute"]; _Chute setvelocity [Velocity _Chute select 0, Velocity _Chute select 1, -5]; sleep 0.5 } };

[_SignalClass, _Box] spawn 
{
	_SignalClass = _This select 0;
	_Box = _This select 1;
	
	sleep 5;
	_Signal = createVehicle [_SignalClass, [0,0,0], [], 0, "NONE"];
	_Signal AttachTo [_Box,[0,0,0]];
	WaitUntil {(((GetPosATL _Box) select 2) <= 1)};
	
	Detach _Box;
};


//Suspending until the Vehicle reached the Despawn Position
WaitUntil {sleep 1; (_supplyDropDeSpawn distance2D _supplyDropVehicle < 200) || !alive _supplyDropVehicle};

if (!alive _supplyDropVehicle) exitWith {

	supplyDropReturn = 1;
	publicVariable "supplyDropReturn";
	
	if (_customAudio) then {
		["All Elements, be advised: Supply Drop was destroyed on its way back to base.",_callerID,"msg_supplyDropDestroyedBase",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	}
	else {
		["All Elements, be advised: Supply Drop was destroyed on its way back to base.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
	};
};

supplyDropReturn = 1;
publicVariable "supplyDropReturn";
	
//Deleting Crew and Vehicle
DeleteVehicleCrew _supplyDropVehicle;
DeleteVehicle _supplyDropVehicle;

if (_customAudio) then {
	["All Units: Supply Helicopter is back at Base.",_callerID,"msg_supplyDropBack",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
}
else {
	["All Units: Supply Helicopter is back at Base.",_callerID,"Radio",_callerSide] remoteExec ["UAMT_fnc_quickMsg",_callerSide];
};

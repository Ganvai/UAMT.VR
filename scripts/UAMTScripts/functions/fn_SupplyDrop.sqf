//-----------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------
//
//							Supply Drop
//
// Spawns a helicopter in the configured distance, lets them fly over the position
// and drop a crate with Supplies. The Supplies can have the UAMT Supply Point
// function OR can be an Array of Items
//
// CALL:
// [_deliveryPos,_dir, _heliClass, _pilotClass, _spawnDistance,_side,_createMarker,_customLoad,_damage,_audio,_UAMT]call UAMT_fnc_supplyDrop;
//
// PARAMETERS:
// _deliveryPos ARRAY - Position ARRAY in AGL or ASL - Supply Drop will be dropped here
//							Keep in Mind that Wind and speed of Helicopter have influence where
//							the drop will actually land
//
// _dir NUMBER - Direction from where the Helicopter will come regarding the _deliveryPos
//
// _heliClass STRING - Class of Helicopter
//
// _pilotClass STRING - Class of Pilot
//
// _spawnDistance NUMBER - Distance to _deliveryPos where the heli will spawn
//
// _side (Optional, default WEST) - Side of spawned helicopter -> Also used for Audio Messages Coloring
//
// _createMarker BOOL (Optional, default true) - Creates a Marker on the Drop position.
//
// _customLoad ARRAY (Optional, default []) - Multidimensional Array [[itemClass,Amount],[itemClass,Amount]]
//
// _damage BOOL (Optional, default false) - If Helicopter can be damaged
//
// _audio BOOL (Optional, default false) - Sends Audiomessages about status of Helicopter -> Only works in full UAMT context
//
// _customAudio BOOL (Optional, default false) - Plays the custom Audio messages from UAMT -> Only works in full UAMT contexts
//
// _radioName STRING (Optional, default "TOC") - Name of the sender of the messages. Only needed if _audio is true.
// 
// _UAMT Bool (Optional, default false) - Needed for call via sdpDialog. Should always be false when you use it in a script
//
//-----------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------
if (!isServer) exitWith {};

params ["_deliveryPos","_dir","_heliClass","_pilotClass","_spawnDistance",["_side",west],["_createMarker",true],["_customLoad",[]],["_damage",false],["_audio",false],["_customAudio",false],["_radioName","TOC"],["_UAMT",false]];

// Set Status of sdp Function for Dialog
if (_UAMT) then {
	missionNameSpace setVariable ["supplyDropStatus",2,true];
};

_supplyDropCount = missionNameSpace getVariable ["supplyDropCount",0];
missionNameSpace setVariable ["supplyDropCount",(_supplyDropCount + 1),true];

// Create Markers
if (_createMarker) then {

	_markerName = format ["_USER_DEFINED supplyDropMrk%1",_supplyDropCount];
	_markerText = format ["Supply Drop %1",_supplyDropCount];
	
	createMarker [_markerName,[0,0,0]];
	_markerName setMarkerAlpha 0;
	_markerName setMarkerType "mil_destroy_noShadow";
	_markerName setMarkerText _markerText;
};

//Private Variables needed in the Script
_pos = [0,0,0];
_SignalClass = "SmokeShellGreen";
_ChuteClass = "B_Parachute_02_F";

//Calculate Coordinates for Spawn and Despawn with Approach Vektor Position
_supplyDropSpawn =  _deliveryPos getPos [_spawnDistance, _dir];
_supplyDropDeSpawn =  _deliveryPos getPos [_spawnDistance, _dir + 180];

// Whether it'll have a smoke grenade or a chemlight for signal
if ((dayTime > 04.30) and (dayTime < 19.30)) then {_SignalClass = "SmokeShellGreen"};

// Spawning the Vehicle
_supplyDropVehicle = createVehicle [_heliClass, _supplyDropSpawn, [], 0, "FLY"];
_supplyDropVehicle setPos [(getpos _supplyDropVehicle # 0),(getpos _supplyDropVehicle # 1), 150];
_supplyDropVehicle setDir (_dir + 180);
_supplyDropVehicle AllowDamage _damage;

// Spawning the Pilot
_Pilot = CreateAgent [_pilotClass, [0,0,0], [], 0, "NONE"];
_Pilot MoveInDriver _supplyDropVehicle;
_Pilot setRank "SERGEANT";
_Pilot SetBehaviour "CARELESS";
_Pilot setCombatMode "BLUE";
_Pilot disableAI "FSM";

//Setting the Waypoint for the Supply Drop Delivery
_Pilot MoveTo _deliveryPos;

//Setting the Flight Height for the Vehicle
_supplyDropVehicle flyInHeight 150;

//Send Audio Messages
if (_audio) then {
	if (_customAudio) then {
		["Coordinates recieved. Supply Drop is on the way.",_radioName,"msg_supplyDropConfirm",_side] remoteExec ["UAMT_fnc_quickMsg",_side];	
	}
	else {
		["Coordinates recieved. Supply Drop is on the way.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];	
	};
};

		
//Wait until the Vehicle is close to the Drop Position
WaitUntil {sleep 0.5; (_deliveryPos distance2D _supplyDropVehicle < 200) || not canMove _supplyDropVehicle};

// If Heli is damaged and cannot move
if (not canMove _supplyDropVehicle) exitWith {
	// Clean up vehicle and Crew
	deleteVehicleCrew _supplyDropVehicle;
	_supplyDropVehicle setDamage 1;
	
	// Send Audio Message
	if (_audio) then {
		if (_customAudio) then {
			["Supply Helicopter was destroyed before it could reach the dropzone.",_radioName,"msg_SupplyDropDestroyedBefore",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["Supply Helicopter was destroyed before it could reach the dropzone.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};		
	};
	
	//If sdpDialog function handle respawn
	if (_UAMT) then {
		if ((missionNameSpace getVariable ["supplyDropCount",0]) < (getMissionConfigValue "supplyDropMax")) then {
			// Do this when there are still Supply Drop Calls left
			
			//Change Status for Dialog Message
			missionNameSpace setVariable ["supplyDropStatus",3,true];
			
			//Calculate Cooldown
			_cooldown = (getMissionConfigValue "supplyDropDelay") + (getMissionConfigValue "supplyDropDelayPenalty");
			
			// Audio Message for respawn time
			if (_audio) then {

				_coolDownMike = ceil (_cooldown / 60);

				_msg = format ["We are preparing a new Supply Drop. Available in: %1 Mike.",_coolDownMike];

				sleep 3;

				if (_customAudio) then {
					[_msg,_radioName,"msg_supplyDropPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					[_msg,_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};

			// wait for respawn
			sleep _cooldown;
			
			// Make Dialog accessible after respawn
			missionNameSpace setVariable ["supplyDropStatus",0,true];
			
			// Send Audio Message
			if (_audio) then {
				if (_customAudio) then {
					["All Elements, be advised: New Supply Drop is available.",_radioName,"msg_supplyDropAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Elements, be advised: New Supply Drop is available.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};
		}
		else {
			// Do this when no supply Drop available anymore

			// Make Dialog accessible
			missionNameSpace setVariable ["supplyDropStatus",0,true];

			if (_audio) then {
				if (_customAudio) then {
					["This was the last Supply Drop available. We can't send anymore.",_radioName,"msg_supplyDropLast",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["This was the last Supply Drop available. We can't send anymore.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};
		};
	};
};

//Setting a Waypoint for the Vehicle to the Despawn position
_Pilot MoveTo _supplyDropDeSpawn;

// Create box and Chute and make it fall
_Box = CreateVehicle ["B_CargoNet_01_ammo_F", [0,0,0], [], 0, "NONE"];
_Box disableCollisionWith _supplyDropVehicle;

if (_audio) then {
	if (_customAudio) then {
		["All Units: Supply Drop is out. Helicopter is RTB.",_radioName,"msg_supplyDropOut",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units: Supply Drop is out. Helicopter is RTB.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

//Make Cargo Container Empty. Only Supply Drop Spawn Function for Cargo
clearWeaponCargoGlobal _Box;
clearItemCargoGlobal _Box;
clearMagazineCargoGlobal _Box;
clearBackpackCargoGlobal _Box;

// Fill the Supply Crate with items from _customLoad Array or attach Supply Point Function
// custom load array should be format [[itemClass,itemCount],[itemClass,itemCount]]
if (count _customLoad == 0) then {
	_boxes = [missionConfigFile >> "CfgFactionEquipment", "supplyCrates", []] call BIS_fnc_returnConfigEntry;
	
	_supplyPoint = _Box;
	
	_supplyPointDist = 2;
	_supplyPointDir = 0;
	_supplyPointBoxName = "";
	_supplyPointBoxType = "";
	_supplyPointBoxVar = "";
	_boxNumber = 0;
	
	{
		_boxNumber = _boxNumber + 1;
		_actionName = format ["SupplyBox %1", _boxNumber];
		_supplyPointBoxName = _x select 0;
		_supplyPointBoxType = _x select 1;
		_supplyPointBoxVar = _x select 2;

		_statement = {
			params ["_target", "_player", "_actionParams"];
			_actionParams params ["_supplyPoint", "_supplyPointDist", "_supplyPointDir", "_supplyPointBoxType", "_supplyPointBoxVar"];
			
			[_supplyPoint,_supplyPointDist,_supplyPointDir,_supplyPointBoxType,_supplyPointBoxVar] remoteExec ["UAMT_fnc_spawnSupplyCrate",2];
			//[_supplyPoint,_supplyPointDist,_supplyPointDir,_supplyPointBoxType,_supplyPointBoxVar] call UAMT_fnc_spawnSupplyCrate;
		};
		
		_boxMenu = [_actionName, _supplyPointBoxName, "", _statement, {true}, {}, [_supplyPoint, _supplyPointDist, _supplyPointDir, _supplyPointBoxType, _supplyPointBoxVar]] call ace_interact_menu_fnc_createAction;		
		[_supplyPoint, 0, ["ACE_MainActions"], _boxMenu] call ace_interact_menu_fnc_addActionToObject;
		
	}forEach _boxes;
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
WaitUntil {sleep 1; (_supplyDropDeSpawn distance2D _supplyDropVehicle < 200) || not canMove _supplyDropVehicle};

// If Heli was damaged and cannot move
if (not canMove _supplyDropVehicle) exitWith {
	
	// Clean up
	deleteVehicleCrew _supplyDropVehicle;
	_supplyDropVehicle setDamage 1;

	if (_audio) then {
		if (_customAudio) then {
			["All Elements, be advised: Supply Drop was destroyed on its way back to base.",_radioName,"msg_supplyDropDestroyedBase",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		}
		else {
			["All Elements, be advised: Supply Drop was destroyed on its way back to base.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
		};	
	};
	
	if (_UAMT) then {
		if ((missionNameSpace getVariable ["supplyDropCount",0]) < (getMissionConfigValue "supplyDropMax")) then {
			// If there are still supply drops available
			
			// Set status for Dialog Message
			missionNameSpace setVariable ["supplyDropStatus",3,true];
			
			// Calculate respawn time
			_cooldown = (getMissionConfigValue "supplyDropDelay") + (getMissionConfigValue "supplyDropDelayPenalty");
			
			if (_audio) then {

				_coolDownMike = ceil (_cooldown / 60);

				_msg = format ["We are preparing a new Supply Drop. Available in: %1 Mike.",_coolDownMike];

				sleep 3;

				if (_customAudio) then {
					[_msg,_radioName,"msg_supplyDropPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					[_msg,_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};
			
			// Wait for respawn
			sleep _cooldown;
			
			// Respawn done. Make Dialog available again
			missionNameSpace setVariable ["supplyDropStatus",0,true];
			
			if (_audio) then {
				if (_customAudio) then {
					["All Elements, be advised: New Supply Drop is available.",_radioName,"msg_supplyDropAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["All Elements, be advised: New Supply Drop is available.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};
		}
		else {
			// If no more Supply Drops are available
			
			missionNameSpace setVariable ["supplyDropStatus",0,true];

			if (_audio) then {
				if (_customAudio) then {
					["This was the last Supply Drop available. We can't send anymore.",_radioName,"msg_supplyDropLast",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				}
				else {
					["This was the last Supply Drop available. We can't send anymore.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
				};
			};
		};
	};
};
	
//Deleting Crew and Vehicle
DeleteVehicleCrew _supplyDropVehicle;
DeleteVehicle _supplyDropVehicle;

if (_audio) then {
	if (_customAudio) then {
		["All Units: Supply Helicopter is back at Base.",_radioName,"msg_supplyDropBack",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	}
	else {
		["All Units: Supply Helicopter is back at Base.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
	};
};

// If function was called from spdDialog
if (_UAMT) then {
	if ((missionNameSpace getVariable ["supplyDropCount",0]) < (getMissionConfigValue "supplyDropMax")) then {
		// If there are still Supply Drops available
		
		// Set Status for Dialog message
		missionNameSpace setVariable ["supplyDropStatus",3,true];
	
		// Set cooldown
		_cooldown = getMissionConfigValue "supplyDropDelay";
		
		if (_audio) then {

			_coolDownMike = ceil (_cooldown / 60);

			_msg = format ["We are preparing a new Supply Drop. Available in: %1 Mike.",_coolDownMike];

			sleep 3;

			if (_customAudio) then {
				[_msg,_radioName,"msg_supplyDropPrepare",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				[_msg,_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};

		// Wait for respawn
		sleep _cooldown;
		
		// Make dialog available again
		missionNameSpace setVariable ["supplyDropStatus",0,true];
		
		if (_audio) then {
			if (_customAudio) then {
				["All Elements, be advised: New Supply Drop is available.",_radioName,"msg_supplyDropAvailable",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["All Elements, be advised: New Supply Drop is available.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	}
	else {
		// If this was the last supply drop
		missionNameSpace setVariable ["supplyDropStatus",0,true];

		if (_audio) then {
			if (_customAudio) then {
				["This was the last Supply Drop available. We can't send anymore.",_radioName,"msg_supplyDropLast",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			}
			else {
				["This was the last Supply Drop available. We can't send anymore.",_radioName,"Radio",_side] remoteExec ["UAMT_fnc_quickMsg",_side];
			};
		};
	};
};

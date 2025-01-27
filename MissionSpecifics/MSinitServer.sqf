//-------------------------------------------------------
// 		Showcase Keypad
//-------------------------------------------------------
[pad_2,"1234",[1,4]] call UAMT_fnc_createKeypad;


//-------------------------------------------------------
// 		 Showcase Intel Feature
//-------------------------------------------------------

//Variables for Intel Feature
missionNameSpace setVariable ["IntelMaxCounter",9,true];
missionNameSpace setVariable ["IntelSecondaryArray",["marker_1","maker_2","marker_3"],true];

// Loop over every OPFOR Unit in the Mission
{
	// Add an Eventhandler to every OPFOR Unit that has a chance to have an "Search Intel"-HoldAction if Killed
	_x addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		
		hint "Killed EH";
		// Only add the Hold Action if the Unit was killed by a player
		if (isPlayer _killer) then {
			
			// Random Chance
			_chance = random 1;
			hint str _chance;
			
			// Check if there is any Intel to be revealed
			_IntelMainCounter = missionNameSpace getVariable ["IntelMainCounter",0];
			_intelSecondaryArray = missionNameSpace getVariable ["IntelSecondaryArray",[]];
			
			hint str _IntelMainCounter;
			// If Chance is High enough and there is still Intel left to be revealed:
			if (_chance > 0 && _intelMainCounter <= (missionNameSpace getVariable ["IntelMaxCounter",0]) && count _intelSecondaryArray > 0) then {
				hint "Add Intel Action";
				// Remove Unit from Garbage Collector
				removeFromRemainsCollector [_unit];
				
				//Add Intel Action to unit
				[_unit] call UAMT_fnc_intelAddHoldAction;
			};
		};
		
		// Remove the Event Handler just to be a nice, clean Missionmaker
		_unit removeEventHandler [_thisEvent,_thisEventHandler];
	}];
}forEach units opfor;

//-------------------------------------------------------
// 		 Showcase Ambient Vehicle Fire
//-------------------------------------------------------
avfCondition = false;
publicVariable "avfCondition";

[
	avfTerminal,
	"Start Ambient Vehicle Fire",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3 && !avfCondition",
	"_caller distance _target < 3 && !avfCondition",
	{},
	{},
	{ 
		avfCondition = true;
		publicVariable "avfCondition";
		
		// Call Function for the AAs, that have a wide horizontal and vertical angles and a large salvo
		[[[avfAA_1,avfAA_2],360,150,20,5,{avfCondition}],UAMT_fnc_ambientVehicleFire] remoteExec ["call",2];

		// Call Function for the tanks that have narrow angles and only single shot
		[[[avftank_1,avftank_2],50,50,1,10,{avfCondition}],UAMT_fnc_ambientVehicleFire] remoteExec ["call",2];
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[
	avfTerminal,
	"Stop Ambient Vehicle Fire",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3 && avfCondition",
	"_caller distance _target < 3 && avfCondition",
	{},
	{},
	{ 
		avfCondition = false;
		publicVariable "avfCondition";
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

//-------------------------------------------------------
// 		 Showcase Artillery Fire
//-------------------------------------------------------
afCondition = false;
publicVariable "afCondition";

[
	afTerminal,
	"Start Artillery Fire",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3 && !afCondition",
	"_caller distance _target < 3 && !afCondition",
	{},
	{},
	{ 
		afCondition = true;
		publicVariable "afCondition";
		
		// Call Artillery fire function
		[[afMortar_1,afMortar_2],[5665.11,7381.19,0],"8Rnd_82mm_Mo_shells",1,100,80,10,{afCondition}] call UAMT_fnc_artilleryFire;

	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[
	afTerminal,
	"Stop Artillery Fire",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3 && afCondition",
	"_caller distance _target < 3 && afCondition",
	{},
	{},
	{ 
		afCondition = false;
		publicVariable "afCondition";
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

//-------------------------------------------------------
// 		 Showcase Heli Taxi Hop
//-------------------------------------------------------

[
	heliHopTerminal,
	"Heli Taxi Hop",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ 
		[heliHop_1,[5297.02,7013.99,0],1,true,true,true] call UAMT_fnc_heliTaxiHopCall;
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[
	heliTaxiTerminal,
	"Heli Taxi Full",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ 
		[["heliTaxiSpawn_1","heliTaxiSpawn_2"],["heliTaxiPickUp_1","heliTaxiPickUp_2"],["heliTaxiDrop_1","heliTaxiDrop_2"],["heliTaxiDespawn_1","heliTaxiDespawn_2"], "B_Heli_Light_01_F", true, true] call UAMT_fnc_heliTaxiCall;
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

//-------------------------------------------------------
// 		 Showcase Reinforcements
//-------------------------------------------------------

[
	paradropTerminal,
	"call Paradrop Reinforcements",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ 
		["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,[6095.03,7516.11,0],[5334.57,7622,0],_caller] call UAMT_fnc_heliReInfPara;
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];

[
	reinfLandTerminal,
	"call Landing Reinforcements",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ 
		["O_Heli_Light_02_dynamicLoadout_F",["O_Soldier_F","O_Soldier_F","O_Soldier_F"],east,[6095.03,7516.11,0],[5334.57,7622,0],getPos _caller,true] call UAMT_fnc_heliReInfLand;
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, true];
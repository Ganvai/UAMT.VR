//-------------------------------------------------------
// 		Showcase Keypad
//-------------------------------------------------------
[pad_2,"1234",[1,4]] call UAMT_fnc_createKeypad;

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
		[[avfAA_1,avfAA_2],360,150,20,5,{avfCondition}] call UAMT_fnc_ambientVehicleFire;

		// Call Function for the tanks that have narrow angles and only single shot
		[[avftank_1,avftank_2],50,50,1,10,{avfCondition}] call UAMT_fnc_ambientVehicleFire;
	},
	{},
	[],
	1,
	0,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, avfTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, avfTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, afTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, afTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, heliHopTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, heliTaxiTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, paradropTerminal];

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
] remoteExec ["BIS_fnc_holdActionAdd", 0, reinfLandTerminal];
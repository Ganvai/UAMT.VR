//--------------------------------------------------------------------
//
//		Supply System Configuration
//
//--------------------------------------------------------------------
// Here you can add new Supply Boxes to both supply points.
// To add a new Box, just add a new Array to the boxes-Array below
// The array structure is:
// 
// ["Name","BoxType","File.sqf"];
//
// Name		= Name of the box displayed in the ACE Interaction Menu of the supply Point
//
// BoxType 	= The Classname of the Box that is to be spawned. Keep in mind it should be preferably an ACE Box Type to have ACe Drag/Carry working properly
//			  Available Box Types are:
//			  "ACE_Box_Ammo" - A Small Metal Box with AMMO written on it
//			  "ACE_Box_82mm_Mo_HE" - Small Metal Box with Explosive Sign on it
//			  "ACE_Box_Chemlights" - Large, flat Metalbox with "Special Purpose" written over it
//			  "ACE_medicalSupplyCrate" - Wodden Box with Red Cross on White circle
//			  "Box_NATO_Equip_F" - The Vanilla Equipment Box
//			  "B_supplyCrate_F" - The Vanilla Supply Crate, normally used for Arsenals
//
// File.sqf = The filename of the Script that fills the box. Needs to be located in the supplySystem folder of the used faction.
//--------------------------------------------------------------------

_boxes = [
	["Ammo","ACE_Box_Ammo","SupplyPoint_AmmoCrate"],
	["Heavy Ammo","ACE_Box_Ammo","SupplyPoint_HeavyAmmoCrate"],
	["Grenades","ACE_Box_82mm_Mo_HE","SupplyPoint_GrenadeCrate"],
	["AT Ammo","ACE_Box_Chemlights","SupplyPoint_ATCrate"],
	["AA Ammo","ACE_Box_Chemlights","SupplyPoint_AACrate"],
	["AT-Light","ACE_Box_Chemlights","SupplyPoint_ATLightCrate"],
	["Medic Supplies","ACE_medicalSupplyCrate","SupplyPoint_MedicCrate"],
	["Explosives","ACE_Box_82mm_Mo_HE","SupplyPoint_ExplosivesCrate"],
	["UAV","Box_NATO_Equip_F","SupplyPoint_UAVCrate"],
	["Empty Box","Box_NATO_Equip_F","10_sp_empty.sqf"],
	["Emtpy Transport Box","B_supplyCrate_F","11_sp_emptyLarge.sqf"]
];


//*****************************************************************
//*****************************************************************
//
//								Code
//
//
// Executing the loops to generate the Supply Point Interactions
// Don't change anything in here or it might crash
//
//*****************************************************************
//*****************************************************************

_supplyPointVar = _this select 0;
_supplyPointDist = _this select 1;
_supplyPointDir = _this select 2;
_supplyPointBoxName = "";
_supplyPointBoxType = "";
_supplyPointBoxVar = "";
_boxNumber = 0;

private _supplyPoint = _this select 0;
{
	_boxNumber = _boxNumber + 1;
	_actionName = format ["SupplyBox %1", _boxNumber];
	_supplyPointBoxName = _x select 0;
	_supplyPointBoxType = _x select 1;
	_supplyPointBoxVar = _x select 2;

	_statement = {
		params ["_target", "_player", "_actionParams"];
		_actionParams params ["_supplyPointVar", "_supplyPointDist", "_supplyPointDir", "_supplyPointBoxType", "_supplyPointBoxVar"];
		
		[_supplyPointVar,_supplyPointDist,_supplyPointDir,_supplyPointBoxType,_supplyPointBoxVar] call UAMT_fnc_spawnSupplyCrate;
	};
	
	_box = [_actionName, _supplyPointBoxName, "", _statement, {true}, {}, [_supplyPointVar, _supplyPointDist, _supplyPointDir, _supplyPointBoxType, _supplyPointBoxVar]] call ace_interact_menu_fnc_createAction;		
	[_supplyPointVar, 0, ["ACE_MainActions"], _box] call ace_interact_menu_fnc_addActionToObject;
	
}forEach _boxes;
// description.ext -> #include "loadouts\Nato-2035_config_sgn\CfgFactionEquipment.hpp"

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Roles
//
// First step  for your new Faction should be defining what Roles
// you want to use. 
// 
// To be easily edited, we recommend just commenting out the Roles
// you don't want in your faction.
//
// Roles format is {"Role-Name","unitLoadout"}
// "Role-Name" 		-> STRING -> display Role Name in Loadout-Dialog; special characters and space allowed
// "unitLoadout" 	-> STRING -> equals loadout-variable from init field of the unit; no space, no special characters
//------------------------------------------------------------------
//------------------------------------------------------------------

class CfgRoles {	
	roles[] = {
		{"Rifleman","Rifleman"},
		{"Grenadier","Grenadier"},
		{"MG","MG"},
		{"MG-Assistant","MGAssistant"},
		{"Autorifle","autorifle"},
		{"AT","AT"},
		{"AT-Assistant","ATAssistant"},
		{"AA","AA"},
		{"AA-Assistant","AAAssistant"},
		{"AT-Light","ATLight"},
		{"DM","DM"},
		{"EOD","EOD"},
		{"Engineer","Engineer"},
		{"JTAC","JTAC"},
		{"Medic","Medic"},
		{"Doc","Doc"},
		{"Squadleader","Squadleader"},
		{"Groupleader","Groupleader"},
		{"Sniper","Sniper"},
		{"Spotter","Spotter"},
		{"Diver-Groupleader","DiverGroupleader"},
		{"Diver-EOD","DiverEOD"},
		{"Diver-Medic","DiverMedic"},
		{"Diver-Rifleman","DiverRifleman"},
		{"Pilot","Pilot"},
		{"Fighter-Pilot","FighterPilot"},
		{"AV Crew","AVcrew"},
		{"AV Commander","AVcommander"},
	};
};

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Faction Equipment
//
// Here you can configure the Equipment of your faction.
// This automatically fills up all loadouts with the specified items.
//
// Every field can be left empty, for example
// GPS Terminals for WW2 scenarios, or binocs for more authentic
// MilSim loadouts. Don't remove a variable as this will throw
// a lot of errors.
//
// The Supply System will be filled automatically with Items 
// defined here.
//
// For a better Explanation, all Values have in Comments what they expect as Type
//
// There are three Types:
// 1. - STRING "ItemClassName" - A simple String with the Item Class Name
//
// 2. - Variant Array ["ItemClassname 1","ItemClassName 2", etc] - An array with multiple Item Class names. 
//																	Even when you only have one Item, you still need to set this in array brackets []
//
// 3. - Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc] - A multidimensional array giving the ItemClassName as string
//																									and the amount to load as number (mostly used for Container Loading, 
//																									like uniforms, vests and backpacks)
//
//------------------------------------------------------------------
//------------------------------------------------------------------
class CfgFactionEquipment {	
	//------------------------------------------------------------------
	// 	Backpacks
	//
	// To keep it simple, three standard variants.
	// Every Role has its own Backpack Variable that is prefilled with one of the three
	// instances, depending on their need for carrying capacity.
	// You can change these standard types accordingly if something does not sit right
	//
	// These Variables must always be an Array, even if you put only one 
	// element into it. So always use:
	// variable = ["itemName"];
	//------------------------------------------------------------------
	backpack_std[] = {"B_AssaultPack_mcamo"};
	backpack_med[] = {"B_Kitbag_mcamo"};
	backpack_big[] = {"B_Carryall_mcamo"};	

	//------------------------------------------------------------------
	//
	//						Terminal CTab Ready
	//
	// All Loadouts are cTab ready. Therefor we have Tiers for the Terminals.
	// 
	// cTab gives a very interesting amount of Options in game depending on
	// what cTab Item you have. 
	//
	// Standard roles only get the Tier 1, while Squadleaders and Crew Roles
	// get Tier 2.
	// Groupleaders and JTAC get Tier 3. As always, you still can adapt this
	// here in the Role Equipment Sections
	//------------------------------------------------------------------	
	terminal_t1 = "ItemGPS";
	terminal_t2 = "ItemGPS";
	terminal_t3 = "ItemGPS";
	
	// These Items will be distributed instead of the above if CTAB is loaded
	ctab_terminal_t1 = "ItemMicroDAGR";
	ctab_terminal_t2 = "ItemAndroid";
	ctab_terminal_t3 = "ItemcTab";	
	
	//------------------------------------------------------------------
	//							Radios 
	//
	// This is a Mission Maker Service, making the Missions playable
	// no matter what Mod you use, so you can share it with other people.
	//
	//------------------------------------------------------------------
	//radio = "ItemRadio";
	tfar_radio = "TFAR_anprc152";
	acre_radio = "ACRE_PRC152";	
	
	//------------------------------------------------------------------
	//						Longrange Radios 
	//------------------------------------------------------------------
	
	// Longrange Radios you can set this variable to true.
	lrAvailable = 0; // Long Range Available
	lrRoles[] = {"Groupleader","JTAC"}; // Roles that get Long Range Radio Equipment.
										// If TFAR or Vanilla LR, overwrites the default Backpack of the role

	lrRadio = ""; 	// String | Use this for using Vanilla LR Radio Backpack. 
					// Will be overwritten when ACRE or TFAR is loaded
	tfar_lrRadio = "TFAR_rt1523g_big";
	acre_lrRadio = "ACRE_PRC117F";	
	
	//------------------------------------------------------------------
	//							Medical Items
	//
	// Creates four Medical Loadouts that are given to the roles.
	// 
	// Medic Loadouts are balanced for Advanced Medication and 
	// Advanced Bandaging.
	//------------------------------------------------------------------

	//------------------------------------------------------------------
	//	Tier 0 medical Equipment
	//
	// Limited med equipment for Crew Loadouts or Roles that normally 
	// don't have a lot of cargo space in their inventory
	//------------------------------------------------------------------	
	san_t0_u[] = {
		{"ACE_fieldDressing", 2},
		{"ACE_elasticBandage", 2},
		{"ACE_packingBandage", 2},
		{"ACE_quikclot", 2},
		{"ACE_salineIV_500",1},
		{"ACE_splint",1},
		{"ACE_tourniquet",1},
		{"ACE_morphine",1},
		{"ACE_epinephrine",1}
	};	
	san_t0_v[] = { };
	san_t0_b[] = { };
	
	//------------------------------------------------------------------
	//			Tier 1 medical Equipment
	//
	// For all roles without medical Training but with a large Inventory space
	//------------------------------------------------------------------
	san_t1_u[] = { };
	san_t1_v[] = { };
	san_t1_b[] = {
		{"ACE_fieldDressing",8},
		{"ACE_elasticBandage",4},
		{"ACE_packingBandage",4},		
		{"ACE_salineIV_500",2},
		{"ACE_splint",2},
		{"ACE_tourniquet",2},
		{"ACE_morphine",1},
		{"ACE_epinephrine",1}
	};
	
	//------------------------------------------------------------------
	//	Tier 2 medical Equipment
	//
	// For Medics
	//------------------------------------------------------------------
	san_t2_u[] = { };
	san_t2_v[] = { };
	san_t2_b[] = {				
		{"ACE_fieldDressing",30},			
		{"ACE_elasticBandage",15},
		{"ACE_packingBandage",15},
		{"ACE_quikclot",15},
					
		{"ACE_splint",10},
		{"ACE_suture",5},
		{"ACE_tourniquet",5},
					
		{"ACE_salineIV_500",15},
					
		{"ACE_morphine",15},
		{"ACE_epinephrine",15},
					
		{"ACE_bodyBag",2}
	};

	//------------------------------------------------------------------
	//	Tier 3 medical Equipment
	//
	// For Docs
	//------------------------------------------------------------------
	san_t3_u[] = { };
	san_t3_v[] = { };
	san_t3_b[] = {
		{"ACE_surgicalKit",1},
				
		{"ACE_fieldDressing",30},			
		{"ACE_elasticBandage",15},
		{"ACE_packingBandage",15},
		{"ACE_quikclot",15},
					
		{"ACE_splint",10},
		{"ACE_suture",5},
		{"ACE_tourniquet",5},
					
		{"ACE_salineIV_500",15},
					
		{"ACE_morphine",15},
		{"ACE_painkillers",2},
		{"ACE_epinephrine",15},
		{"ACE_adenosine",5},
	};
	
	//------------------------------------------------------------------
	//					Standard Items in Inventory
	//
	// All Roles except Crew and Diver have this in their Uniforms
	//
	//------------------------------------------------------------------
	invStd_u[] = {
		{"ACE_EarPlugs",1},
		{"ACE_CableTie",2},
		{"ACE_Flashlight_XL50",1},
		{"ACE_MapTools",1},
		{"ACE_IR_Strobe_Item",1}
	}; 

	invStd_v[] = {};

	invStd_b[] = {}; 

	// Standard throwables. Will be put into Vests, if full into Backpacks
	throwablesStd[] = {
		{"HandGrenade",2},
		{"SmokeShell",2},
		{"ACE_CTS9",2}
	}; 

	// Extended Trowables. Will be put into Vests, if full into Backpacks
	throwablesExt[] = {
		{"SmokeShellGreen",2},
		{"SmokeShellRed",2},
		{"B_IR_Grenade",2}
	};
	
	
	//------------------------------------------------------------------
	//	Content for Armory
	//------------------------------------------------------------------


	//------------------------------------------------------------------
	//	Special Equipment used in Loadouts
	//------------------------------------------------------------------

	//      ToDo


	//------------------------------------------------------------------
	//------------------------------------------------------------------
	//			Equipment Alternatives for Everyone
	//
	// Here you can put in alternative Equipment that should be available
	// for everyone, except Crew- and Diver-Roles.
	//
	// This is mostly Tactical Barby Stuff. Uniforms, Vests and Helmets 
	// with Camo alternativs, Facewear to look cool or stupid but also 
	// Scopes that are not limited to one Role (like Sniper or DM), but
	// should be available for all Roles.
	//
	// It should be said that this is totally up to you, what you want
	// to give the Players as alternatives. The idea is to give a 
	// limited Arsenal so Players don't escalate with their Tactical Barby
	// syndrom but still give them some possibility for individualisation.
	//
	// But its not needed in any way, so you can leave this empty if you
	// want
	// 
	//------------------------------------------------------------------

	equipment_ar[] = {
		//Ammo
		"30Rnd_65x39_caseless_mag",
		"30Rnd_65x39_caseless_mag_Tracer",
		"30Rnd_65x39_caseless_black_mag",
		"30Rnd_65x39_caseless_black_mag_Tracer",
		"30Rnd_65x39_caseless_khaki_mag",
		"30Rnd_65x39_caseless_khaki_mag_Tracer",

		//Scopes
		"optic_ACO_grn",
		"optic_Aco",
		"optic_ACO_grn_smg",
		"optic_Aco_smg",
		"ACE_optic_Arco_2D",
		"optic_Arco_arid_F",
		"optic_Arco_blk_F",
		"optic_Arco_lush_F",
		"ACE_optic_Arco_PIP",
		"optic_Arco",
		"optic_Arco_AK_arid_F",
		"optic_Arco_AK_blk_F",
		"optic_Arco_AK_lush_F",
		"optic_Holosight_arid_F",
		"optic_Holosight_blk_F",
		"optic_Holosight_khk_F",
		"optic_Holosight_lush_F",
		"optic_Holosight",
		"optic_Holosight_smg_blk_F",
		"optic_Holosight_smg_khk_F",
		"optic_Holosight_smg",
		
		//Attachements (silencers, laser, etc)
		"optic_Hamr",
		"ACE_optic_Hamr_2D",
		"optic_Hamr_khk_F",
		"ACE_optic_Hamr_PIP",
		"ACE_DBAL_A3_Green",
		"ACE_DBAL_A3_Red",
		"ACE_acc_pointer_green",
		"acc_pointer_IR",
		"muzzle_snds_H",
		"muzzle_snds_H_khk_F",
		"muzzle_snds_H_snd_F",
		"muzzle_snds_65_TI_blk_F",
		"bipod_01_F_blk",
		"bipod_01_F_khk",
		"bipod_01_F_mtp",
		"bipod_01_F_snd",
		"muzzle_snds_H_MG",
		"muzzle_snds_H_MG_blk_F",
		"muzzle_snds_H_MG_khk_F",
		"muzzle_snds_338_black",
		"muzzle_snds_338_green",
		"muzzle_snds_338_sand",

		//Uniforms
		"U_B_CombatUniform_mcam_tshirt",
		"U_B_T_Soldier_F",
		"U_B_T_Soldier_AR_F",
		"U_B_CombatUniform_mcam_wdl_f",
		"U_B_CombatUniform_tshirt_mcam_wdL_f",
		
		//Vests
		"V_PlateCarrierGL_blk",
		"V_PlateCarrierGL_rgr",
		"V_PlateCarrierGL_mtp",
		"V_PlateCarrierGL_tna_F",
		"V_PlateCarrierGL_wdl",
		"V_PlateCarrier1_blk",
		"V_PlateCarrier1_rgr",
		"V_PlateCarrier1_rgr_noflag_F",
		"V_PlateCarrier1_tna_F",
		"V_PlateCarrier1_wdl",
		"V_PlateCarrier2_blk",
		"V_PlateCarrier2_rgr",
		"V_PlateCarrier2_rgr_noflag_F",
		"V_PlateCarrier2_tna_F",
		"V_PlateCarrier2_wdl",
		"V_PlateCarrierSpec_blk",
		"V_PlateCarrierSpec_rgr",
		"V_PlateCarrierSpec_mtp",
		"V_PlateCarrierSpec_tna_F",
		"V_PlateCarrierSpec_wdl",
		
		//Helmets
		"H_HelmetB",
		"H_HelmetB_black",
		"H_HelmetB_camo",
		"H_HelmetB_desert",
		"H_HelmetB_grass",
		"H_HelmetB_sand",
		"H_HelmetB_snakeskin",
		"H_HelmetB_tna_F",
		"H_HelmetB_plain_wdl",
		"H_HelmetSpecB",
		"H_HelmetSpecB_blk",
		"H_HelmetSpecB_paint2",
		"H_HelmetSpecB_paint1",
		"H_HelmetSpecB_sand",
		"H_HelmetSpecB_snakeskin",
		"H_HelmetB_Enh_tna_F",
		"H_HelmetSpecB_wdl",
		"H_HelmetB_light",
		"H_HelmetB_light_black",
		"H_HelmetB_light_desert",
		"H_HelmetB_light_grass",
		"H_HelmetB_light_sand",
		"H_HelmetB_light_snakeskin",
		"H_HelmetB_Light_tna_F",
		"H_HelmetB_light_wdl",

		//backpack
		"B_AssaultPack_blk",
		"B_AssaultPack_cbr",
		"B_AssaultPack_eaf_F",
		"B_AssaultPack_rgr",
		"B_AssaultPack_khk",
		"B_AssaultPack_mcamo",
		"B_AssaultPack_sgg",
		"B_AssaultPack_tna_F",
		"B_AssaultPack_wdl_F",
		"B_Carryall_blk",
		"B_Carryall_cbr",
		"B_Carryall_eaf_F",
		"B_Carryall_green_F",
		"B_Carryall_khk",
		"B_Carryall_mcamo",
		"B_Carryall_oli",
		"B_Carryall_wdl_F"
	};

	//------------------------------------------------------------------
	//	Facewear Armory Extension
	//
	// Same as above, only for Facewear Items that are also available
	// for Crew-Roles (sorry Divers, no special Facewear for you).
	//------------------------------------------------------------------
	facewear_Arm[] = {
		"G_Aviator",
		"G_Lowprofile",
		"G_Shades_Black",
		"G_Squares_Tinted",
		"G_Squares",
		"G_Bandanna_aviator",
		"G_Bandanna_beast",
		"G_Bandanna_blk",
		"G_Bandanna_khk",
		"G_Bandanna_oli",
		"G_Bandanna_shades",
		"G_Bandanna_tan",
		"G_Tactical_Clear",
		"G_Tactical_Black",
		"G_Lowprofile"
	};
};


//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
//
//				Explanation for Arrays and Item Declaration
//
// For the Loadouts, there are multiple types of Items and Arrays used.
//
// Simple Item: Just a string with the Item Class inserted. 
//		map 	= "ItemMap";
//
// Array: Array with Items. You can just put one item in there, but you have the option
//			to have multiple Items in it that will be distributed randomised to the players
// 		helmet[] 	= {"H_HelmetB","H_Cap_khaki_specops_UK","H_Cap_usblack"};
//
// BIS Unit Loadout Array: BIS Array format to supply Loadout informations. There are a lot of these
//					but there is of course a Wiki Page to explain them all:
//		https://community.bistudio.com/wiki/Unit_Loadout_Array
//
// Item Loadout Arrays: A multidimensional Array similar to the Unit Loadout Array.
//						An Array that has multiple Arrays inside it, defining the Item and the amount
//						that will be stored in the players inventory.
//		{
//			{ "ItemClass1",Amount},	// ItemClass = String with Item Class | Amount = Number of Items added to inventory
//			{ "ItemClass2",Amount}  // ItemClass2 = String with Item Class | Amount = Number of Items added to inventory
//		}
//
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------


class CfgLoadouts {	
	class DefaultLoadout {
		helmet[] 	= {"H_HelmetB","H_Cap_khaki_specops_UK","H_Cap_usblack"}; 				// Array -> item will be selected by random
		facewear[] 	= {"G_Tactical_Clear","G_Lowprofile"};									// Array -> item will be selected by random
        uniforms[] 	= {"U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt"};			// Array -> item will be selected by random
		vests[] 	= {"V_PlateCarrier1_rgr"};												// Array -> item will be selected by random
        backpack[]  = {"backpack_std"};														// Array -> item will be selected by random
		
		// [classname, suppressor, pointer, optics, muzzle 1's magazine and ammunition, muzzle 2's magazine and ammunition, bipod]
		primary[] 	= {"arifle_MX_F","","ACE_DBAL_A3_Green","optic_Aco",{"30Rnd_65x39_caseless_mag",1},{},""}; // Array in format weapon-Array
		handgun[] 	= {"hgun_ACPC2_F","","","",{"16Rnd_9x21_Mag",1},{},""};										// Array  in format weapon-Array
		secondary[] = {"","","","",{},{},""};												// Array  in format weapon-Array
				
		map 	= "ItemMap"; 	// String ItemMap
		terminal= "terminal_t1"; 	// String
		radio 	= "ItemRadio"; 	// String
		compass = "ItemCompass"; // String
		watch 	= "ACE_Altimeter"; // String		
		nvgs 	= "NVGoggles";	 // String	 
		binocs 	= "Binocular"; 	// String  	     
		
		// Item Loadout Array
		itemsUniform[] 	= {
			"invStd_u",			// Reference to config Class
			"san_t1_u"			// Reference to config Class
		}; 	
		
		// Item Loadout Array
		itemsVest[] 	= {
			{"30Rnd_65x39_caseless_mag",5},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}
		}; 
		
		// Item Loadout Array
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b"			
		}; 	
		
		// Simple Array
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			"arifle_MX_Black_F",
			"arifle_MX_khk_F",
			"arifle_MXC_F",
			"arifle_MXC_Black_F",
			"arifle_MXC_khk_F"
		};
		
        insignia[] = {"CTRG"};	// Array
		
		ace_isMedic = 0; 		// 0 | 1 | 2
		ace_isEngineer = 0;		// 0 | 1 | 2
		ace_isEOD = false;		// true | false		
    };
	
	//------------------------------------------------------------------------
	//				Rifleman
	//
	// Rifleman Class. All Troop Loudouts with Standard Rifle inherit from 
	// this Class
	//------------------------------------------------------------------------
	class Rifleman: DefaultLoadout { 		
		itemsVest[] 	= {
			{"30Rnd_65x39_caseless_mag",5},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2},
			"throwablesStd"
		}; 
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_EntrenchingTool",1},
			{"ACE_wirecutter",1}
		}; 		
    };
	
	//------------------------------------------------------------------------
	//			Grenadier
	//------------------------------------------------------------------------
	class Grenadier: DefaultLoadout {
		primary[] 	= {"arifle_MX_GL_F","","ACE_DBAL_A3_Green","optic_Aco",{"30Rnd_65x39_caseless_mag",1},{},""};
		itemsVest[] = {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}			
		}; 
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"1Rnd_HE_Grenade_shell",6},
			{"1Rnd_Smoke_Grenade_shell",4},
			{"ACE_40mm_Flare_ir",2}
		}; 	
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			//Weapons
			"arifle_MX_GL_Black_F",
			"arifle_MX_GL_khk_F",
			//Ammo
			"1Rnd_SmokeRed_Grenade_shell",
			"UGL_FlareGreen_F",
			"UGL_FlareCIR_F",
			"UGL_FlareRed_F",
			"UGL_FlareWhite_F",
			"UGL_FlareYellow_F",
			"ACE_40mm_Flare_white",
			"ACE_40mm_Flare_green",
			"ACE_40mm_Flare_red",
			"ACE_40mm_Flare_ir",
			"1Rnd_SmokeBlue_Grenade_shell",
			"1Rnd_SmokeGreen_Grenade_shell",
			"1Rnd_SmokeOrange_Grenade_shell",
			"1Rnd_SmokePurple_Grenade_shell",
			"1Rnd_SmokeRed_Grenade_shell",
			"1Rnd_SmokeYellow_Grenade_shell",			
			//Hunt IR Equipment
			"ACE_HuntIR_M203",
			"ACE_HuntIR_monitor"
		};
	};

	//------------------------------------------------------------------------
	//			MG
	//------------------------------------------------------------------------
    class MG: DefaultLoadout {		
		primary[] 	= {"MMG_02_sand_F","","ACE_DBAL_A3_Green","optic_Hamr",{"130Rnd_338_Mag",130},{},"bipod_01_F_snd"}; 		
		itemsVest[] = {
			"throwablesStd",			
			{"130Rnd_338_Mag",1},			
			{"16Rnd_9x21_Mag",2}			
		}; 
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"130Rnd_338_Mag",4}
		}; 	
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			//Weapons
			"MMG_02_camo_F",
			"MMG_02_black_F"
		};		
	};
	
	//------------------------------------------------------------------------
	//			MG-Assistant
	//------------------------------------------------------------------------
    class MGAssistant: DefaultLoadout {
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"130Rnd_338_Mag",4}
		}; 	
	};

	//------------------------------------------------------------------------
	//			Autorifle
	//------------------------------------------------------------------------
    class Autorifle: DefaultLoadout {		
		primary[] 	= {"arifle_MX_SW_F","","ACE_DBAL_A3_Green","optic_Aco",{"100Rnd_65x39_caseless_mag",100},{},"bipod_01_F_snd"}; 		
		itemsVest[] = {
			"throwablesStd",			
			{"100Rnd_65x39_caseless_mag",4},
			{"100Rnd_65x39_caseless_mag_Tracer",2},		
			{"16Rnd_9x21_Mag",2}			
		}; 		 	
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			//Weapons
			"arifle_MX_SW_Black_F",
			"arifle_MX_SW_khk_F",
			//ammo
			"100Rnd_65x39_caseless_black_mag",
			"100Rnd_65x39_caseless_black_mag_tracer",
			"100Rnd_65x39_caseless_khaki_mag",
			"100Rnd_65x39_caseless_khaki_mag_tracer"
		};		
	};
	
	//------------------------------------------------------------------------
	//			AT
	//------------------------------------------------------------------------
    class AT: Rifleman {
		secondary[] = {"launch_B_Titan_short_F","","","",{},{},""};
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {			
			{"Titan_AT",1}
		};
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			"Titan_AP"
		};	
	};
	
	//------------------------------------------------------------------------
	//			AT-Assistant
	//------------------------------------------------------------------------
    class ATAssistant: Rifleman {
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {			
			{"Titan_AT",1}
		};
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			"Titan_AP"
		};
	};
	
	//------------------------------------------------------------------------
	//			AA
	//------------------------------------------------------------------------
    class AA: Rifleman {
		secondary[] = {"launch_B_Titan_F","","","",{},{},""};
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {			
			{"Titan_AA",1}
		};		
	};
	
	//------------------------------------------------------------------------
	//			AA-Assistant
	//------------------------------------------------------------------------
    class AAAssistant: Rifleman {
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {			
			{"Titan_AA",1}
		};	
	};
	
	//------------------------------------------------------------------------
	//			AT-Light
	//------------------------------------------------------------------------
    class ATLight: Rifleman {
		secondary[] = {"launch_RPG32_F","","","",{"RPG32_F",1},{},""};		
	};
	
	//------------------------------------------------------------------------
	//			DM
	//------------------------------------------------------------------------
    class DM: DefaultLoadout {
		primary[] 	= {"arifle_MXM_F","","ACE_DBAL_A3_Green","optic_Hamr",{"30Rnd_65x39_caseless_mag",30},{},"bipod_01_F_snd"}; 
		itemsUniform[] 	= {
			"invStd_u",			
			"san_t1_u",
			{"ACE_RangeCard",1}
		}; 	
		itemsVest[] = {
			"throwablesStd",			
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},		
			{"16Rnd_9x21_Mag",2}			
		}; 		
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_EntrenchingTool",1},
			{"ACE_wirecutter",1}
		}; 		
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			//Weapons
			"arifle_MXM_Black_F",
			"arifle_MXM_khk_F",
			//Tools
			"optic_AMS",
			"optic_AMS_khk",
			"optic_AMS_snd",
			"optic_DMS"
		};	
	};
	
	//------------------------------------------------------------------------
	//			EOD
	//------------------------------------------------------------------------
    class EOD: Rifleman {
		backpack[]  = {"backpack_med"};	
		itemsVest[] = {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}			
		}; 
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_M26_Clacker",1},
			{"DemoCharge_Remote_Mag",2},
			{"ACE_VMM3",1}
		};
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",			
			//Tools					
			"SatchelCharge_Remote_Mag",			
			"ClaymoreDirectionalMine_Remote_Mag",
			"ATMine_Range_Mag",
			"ACE_DeadManSwitch",
			"ACE_Cellphone"
		};	
		ace_isEOD = true;
	};
	
	//------------------------------------------------------------------------
	//			Engineer
	//------------------------------------------------------------------------
    class Engineer: Rifleman {
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_Fortify",1},
			{"ToolKit",1}
		};
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",			
			//Tools					
			"ACE_EntrenchingTool",
			"ACE_wirecutter"
		};	
		ace_isEngineer = 2;		// 0 | 1 | 2
	};
	
	//------------------------------------------------------------------------
	//			JTAC
	//------------------------------------------------------------------------
    class JTAC: Rifleman {		
		terminal= "terminal_t3"; 		
		binocs 	= "Laserdesignator";  
		itemsUniform[] 	= {
			"invStd_u",			
			"san_t1_u",
			{"ACE_RangeTable_82mm",1},
			{"ACE_artilleryTable",1}, 
			{"ACE_PlottingBoard",1},
			{"Laserbatteries",2}
		}; 
		itemsVest[] = {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}			
		}; 
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_HuntIR_monitor",1},
			{"B_UavTerminal",1}
		};
	};
	
	//------------------------------------------------------------------------
	//			Medic
	//------------------------------------------------------------------------
    class Medic: Rifleman {
		backpack[]  = {"backpack_med"};	
		itemsBackPack[] = {
			"san_t2_b",
			"throwablesExt"			
		};		
		ace_isMedic = 1; 		// 0 | 1 | 2
	};
	
	//------------------------------------------------------------------------
	//			Doc
	//------------------------------------------------------------------------
    class Doc: Rifleman {
		backpack[]  = {"backpack_med"};	
		ace_isMedic = 2; 		// 0 | 1 | 2
		itemsBackPack[] = {
			"san_t3_b",
			"throwablesExt"			
		};	
	};
	
	//------------------------------------------------------------------------
	//			Squadleader
	//------------------------------------------------------------------------
    class Squadleader: Rifleman {
		terminal= "terminal_t2";
		binocs 	= "Rangefinder";
		itemsVest[] = {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}			
		}; 		
	};
	
	//------------------------------------------------------------------------
	//			Groupleader
	//------------------------------------------------------------------------
    class Groupleader: Rifleman {
		terminal= "terminal_t3"; 	// String
		binocs 	= "Laserdesignator"; 	// String 
		itemsUniform[] 	= {
			"invStd_u",
			"san_t1_u",
			{"Laserbatteries",2}
		};
		itemsVest[] = {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},
			{"16Rnd_9x21_Mag",2}			
		}; 
    };
	
	//------------------------------------------------------------------------
	//------------------------------------------------------------------------
	//
	//			Specialist Roles
	//
	// Roles that are above the normal troops loadouts. They have mostly their
	// complete own setup and differ widely from the Default Loadout because
	// of their very specialised assignment.
	//
	//------------------------------------------------------------------------	
	//------------------------------------------------------------------------	
	
	//------------------------------------------------------------------------
	//			Sniper
	//------------------------------------------------------------------------
	class Sniper: DefaultLoadout {
		helmet[] 	= {"H_Bandanna_mcamo"}; 						
        uniforms[] 	= {"U_B_GhillieSuit"};						
		vests[] 	= {"V_Chestrig_rgr"};		
		primary[] 	= {"srifle_LRR_camo_F","","ACE_DBAL_A3_Green","optic_LRPS",{"7Rnd_408_Mag",7},{},""}; // Array in format weapon-Array		
		terminal= "terminal_t2"; 		
		itemsUniform[] 	= {
			"invStd_u",			
			"san_t1_u",
			{"ACE_RangeCard",1},
			{"ACE_Kestrel4500",1}
		};		
		itemsVest[] 	= {
			{"7Rnd_408_Mag",5},			
			{"16Rnd_9x21_Mag",2}
		};		
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			"throwablesStd",
			"throwablesExt"
		};		
		arsenal[] = {
			"equipment_ar",
			"facewear_Arm",
			"srifle_LRR_F",
			"srifle_LRR_tna_F"
		};	
	};

	//------------------------------------------------------------------------
	//			Spotter
	//------------------------------------------------------------------------
	class Spotter: Sniper {			
		primary[] 	= {"arifle_MXM_F","","ACE_DBAL_A3_Green","optic_Hamr",{"30Rnd_65x39_caseless_mag",30},{},"bipod_01_F_snd"}; 		 	
		binocs 	= "Rangefinder";
		itemsUniform[] 	= {
			"invStd_u",			
			"san_t1_u",
			{"ACE_RangeCard",1}
		};		
		itemsVest[] 	= {
			"throwablesStd",
			"throwablesExt",
			{"30Rnd_65x39_caseless_mag",4},
			{"30Rnd_65x39_caseless_mag_Tracer",2},			
			{"16Rnd_9x21_Mag",2}
		};		
		itemsBackPack[] = {
			"invStd_b",
			"san_t1_b",
			{"ACE_Kestrel4500",1},
			{"ACE_SpottingScope",1},
			{"ACE_wirecutter",1}
		};		
	};

	//------------------------------------------------------------------------
	//			DiverRifleman
	//------------------------------------------------------------------------
	class DiverRifleman: DefaultLoadout {
		helmet[] 	= {"H_HelmetB_light_black"}; 				
		facewear[] 	= {"G_B_Diving"};									
        uniforms[] 	= {"U_B_Wetsuit"};			
		vests[] 	= {"V_RebreatherB"};												
        backpack[]  = {"B_AssaultPack_blk"};	
		primary[] 	= {"arifle_SDAR_F","","","",{"20Rnd_556x45_UW_mag",20},{},""}; 
		handgun[] 	= {"hgun_P07_F","muzzle_snds_L","","",{"16Rnd_9x21_Mag",16},{},""};			
		itemsUniform[] 	= {
			"invStd_u",			
			"san_t1_u",
			"san_t1_v",
			"san_t1_b"
		}; 
		itemsVest[] = {};
		itemsBackPack[] = {
			"throwablesStd",
			"throwablesExt",
			{"20Rnd_556x45_UW_mag",2},			
			{"16Rnd_9x21_Mag",2}
		}; 
	};

	//------------------------------------------------------------------------
	//			Diver-Groupleader
	//------------------------------------------------------------------------
	class DiverGroupleader: DiverRifleman {
		terminal= "terminal_t3";
	};

	//------------------------------------------------------------------------
	//			Diver-EOD
	//------------------------------------------------------------------------
	class DiverEOD: DiverRifleman {
		itemsBackPack[] = {
			"throwablesStd",
			"throwablesExt",
			{"20Rnd_556x45_UW_mag",2},			
			{"16Rnd_9x21_Mag",2},
			{"ACE_Clacker",1},
			{"DemoCharge_Remote_Mag",2}
		}; 		
		ace_isEOD = true;		// true | false		
	};
	
	//------------------------------------------------------------------------
	//			Diver-Medic
	//------------------------------------------------------------------------
	class DiverMedic: DiverRifleman {
		itemsBackPack[] = {
			"throwablesStd",
			"throwablesExt",
			{"20Rnd_556x45_UW_mag",2},			
			{"16Rnd_9x21_Mag",2},
			{"ACE_surgicalKit",1},
			{"ACE_fieldDressing",20},
			{"ACE_elasticBandage",10},
			{"ACE_packingBandage",10},
			{"ACE_epinephrine",5},
			{"ACE_morphine",5},
			{"ACE_salineIV_250",5},
			{"ACE_splint",10},
			{"ACE_tourniquet",3}
		}; 		
		ace_isMedic = 1; 		// 0 | 1 | 2
	};		

	//------------------------------------------------------------------------
	//			Pilot
	//
	// Meant for Helicopter Pilots
	//------------------------------------------------------------------------
	class Pilot: DefaultLoadout {
		helmet[] 	= {"H_PilotHelmetHeli_B"}; 				
		facewear[] 	= {"G_Aviator"};									
        uniforms[] 	= {"U_B_HeliPilotCoveralls"};			
		vests[] 	= {"V_TacVest_blk"};												
        backpack[]  = {""};	
		primary[] 	= {"SMG_01_F","","","optic_Holosight_smg",{"30Rnd_45ACP_Mag_SMG_01",30},{},""}; 
		handgun[] 	= {"hgun_P07_F","","","",{"16Rnd_9x21_Mag",16},{},""};
		terminal= "terminal_t2";
		nvgs 	= "ACE_NVG_Wide";
		itemsUniform[] 	= {
			"invStd_u"			
		}; 			
		itemsVest[] = {
			"san_t0_u",
			{"30Rnd_45ACP_Mag_SMG_01",2},			
			{"16Rnd_9x21_Mag",2},
			{"ACE_HandFlare_Green",2},			
			{"SmokeShellGreen",2}
		};
		arsenal[] = {
			"ACE_NVG_Wide_WP"			
		};
	};

	//------------------------------------------------------------------------
	//			Fighter-Pilot
	//
	// Extension of Pilot with special outfit for Fighter Pilots
	//------------------------------------------------------------------------
	class FighterPilot: Pilot {
		handgun[] 	= {};
		helmet[] 	= {"H_PilotHelmetFighter_B"}; 				
		facewear[] 	= {""};									
        uniforms[] 	= {"U_B_PilotCoveralls"};			
		vests[] 	= {""};												
        backpack[]  = {"B_Parachute"};	
		itemsUniform[] 	= {
			"invStd_u",
			"san_t0_u",
			{"30Rnd_45ACP_Mag_SMG_01",2},			
			{"ACE_HandFlare_Green",1},			
			{"SmokeShellGreen",1}
		};
		itemsVest[] = {};
	};

	//------------------------------------------------------------------------
	//			AV Crew
	//------------------------------------------------------------------------
	class AVcrew: DefaultLoadout {
		helmet[] 	= {"H_HelmetCrew_B"}; 				
		facewear[] 	= {"G_Lowprofile"};									
        uniforms[] 	= {"U_B_CombatUniform_mcam_vest"};			
		vests[] 	= {"V_BandollierB_rgr"};												
        backpack[]  = {""};	
		primary[] 	= {"arifle_MXC_F","","","",{"30Rnd_65x39_caseless_mag",30},{},""}; 
		handgun[] 	= {"hgun_P07_F","","","",{"16Rnd_9x21_Mag",16},{},""};				
		itemsUniform[] 	= {
			"invStd_u",
			"san_t0_u"
		}; 			
		itemsVest[] = {			
			{"30Rnd_65x39_caseless_mag",2},			
			{"16Rnd_9x21_Mag",2},
			{"ACE_HandFlare_Green",2},			
			{"SmokeShellGreen",2}
		};
		arsenal[] = {
			"V_BandollierB_blk",
			"V_BandollierB_cbr",
			"V_BandollierB_khk",
			"V_BandollierB_oli",
			"H_Cap_headphones"			
		};
	};

	//------------------------------------------------------------------------
	//			AV Commander
	//------------------------------------------------------------------------
	class AVcommander: AVcrew {
		terminal= "terminal_t2";
	};
};
// description.ext -> #include "loadouts\Nato-2035_config_sgn\CfgFactionEquipment.hpp"
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
	// Creates three Medical Loadouts that are given to the roles.
	// 
	// Medic Loadouts are balanced for Advanced Medication and 
	// Advanced Bandaging.
	//------------------------------------------------------------------

	//------------------------------------------------------------------
	//	Tier 0 medical Equipment
	//
	// Limited med equipment for Crew Loadouts
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
	// For all roles except Medics and Docs
	//
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
	//	Tier 2 medical Equipment
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

	// Will be put into Vests, if full into Backpacks
	throwablesStd[] = {
		{"HandGrenade",2},
		{"SmokeShell",2},
		{"ACE_CTS9",2}
	}; 

	// Will be put into Vests, if full into Backpacks
	throwablesExt[] = {
		{"SmokeShellGreen",2},
		{"SmokeShellRed",2},
		{"B_IR_Grenade",2}
	};
	
	
	grenadier_UGL_inv[] = {
		{"1Rnd_HE_Grenade_shell",6} ,
		{"1Rnd_Smoke_Grenade_shell",4},
		{"ACE_40mm_Flare_ir",2}
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

// Here you find all Loadouts and customise them further to your liking
#include "loadouts\Nato-2035_config_sgn\CfgLoadouts.hpp"
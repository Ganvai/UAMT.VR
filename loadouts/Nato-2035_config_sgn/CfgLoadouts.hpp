// description.ext -> #include "loadouts\Nato-2035_config_sgn\CfgLoadouts.hpp"


// Roles format is {"Role-Name","unitLoadout"}
// "Role-Name" 		-> STRING -> display Role Name in Loadout-Dialog; special characters and space allowed
// "unitLoadout" 	-> STRING -> equals loadout-variable from init field of the unit; no space, no special characters
class CfgRoles {	
	roles[] = {
		{"Rifleman","Rifleman"},
		{"Grenadier","Grenadier"},
		{"MG","MG"},
		{"MG-Assistant","MG-Assistant"},
		{"Autorifle","autorifle"},
		{"AT","AT"},
		{"AT-Assistant","AT-Assistant"},
		{"AA","AA"},
		{"AA-Assistant","AA-Assistant"},
		{"AT-Light","AT-Light"},
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
		{"Diver-Groupleader","Diver-Groupleader"},
		{"Diver-EOD","Diver-EOD"},
		{"Diver-Medic","Diver-Medic"},
		{"Diver-Rifleman","Diver-Rifleman"},
		{"Pilot","Pilot"},
		{"Fighter-Pilot","Fighter-Pilot"},
		{"AV Crew","crew"}	
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
		terminal= "ItemGPS"; 	// String
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
	class Rifleman: DefaultLoadout {   
		terminal = "terminal_t1"; 
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
    class Groupleader: DefaultLoadout {
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
    class B_Soldier_AR_F: DefaultLoadout {
        backpack[] = {"B_AssaultPack_rgr", "B_AssaultPack_blk"};
        primary[] = {"LMG_03_F", "optic_Holosight_blk_F"};
        magazines[] = {
            "200Rnd_556x45_Box_Red_F", 5,
            "9Rnd_45ACP_Mag", 2,
            "SmokeShell", 2,
            "SmokeShellRed",
            "SmokeShellGreen"
        };
    };
    class B_Soldier_GL_F: DefaultLoadout {
        primary[] = {
            {"arifle_SPAR_01_GL_blk_F", "optic_Holosight_blk_F", "muzzle_snds_M"},
            {"arifle_SPAR_01_GL_snd_F", "optic_Holosight_blk_F", "muzzle_snds_M"}
        };
        magazines[] = {
            "30Rnd_556x45_Stanag", 6,
            "30Rnd_556x45_Stanag_Tracer_Red", 2,
            "9Rnd_45ACP_Mag", 2,
            "1Rnd_HE_Grenade_shell", 31,
            "SmokeShell", 2,
            "SmokeShellRed",
            "SmokeShellGreen"
        };
        backpack[] = {"B_AssaultPack_rgr", "B_AssaultPack_blk"};
    };
    class B_medic_F: DefaultLoadout {
        backpack[] = {"B_Kitbag_rgr"};
        items[] = {
            "ACE_fieldDressing", 25,
            "ACE_packingBandage", 25,
            "ACE_elasticBandage", 25,
            "ACE_quikclot", 25,
            "ACE_morphine", 10,
            "ACE_epinephrine", 10,
            "ACE_salineIV_500", 10,
            "ACE_tourniquet", 10,
            "ACE_surgicalKit", 5,
            "ACE_earplugs"
        };
    };
};
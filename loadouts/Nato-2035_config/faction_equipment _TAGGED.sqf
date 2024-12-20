//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Faction Equipment
//
// Here you can configure the Equipment of your faction.
// This automatically fills up all loadouts with the specified items.
//
// Every field can be left empty, for example
// GPS Terminals for WW2 scenarios, or UAMT_binocs for more authentic
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
//																									like UAMT_uniforms, UAMT_vests and backpacks)
//
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//
//	Standard Outfit
//
// The standard outfit for every role except Pilot, Crew and Diver roles
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// These Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_uniforms = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
UAMT_helmet = ["H_UAMT_helmetB","H_Cap_khaki_specops_UK","H_Cap_usblack"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
UAMT_vests = ["V_PlateCarrier1_rgr"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
UAMT_facewear = ["G_Tactical_Clear","G_Lowprofile"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]

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
UAMT_backpack_std = ["B_AssaultPack_mcamo"]; // For all roles without much to carry, like Rifleman, DM, Squadleaders | Variant Array ["ItemClassname 1","ItemClassName 2", etc]
UAMT_backpack_med = ["B_Kitbag_mcamo"]; // For roles with need for larger carrying capacity: MG, Medic, Groupleader, EOD, Engineer | Variant Array ["ItemClassname 1","ItemClassName 2", etc]
UAMT_backpack_big = ["B_Carryall_mcamo"]; // For Roles with heavy loads, like AT,AA, all Assistants | Variant Array ["ItemClassname 1","ItemClassName 2", etc]

//------------------------------------------------------------------
//							Slotted Items
//
// Every Role will be equipped with these. But if you have a role
// that needs a special Item, you can overwrite this in the Role
// Equipment Section, for example a Laserdesignator for JTAC (don't
// forget to give him batteries) or a Rangefinder for Squad- and Group-
// Leaders.
//------------------------------------------------------------------
// Standard Items
UAMT_watch = "ACE_Altimeter"; // String
UAMT_map = "ItemUAMT_map"; // String
UAMT_compass = "ItemUAMT_compass"; // String
UAMT_binocs = "Binocular"; // String

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
UAMT_terminal_t1 = "ItemGPS"; // Available for Everyone | String
UAMT_terminal_t2 = "ItemGPS"; // Only Available for Groupleader | String
UAMT_terminal_t3 = "ItemGPS"; // Only available for Squadleaders | String

if (isClass(configFile >> "cfgPatches" >> "cTab")) then {
	UAMT_terminal_t1 = "ItemMicroDAGR"; // String
	UAMT_terminal_t2 = "ItemAndroid"; // String
	UAMT_terminal_t3 = "ItemcTab"; // String
};

// All Roles except Fighter Pilots
// All standard Infantery roles have the UAMT_nvgs put in their UAMT_uniforms
// Roles with limited carrying capacity like Divers and Crew Roles
// have the UAMT_nvg equipped.
UAMT_nvg = "UAMT_nvgoggles"; // String


//------------------------------------------------------------------
//							UAMT_radios 
//
// This is a Mission Maker Service, making the Missions playable
// no matter what Mod you use, so you can share it with other people.
//
//------------------------------------------------------------------

//UAMT_radios with Modcheck for TFAR or ACRE
UAMT_radio = "ItemUAMT_radio"; // String
if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
	UAMT_radio = "TFAR_anprc152"; // String
};

if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
	UAMT_radio = "ACRE_PRC152"; // String
};

//------------------------------------------------------------------
//						Longrange Radios 
//------------------------------------------------------------------

// Longrange Radios you can set this variable to true.
UAMT_lrAvailable = false; // Long Range Available
UAMT_lrRoles = ["Groupleader","JTAC"]; 	// Roles that get Long Range Radio Equipment.
									// If TFAR or Vanilla LR, overwrites the default Backpack of the role

UAMT_lrRadio = ""; 	// String | Use this for using Vanilla LR Radio Backpack. 
				// Will be overwritten when ACRE or TFAR is loaded

// LR Rradio Equipment depending on loaded Mod
if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
	UAMT_lrRadio = "TFAR_rt1523g_big"; // String
};

if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
	UAMT_lrRadio = "ACRE_PRC117F"; // String
};

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

UAMT_san_t0_u = [
					["ACE_fieldDressing",2],
					["ACE_elasticBandage",2],
					["ACE_packingBandage",2],
					["ACE_quikclot",2],
					["ACE_salineIV_500",1],
					["ACE_splint",1],
					["ACE_tourniquet",1],
					["ACE_morphine",1],
					["ACE_epinephrine",1]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t0_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t0_b = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

//------------------------------------------------------------------
//			Tier 1 medical Equipment
//
// For all roles except Medics and Docs
//
//------------------------------------------------------------------
UAMT_UAMT_san_t1_b = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t1_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t1_b = [					
					["ACE_fieldDressing",8],
					["ACE_elasticBandage",4],
					["ACE_packingBandage",4],		
					["ACE_salineIV_500",2],
					["ACE_splint",2],
					["ACE_tourniquet",2],
					["ACE_morphine",1],
					["ACE_epinephrine",1]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]


//------------------------------------------------------------------
//	Tier 2 medical Equipment
//
// For Medics and Docs
//------------------------------------------------------------------
UAMT_san_t2_u = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t2_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_san_t2_b = [		
					["ACE_surgicalKit",1],
					
					["ACE_fieldDressing",30],			
					["ACE_elasticBandage",15],
					["ACE_packingBandage",15],
					["ACE_quikclot",15],
					
					["ACE_splint",10],
					["ACE_suture",5],
					["ACE_tourniquet",5],
					
					["ACE_salineIV_500",15],
					
					["ACE_morphine",15],
					["ACE_painkillers",2],
					["ACE_epinephrine",15],
					["ACE_adenosine",5],
					
					["ACE_bodyBag",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]


//------------------------------------------------------------------
//					Standard Items in Inventory
//
// All Roles except Crew and Diver have this in their UAMT_uniforms
//
//------------------------------------------------------------------
UAMT_invStd_u = [
	["ACE_EarPlugs",1],
	["ACE_CableTie",2],
	["ACE_Flashlight_XL50",1],
	["ACE_UAMT_mapTools",1],
	["ACE_IR_Strobe_Item",1]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_invStd_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

UAMT_invStd_b = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Will be put into UAMT_vests, if full into Backpacks
UAMT_throwablesStd = [
	["HandGrenade",2],
	["SmokeShell",2],
	["ACE_CTS9",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Will be put into UAMT_vests, if full into Backpacks
UAMT_throwablesExt = [
	["SmokeShellGreen",2],
	["SmokeShellRed",2],
	["B_IR_Grenade",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

//------------------------------------------------------------------
//
//		Primary Weapon
//
// This will be available for all Roles without a special Weapon, 
// i.E. DM, MG, Grenadier
//
// Crew and Diver Roles have their own Rifle
//
//------------------------------------------------------------------

UAMT_std_rifle = "arifle_MX_F"; // String
UAMT_std_scope = "optic_Aco"; // String
std_attachement1 = "ACE_DBAL_A3_Green"; // String
std_attachement2 = ""; // String
std_attachement3 = ""; // String

UAMT_std_rifleAmmo_inv = [
	["30Rnd_65x39_caseless_mag",5],
	["30Rnd_65x39_caseless_mag_Tracer",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Available for all Roles except fpilot
UAMT_std_handgun = "hgun_P07_F"; // String
UAMT_std_handgun_scope = ""; // String
UAMT_std_handgun_attachment1 = ""; // String
UAMT_std_handgun_attachment2 = ""; // String

UAMT_std_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Alternative Weapons for Roles with Standard Rifles in Armory. 
// Ammo, Scopes and Attachements go into Equipment Array, as they should be available for all Roles
UAMT_UAMT_std_weapons_alt = [
	//Weapons
	"arifle_MX_Black_F",
	"arifle_MX_khk_F",
	"arifle_MXC_F",
	"arifle_MXC_Black_F",
	"arifle_MXC_khk_F"
]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]

//------------------------------------------------------------------
//	Rifelman Equipment
//------------------------------------------------------------------

// Outfit
UAMT_UAMT_rifleman_uniform = UAMT_uniforms;
UAMT_UAMT_rifleman_vest = UAMT_vests;
UAMT_UAMT_rifleman_UAMT_helmet = UAMT_helmet;
UAMT_rifleman_backpack = UAMT_backpack_std;

// Weapons Loadout
UAMT_rifleman_rifle = UAMT_std_rifle; // String
UAMT_rifleman_scope = UAMT_std_scope; // String
UAMT_rifleman_attachement1 = std_attachement1; // String
UAMT_rifleman_attachement2 = std_attachement2; // String
UAMT_rifleman_attachement3 = std_attachement3; // String

// Rifle Ammo in Inventory
UAMT_rifleman_ammo_inv = UAMT_std_rifleAmmo_inv; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Handgun Loadout
UAMT_rifleman_handgun = UAMT_std_handgun; // String
UAMT_rifleman_handgun_scope = UAMT_std_handgun_scope; // String
UAMT_rifleman_handgun_attachement1 = UAMT_std_handgun_attachment1; // String
UAMT_rifleman_handgun_attachement2 = UAMT_std_handgun_attachment2; // String

// Handgun Ammo in Inventory
UAMT_rifleman_handgunAmmo_inv = UAMT_std_handgunAmmo_inv; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Slotted Items
UAMT_rifleman_UAMT_watch = UAMT_watch; // String
UAMT_rifleman_UAMT_map = UAMT_map; // String
UAMT_rifleman_UAMT_compass = UAMT_compass; // String
UAMT_rifleman_UAMT_binocs = UAMT_binocs; // String
UAMT_rifleman_terminal = UAMT_terminal_t1; // String
UAMT_rifleman_UAMT_radio = UAMT_radio; // String

// Inventory items
UAMT_rifleman_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]
UAMT_rifleman_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]
UAMT_rifleman_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

//Additional or alternative Items available for this specific Role in the Armory
UAMT_rifleman_UAMT_equipment_ar = []; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]

//------------------------------------------------------------------
//	Grenadier Equipment
//------------------------------------------------------------------

// Outfit
UAMT_grenadier_uniform = UAMT_uniforms;
UAMT_grenadier_vest = UAMT_vests;
UAMT_grenadier_UAMT_helmet = UAMT_helmet;
UAMT_grenadier_backpack = UAMT_backpack_std;

// Weapons Loadout
UAMT_grenadier_rifle = "arifle_MX_UAMT_gl_F";
UAMT_grenadier_scope = UAMT_std_scope;
UAMT_grenadier_attachement1 = std_attachement1;
UAMT_grenadier_attachement2 = std_attachement2;
UAMT_grenadier_attachement3 = std_attachement3;

// Rifle Ammo in Inventory
UAMT_grenadier_ammo_inv = UAMT_std_rifleAmmo_inv;

// Handgun Loadout
UAMT_grenadier_handgun = UAMT_std_handgun;
UAMT_grenadier_handgun_scope = UAMT_std_handgun_scope;
UAMT_grenadier_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_grenadier_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_grenadier_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

UAMT_grenadier_UUAMT_gl_inv = [
	["1Rnd_HE_Grenade_shell",6],
	["1Rnd_Smoke_Grenade_shell",4],
	["ACE_40mm_Flare_ir",2]
];

// Grenadier UGL Pool
// Put everything in here that you want in the Armory and in the
// UAMT_explosives Supply Crate. 
// If you want to Add Ammo to the armory but not the Supply crate, put it
// into the UAMT_grenadier_UAMT_equipment_ar
UAMT_grenadier_UUAMT_gl_Pool = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"ACE_40mm_Flare_ir",
	"1Rnd_SmokeGreen_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell"	
];

// Slotted items
UAMT_grenadier_UAMT_watch = UAMT_watch;
UAMT_grenadier_UAMT_map = UAMT_map;
UAMT_grenadier_UAMT_compass = UAMT_compass;
UAMT_grenadier_UAMT_binocs = UAMT_binocs;
UAMT_grenadier_terminal = UAMT_terminal_t1;
UAMT_grenadier_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_grenadier_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_grenadier_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_grenadier_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

//Additional or alternative Items available for this specific Role in the Armory
UAMT_grenadier_UAMT_equipment_ar = [
	//Weapons
	"arifle_MX_UAMT_gl_Black_F",
	"arifle_MX_UAMT_gl_khk_F",

	//Ammo
	"1Rnd_SmokeRed_Grenade_shell",
	"UUAMT_gl_FlareGreen_F",
	"UUAMT_gl_FlareCIR_F",
	"UUAMT_gl_FlareRed_F",
	"UUAMT_gl_FlareWhite_F",
	"UUAMT_gl_FlareYellow_F",
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
];

//------------------------------------------------------------------
//	MG Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_mg_uniform = UAMT_uniforms;
UAMT_mg_vest = UAMT_vests;
UAMT_mg_UAMT_helmet = UAMT_helmet;
UAMT_mg_backpack = UAMT_backpack_std;

// Weapons
UAMT_mg_rifle = "MUAMT_mg_02_sand_F";
UAMT_mg_scope = "optic_Hamr";
UAMT_mg_attachement1 = std_attachement1;
UAMT_mg_attachement2 = "bipod_01_F_snd";
UAMT_mg_attachement3 = std_attachement3;

UAMT_mg_ammo_inv = [
	["130Rnd_338_Mag",4]
];

UAMT_mg_handgun = UAMT_std_handgun;
UAMT_mg_handgun_scope = UAMT_std_handgun_scope;
UAMT_mg_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_mg_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_mg_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_mg_UAMT_watch = UAMT_watch;
UAMT_mg_UAMT_map = UAMT_map;
UAMT_mg_UAMT_compass = UAMT_compass;
UAMT_mg_UAMT_binocs = UAMT_binocs;
UAMT_mg_terminal = UAMT_terminal_t1;
UAMT_mg_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_mg_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_mg_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_mg_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

// Use this for items for MG that should also be available for Assis Roles,
// for example Ammo or spareparts
UAMT_mg_assistant_share_ar = []; 

// Special alternative equipment for this specific Role in the Armory
UAMT_mg_UAMT_equipment_ar = [
	"MUAMT_mg_02_camo_F",
	"MUAMT_mg_02_black_F"
];


//------------------------------------------------------------------
//	MG Assistant Equipment
//
// This role has always additional Ammo for MG loaded. No need
// to add this in additionalItems
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_mgAssis_uniform = UAMT_uniforms;
UAMT_mgAssis_vest = UAMT_vests;
UAMT_mgAssis_UAMT_helmet = UAMT_helmet;
UAMT_mgAssis_backpack = UAMT_backpack_med;

// Weapons
UAMT_mgAssis_rifle = UAMT_std_rifle;
UAMT_mgAssis_scope = UAMT_std_scope;
UAMT_mgAssis_attachement1 = std_attachement1;
UAMT_mgAssis_attachement2 = std_attachement2;
UAMT_mgAssis_attachement3 = std_attachement3;

UAMT_mgAssis_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_mgAssis_handgun = UAMT_std_handgun;
UAMT_mgAssis_handgun_scope = UAMT_std_handgun_scope;
UAMT_mgAssis_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_mgAssis_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_mgAssis_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_mgAssis_UAMT_watch = UAMT_watch;
UAMT_mgAssis_UAMT_map = UAMT_map;
UAMT_mgAssis_UAMT_compass = UAMT_compass;
UAMT_mgAssis_UAMT_binocs = UAMT_binocs;
UAMT_mgAssis_terminal = UAMT_terminal_t1;
UAMT_mgAssis_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_mgAssis_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_mgAssis_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_mgAssis_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

// Aditional Items the role should have in their loadout
UAMT_mgAssis_additionalItems = [];

// Additonal Items for the Role in the Armory
UAMT_mgAssis_UAMT_equipment_ar = [];


//------------------------------------------------------------------
//	Autorifle Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_autorifle_uniform = UAMT_uniforms;
UAMT_autorifle_vest = UAMT_vests;
UAMT_autorifle_UAMT_helmet = UAMT_helmet;
UAMT_autorifle_backpack = UAMT_backpack_std;

// Weapons
UAMT_autorifle_rifle = "arifle_MX_SW_F";
UAMT_autorifle_scope = UAMT_std_scope;
UAMT_autorifle_attachement1 = std_attachement1;
UAMT_autorifle_attachement2 = "bipod_01_F_snd";
UAMT_autorifle_attachement3 = std_attachement3;

UAMT_autorifle_ammo_inv = [
	["100Rnd_65x39_caseless_mag",5],
	["100Rnd_65x39_caseless_mag_Tracer",2]
];

UAMT_autorifle_handgun = UAMT_std_handgun;
UAMT_autorifle_handgun_scope = UAMT_std_handgun_scope;
UAMT_autorifle_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_autorifle_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_autorifle_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_autorifle_UAMT_watch = UAMT_watch;
UAMT_autorifle_UAMT_map = UAMT_map;
UAMT_autorifle_UAMT_compass = UAMT_compass;
UAMT_autorifle_UAMT_binocs = UAMT_binocs;
UAMT_autorifle_terminal = UAMT_terminal_t1;
UAMT_autorifle_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_autorifle_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_autorifle_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_autorifle_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

//Special alternative equipment for Autoriflemen in Armory
UAMT_autorifle_UAMT_equipment_ar = [
	//Weapons
	"arifle_MX_SW_Black_F",
	"arifle_MX_SW_khk_F",
	//ammo
	"100Rnd_65x39_caseless_black_mag",
	"100Rnd_65x39_caseless_black_mag_tracer",
	"100Rnd_65x39_caseless_khaki_mag",
	"100Rnd_65x39_caseless_khaki_mag_tracer"
];

//------------------------------------------------------------------
//	DM Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_dm_uniform = UAMT_uniforms;
UAMT_dm_vest = UAMT_vests;
UAMT_dm_UAMT_helmet = UAMT_helmet;
UAMT_dm_backpack = UAMT_backpack_std;

// Weapons
UAMT_dm_rifle = "arifle_MXM_F";
UAMT_dm_scope = "optic_Hamr";
UAMT_dm_attachement1 = std_attachement1;
UAMT_dm_attachement2 = "bipod_01_F_snd";
UAMT_dm_attachement3 = std_attachement3;

UAMT_dm_ammo_inv = [
	["30Rnd_65x39_caseless_mag",7],
	["30Rnd_65x39_caseless_mag_Tracer",2]
];

UAMT_dm_handgun = UAMT_std_handgun;
UAMT_dm_handgun_scope = UAMT_std_handgun_scope;
UAMT_dm_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_dm_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_dm_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_dm_UAMT_watch = UAMT_watch;
UAMT_dm_UAMT_map = UAMT_map;
UAMT_dm_UAMT_compass = UAMT_compass;
UAMT_dm_UAMT_binocs = UAMT_binocs;
UAMT_dm_terminal = UAMT_terminal_t1;
UAMT_dm_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_dm_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b  + [["ACE_RangeCard",1]];
UAMT_dm_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_dm_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]];

//Special alternative equipment for DM in Armory
UAMT_dm_UAMT_equipment_ar = [
	//Weapons
	"arifle_MXM_Black_F",
	"arifle_MXM_khk_F",
	//Tools
	"optic_AMS",
	"optic_AMS_khk",
	"optic_AMS_snd",
	"optic_DMS"
];

//------------------------------------------------------------------
//	Launchers Equipment
//
// Launcher Roles are Roles with Launcher. While we have predefined
// Roles for AT (Anti Tank), AA (Anti-Air) and AT-Light (light variant)
// all of these Roles have the same Items/Weapons Available in their
// Armory.
//
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_launcher_uniform = UAMT_uniforms;
UAMT_launcher_vest = UAMT_vests;
UAMT_launcher_UAMT_helmet = UAMT_helmet;
UAMT_launcher_backpack = UAMT_backpack_med;

// Weapons
UAMT_launcher_rifle = UAMT_std_rifle;
UAMT_launcher_scope = UAMT_std_scope;
UAMT_launcher_attachement1 = std_attachement1;
UAMT_launcher_attachement2 = std_attachement2;
UAMT_launcher_attachement3 = std_attachement3;

UAMT_launcher_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_launcher_handgun = UAMT_std_handgun;
UAMT_launcher_handgun_scope = UAMT_std_handgun_scope;
UAMT_launcher_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_launcher_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_launcher_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Only available for AT and AA Roles
// Ammunition is available for AT-Assistant Role too
UAMT_launcher_at = "launch_B_Titan_short_F";
UAMT_launcher_at_attachement1 = "";
UAMT_launcher_at_attachement2 = "";
UAMT_launcher_at_attachement3 = "";
// Assistant Roles will load 1.5 ceiled amounts of ammunition
UAMT_launcher_at_ammo = [
	["Titan_AT",1]
]; 
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
UAMT_launcher_at_ammoPool = ["Titan_AP"];

UAMT_launcher_aa = "launch_B_Titan_F";
UAMT_launcher_aa_attachement1 = "";
UAMT_launcher_aa_attachement2 = "";
UAMT_launcher_aa_attachement3 = "";
// Assistant Roles will load 1.5 ceiled amounts of ammunition
UAMT_launcher_aa_ammo = [
	["Titan_AA",1]
];
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
UAMT_launcher_aa_ammoPool = [];

UAMT_launcher_at_light = "";
UAMT_launcher_at_light_attachement1 = "";
UAMT_launcher_at_light_attachement2 = "";
UAMT_launcher_at_light_attachement3 = "";


// Set this true if your AT Light Launcher is a one-shot/dispensible Launcher
// Needed for the Supply Crate
_lightATdispenseble = true;

// Even with a dispensible launcher, this is needed to fill the weapon. 
// Needs multidimensional  Array: [["Ammo_Type_1",1],["Ammo_Type_2",1]]
UAMT_launcher_at_light_ammo = [];
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
UAMT_launcher_at_light_ammoPool = [];

// Slotted Items
UAMT_launcher_UAMT_watch = UAMT_watch;
UAMT_launcher_UAMT_map = UAMT_map;
UAMT_launcher_UAMT_compass = UAMT_compass;
UAMT_launcher_UAMT_binocs = UAMT_binocs;
UAMT_launcher_terminal = UAMT_terminal_t1;
UAMT_launcher_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_launcher_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_launcher_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_launcher_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

// Inventory items for Assistant Roles
launcherAssis_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
launcherAssis_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
launcherAssis_inv_b = UAMT_invStd_b + UAMT_san_t1_b;


//Special alternative equipment for AT in Armory
UAMT_launcher_UAMT_equipment_ar = [];

//------------------------------------------------------------------
//	Medic Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_medic_uniform = UAMT_uniforms;
UAMT_medic_vest = UAMT_vests;
UAMT_medic_UAMT_helmet = UAMT_helmet;
UAMT_medic_backpack = UAMT_backpack_med;

// Weapons
UAMT_medic_rifle = UAMT_std_rifle;
UAMT_medic_scope = UAMT_std_scope;
UAMT_medic_attachement1 = std_attachement1;
UAMT_medic_attachement2 = std_attachement2;
UAMT_medic_attachement3 = std_attachement3;

UAMT_medic_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_medic_handgun = UAMT_std_handgun;
UAMT_medic_handgun_scope = UAMT_std_handgun_scope;
UAMT_medic_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_medic_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_medic_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_medic_UAMT_watch = UAMT_watch;
UAMT_medic_UAMT_map = UAMT_map;
UAMT_medic_UAMT_compass = UAMT_compass;
UAMT_medic_UAMT_binocs = UAMT_binocs;
UAMT_medic_terminal = UAMT_terminal_t1;
UAMT_medic_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_medic_inv_u = UAMT_invStd_u + UAMT_san_t2_u;
UAMT_medic_inv_v = UAMT_invStd_v + UAMT_san_t2_v + UAMT_throwablesStd;
UAMT_medic_inv_b = UAMT_invStd_b + UAMT_san_t2_b + UAMT_throwablesExt;

// Additonal Items for the Role in the Armory
UAMT_medic_UAMT_equipment_ar = [];

//------------------------------------------------------------------
//	EOD Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_eod_uniform = UAMT_uniforms;
UAMT_eod_vest = UAMT_vests;
UAMT_eod_UAMT_helmet = UAMT_helmet;
UAMT_eod_backpack = UAMT_backpack_med;

// Weapons
UAMT_eod_rifle = UAMT_std_rifle;
UAMT_eod_scope = UAMT_std_scope;
UAMT_eod_attachement1 = std_attachement1;
UAMT_eod_attachement2 = std_attachement2;
UAMT_eod_attachement3 = std_attachement3;

UAMT_eod_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_eod_handgun = UAMT_std_handgun;
UAMT_eod_handgun_scope = UAMT_std_handgun_scope;
UAMT_eod_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_eod_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_eod_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_eod_UAMT_watch = UAMT_watch;
UAMT_eod_UAMT_map = UAMT_map;
UAMT_eod_UAMT_compass = UAMT_compass;
UAMT_eod_UAMT_binocs = UAMT_binocs;
UAMT_eod_terminal = UAMT_terminal_t1;
UAMT_eod_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_eod_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_eod_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd  + UAMT_throwablesExt;
UAMT_eod_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [
	["ACE_M26_Clacker",2],
	["DemoCharge_Remote_Mag",2],
	["ACE_VMM3",1]
];

// EOD Explosive Pool
// Put everything in here that you want in the Armory and in the
// UAMT_explosives Supply Crate
UAMT_eod_explosive_pool = [
	"ACE_M26_Clacker",
	"DemoCharge_Remote_Mag",
	"SatchelCharge_Remote_Mag",
	"ACE_VMM3"
];

// Mines Pool
// Put everything in here that you want in the Armory and in the
// UAMT_explosives Supply Crate
UAMT_eod_mines_pool = [
	"ClaymoreDirectionalMine_Remote_Mag",
	"UAMT_atMine_Range_Mag"
];

// Additional Equipment in the Armory
// Put everything here you want to be available for EODs in the armory
// BUT not in the Supply Crates
UAMT_eod_UAMT_equipment_ar = [
	"ACE_DeadManSwitch",
	"ACE_Cellphone"
];

//------------------------------------------------------------------
//	Engineer Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_engineer_uniform = UAMT_uniforms;
UAMT_engineer_vest = UAMT_vests;
UAMT_engineer_UAMT_helmet = UAMT_helmet;
UAMT_engineer_backpack = UAMT_backpack_std;

// Weapons
UAMT_engineer_rifle = UAMT_std_rifle;
UAMT_engineer_scope = UAMT_std_scope;
UAMT_engineer_attachement1 = std_attachement1;
UAMT_engineer_attachement2 = std_attachement2;
UAMT_engineer_attachement3 = std_attachement3;

UAMT_engineer_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_engineer_handgun = UAMT_std_handgun;
UAMT_engineer_handgun_scope = UAMT_std_handgun_scope;
UAMT_engineer_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_engineer_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_engineer_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_engineer_UAMT_watch = UAMT_watch;
UAMT_engineer_UAMT_map = UAMT_map;
UAMT_engineer_UAMT_compass = UAMT_compass;
UAMT_engineer_UAMT_binocs = UAMT_binocs;
UAMT_engineer_terminal = UAMT_terminal_t1;
UAMT_engineer_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_engineer_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_engineer_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd;
UAMT_engineer_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [["ACE_Fortify",1], ["ToolKit",1]];

// Additonal Items for the Role in the Armory
UAMT_engineer_UAMT_equipment_ar = [
	"ACE_EntrenchingTool",
	"ACE_wirecutter"
];

//------------------------------------------------------------------
//	JTAC Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_jtac_uniform = UAMT_uniforms;
UAMT_jtac_vest = UAMT_vests;
UAMT_jtac_UAMT_helmet = UAMT_helmet;
UAMT_jtac_backpack = UAMT_backpack_std;

// Weapons
UAMT_jtac_rifle = UAMT_std_rifle;
UAMT_jtac_scope = UAMT_std_scope;
UAMT_jtac_attachement1 = std_attachement1;
UAMT_jtac_attachement2 = std_attachement2;
UAMT_jtac_attachement3 = std_attachement3;

UAMT_jtac_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_jtac_handgun = UAMT_std_handgun;
UAMT_jtac_handgun_scope = UAMT_std_handgun_scope;
UAMT_jtac_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_jtac_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_jtac_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_jtac_UAMT_watch = UAMT_watch;
UAMT_jtac_UAMT_map = UAMT_map;
UAMT_jtac_UAMT_compass = UAMT_compass;
UAMT_jtac_UAMT_binocs = "Laserdesignator";
UAMT_jtac_terminal = UAMT_terminal_t3;
UAMT_jtac_UAMT_radio = UAMT_radio;

// Inventory items | Multidimensional Array [["ITEMNAME",AMOUNT],["ITEMNAME",AMOUNT]]
UAMT_jtac_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + [["ACE_RangeTable_82mm",1], ["ACE_artilleryTable",1], ["ACE_PlottingBoard",1], ["Laserbatteries",1]];
UAMT_jtac_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_jtac_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [["ACE_HuntIR_monitor",1], ["B_UavTerminal",1]];

// Additonal Items for the Role in the Armory
UAMT_jtac_UAMT_equipment_ar = [];

//------------------------------------------------------------------
//	Squadleader Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_sql_uniform = UAMT_uniforms;
UAMT_sql_vest = UAMT_vests;
UAMT_sql_UAMT_helmet = UAMT_helmet;
UAMT_sql_backpack = UAMT_backpack_std;

// Weapons
UAMT_sql_rifle = UAMT_std_rifle;
UAMT_sql_scope = UAMT_std_scope;
UAMT_sql_attachement1 = std_attachement1;
UAMT_sql_attachement2 = std_attachement2;
UAMT_sql_attachement3 = std_attachement3;

UAMT_sql_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_sql_handgun = UAMT_std_handgun;
UAMT_sql_handgun_scope = UAMT_std_handgun_scope;
UAMT_sql_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_sql_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_sql_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_sql_UAMT_watch = UAMT_watch;
UAMT_sql_UAMT_map = UAMT_map;
UAMT_sql_UAMT_compass = UAMT_compass;
UAMT_sql_UAMT_binocs = "Rangefinder";
UAMT_sql_terminal = UAMT_terminal_t2;
UAMT_sql_UAMT_radio = UAMT_radio;


// Inventory items
UAMT_sql_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b;
UAMT_sql_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_sql_inv_b = UAMT_invStd_b + UAMT_san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]];

// Additonal Items for the Role in the Armory
UAMT_sql_UAMT_equipment_ar = [];


//------------------------------------------------------------------
//	Groupleader Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_gl_uniform = UAMT_uniforms;
UAMT_gl_vest = UAMT_vests;
UAMT_gl_UAMT_helmet = UAMT_helmet;
UAMT_gl_backpack = UAMT_backpack_std;

// Weapons
UAMT_gl_rifle = UAMT_std_rifle;
UAMT_gl_scope = UAMT_std_scope;
UAMT_gl_attachement1 = std_attachement1;
UAMT_gl_attachement2 = std_attachement2;
UAMT_gl_attachement3 = std_attachement3;

UAMT_gl_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_gl_handgun = UAMT_std_handgun;
UAMT_gl_handgun_scope = UAMT_std_handgun_scope;
UAMT_gl_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_gl_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_gl_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_gl_UAMT_watch = UAMT_watch;
UAMT_gl_UAMT_map = UAMT_map;
UAMT_gl_UAMT_compass = UAMT_compass;
UAMT_gl_UAMT_binocs = "Laserdesignator";
UAMT_gl_terminal = UAMT_terminal_t3;
UAMT_gl_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_gl_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + [["Laserbatteries",1]];
UAMT_gl_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_gl_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

//Throwables
UAMT_gl_throwables = UAMT_throwablesStd + UAMT_throwablesExt;

// Aditional Items the role should have in their loadout
UAMT_gl_additionalItems = [];

// Additonal Items for the Role in the Armory
UAMT_gl_UAMT_equipment_ar = [];


//------------------------------------------------------------------
//	Sniper Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_sniper_uniform = ["U_B_GhillieSuit"];
UAMT_sniper_vest = ["V_Chestrig_rgr"];
UAMT_sniper_UAMT_helmet = ["H_Bandanna_mcamo"];
UAMT_sniper_backpack = UAMT_backpack_std;

// Role Specific Rifle
UAMT_sniper_rifle = "srifle_LRR_camo_F";
UAMT_sniper_scope = "optic_LRPS";
UAMT_sniper_attachement1 = "";
UAMT_sniper_attachement2 = "";
UAMT_sniper_attachement3 = "";

UAMT_sniper_ammo_inv = [
	["7Rnd_408_Mag",5]
];

UAMT_sniper_handgun = UAMT_std_handgun;
UAMT_sniper_handgun_scope = UAMT_std_handgun_scope;
UAMT_sniper_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_sniper_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_sniper_handgunAmmo_inv = UAMT_std_handgunAmmo_inv;

// Slotted Items
UAMT_sniper_UAMT_watch = UAMT_watch;
UAMT_sniper_UAMT_map = UAMT_map;
UAMT_sniper_UAMT_compass = UAMT_compass;
UAMT_sniper_UAMT_binocs = UAMT_binocs;
UAMT_sniper_terminal = UAMT_terminal_t2;
UAMT_sniper_UAMT_radio = UAMT_radio;

//Throwables
UAMT_sniper_throwables = UAMT_throwablesStd + UAMT_throwablesExt;

// Inventory items
UAMT_sniper_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + [["ACE_RangeCard",1], ["ACE_Kestrel4500",1]];
UAMT_sniper_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_sniper_inv_b = UAMT_invStd_b + UAMT_san_t1_b;

//Special alternative equipment for Snipers and Spotters in Armory
UAMT_sniper_UAMT_equipment_ar = [
	"srifle_LRR_F",
	"srifle_LRR_tna_F"
];


//------------------------------------------------------------------
//	Spotter Equipment
//
// The spotter is default equiped with DM equipment and has access
// to DM Equipment in the armory, as well as to Sniper Ammunition
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_spotter_uniform = ["U_B_GhillieSuit"];
UAMT_spotter_vest = ["V_Chestrig_rgr"];
UAMT_spotter_UAMT_helmet = ["H_Bandanna_mcamo"];
UAMT_spotter_backpack = UAMT_backpack_std;

// Weapons
UAMT_spotter_rifle = UAMT_dm_rifle;
UAMT_spotter_scope = UAMT_dm_scope;
UAMT_spotter_attachement1 = UAMT_dm_attachement1;
UAMT_spotter_attachement2 = UAMT_dm_attachement2;
UAMT_spotter_attachement3 = UAMT_dm_attachement3;

UAMT_spotter_ammo_inv = UAMT_std_rifleAmmo_inv;

UAMT_spotter_handgun = UAMT_std_handgun;
UAMT_spotter_handgun_scope = UAMT_std_handgun_scope;
UAMT_spotter_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_spotter_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_spotter_handgunAmmo_inv = UAMT_dm_ammo_inv;

// Slotted Items
UAMT_spotter_UAMT_watch = UAMT_watch;
UAMT_spotter_UAMT_map = UAMT_map;
UAMT_spotter_UAMT_compass = UAMT_compass;
UAMT_spotter_UAMT_binocs = "Rangefinder";
UAMT_spotter_terminal = UAMT_terminal_t2;
UAMT_spotter_UAMT_radio = UAMT_radio;

// Inventory items
UAMT_spotter_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + [["ACE_RangeCard",1]];
UAMT_spotter_inv_v = UAMT_invStd_v + UAMT_san_t1_v + UAMT_throwablesStd + UAMT_throwablesExt;
UAMT_spotter_inv_b = UAMT_invStd_b + UAMT_san_t1_b  + [["ACE_Kestrel4500",1], ["ACE_SpottingScope",1], ["ACE_wirecutter",1]];

//Special alternative equipment for Snipers and Spotters in Armory
UAMT_spotter_UAMT_equipment_ar = [];


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Crew Loadouts
//
// Crewloadouts are very different. They don't need a Primary gun.
// Also, they have now backpacks and therefor limited medical access
// They also have only SR UAMT_radios as LR should be available in vehicle
// 
// Crew Roles don't have any Access to the other shared Equipment besides
// UAMT_facewear.
// 
// The only Equipment they will have as options in the armory is what 
// you define here.
//
// This is all to make the crews more dependent on their vehicle and
// can create intense SERE Situations for the Crew and Rescue Missions
// for the rest of the Players
//
// This makes it important for the Mission Maker to setup the vehicles
// with a fitting loadout
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//	Helicopter and Plane Pilot Equipment
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_pilot_uniform = ["U_B_HeliPilotCoveralls"];
UAMT_pilot_UAMT_helmet = ["H_PilotUAMT_helmetHeli_B"];
UAMT_pilot_vest = ["V_TacVest_blk"];
UAMT_pilot_backpack = [""];
UAMT_pilot_UAMT_facewear = ["G_Aviator"];

// Weapons
UAMT_pilot_rifle = "SUAMT_mg_01_F";
UAMT_pilot_scope = "optic_Holosight_smg";
UAMT_pilot_attachement1 = "";
UAMT_pilot_attachement2 = "";
UAMT_pilot_attachement3 = "";

UAMT_pilot_ammo_inv = [
	["30Rnd_45ACP_Mag_SUAMT_mg_01",2]
];

UAMT_pilot_handgun = "hgun_P07_F";
UAMT_pilot_handgun_scope = UAMT_std_handgun_scope;
UAMT_pilot_handgun_attachement1 = UAMT_std_handgun_attachment1;
UAMT_pilot_handgun_attachement2 = UAMT_std_handgun_attachment2;

UAMT_pilot_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
UAMT_pilot_UAMT_watch = UAMT_watch;
UAMT_pilot_UAMT_map = UAMT_map;
UAMT_pilot_UAMT_compass = UAMT_compass;
UAMT_pilot_UAMT_binocs = UAMT_binocs;
UAMT_pilot_terminal = UAMT_terminal_t2;
UAMT_pilot_UAMT_radio = UAMT_radio;
UAMT_pilot_UAMT_nvg = "ACE_UAMT_nvg_Wide";

// Inventory items
UAMT_pilot_inv_u = UAMT_invStd_u;
UAMT_pilot_inv_v = UAMT_san_t0_u + [
	["ACE_HandFlare_Green",2],
	["SmokeShellGreen",2]
];
UAMT_pilot_inv_b = [];


//Special alternative equipment for Pilots in Armory
UAMT_pilot_UAMT_equipment_ar = [
	"ACE_UAMT_nvg_Wide_WP"
];


//------------------------------------------------------------------
//	Fighter Pilot Equipment
//
// Fighter Pilots have no Vest, so even more limited inventory Space.
// Therefor they don't get any Standard Equipment outside of 
// "backpackfPilot"
//
// So you need to equip even medical Items for your Pilots in here!
//
// They get a Parachute as Backpack
//
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_fpilot_uniform = ["U_B_PilotCoveralls"];
UAMT_fpilot_UAMT_helmet = ["H_PilotUAMT_helmetFighter_B"];
UAMT_fpilot_vest = [""];
UAMT_fpilot_backpack = ["B_Parachute"];
UAMT_fpilot_UAMT_facewear = [""];

// Weapons
UAMT_fpilot_rifle = "SUAMT_mg_01_F";
UAMT_fpilot_scope = "optic_Holosight_smg";
UAMT_fpilot_attachement1 = "";
UAMT_fpilot_attachement2 = "";
UAMT_fpilot_attachement3 = "";

UAMT_fpilot_ammo_inv = [
	["30Rnd_45ACP_Mag_SUAMT_mg_01",2]
];

UAMT_fpilot_handgun = "";
UAMT_fpilot_handgun_scope = "";
UAMT_fpilot_handgun_attachement1 = "";
UAMT_fpilot_handgun_attachement2 = "";

UAMT_fpilot_handgunAmmo_inv = [];

// Slotted Items
UAMT_fpilot_UAMT_watch = UAMT_watch;
UAMT_fpilot_UAMT_map = UAMT_map;
UAMT_fpilot_UAMT_compass = UAMT_compass;
UAMT_fpilot_UAMT_binocs = UAMT_binocs;
UAMT_fpilot_terminal = UAMT_terminal_t2;
UAMT_fpilot_UAMT_radio = UAMT_radio;
UAMT_fpilot_UAMT_nvg = "ACE_UAMT_nvg_Wide";

// Inventory items
UAMT_fpilot_inv_u = UAMT_invStd_u + UAMT_san_t0_u + [
	["ACE_HandFlare_Green",1],
	["SmokeShellGreen",1]
];
UAMT_fpilot_inv_v =  [];
UAMT_fpilot_inv_b = [];


//Special alternative equipment for Pilots in Armory
UAMT_fpilot_UAMT_equipment_ar = [
	"ACE_UAMT_nvg_Wide_WP"
];

//------------------------------------------------------------------
//	Crewman Equipment 
//	(for Ground Vehicles with Special Training like Tanks, APCs)
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_crew_uniform = ["U_B_CombatUniform_mcam_vest"];
UAMT_crew_vest = ["V_BandollierB_rgr"];
UAMT_crew_UAMT_helmet = ["H_UAMT_helmetUAMT_crew_B"];
UAMT_crew_backpack = [""];
UAMT_crew_UAMT_facewear = ["G_Lowprofile"];

// Weapons
UAMT_crew_rifle = "arifle_MXC_F";
UAMT_crew_scope = "";
UAMT_crew_attachement1 = "";
UAMT_crew_attachement2 = "";
UAMT_crew_attachement3 = "";

UAMT_crew_ammo_inv = [
	["30Rnd_65x39_caseless_mag",2]
];

UAMT_crew_handgun = "hgun_P07_F";
UAMT_crew_handgun_scope = "";
UAMT_crew_handgun_attachement1 = "";
UAMT_crew_handgun_attachement2 = "";

UAMT_crew_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
UAMT_crew_UAMT_watch = UAMT_watch;
UAMT_crew_UAMT_map = UAMT_map;
UAMT_crew_UAMT_compass = UAMT_compass;
UAMT_crew_UAMT_binocs = UAMT_binocs;
UAMT_crew_terminal = UAMT_terminal_t1;
UAMT_crew_UAMT_radio = UAMT_radio;
UAMT_crew_UAMT_nvg = UAMT_nvg;

// Inventory items
UAMT_crew_inv_u = UAMT_invStd_u + UAMT_san_t0_u;
UAMT_crew_inv_v = [
	["ACE_HandFlare_Green",2],
	["SmokeShellGreen",2]
];
UAMT_crew_inv_b = [];

// Additonal Items for the Role in the Armory
UAMT_crew_UAMT_equipment_ar = [
	"V_BandollierB_blk",
	"V_BandollierB_cbr",
	"V_BandollierB_khk",
	"V_BandollierB_oli",
	"H_Cap_headphones"
];

//------------------------------------------------------------------
//						Diver Equipment
//
// For at least a bit of realism Diver Roles have in the preset 
// very light loadouts. You can of course change this to the 
// playstile of your group.
//
//------------------------------------------------------------------
// Outfit Variables
//
// You can give more than one item if you want some randomised variation
// for the Players. 
//
// IMPORTANT: Outfit Variables must always be an Array, even if you put only one 
// element into it. So always use:
// variable = ["itemName"];
//------------------------------------------------------------------
UAMT_diver_uniform = ["U_B_Wetsuit"];
UAMT_diver_vest = ["V_RebreatherB"];
UAMT_diver_UAMT_helmet = ["H_UAMT_helmetB_light_black"];
UAMT_diver_backpack = ["B_AssaultPack_blk"];
UAMT_diver_UAMT_facewear = ["G_B_Diving"];

// Weapons
UAMT_diver_rifle = "arifle_SDAR_F";
UAMT_diver_scope = "";
UAMT_diver_attachement1 = "";
UAMT_diver_attachement2 = "";
UAMT_diver_attachement3 = "";

UAMT_diver_ammo_inv = [
	["20Rnd_556x45_UW_mag",5]
];

UAMT_diver_handgun = "hgun_P07_F";
UAMT_diver_handgun_scope = "";
UAMT_diver_handgun_attachement1 = "muzzle_snds_L";
UAMT_diver_handgun_attachement2 = "";

UAMT_diver_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
UAMT_diver_UAMT_watch = UAMT_watch;
UAMT_diver_UAMT_map = UAMT_map;
UAMT_diver_UAMT_compass = UAMT_compass;
UAMT_diver_UAMT_binocs = UAMT_binocs;
UAMT_diver_terminal = UAMT_terminal_t1;
UAMT_diver_UAMT_radio = UAMT_radio;
UAMT_diver_UAMT_nvg = UAMT_nvg;

// Inventory items
UAMT_diver_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + UAMT_san_t1_v + UAMT_san_t1_b;
UAMT_diver_inv_v = [];
UAMT_diver_inv_b = UAMT_throwablesStd + UAMT_throwablesExt ;

// Inventory items
diverUAMT_eod_inv_u = UAMT_invStd_u + UAMT_UAMT_san_t1_b + UAMT_san_t1_v + UAMT_san_t1_b;
diverUAMT_eod_inv_v = [];
diverUAMT_eod_inv_b = UAMT_throwablesStd + UAMT_throwablesExt + [
	["ACE_Clacker",2],
	["DemoCharge_Remote_Mag",2]
];

// Inventory items
diverUAMT_medic_inv_u = UAMT_invStd_u;
diverUAMT_medic_inv_v = [];
diverUAMT_medic_inv_b = UAMT_throwablesStd + UAMT_throwablesExt + [
	["ACE_surgicalKit",1],
	["ACE_fieldDressing",20],
	["ACE_elasticBandage",10],
	["ACE_packingBandage",10],
	["ACE_epinephrine",5],
	["ACE_morphine",5],
	["ACE_salineIV_250",5],
	["ACE_splint",10],
	["ACE_tourniquet",3]
];

//Additional or alternative Items available for this specific Role in the Armory
UAMT_diver_UAMT_equipment_ar = [];

//------------------------------------------------------------------
//	Content for Armory
//------------------------------------------------------------------


//------------------------------------------------------------------
//	Special Equipment used in Loadouts
//------------------------------------------------------------------


UAMT_uav_Terminal = "B_UavTerminal";			//No attached Role, just needed for the Supply Point Crate
UAMT_uav_backpack = "B_UAV_01_backpack_F";	//No attached Role, just needed for the Supply Point Crate
UAMT_uav_battery = "ACE_UAVBattery";			//No attached Role, just needed for the Supply Point Crate

UAMT_minedetector = "ACE_VMM3";				//Only available for EOD and Diver Team

UAMT_explosivedevice = "ACE_Clacker";		//Only available for EOD and Diver Team
UAMT_defusalkit = "ACE_DefusalKit";			//Only available for EOD and Diver Team

//UAMT_explosives for special occasions. Only available for EOD and Diver Roles or TOC Group
UAMT_smallDemo = "DemoCharge_Remote_Mag";
UAMT_bigDemo = "SatchelCharge_Remote_Mag";
UAMT_apMine = "ClaymoreDirectionalMine_Remote_Mag";
UAMT_atMine = "UAMT_atMine_Range_Mag";

//More UAMT_explosives in the Arsenal
UAMT_explosives = [
	"SatchelCharge_Remote_Mag",
	"SLAMDirectionalMine_Wire_Mag",
	"ClaymoreDirectionalMine_Remote_Mag",
	"ACE_FlareTripMine_Mag"
];

UAMT_explosives pushback smallDemo;
UAMT_explosives pushback bigDemo;
UAMT_explosives pushback apMine;
UAMT_explosives pushback UAMT_atMine;




//------------------------------------------------------------------
//------------------------------------------------------------------
//			Equipment Alternatives for Everyone
//
// Here you can put in alternative Equipment that should be available
// for everyone, except Crew- and Diver-Roles.
//
// This is mostly Tactical Barby Stuff. UAMT_uniforms, UAMT_vests and UAMT_helmets 
// with Camo alternativs, UAMT_facewear to look cool or stupid but also 
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

UAMT_equipment_ar = [
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
	"optic_Holosight_sUAMT_mg_blk_F",
	"optic_Holosight_sUAMT_mg_khk_F",
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
	"muzzle_snds_H_UAMT_mg_blk_F",
	"muzzle_snds_H_UAMT_mg_khk_F",
	"muzzle_snds_338_black",
	"muzzle_snds_338_green",
	"muzzle_snds_338_sand",

	//UAMT_uniforms
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_T_Soldier_F",
	"U_B_T_Soldier_AR_F",
	"U_B_CombatUniform_mcam_wdl_f",
	"U_B_CombatUniform_tshirt_mcam_wdL_f",
	
	//UAMT_vests
	"V_PlateCarrierUAMT_gl_blk",
	"V_PlateCarrierUAMT_gl_rgr",
	"V_PlateCarrierUAMT_gl_mtp",
	"V_PlateCarrierUAMT_gl_tna_F",
	"V_PlateCarrierUAMT_gl_wdl",
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
	
	//UAMT_helmets
	"H_UAMT_helmetB",
	"H_UAMT_helmetB_black",
	"H_UAMT_helmetB_camo",
	"H_UAMT_helmetB_desert",
	"H_UAMT_helmetB_grass",
	"H_UAMT_helmetB_sand",
	"H_UAMT_helmetB_snakeskin",
	"H_UAMT_helmetB_tna_F",
	"H_UAMT_helmetB_plain_wdl",
	"H_UAMT_helmetSpecB",
	"H_UAMT_helmetSpecB_blk",
	"H_UAMT_helmetSpecB_paint2",
	"H_UAMT_helmetSpecB_paint1",
	"H_UAMT_helmetSpecB_sand",
	"H_UAMT_helmetSpecB_snakeskin",
	"H_UAMT_helmetB_Enh_tna_F",
	"H_UAMT_helmetSpecB_wdl",
	"H_UAMT_helmetB_light",
	"H_UAMT_helmetB_light_black",
	"H_UAMT_helmetB_light_desert",
	"H_UAMT_helmetB_light_grass",
	"H_UAMT_helmetB_light_sand",
	"H_UAMT_helmetB_light_snakeskin",
	"H_UAMT_helmetB_Light_tna_F",
	"H_UAMT_helmetB_light_wdl",

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
];

//------------------------------------------------------------------
//	UAMT_facewear Armory Extension
//
// Same as above, only for UAMT_facewear Items that are also available
// for Crew-Roles (sorry Divers, no special UAMT_facewear for you).
//------------------------------------------------------------------
UAMT_facewear_Arm = [
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
];

//------------------------------------------------------------------
//
//	Armory Arrays
//
// Arrays for the Roles, defining what will be available for the
// Role inside the armory
//------------------------------------------------------------------

//------------------------------------------------------------------
//	Standard Equipment Array
//------------------------------------------------------------------
UAMT_std_equipment = [];
UAMT_std_equipment append UAMT_uniforms;
UAMT_std_equipment append UAMT_helmet;
UAMT_std_equipment append UAMT_vests;
UAMT_std_equipment append UAMT_facewear;
UAMT_std_equipment append UAMT_backpack_std;
UAMT_std_equipment append UAMT_backpack_med;
UAMT_std_equipment append UAMT_backpack_big;
UAMT_std_equipment append [
	UAMT_watch,
	UAMT_map,
	UAMT_compass,
	UAMT_binocs,
	UAMT_radio,
	UAMT_std_scope,
	UAMT_std_attachement1,
	UAMT_std_attachement2,
	UAMT_std_attachement3,
	UAMT_std_handgun_scope,
	UAMT_std_handgun_attachment1,
	UAMT_std_handgun_attachment2
];

UAMT_std_weapons = [];
UAMT_std_weapons append [UAMT_std_rifle,UAMT_std_handgun];
UAMT_std_weapons append UAMT_UAMT_std_weapons_alt;

{
	UAMT_std_equipment pushback (_x select 0);
} forEach UAMT_std_rifleAmmo_inv;

{
	UAMT_std_equipment pushback (_x select 0);
} forEach UAMT_std_handgunAmmo_inv;

{
	UAMT_std_equipment pushback (_x select 0);
} forEach UAMT_invStd_u;

{
	UAMT_std_equipment pushback (_x select 0);
} forEach UAMT_invStd_v;

{
	UAMT_std_equipment pushback (_x select 0);
} forEach UAMT_invStd_b;

//------------------------------------------------------------------
//	Rifleman Equipment Array
//------------------------------------------------------------------
UAMT_rifleman_armory = [];
UAMT_rifleman_armory append UAMT_std_equipment;
UAMT_rifleman_armory append UAMT_std_weapons;
UAMT_rifleman_armory append UAMT_UAMT_rifleman_uniform;
UAMT_rifleman_armory append UAMT_UAMT_rifleman_vest;
UAMT_rifleman_armory append UAMT_UAMT_rifleman_UAMT_helmet;
UAMT_rifleman_armory append UAMT_rifleman_backpack;
UAMT_rifleman_armory append [
	UAMT_rifleman_rifle,
	UAMT_rifleman_scope,
	UAMT_rifleman_attachement1,
	UAMT_rifleman_attachement2,
	UAMT_rifleman_attachement3,
	UAMT_rifleman_handgun,
	UAMT_rifleman_handgun_scope,
	UAMT_rifleman_handgun_attachement1,
	UAMT_rifleman_handgun_attachement2,
	UAMT_rifleman_UAMT_watch,
	UAMT_rifleman_UAMT_map,
	UAMT_rifleman_UAMT_compass,
	UAMT_rifleman_UAMT_binocs,
	UAMT_rifleman_terminal,
	UAMT_rifleman_UAMT_radio,
	UAMT_nvg
];

UAMT_rifleman_armory append UAMT_rifleman_UAMT_equipment_ar;
UAMT_rifleman_armory append UAMT_equipment_ar;
UAMT_rifleman_armory append UAMT_facewear_Arm;

{
	UAMT_rifleman_armory pushback (_x select 0);
} forEach UAMT_rifleman_ammo_inv;

{
	UAMT_rifleman_armory pushback (_x select 0);
} forEach UAMT_rifleman_handgunAmmo_inv;	

{
	UAMT_rifleman_armory pushback (_x select 0);
} forEach UAMT_rifleman_inv_u;

{
	UAMT_rifleman_armory pushback (_x select 0);
} forEach UAMT_rifleman_inv_v;

{
	UAMT_rifleman_armory pushback (_x select 0);
} forEach UAMT_rifleman_inv_b;

if ("Rifleman" in UAMT_lrRoles) then {
	UAMT_rifleman_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	Grenadier Equipment Array
//------------------------------------------------------------------	
UAMT_grenadier_armory = [];
UAMT_grenadier_armory append UAMT_std_equipment;
UAMT_grenadier_armory append UAMT_grenadier_uniform;
UAMT_grenadier_armory append UAMT_grenadier_vest;
UAMT_grenadier_armory append UAMT_grenadier_UAMT_helmet;
UAMT_grenadier_armory append UAMT_grenadier_backpack;
UAMT_grenadier_armory append [
	UAMT_grenadier_rifle,
	UAMT_grenadier_scope,
	UAMT_grenadier_attachement1,
	UAMT_grenadier_attachement2,
	UAMT_grenadier_attachement3,
	UAMT_grenadier_handgun,
	UAMT_grenadier_handgun_scope,
	UAMT_grenadier_handgun_attachement1,
	UAMT_grenadier_handgun_attachement2,
	UAMT_grenadier_UAMT_watch,
	UAMT_grenadier_UAMT_map,
	UAMT_grenadier_UAMT_compass,
	UAMT_grenadier_UAMT_binocs,
	UAMT_grenadier_terminal,
	UAMT_grenadier_UAMT_radio,
	UAMT_nvg
];

UAMT_grenadier_armory append UAMT_grenadier_UAMT_equipment_ar;
UAMT_grenadier_armory append UAMT_equipment_ar;
UAMT_grenadier_armory append UAMT_facewear_Arm;
UAMT_grenadier_armory append UAMT_grenadier_UUAMT_gl_Pool;

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_ammo_inv;

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_handgunAmmo_inv;	

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_inv_u;

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_UUAMT_gl_inv;

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_inv_v;

{
	UAMT_grenadier_armory pushback (_x select 0);
} forEach UAMT_grenadier_inv_b;

if ("Grenadier" in UAMT_lrRoles) then {
	UAMT_grenadier_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	mg Equipment Array
//------------------------------------------------------------------	
UAMT_mg_armory = [];
UAMT_mg_armory append UAMT_std_equipment;
UAMT_mg_armory append UAMT_mg_uniform;
UAMT_mg_armory append UAMT_mg_vest;
UAMT_mg_armory append UAMT_mg_UAMT_helmet;
UAMT_mg_armory append UAMT_mg_backpack;
UAMT_mg_armory append [
	UAMT_mg_rifle,
	UAMT_mg_scope,
	UAMT_mg_attachement1,
	UAMT_mg_attachement2,
	UAMT_mg_attachement3,
	UAMT_mg_handgun,
	UAMT_mg_handgun_scope,
	UAMT_mg_handgun_attachement1,
	UAMT_mg_handgun_attachement2,
	UAMT_mg_UAMT_watch,
	UAMT_mg_UAMT_map,
	UAMT_mg_UAMT_compass,
	UAMT_mg_UAMT_binocs,
	UAMT_mg_terminal,
	UAMT_mg_UAMT_radio,
	UAMT_nvg
];

UAMT_mg_armory append UAMT_mg_UAMT_equipment_ar;
UAMT_mg_armory append UAMT_equipment_ar;
UAMT_mg_armory append UAMT_facewear_Arm;
UAMT_mg_armory append UAMT_mg_assistant_share_ar;

{
	UAMT_mg_armory pushback (_x select 0);
} forEach UAMT_mg_ammo_inv;

{
	UAMT_mg_armory pushback (_x select 0);
} forEach UAMT_mg_handgunAmmo_inv;	

{
	UAMT_mg_armory pushback (_x select 0);
} forEach UAMT_mg_inv_u;

{
	UAMT_mg_armory pushback (_x select 0);
} forEach UAMT_mg_inv_v;

{
	UAMT_mg_armory pushback (_x select 0);
} forEach UAMT_mg_inv_b;

if ("MG" in UAMT_lrRoles) then {
	UAMT_mg_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	mgAssis Equipment Array
//------------------------------------------------------------------	
UAMT_mgAssis_armory = [];
UAMT_mgAssis_armory append UAMT_std_equipment;
UAMT_mgAssis_armory append UAMT_std_weapons;
UAMT_mgAssis_armory append UAMT_mgAssis_uniform;
UAMT_mgAssis_armory append UAMT_mgAssis_vest;
UAMT_mgAssis_armory append UAMT_mgAssis_UAMT_helmet;
UAMT_mgAssis_armory append UAMT_mgAssis_backpack;
UAMT_mgAssis_armory append [
	UAMT_mgAssis_rifle,
	UAMT_mgAssis_scope,
	UAMT_mgAssis_attachement1,
	UAMT_mgAssis_attachement2,
	UAMT_mgAssis_attachement3,
	UAMT_mgAssis_handgun,
	UAMT_mgAssis_handgun_scope,
	UAMT_mgAssis_handgun_attachement1,
	UAMT_mgAssis_handgun_attachement2,
	UAMT_mgAssis_UAMT_watch,
	UAMT_mgAssis_UAMT_map,
	UAMT_mgAssis_UAMT_compass,
	UAMT_mgAssis_UAMT_binocs,
	UAMT_mgAssis_terminal,
	UAMT_mgAssis_UAMT_radio,
	UAMT_nvg
];

UAMT_mgAssis_armory append UAMT_mgAssis_UAMT_equipment_ar;
UAMT_mgAssis_armory append UAMT_equipment_ar;
UAMT_mgAssis_armory append UAMT_facewear_Arm;
UAMT_mgAssis_armory append UAMT_mg_assistant_share_ar;

{
	UAMT_mgAssis_armory pushback (_x select 0);
} forEach UAMT_mgAssis_ammo_inv;

{
	UAMT_mgAssis_armory pushback (_x select 0);
} forEach UAMT_mgAssis_handgunAmmo_inv;	

{
	UAMT_mgAssis_armory pushback (_x select 0);
} forEach UAMT_mgAssis_inv_u;

{
	UAMT_mgAssis_armory pushback (_x select 0);
} forEach UAMT_mgAssis_inv_v;

{
	UAMT_mgAssis_armory pushback (_x select 0);
} forEach UAMT_mgAssis_inv_b;

if ("MG-Assistant" in UAMT_lrRoles) then {
	UAMT_mgAssis_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	autorifle Equipment Array
//------------------------------------------------------------------	
UAMT_autorifle_armory = [];
UAMT_autorifle_armory append UAMT_std_equipment;
UAMT_autorifle_armory append UAMT_autorifle_uniform;
UAMT_autorifle_armory append UAMT_autorifle_vest;
UAMT_autorifle_armory append UAMT_autorifle_UAMT_helmet;
UAMT_autorifle_armory append UAMT_autorifle_backpack;
UAMT_autorifle_armory append [
	UAMT_autorifle_rifle,
	UAMT_autorifle_scope,
	UAMT_autorifle_attachement1,
	UAMT_autorifle_attachement2,
	UAMT_autorifle_attachement3,
	UAMT_autorifle_handgun,
	UAMT_autorifle_handgun_scope,
	UAMT_autorifle_handgun_attachement1,
	UAMT_autorifle_handgun_attachement2,
	UAMT_autorifle_UAMT_watch,
	UAMT_autorifle_UAMT_map,
	UAMT_autorifle_UAMT_compass,
	UAMT_autorifle_UAMT_binocs,
	UAMT_autorifle_terminal,
	UAMT_autorifle_UAMT_radio,
	UAMT_nvg
];

UAMT_autorifle_armory append UAMT_autorifle_UAMT_equipment_ar;
UAMT_autorifle_armory append UAMT_equipment_ar;
UAMT_autorifle_armory append UAMT_facewear_Arm;

{
	UAMT_autorifle_armory pushback (_x select 0);
} forEach UAMT_autorifle_ammo_inv;

{
	UAMT_autorifle_armory pushback (_x select 0);
} forEach UAMT_autorifle_handgunAmmo_inv;	

{
	UAMT_autorifle_armory pushback (_x select 0);
} forEach UAMT_autorifle_inv_u;

{
	UAMT_autorifle_armory pushback (_x select 0);
} forEach UAMT_autorifle_inv_v;

{
	UAMT_autorifle_armory pushback (_x select 0);
} forEach UAMT_autorifle_inv_b;

if ("Autorifle" in UAMT_lrRoles) then {
	UAMT_autorifle_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	dm Equipment Array
//------------------------------------------------------------------	
UAMT_dm_armory = [];
UAMT_dm_armory append UAMT_std_equipment;
UAMT_dm_armory append UAMT_dm_uniform;
UAMT_dm_armory append UAMT_dm_vest;
UAMT_dm_armory append UAMT_dm_UAMT_helmet;
UAMT_dm_armory append UAMT_dm_backpack;
UAMT_dm_armory append [
	UAMT_dm_rifle,
	UAMT_dm_scope,
	UAMT_dm_attachement1,
	UAMT_dm_attachement2,
	UAMT_dm_attachement3,
	UAMT_dm_handgun,
	UAMT_dm_handgun_scope,
	UAMT_dm_handgun_attachement1,
	UAMT_dm_handgun_attachement2,
	UAMT_dm_UAMT_watch,
	UAMT_dm_UAMT_map,
	UAMT_dm_UAMT_compass,
	UAMT_dm_UAMT_binocs,
	UAMT_dm_terminal,
	UAMT_dm_UAMT_radio,
	UAMT_nvg
];

UAMT_dm_armory append UAMT_dm_UAMT_equipment_ar;
UAMT_dm_armory append UAMT_equipment_ar;
UAMT_dm_armory append UAMT_facewear_Arm;

{
	UAMT_dm_armory pushback (_x select 0);
} forEach UAMT_dm_ammo_inv;

{
	UAMT_dm_armory pushback (_x select 0);
} forEach UAMT_dm_handgunAmmo_inv;	

{
	UAMT_dm_armory pushback (_x select 0);
} forEach UAMT_dm_inv_u;

{
	UAMT_dm_armory pushback (_x select 0);
} forEach UAMT_dm_inv_v;

{
	UAMT_dm_armory pushback (_x select 0);
} forEach UAMT_dm_inv_b;

if ("DM" in UAMT_lrRoles) then {
	UAMT_dm_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	launcher Equipment Array
//------------------------------------------------------------------	
UAMT_launcher_armory = [];
UAMT_launcher_armory append UAMT_std_equipment;
UAMT_launcher_armory append UAMT_std_weapons;
UAMT_launcher_armory append UAMT_launcher_uniform;
UAMT_launcher_armory append UAMT_launcher_vest;
UAMT_launcher_armory append UAMT_launcher_UAMT_helmet;
UAMT_launcher_armory append UAMT_launcher_backpack;
UAMT_launcher_armory append [
	UAMT_launcher_rifle,
	UAMT_launcher_scope,
	UAMT_launcher_attachement1,
	UAMT_launcher_attachement2,
	UAMT_launcher_attachement3,
	UAMT_launcher_handgun,
	UAMT_launcher_handgun_scope,
	UAMT_launcher_handgun_attachement1,
	UAMT_launcher_handgun_attachement2,
	UAMT_launcher_at,
	UAMT_launcher_at_attachement1,
	UAMT_launcher_at_attachement2,
	UAMT_launcher_at_attachement3,
	UAMT_launcher_aa,
	UAMT_launcher_aa_attachement1,
	UAMT_launcher_aa_attachement2,
	UAMT_launcher_aa_attachement3,
	UAMT_launcher_at_light,
	UAMT_launcher_at_light_attachement1,
	UAMT_launcher_at_light_attachement2,
	UAMT_launcher_at_light_attachement3,
	UAMT_launcher_UAMT_watch,
	UAMT_launcher_UAMT_map,
	UAMT_launcher_UAMT_compass,
	UAMT_launcher_UAMT_binocs,
	UAMT_launcher_terminal,
	UAMT_launcher_UAMT_radio,
	UAMT_nvg
];

UAMT_launcher_armory append UAMT_launcher_UAMT_equipment_ar;
UAMT_launcher_armory append UAMT_launcher_at_ammoPool;
UAMT_launcher_armory append UAMT_launcher_aa_ammoPool;
UAMT_launcher_armory append UAMT_launcher_at_light_ammoPool;
UAMT_launcher_armory append UAMT_equipment_ar;
UAMT_launcher_armory append UAMT_facewear_Arm;

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_ammo_inv;

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_handgunAmmo_inv;	

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_at_ammo;	

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_aa_ammo;	

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_at_light_ammo;	

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_inv_u;

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_inv_v;

{
	UAMT_launcher_armory pushback (_x select 0);
} forEach UAMT_launcher_inv_b;

if ("AT" in UAMT_lrRoles || "AA" in UAMT_lrRoles || "AT-Light" in UAMT_lrRoles) then {
	UAMT_launcher_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	launcherAssis Equipment Array
//------------------------------------------------------------------
UAMT_launcherAssis_armory = [];
UAMT_launcherAssis_armory append UAMT_std_equipment;
UAMT_launcherAssis_armory append UAMT_std_weapons;
UAMT_launcherAssis_armory append UAMT_launcher_uniform;
UAMT_launcherAssis_armory append UAMT_launcher_vest;
UAMT_launcherAssis_armory append UAMT_launcher_UAMT_helmet;
UAMT_launcherAssis_armory append UAMT_launcher_backpack;
UAMT_launcherAssis_armory append [
	UAMT_launcher_rifle,
	UAMT_launcher_scope,
	UAMT_launcher_attachement1,
	UAMT_launcher_attachement2,
	UAMT_launcher_attachement3,
	UAMT_launcher_handgun,
	UAMT_launcher_handgun_scope,
	UAMT_launcher_handgun_attachement1,
	UAMT_launcher_handgun_attachement2,
	UAMT_launcher_UAMT_watch,
	UAMT_launcher_UAMT_map,
	UAMT_launcher_UAMT_compass,
	UAMT_launcher_UAMT_binocs,
	UAMT_launcher_terminal,
	UAMT_launcher_UAMT_radio,
	UAMT_nvg
];

UAMT_launcherAssis_armory append UAMT_launcher_at_ammoPool;
UAMT_launcherAssis_armory append UAMT_launcher_aa_ammoPool;
UAMT_launcherAssis_armory append UAMT_launcher_at_light_ammoPool;
UAMT_launcherAssis_armory append UAMT_equipment_ar;
UAMT_launcherAssis_armory append UAMT_facewear_Arm;

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach UAMT_launcher_ammo_inv;

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach UAMT_launcher_handgunAmmo_inv;	

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach UAMT_launcher_at_ammo;	

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach UAMT_launcher_aa_ammo;	

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach UAMT_launcher_at_light_ammo;

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_u;

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_v;

{
	UAMT_launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_b;

if ("AT-Assistant" in UAMT_lrRoles) then {
	UAMT_launcherAssis_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	medic Equipment Array
//------------------------------------------------------------------
UAMT_medic_armory = [];
UAMT_medic_armory append UAMT_std_equipment;
UAMT_medic_armory append UAMT_std_weapons;
UAMT_medic_armory append UAMT_medic_uniform;
UAMT_medic_armory append UAMT_medic_vest;
UAMT_medic_armory append UAMT_medic_UAMT_helmet;
UAMT_medic_armory append UAMT_medic_backpack;
UAMT_medic_armory append [
	UAMT_medic_rifle,
	UAMT_medic_scope,
	UAMT_medic_attachement1,
	UAMT_medic_attachement2,
	UAMT_medic_attachement3,
	UAMT_medic_handgun,
	UAMT_medic_handgun_scope,
	UAMT_medic_handgun_attachement1,
	UAMT_medic_handgun_attachement2,
	UAMT_medic_UAMT_watch,
	UAMT_medic_UAMT_map,
	UAMT_medic_UAMT_compass,
	UAMT_medic_UAMT_binocs,
	UAMT_medic_terminal,
	UAMT_medic_UAMT_radio,
	UAMT_nvg
];

UAMT_medic_armory append UAMT_medic_UAMT_equipment_ar;
UAMT_medic_armory append UAMT_equipment_ar;
UAMT_medic_armory append UAMT_facewear_Arm;

{
	UAMT_medic_armory pushback (_x select 0);
} forEach UAMT_medic_ammo_inv;

{
	UAMT_medic_armory pushback (_x select 0);
} forEach UAMT_medic_handgunAmmo_inv;	

{
	UAMT_medic_armory pushback (_x select 0);
} forEach UAMT_medic_inv_u;

{
	UAMT_medic_armory pushback (_x select 0);
} forEach UAMT_medic_inv_v;

{
	UAMT_medic_armory pushback (_x select 0);
} forEach UAMT_medic_inv_b;

if ("Medic" in UAMT_lrRoles) then {
	UAMT_medic_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	eod Equipment Array
//------------------------------------------------------------------
UAMT_eod_armory = [];
UAMT_eod_armory append UAMT_std_equipment;
UAMT_eod_armory append UAMT_std_weapons;
UAMT_eod_armory append UAMT_eod_uniform;
UAMT_eod_armory append UAMT_eod_vest;
UAMT_eod_armory append UAMT_eod_UAMT_helmet;
UAMT_eod_armory append UAMT_eod_backpack;
UAMT_eod_armory append [
	UAMT_eod_rifle,
	UAMT_eod_scope,
	UAMT_eod_attachement1,
	UAMT_eod_attachement2,
	UAMT_eod_attachement3,
	UAMT_eod_handgun,
	UAMT_eod_handgun_scope,
	UAMT_eod_handgun_attachement1,
	UAMT_eod_handgun_attachement2,
	UAMT_eod_UAMT_watch,
	UAMT_eod_UAMT_map,
	UAMT_eod_UAMT_compass,
	UAMT_eod_UAMT_binocs,
	UAMT_eod_terminal,
	UAMT_eod_UAMT_radio,
	UAMT_nvg
];

UAMT_eod_armory append UAMT_eod_explosive_pool;
UAMT_eod_armory append UAMT_eod_mines_pool;
UAMT_eod_armory append UAMT_eod_UAMT_equipment_ar;
UAMT_eod_armory append UAMT_equipment_ar;
UAMT_eod_armory append UAMT_facewear_Arm;

{
	UAMT_eod_armory pushback (_x select 0);
} forEach UAMT_eod_ammo_inv;

{
	UAMT_eod_armory pushback (_x select 0);
} forEach UAMT_eod_handgunAmmo_inv;	

{
	UAMT_eod_armory pushback (_x select 0);
} forEach UAMT_eod_inv_u;

{
	UAMT_eod_armory pushback (_x select 0);
} forEach UAMT_eod_inv_v;

{
	UAMT_eod_armory pushback (_x select 0);
} forEach UAMT_eod_inv_b;

if ("EOD" in UAMT_lrRoles) then {
	UAMT_eod_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	engineer Equipment Array
//------------------------------------------------------------------
UAMT_engineer_armory = [];
UAMT_engineer_armory append UAMT_std_equipment;
UAMT_engineer_armory append UAMT_std_weapons;
UAMT_engineer_armory append UAMT_engineer_uniform;
UAMT_engineer_armory append UAMT_engineer_vest;
UAMT_engineer_armory append UAMT_engineer_UAMT_helmet;
UAMT_engineer_armory append UAMT_engineer_backpack;
UAMT_engineer_armory append [
	UAMT_engineer_rifle,
	UAMT_engineer_scope,
	UAMT_engineer_attachement1,
	UAMT_engineer_attachement2,
	UAMT_engineer_attachement3,
	UAMT_engineer_handgun,
	UAMT_engineer_handgun_scope,
	UAMT_engineer_handgun_attachement1,
	UAMT_engineer_handgun_attachement2,
	UAMT_engineer_UAMT_watch,
	UAMT_engineer_UAMT_map,
	UAMT_engineer_UAMT_compass,
	UAMT_engineer_UAMT_binocs,
	UAMT_engineer_terminal,
	UAMT_engineer_UAMT_radio,
	UAMT_nvg
];

UAMT_engineer_armory append UAMT_engineer_UAMT_equipment_ar;
UAMT_engineer_armory append UAMT_equipment_ar;
UAMT_engineer_armory append UAMT_facewear_Arm;
	
{
	UAMT_engineer_armory pushback (_x select 0);
} forEach UAMT_engineer_ammo_inv;

{
	UAMT_engineer_armory pushback (_x select 0);
} forEach UAMT_engineer_handgunAmmo_inv;	

{
	UAMT_engineer_armory pushback (_x select 0);
} forEach UAMT_engineer_inv_u;

{
	UAMT_engineer_armory pushback (_x select 0);
} forEach UAMT_engineer_inv_v;

{
	UAMT_engineer_armory pushback (_x select 0);
} forEach UAMT_engineer_inv_b;

if ("Engineer" in UAMT_lrRoles) then {
	UAMT_engineer_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	jtac Equipment Array
//------------------------------------------------------------------
UAMT_jtac_armory = [];
UAMT_jtac_armory append UAMT_std_equipment;
UAMT_jtac_armory append UAMT_std_weapons;
UAMT_jtac_armory append UAMT_jtac_uniform;
UAMT_jtac_armory append UAMT_jtac_vest;
UAMT_jtac_armory append UAMT_jtac_UAMT_helmet;
UAMT_jtac_armory append UAMT_jtac_backpack;
UAMT_jtac_armory append [
	UAMT_jtac_rifle,
	UAMT_jtac_scope,
	UAMT_jtac_attachement1,
	UAMT_jtac_attachement2,
	UAMT_jtac_attachement3,
	UAMT_jtac_handgun,
	UAMT_jtac_handgun_scope,
	UAMT_jtac_handgun_attachement1,
	UAMT_jtac_handgun_attachement2,
	UAMT_jtac_UAMT_watch,
	UAMT_jtac_UAMT_map,
	UAMT_jtac_UAMT_compass,
	UAMT_jtac_UAMT_binocs,
	UAMT_jtac_terminal,
	UAMT_jtac_UAMT_radio,
	UAMT_nvg
];

UAMT_jtac_armory append UAMT_jtac_UAMT_equipment_ar;
UAMT_jtac_armory append UAMT_equipment_ar;
UAMT_jtac_armory append UAMT_facewear_Arm;

{
	UAMT_jtac_armory pushback (_x select 0);
} forEach UAMT_jtac_ammo_inv;

{
	UAMT_jtac_armory pushback (_x select 0);
} forEach UAMT_jtac_handgunAmmo_inv;	

{
	UAMT_jtac_armory pushback (_x select 0);
} forEach UAMT_jtac_inv_u;

{
	UAMT_jtac_armory pushback (_x select 0);
} forEach UAMT_jtac_inv_v;

{
	UAMT_jtac_armory pushback (_x select 0);
} forEach UAMT_jtac_inv_b;

if ("JTAC" in UAMT_lrRoles) then {
	UAMT_jtac_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	sql Equipment Array
//------------------------------------------------------------------
UAMT_sql_armory = [];
UAMT_sql_armory append UAMT_std_equipment;
UAMT_sql_armory append UAMT_std_weapons;
UAMT_sql_armory append UAMT_sql_uniform;
UAMT_sql_armory append UAMT_sql_vest;
UAMT_sql_armory append UAMT_sql_UAMT_helmet;
UAMT_sql_armory append UAMT_sql_backpack;
UAMT_sql_armory append [
	UAMT_sql_rifle,
	UAMT_sql_scope,
	UAMT_sql_attachement1,
	UAMT_sql_attachement2,
	UAMT_sql_attachement3,
	UAMT_sql_handgun,
	UAMT_sql_handgun_scope,
	UAMT_sql_handgun_attachement1,
	UAMT_sql_handgun_attachement2,
	UAMT_sql_UAMT_watch,
	UAMT_sql_UAMT_map,
	UAMT_sql_UAMT_compass,
	UAMT_sql_UAMT_binocs,
	UAMT_sql_terminal,
	UAMT_sql_UAMT_radio,
	UAMT_nvg
];

UAMT_sql_armory append UAMT_sql_UAMT_equipment_ar;
UAMT_sql_armory append UAMT_equipment_ar;
UAMT_sql_armory append UAMT_facewear_Arm;

{
	UAMT_sql_armory pushback (_x select 0);
} forEach UAMT_sql_ammo_inv;

{
	UAMT_sql_armory pushback (_x select 0);
} forEach UAMT_sql_handgunAmmo_inv;	

{
	UAMT_sql_armory pushback (_x select 0);
} forEach UAMT_sql_inv_u;

{
	UAMT_sql_armory pushback (_x select 0);
} forEach UAMT_sql_inv_v;

{
	UAMT_sql_armory pushback (_x select 0);
} forEach UAMT_sql_inv_b;

if ("Squadleader" in UAMT_lrRoles) then {
	UAMT_sql_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	gl Equipment Array
//------------------------------------------------------------------
UAMT_gl_armory = [];
UAMT_gl_armory append UAMT_std_equipment;
UAMT_gl_armory append UAMT_std_weapons;
UAMT_gl_armory append UAMT_gl_uniform;
UAMT_gl_armory append UAMT_gl_vest;
UAMT_gl_armory append UAMT_gl_UAMT_helmet;
UAMT_gl_armory append UAMT_gl_backpack;
UAMT_gl_armory append [
	UAMT_gl_rifle,
	UAMT_gl_scope,
	UAMT_gl_attachement1,
	UAMT_gl_attachement2,
	UAMT_gl_attachement3,
	UAMT_gl_handgun,
	UAMT_gl_handgun_scope,
	UAMT_gl_handgun_attachement1,
	UAMT_gl_handgun_attachement2,
	UAMT_gl_UAMT_watch,
	UAMT_gl_UAMT_map,
	UAMT_gl_UAMT_compass,
	UAMT_gl_UAMT_binocs,
	UAMT_gl_terminal,
	UAMT_gl_UAMT_radio,
	UAMT_nvg
];

UAMT_gl_armory append UAMT_gl_UAMT_equipment_ar;
UAMT_gl_armory append UAMT_equipment_ar;
UAMT_gl_armory append UAMT_facewear_Arm;
	
{
	UAMT_gl_armory pushback (_x select 0);
} forEach UAMT_gl_ammo_inv;

{
	UAMT_gl_armory pushback (_x select 0);
} forEach UAMT_gl_handgunAmmo_inv;	

{
	UAMT_gl_armory pushback (_x select 0);
} forEach UAMT_gl_inv_u;

{
	UAMT_gl_armory pushback (_x select 0);
} forEach UAMT_gl_inv_v;

{
	UAMT_gl_armory pushback (_x select 0);
} forEach UAMT_gl_inv_b;

if ("Groupleader" in UAMT_lrRoles) then {
	UAMT_gl_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	sniper Equipment Array
//------------------------------------------------------------------
UAMT_sniper_armory = [];
UAMT_sniper_armory append UAMT_std_equipment;
UAMT_sniper_armory append UAMT_std_weapons;
UAMT_sniper_armory append UAMT_sniper_uniform;
UAMT_sniper_armory append UAMT_sniper_vest;
UAMT_sniper_armory append UAMT_sniper_UAMT_helmet;
UAMT_sniper_armory append UAMT_sniper_backpack;
UAMT_sniper_armory append [
	UAMT_sniper_rifle,
	UAMT_sniper_scope,
	UAMT_sniper_attachement1,
	UAMT_sniper_attachement2,
	UAMT_sniper_attachement3,
	UAMT_sniper_handgun,
	UAMT_sniper_handgun_scope,
	UAMT_sniper_handgun_attachement1,
	UAMT_sniper_handgun_attachement2,
	UAMT_sniper_UAMT_watch,
	UAMT_sniper_UAMT_map,
	UAMT_sniper_UAMT_compass,
	UAMT_sniper_UAMT_binocs,
	UAMT_sniper_terminal,
	UAMT_sniper_UAMT_radio,
	UAMT_nvg
];

UAMT_sniper_armory append UAMT_sniper_UAMT_equipment_ar;
UAMT_sniper_armory append UAMT_facewear_Arm;

{
	UAMT_sniper_armory pushback (_x select 0);
} forEach UAMT_sniper_ammo_inv;

{
	UAMT_sniper_armory pushback (_x select 0);
} forEach UAMT_sniper_handgunAmmo_inv;	

{
	UAMT_sniper_armory pushback (_x select 0);
} forEach UAMT_sniper_inv_u;

{
	UAMT_sniper_armory pushback (_x select 0);
} forEach UAMT_sniper_inv_v;

{
	UAMT_sniper_armory pushback (_x select 0);
} forEach UAMT_sniper_inv_b;

if ("Sniper" in UAMT_lrRoles) then {
	UAMT_sniper_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	spotter Equipment Array
//------------------------------------------------------------------
UAMT_spotter_armory = [];
UAMT_spotter_armory append UAMT_std_equipment;
UAMT_spotter_armory append UAMT_std_weapons;
UAMT_spotter_armory append UAMT_dm_armory;
UAMT_spotter_armory append UAMT_spotter_uniform;
UAMT_spotter_armory append UAMT_spotter_vest;
UAMT_spotter_armory append UAMT_spotter_UAMT_helmet;
UAMT_spotter_armory append UAMT_spotter_backpack;
UAMT_spotter_armory append [
	UAMT_spotter_rifle,
	UAMT_spotter_scope,
	UAMT_spotter_attachement1,
	UAMT_spotter_attachement2,
	UAMT_spotter_attachement3,
	UAMT_spotter_handgun,
	UAMT_spotter_handgun_scope,
	UAMT_spotter_handgun_attachement1,
	UAMT_spotter_handgun_attachement2,
	UAMT_spotter_UAMT_watch,
	UAMT_spotter_UAMT_map,
	UAMT_spotter_UAMT_compass,
	UAMT_spotter_UAMT_binocs,
	UAMT_spotter_terminal,
	UAMT_spotter_UAMT_radio,
	UAMT_nvg
];

UAMT_spotter_armory append UAMT_spotter_UAMT_equipment_ar;
UAMT_spotter_armory append UAMT_facewear_Arm;

{
	UAMT_spotter_armory pushback (_x select 0);
} forEach UAMT_spotter_ammo_inv;

{
	UAMT_spotter_armory pushback (_x select 0);
} forEach UAMT_spotter_handgunAmmo_inv;	

{
	UAMT_spotter_armory pushback (_x select 0);
} forEach UAMT_spotter_inv_u;

{
	UAMT_spotter_armory pushback (_x select 0);
} forEach UAMT_spotter_inv_v;

{
	UAMT_spotter_armory pushback (_x select 0);
} forEach UAMT_spotter_inv_b;

if ("Spotter" in UAMT_lrRoles) then {
	UAMT_spotter_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	pilot Equipment Array
//------------------------------------------------------------------
UAMT_pilot_armory = [];
UAMT_pilot_armory append UAMT_pilot_uniform;
UAMT_pilot_armory append UAMT_pilot_vest;
UAMT_pilot_armory append UAMT_pilot_UAMT_helmet;
UAMT_pilot_armory append UAMT_pilot_backpack;
UAMT_pilot_armory append [
	UAMT_pilot_UAMT_facewear,
	UAMT_pilot_rifle,
	UAMT_pilot_scope,
	UAMT_pilot_attachement1,
	UAMT_pilot_attachement2,
	UAMT_pilot_attachement3,
	UAMT_pilot_handgun,
	UAMT_pilot_handgun_scope,
	UAMT_pilot_handgun_attachement1,
	UAMT_pilot_handgun_attachement2,
	UAMT_pilot_UAMT_watch,
	UAMT_pilot_UAMT_map,
	UAMT_pilot_UAMT_compass,
	UAMT_pilot_UAMT_binocs,
	UAMT_pilot_terminal,
	UAMT_pilot_UAMT_radio,
	UAMT_pilot_UAMT_nvg
];

UAMT_pilot_armory append UAMT_pilot_UAMT_equipment_ar;
UAMT_pilot_armory append UAMT_facewear_Arm;

{
	UAMT_pilot_armory pushback (_x select 0);
} forEach UAMT_pilot_ammo_inv;

{
	UAMT_pilot_armory pushback (_x select 0);
} forEach UAMT_pilot_handgunAmmo_inv;	

{
	UAMT_pilot_armory pushback (_x select 0);
} forEach UAMT_pilot_inv_u;

{
	UAMT_pilot_armory pushback (_x select 0);
} forEach UAMT_pilot_inv_v;

{
	UAMT_pilot_armory pushback (_x select 0);
} forEach UAMT_pilot_inv_b;

if ("Pilot" in UAMT_lrRoles) then {
	UAMT_pilot_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	fpilot Equipment Array
//------------------------------------------------------------------
UAMT_fpilot_armory = [];
UAMT_fpilot_armory append UAMT_fpilot_uniform;
UAMT_fpilot_armory append UAMT_fpilot_vest;
UAMT_fpilot_armory append UAMT_fpilot_UAMT_helmet;
UAMT_fpilot_armory append UAMT_fpilot_backpack;
UAMT_fpilot_armory append [
	UAMT_fpilot_UAMT_facewear,
	UAMT_fpilot_rifle,
	UAMT_fpilot_scope,
	UAMT_fpilot_attachement1,
	UAMT_fpilot_attachement2,
	UAMT_fpilot_attachement3,
	UAMT_fpilot_handgun,
	UAMT_fpilot_handgun_scope,
	UAMT_fpilot_handgun_attachement1,
	UAMT_fpilot_handgun_attachement2,
	UAMT_fpilot_UAMT_watch,
	UAMT_fpilot_UAMT_map,
	UAMT_fpilot_UAMT_compass,
	UAMT_fpilot_UAMT_binocs,
	UAMT_fpilot_terminal,
	UAMT_fpilot_UAMT_radio,
	UAMT_fpilot_UAMT_nvg,
	UAMT_fpilot_UAMT_equipment_ar,
	UAMT_facewear_Arm
];

UAMT_fpilot_armory append UAMT_fpilot_UAMT_equipment_ar;
UAMT_fpilot_armory append UAMT_facewear_Arm;

{
	UAMT_fpilot_armory pushback (_x select 0);
} forEach UAMT_fpilot_ammo_inv;

{
	UAMT_fpilot_armory pushback (_x select 0);
} forEach UAMT_fpilot_handgunAmmo_inv;	

{
	UAMT_fpilot_armory pushback (_x select 0);
} forEach UAMT_fpilot_inv_u;

{
	UAMT_fpilot_armory pushback (_x select 0);
} forEach UAMT_fpilot_inv_v;

{
	UAMT_fpilot_armory pushback (_x select 0);
} forEach UAMT_fpilot_inv_b;

if ("Fighter-Pilot" in UAMT_lrRoles) then {
	UAMT_fpilot_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//	crew Equipment Array
//------------------------------------------------------------------
UAMT_crew_armory = [];
UAMT_crew_armory append UAMT_crew_uniform;
UAMT_crew_armory append UAMT_crew_vest;
UAMT_crew_armory append UAMT_crew_UAMT_helmet;
UAMT_crew_armory append UAMT_crew_backpack;
UAMT_crew_armory append [
	UAMT_crew_UAMT_facewear,
	UAMT_crew_rifle,
	UAMT_crew_scope,
	UAMT_crew_attachement1,
	UAMT_crew_attachement2,
	UAMT_crew_attachement3,
	UAMT_crew_handgun,
	UAMT_crew_handgun_scope,
	UAMT_crew_handgun_attachement1,
	UAMT_crew_handgun_attachement2,
	UAMT_crew_UAMT_watch,
	UAMT_crew_UAMT_map,
	UAMT_crew_UAMT_compass,
	UAMT_crew_UAMT_binocs,
	UAMT_crew_terminal,
	UAMT_crew_UAMT_radio,
	UAMT_crew_UAMT_nvg
];

UAMT_crew_armory append UAMT_crew_UAMT_equipment_ar;
UAMT_crew_armory append UAMT_facewear_Arm;

{
	UAMT_crew_armory pushback (_x select 0);
} forEach UAMT_crew_ammo_inv;

{
	UAMT_crew_armory pushback (_x select 0);
} forEach UAMT_crew_handgunAmmo_inv;	

{
	UAMT_crew_armory pushback (_x select 0);
} forEach UAMT_crew_inv_u;

{
	UAMT_crew_armory pushback (_x select 0);
} forEach UAMT_crew_inv_v;

{
	UAMT_crew_armory pushback (_x select 0);
} forEach UAMT_crew_inv_b;

if ("crew" in UAMT_lrRoles) then {
	UAMT_crew_armory pushBack UAMT_lrRadio;
};


//------------------------------------------------------------------
//	diver Equipment Array
//------------------------------------------------------------------
UAMT_diver_armory = [];
UAMT_diver_armory append UAMT_diver_uniform;
UAMT_diver_armory append UAMT_diver_vest;
UAMT_diver_armory append UAMT_diver_UAMT_helmet;
UAMT_diver_armory append UAMT_diver_backpack;
UAMT_diver_armory append UAMT_diver_UAMT_facewear;
UAMT_diver_armory append [
	UAMT_diver_rifle,
	UAMT_diver_scope,
	UAMT_diver_attachement1,
	UAMT_diver_attachement2,
	UAMT_diver_attachement3,
	UAMT_diver_handgun,
	UAMT_diver_handgun_scope,
	UAMT_diver_handgun_attachement1,
	UAMT_diver_handgun_attachement2,
	UAMT_diver_UAMT_watch,
	UAMT_diver_UAMT_map,
	UAMT_diver_UAMT_compass,
	UAMT_diver_UAMT_binocs,
	UAMT_diver_terminal,
	UAMT_diver_UAMT_radio,
	UAMT_diver_UAMT_nvg,
	UAMT_diver_UAMT_equipment_ar
];
	
{
	UAMT_diver_armory pushback (_x select 0);
} forEach UAMT_diver_ammo_inv;

{
	UAMT_diver_armory pushback (_x select 0);
} forEach UAMT_diver_handgunAmmo_inv;	

{
	UAMT_diver_armory pushback (_x select 0);
} forEach UAMT_diver_inv_u;

{
	UAMT_diver_armory pushback (_x select 0);
} forEach UAMT_diver_inv_v;

{
	UAMT_diver_armory pushback (_x select 0);
} forEach UAMT_diver_inv_b;

if ("Diver-Rifleman" in UAMT_lrRoles) then {
	UAMT_diver_armory pushBack UAMT_lrRadio;
};

if ("Diver-Groupleader" in UAMT_lrRoles) then {
	UAMT_diver_armory pushBack UAMT_lrRadio;
};

diverUAMT_eod_armory = [];
diverUAMT_eod_armory append UAMT_diver_armory;

{
	diverUAMT_eod_armory pushback (_x select 0);
} forEach diverUAMT_eod_inv_u;

{
	diverUAMT_eod_armory pushback (_x select 0);
} forEach diverUAMT_eod_inv_v;

{
	diverUAMT_eod_armory pushback (_x select 0);
} forEach diverUAMT_eod_inv_b;

if ("Diver-EOD" in UAMT_lrRoles) then {
	diverUAMT_eod_armory pushBack UAMT_lrRadio;
};

diverUAMT_medic_armory = [];
diverUAMT_medic_armory append UAMT_diver_armory;

{
	diverUAMT_medic_armory pushback (_x select 0);
} forEach diverUAMT_medic_inv_u;

{
	diverUAMT_medic_armory pushback (_x select 0);
} forEach diverUAMT_medic_inv_v;

{
	diverUAMT_medic_armory pushback (_x select 0);
} forEach diverUAMT_medic_inv_b;

if ("Diver-Medic" in UAMT_lrRoles) then {
	diverUAMT_medic_armory pushBack UAMT_lrRadio;
};

//------------------------------------------------------------------
//
//	Supply Crates
//
//------------------------------------------------------------------
_crateLimit = 600;
//------------------------------------------------------------------
//	Ammo Crate
//------------------------------------------------------------------
ammoCrateArr = [];

//Primary Mag load - Alway takes the first Mag Type from the UAMT_std_rifleAmmo_inv array
_mag = (UAMT_std_rifleAmmo_inv select 0) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (500 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

_mag = (UAMT_std_handgunAmmo_inv select 0) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (100 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

//------------------------------------------------------------------
// 	Heavy Ammo Crate
//------------------------------------------------------------------
heavyammoCrateArr = [];

_div = 0;

if (count UAMT_mg_ammo_inv >= 1) then {
	_div = _div + 1;
};

if (count UAMT_autorifle_ammo_inv >= 1) then {
	_div = _div + 1;
};

if (count UAMT_dm_ammo_inv >= 1) then {
	_div = _div + 1;
};

_loadMass = _crateLimit / _div;

if (count UAMT_mg_ammo_inv >= 1) then {
	_mag = (UAMT_mg_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if (count UAMT_autorifle_ammo_inv >= 1) then {
	_mag = (UAMT_autorifle_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if (count UAMT_dm_ammo_inv >= 1) then {
	_mag = (UAMT_dm_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

//------------------------------------------------------------------
// 	Grenades Ammo Crate
//------------------------------------------------------------------

grenadeCrateArr = [];

_div = count UAMT_throwablesStd + count UAMT_throwablesExt;

_loadMass = floor (400 / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach UAMT_throwablesStd;

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach UAMT_throwablesExt;


_div = count UAMT_grenadier_UUAMT_gl_Pool;

_loadMass = floor (200 / _div);

{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach UAMT_grenadier_UUAMT_gl_Pool;

//------------------------------------------------------------------
// 	AT Missile Ammo Crate
//------------------------------------------------------------------
atMissileCrateArr = [];

_div = 	count UAMT_launcher_at_ammo + count UAMT_launcher_at_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach UAMT_launcher_at_ammo;

{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach UAMT_launcher_at_ammoPool;


//------------------------------------------------------------------
// 	AA Missile Ammo Crate
//------------------------------------------------------------------
aaMissileCrateArr = [];

_div = 	count UAMT_launcher_aa_ammo + count UAMT_launcher_aa_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach UAMT_launcher_aa_ammo;


{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach UAMT_launcher_aa_ammoPool;

//------------------------------------------------------------------
// 	AT-Light Missile Ammo Crate
//------------------------------------------------------------------
atLightCrateArr = [];

if (UAMT_launcher_at_light != "") then {
	if (_lightATdispenseble) then {
		_magMass = getNumber (configFile >> "CfgWeapons" >> UAMT_launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (600 / _magMass);
		
		atLightCrateArr append [[UAMT_launcher_at_light,_loaditems]];
	}
	else
	{
		_magMass = getNumber (configFile >> "CfgWeapons" >> UAMT_launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (300 / _magMass);
		
		atLightCrateArr append [[UAMT_launcher_at_light,_loaditems]];
		
		_atLightAmmoArr = UAMT_launcher_at_light_ammoPool;
		
		{
			_atLightAmmoArr pushback (_x select 0);
		} forEach UAMT_launcher_at_light_ammo;

		_div = 	count _atLightAmmoArr;

		_loadMass = floor (_crateLimit / _div);
		
		{
			atLightCrateArr append [[_x,_loaditems]];
		} forEach _atLightAmmoArr;
	};
};


//------------------------------------------------------------------
// 	Medic Supplies
//------------------------------------------------------------------
medicCrateArr = [];
_sanCollected = [];

_sanCollected append UAMT_UAMT_san_t1_b;
_sanCollected append UAMT_san_t1_v;
_sanCollected append UAMT_san_t1_b;
_sanCollected append UAMT_san_t2_u;
_sanCollected append UAMT_san_t2_v;
_sanCollected append UAMT_san_t2_b;

{
	medicCrateArr append [[_x select 0,(_x select 1) * 2]];
}forEach _sanCollected;

//------------------------------------------------------------------
// 	UAMT_explosives Supplies
//------------------------------------------------------------------
explosivesCrateArr = [];

_div = count UAMT_eod_explosive_pool;
_itemMass = 0;
_loadItems = 0;
_loadMass = floor (600 / _div);

{
	if (isClass (configFile >> "CfgVehicles" >> _x)) then {
		if (getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass") != 0) then {
			_itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass");
			
			_loadItems = floor (_loadMass / _itemMass);
		}
		else {
			if (getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass") != 0) then {
				_itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass");
				
				_loadItems = floor (_loadMass / _itemMass);
			};
		};
	}
	else {
		if (isClass (configFile >> "CfgMagazines" >> _x)) then {
			_itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
			_loadItems = floor (_loadMass / _itemMass);
		};
	};
	
	explosivesCrateArr append [[_x,_loadItems]];
}forEach UAMT_eod_explosive_pool;

//------------------------------------------------------------------
// 	Mines Supplies
//------------------------------------------------------------------
minesCrateArr = [];
_loadItems = 0;
_div = count UAMT_eod_mines_pool;

_loadMass = floor (600 / _div);

{
	_itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
	_loadItems = floor (_loadMass / _itemMass);
	minesCrateArr append [[_x,_loadItems]];
}forEach UAMT_eod_mines_pool;


//------------------------------------------------------------------
//
//	Push Public Variables
//
//------------------------------------------------------------------

publicVariable "UAMT_uniforms";
publicVariable "UAMT_helmet";
publicVariable "UAMT_vests";
publicVariable "UAMT_facewear";

publicVariable "UAMT_backpack_std";
publicVariable "UAMT_backpack_med";
publicVariable "UAMT_backpack_big";

publicVariable "UAMT_watch";
publicVariable "UAMT_map";
publicVariable "UAMT_compass";
publicVariable "UAMT_binocs";

publicVariable "UAMT_terminal_t1";
publicVariable "UAMT_terminal_t2";
publicVariable "UAMT_terminal_t3";

publicVariable "UAMT_nvg";
publicVariable "UAMT_radio";
publicVariable "UAMT_lrAvailable";
publicVariable "UAMT_lrRoles";
publicVariable "UAMT_lrRadio";

publicVariable "UAMT_san_t0_u";
publicVariable "UAMT_san_t0_v";
publicVariable "UAMT_san_t0_b";
publicVariable "UAMT_UAMT_san_t1_b";
publicVariable "UAMT_san_t1_v";
publicVariable "UAMT_san_t1_b";
publicVariable "UAMT_san_t2_u";
publicVariable "UAMT_san_t2_v";
publicVariable "UAMT_san_t2_b";

publicVariable "UAMT_invStd_u";
publicVariable "UAMT_invStd_v";
publicVariable "UAMT_invStd_b";

publicVariable "UAMT_throwablesStd";
publicVariable "UAMT_throwablesExt";

publicVariable "UAMT_std_rifle";
publicVariable "UAMT_std_scope";
publicVariable "std_attachement1";
publicVariable "std_attachement2";
publicVariable "std_attachement3";
publicVariable "UAMT_std_rifleAmmo_inv";

publicVariable "UAMT_std_handgun";
publicVariable "UAMT_std_handgun_scope";
publicVariable "UAMT_std_handgun_attachment1";
publicVariable "UAMT_std_handgun_attachment2";
publicVariable "UAMT_std_handgunAmmo_inv";

publicVariable "UAMT_UAMT_std_weapons_alt";

publicVariable "UAMT_UAMT_rifleman_uniform";
publicVariable "UAMT_UAMT_rifleman_vest";
publicVariable "UAMT_UAMT_rifleman_UAMT_helmet";
publicVariable "UAMT_rifleman_backpack";
publicVariable "UAMT_rifleman_rifle";
publicVariable "UAMT_rifleman_scope";
publicVariable "UAMT_rifleman_attachement1";
publicVariable "UAMT_rifleman_attachement2";
publicVariable "UAMT_rifleman_attachement3";
publicVariable "UAMT_rifleman_ammo_inv";
publicVariable "UAMT_rifleman_handgun";
publicVariable "UAMT_rifleman_handgun_scope";
publicVariable "UAMT_rifleman_handgun_attachement1";
publicVariable "UAMT_rifleman_handgun_attachement2";
publicVariable "UAMT_rifleman_handgunAmmo_inv";
publicVariable "UAMT_rifleman_UAMT_watch";
publicVariable "UAMT_rifleman_UAMT_map";
publicVariable "UAMT_rifleman_UAMT_compass";
publicVariable "UAMT_rifleman_UAMT_binocs";
publicVariable "UAMT_rifleman_terminal";
publicVariable "UAMT_rifleman_UAMT_radio";
publicVariable "UAMT_rifleman_inv_u";
publicVariable "UAMT_rifleman_inv_v";
publicVariable "UAMT_rifleman_inv_b";
publicVariable "UAMT_rifleman_UAMT_equipment_ar";

publicVariable "UAMT_grenadier_uniform";
publicVariable "UAMT_grenadier_vest";
publicVariable "UAMT_grenadier_UAMT_helmet";
publicVariable "UAMT_grenadier_backpack";
publicVariable "UAMT_grenadier_rifle";
publicVariable "UAMT_grenadier_scope";
publicVariable "UAMT_grenadier_attachement1";
publicVariable "UAMT_grenadier_attachement2";
publicVariable "UAMT_grenadier_attachement3";
publicVariable "UAMT_grenadier_ammo_inv";
publicVariable "UAMT_grenadier_handgun";
publicVariable "UAMT_grenadier_handgun_scope";
publicVariable "UAMT_grenadier_handgun_attachement1";
publicVariable "UAMT_grenadier_handgun_attachement2";
publicVariable "UAMT_grenadier_handgunAmmo_inv";
publicVariable "UAMT_grenadier_UUAMT_gl_inv";
publicVariable "UAMT_grenadier_UAMT_watch";
publicVariable "UAMT_grenadier_UAMT_map";
publicVariable "UAMT_grenadier_UAMT_compass";
publicVariable "UAMT_grenadier_UAMT_binocs";
publicVariable "UAMT_grenadier_terminal";
publicVariable "UAMT_grenadier_UAMT_radio";
publicVariable "UAMT_grenadier_inv_u";
publicVariable "UAMT_grenadier_inv_v";
publicVariable "UAMT_grenadier_inv_b";
publicVariable "UAMT_grenadier_UAMT_equipment_ar";

publicVariable "UAMT_mg_uniform";
publicVariable "UAMT_mg_vest";
publicVariable "UAMT_mg_UAMT_helmet";
publicVariable "UAMT_mg_backpack";
publicVariable "UAMT_mg_rifle";
publicVariable "UAMT_mg_scope";
publicVariable "UAMT_mg_attachement1";
publicVariable "UAMT_mg_attachement2";
publicVariable "UAMT_mg_attachement3";
publicVariable "UAMT_mg_ammo_inv";
publicVariable "UAMT_mg_handgun";
publicVariable "UAMT_mg_handgun_scope";
publicVariable "UAMT_mg_handgun_attachement1";
publicVariable "UAMT_mg_handgun_attachement2";
publicVariable "UAMT_mg_handgunAmmo_inv";
publicVariable "UAMT_mg_UAMT_watch";
publicVariable "UAMT_mg_UAMT_map";
publicVariable "UAMT_mg_UAMT_compass";
publicVariable "UAMT_mg_UAMT_binocs";
publicVariable "UAMT_mg_terminal";
publicVariable "UAMT_mg_UAMT_radio";
publicVariable "UAMT_mg_inv_u";
publicVariable "UAMT_mg_inv_v";
publicVariable "UAMT_mg_inv_b";
publicVariable "UAMT_mg_UAMT_equipment_ar";

publicVariable "UAMT_mgAssis_uniform";
publicVariable "UAMT_mgAssis_vest";
publicVariable "UAMT_mgAssis_UAMT_helmet";
publicVariable "UAMT_mgAssis_backpack";
publicVariable "UAMT_mgAssis_rifle";
publicVariable "UAMT_mgAssis_scope";
publicVariable "UAMT_mgAssis_attachement1";
publicVariable "UAMT_mgAssis_attachement2";
publicVariable "UAMT_mgAssis_attachement3";
publicVariable "UAMT_mgAssis_ammo_inv";
publicVariable "UAMT_mgAssis_handgun";
publicVariable "UAMT_mgAssis_handgun_scope";
publicVariable "UAMT_mgAssis_handgun_attachement1";
publicVariable "UAMT_mgAssis_handgun_attachement2";
publicVariable "UAMT_mgAssis_handgunAmmo_inv";
publicVariable "UAMT_mgAssis_UAMT_watch";
publicVariable "UAMT_mgAssis_UAMT_map";
publicVariable "UAMT_mgAssis_UAMT_compass";
publicVariable "UAMT_mgAssis_UAMT_binocs";
publicVariable "UAMT_mgAssis_terminal";
publicVariable "UAMT_mgAssis_UAMT_radio";
publicVariable "UAMT_mgAssis_inv_u";
publicVariable "UAMT_mgAssis_inv_v";
publicVariable "UAMT_mgAssis_inv_b";
publicVariable "UAMT_mgAssis_UAMT_equipment_ar";

publicVariable "UAMT_autorifle_uniform";
publicVariable "UAMT_autorifle_vest";
publicVariable "UAMT_autorifle_UAMT_helmet";
publicVariable "UAMT_autorifle_backpack";
publicVariable "UAMT_autorifle_rifle";
publicVariable "UAMT_autorifle_scope";
publicVariable "UAMT_autorifle_attachement1";
publicVariable "UAMT_autorifle_attachement2";
publicVariable "UAMT_autorifle_attachement3";
publicVariable "UAMT_autorifle_ammo_inv";
publicVariable "UAMT_autorifle_handgun";
publicVariable "UAMT_autorifle_handgun_scope";
publicVariable "UAMT_autorifle_handgun_attachement1";
publicVariable "UAMT_autorifle_handgun_attachement2";
publicVariable "UAMT_autorifle_handgunAmmo_inv";
publicVariable "UAMT_autorifle_UAMT_watch";
publicVariable "UAMT_autorifle_UAMT_map";
publicVariable "UAMT_autorifle_UAMT_compass";
publicVariable "UAMT_autorifle_UAMT_binocs";
publicVariable "UAMT_autorifle_terminal";
publicVariable "UAMT_autorifle_UAMT_radio";
publicVariable "UAMT_autorifle_inv_u";
publicVariable "UAMT_autorifle_inv_v";
publicVariable "UAMT_autorifle_inv_b";
publicVariable "UAMT_autorifle_UAMT_equipment_ar";

publicVariable "UAMT_dm_uniform";
publicVariable "UAMT_dm_vest";
publicVariable "UAMT_dm_UAMT_helmet";
publicVariable "UAMT_dm_backpack";
publicVariable "UAMT_dm_rifle";
publicVariable "UAMT_dm_scope";
publicVariable "UAMT_dm_attachement1";
publicVariable "UAMT_dm_attachement2";
publicVariable "UAMT_dm_attachement3";
publicVariable "UAMT_dm_ammo_inv";
publicVariable "UAMT_dm_handgun";
publicVariable "UAMT_dm_handgun_scope";
publicVariable "UAMT_dm_handgun_attachement1";
publicVariable "UAMT_dm_handgun_attachement2";
publicVariable "UAMT_dm_handgunAmmo_inv";
publicVariable "UAMT_dm_UAMT_watch";
publicVariable "UAMT_dm_UAMT_map";
publicVariable "UAMT_dm_UAMT_compass";
publicVariable "UAMT_dm_UAMT_binocs";
publicVariable "UAMT_dm_terminal";
publicVariable "UAMT_dm_UAMT_radio";
publicVariable "UAMT_dm_inv_u";
publicVariable "UAMT_dm_inv_v";
publicVariable "UAMT_dm_inv_b";
publicVariable "UAMT_dm_UAMT_equipment_ar";

publicVariable "UAMT_launcher_uniform";
publicVariable "UAMT_launcher_vest";
publicVariable "UAMT_launcher_UAMT_helmet";
publicVariable "UAMT_launcher_backpack";
publicVariable "UAMT_launcher_rifle";
publicVariable "UAMT_launcher_scope";
publicVariable "UAMT_launcher_attachement1";
publicVariable "UAMT_launcher_attachement2";
publicVariable "UAMT_launcher_attachement3";
publicVariable "UAMT_launcher_ammo_inv";
publicVariable "UAMT_launcher_handgun";
publicVariable "UAMT_launcher_handgun_scope";
publicVariable "UAMT_launcher_handgun_attachement1";
publicVariable "UAMT_launcher_handgun_attachement2";
publicVariable "UAMT_launcher_handgunAmmo_inv";

publicVariable "UAMT_launcher_at";
publicVariable "UAMT_launcher_at_attachement1";
publicVariable "UAMT_launcher_at_attachement2";
publicVariable "UAMT_launcher_at_attachement3";
publicVariable "UAMT_launcher_at_ammo";

publicVariable "UAMT_launcher_aa";
publicVariable "UAMT_launcher_aa_attachement1";
publicVariable "UAMT_launcher_aa_attachement2";
publicVariable "UAMT_launcher_aa_attachement3";
publicVariable "UAMT_launcher_aa_ammo";

publicVariable "UAMT_launcher_at_light";
publicVariable "UAMT_launcher_at_light_attachement1";
publicVariable "UAMT_launcher_at_light_attachement2";
publicVariable "UAMT_launcher_at_light_attachement3";
publicVariable "UAMT_launcher_at_light_ammo";

publicVariable "UAMT_launcher_UAMT_watch";
publicVariable "UAMT_launcher_UAMT_map";
publicVariable "UAMT_launcher_UAMT_compass";
publicVariable "UAMT_launcher_UAMT_binocs";
publicVariable "UAMT_launcher_terminal";
publicVariable "UAMT_launcher_UAMT_radio";
publicVariable "UAMT_launcher_inv_u";
publicVariable "UAMT_launcher_inv_v";
publicVariable "UAMT_launcher_inv_b";
publicVariable "UAMT_launcher_UAMT_equipment_ar";

publicVariable "UAMT_launcher_ammo_pool";

publicVariable "UAMT_eod_uniform";
publicVariable "UAMT_eod_vest";
publicVariable "UAMT_eod_UAMT_helmet";
publicVariable "UAMT_eod_backpack";
publicVariable "UAMT_eod_rifle";
publicVariable "UAMT_eod_scope";
publicVariable "UAMT_eod_attachement1";
publicVariable "UAMT_eod_attachement2";
publicVariable "UAMT_eod_attachement3";
publicVariable "UAMT_eod_ammo_inv";
publicVariable "UAMT_eod_handgun";
publicVariable "UAMT_eod_handgun_scope";
publicVariable "UAMT_eod_handgun_attachement1";
publicVariable "UAMT_eod_handgun_attachement2";
publicVariable "UAMT_eod_handgunAmmo_inv";
publicVariable "UAMT_eod_UAMT_watch";
publicVariable "UAMT_eod_UAMT_map";
publicVariable "UAMT_eod_UAMT_compass";
publicVariable "UAMT_eod_UAMT_binocs";
publicVariable "UAMT_eod_terminal";
publicVariable "UAMT_eod_UAMT_radio";
publicVariable "UAMT_eod_inv_u";
publicVariable "UAMT_eod_inv_v";
publicVariable "UAMT_eod_inv_b";
publicVariable "UAMT_eod_UAMT_equipment_ar";

publicVariable "UAMT_engineer_uniform";
publicVariable "UAMT_engineer_vest";
publicVariable "UAMT_engineer_UAMT_helmet";
publicVariable "UAMT_engineer_backpack";
publicVariable "UAMT_engineer_rifle";
publicVariable "UAMT_engineer_scope";
publicVariable "UAMT_engineer_attachement1";
publicVariable "UAMT_engineer_attachement2";
publicVariable "UAMT_engineer_attachement3";
publicVariable "UAMT_engineer_ammo_inv";
publicVariable "UAMT_engineer_handgun";
publicVariable "UAMT_engineer_handgun_scope";
publicVariable "UAMT_engineer_handgun_attachement1";
publicVariable "UAMT_engineer_handgun_attachement2";
publicVariable "UAMT_engineer_handgunAmmo_inv";
publicVariable "UAMT_engineer_UAMT_watch";
publicVariable "UAMT_engineer_UAMT_map";
publicVariable "UAMT_engineer_UAMT_compass";
publicVariable "UAMT_engineer_UAMT_binocs";
publicVariable "UAMT_engineer_terminal";
publicVariable "UAMT_engineer_UAMT_radio";
publicVariable "UAMT_engineer_inv_u";
publicVariable "UAMT_engineer_inv_v";
publicVariable "UAMT_engineer_inv_b";
publicVariable "UAMT_engineer_UAMT_equipment_ar";

publicVariable "UAMT_jtac_uniform";
publicVariable "UAMT_jtac_vest";
publicVariable "UAMT_jtac_UAMT_helmet";
publicVariable "UAMT_jtac_backpack";
publicVariable "UAMT_jtac_rifle";
publicVariable "UAMT_jtac_scope";
publicVariable "UAMT_jtac_attachement1";
publicVariable "UAMT_jtac_attachement2";
publicVariable "UAMT_jtac_attachement3";
publicVariable "UAMT_jtac_ammo_inv";
publicVariable "UAMT_jtac_handgun";
publicVariable "UAMT_jtac_handgun_scope";
publicVariable "UAMT_jtac_handgun_attachement1";
publicVariable "UAMT_jtac_handgun_attachement2";
publicVariable "UAMT_jtac_handgunAmmo_inv";
publicVariable "UAMT_jtac_UAMT_watch";
publicVariable "UAMT_jtac_UAMT_map";
publicVariable "UAMT_jtac_UAMT_compass";
publicVariable "UAMT_jtac_UAMT_binocs";
publicVariable "UAMT_jtac_terminal";
publicVariable "UAMT_jtac_UAMT_radio";
publicVariable "UAMT_jtac_inv_u";
publicVariable "UAMT_jtac_inv_v";
publicVariable "UAMT_jtac_inv_b";
publicVariable "UAMT_jtac_UAMT_equipment_ar";

publicVariable "UAMT_sql_uniform";
publicVariable "UAMT_sql_vest";
publicVariable "UAMT_sql_UAMT_helmet";
publicVariable "UAMT_sql_backpack";
publicVariable "UAMT_sql_rifle";
publicVariable "UAMT_sql_scope";
publicVariable "UAMT_sql_attachement1";
publicVariable "UAMT_sql_attachement2";
publicVariable "UAMT_sql_attachement3";
publicVariable "UAMT_sql_ammo_inv";
publicVariable "UAMT_sql_handgun";
publicVariable "UAMT_sql_handgun_scope";
publicVariable "UAMT_sql_handgun_attachement1";
publicVariable "UAMT_sql_handgun_attachement2";
publicVariable "UAMT_sql_handgunAmmo_inv";
publicVariable "UAMT_sql_UAMT_watch";
publicVariable "UAMT_sql_UAMT_map";
publicVariable "UAMT_sql_UAMT_compass";
publicVariable "UAMT_sql_UAMT_binocs";
publicVariable "UAMT_sql_terminal";
publicVariable "UAMT_sql_UAMT_radio";
publicVariable "UAMT_sql_inv_u";
publicVariable "UAMT_sql_inv_v";
publicVariable "UAMT_sql_inv_b";
publicVariable "UAMT_sql_UAMT_equipment_ar";

publicVariable "UAMT_gl_uniform";
publicVariable "UAMT_gl_vest";
publicVariable "UAMT_gl_UAMT_helmet";
publicVariable "UAMT_gl_backpack";
publicVariable "UAMT_gl_rifle";
publicVariable "UAMT_gl_scope";
publicVariable "UAMT_gl_attachement1";
publicVariable "UAMT_gl_attachement2";
publicVariable "UAMT_gl_attachement3";
publicVariable "UAMT_gl_ammo_inv";
publicVariable "UAMT_gl_handgun";
publicVariable "UAMT_gl_handgun_scope";
publicVariable "UAMT_gl_handgun_attachement1";
publicVariable "UAMT_gl_handgun_attachement2";
publicVariable "UAMT_gl_handgunAmmo_inv";
publicVariable "UAMT_gl_UAMT_watch";
publicVariable "UAMT_gl_UAMT_map";
publicVariable "UAMT_gl_UAMT_compass";
publicVariable "UAMT_gl_UAMT_binocs";
publicVariable "UAMT_gl_terminal";
publicVariable "UAMT_gl_UAMT_radio";
publicVariable "UAMT_gl_inv_u";
publicVariable "UAMT_gl_inv_v";
publicVariable "UAMT_gl_inv_b";
publicVariable "UAMT_gl_UAMT_equipment_ar";

publicVariable "UAMT_sniper_uniform";
publicVariable "UAMT_sniper_vest";
publicVariable "UAMT_sniper_UAMT_helmet";
publicVariable "UAMT_sniper_backpack";
publicVariable "UAMT_sniper_rifle";
publicVariable "UAMT_sniper_scope";
publicVariable "UAMT_sniper_attachement1";
publicVariable "UAMT_sniper_attachement2";
publicVariable "UAMT_sniper_attachement3";
publicVariable "UAMT_sniper_ammo_inv";
publicVariable "UAMT_sniper_handgun";
publicVariable "UAMT_sniper_handgun_scope";
publicVariable "UAMT_sniper_handgun_attachement1";
publicVariable "UAMT_sniper_handgun_attachement2";
publicVariable "UAMT_sniper_handgunAmmo_inv";
publicVariable "UAMT_sniper_UUAMT_sniper_inv";
publicVariable "UAMT_sniper_UAMT_watch";
publicVariable "UAMT_sniper_UAMT_map";
publicVariable "UAMT_sniper_UAMT_compass";
publicVariable "UAMT_sniper_UAMT_binocs";
publicVariable "UAMT_sniper_terminal";
publicVariable "UAMT_sniper_UAMT_radio";
publicVariable "UAMT_sniper_inv_u";
publicVariable "UAMT_sniper_inv_v";
publicVariable "UAMT_sniper_inv_b";
publicVariable "UAMT_sniper_UAMT_equipment_ar";

publicVariable "UAMT_spotter_uniform";
publicVariable "UAMT_spotter_vest";
publicVariable "UAMT_spotter_UAMT_helmet";
publicVariable "UAMT_spotter_backpack";
publicVariable "UAMT_spotter_rifle";
publicVariable "UAMT_spotter_scope";
publicVariable "UAMT_spotter_attachement1";
publicVariable "UAMT_spotter_attachement2";
publicVariable "UAMT_spotter_attachement3";
publicVariable "UAMT_spotter_ammo_inv";
publicVariable "UAMT_spotter_handgun";
publicVariable "UAMT_spotter_handgun_scope";
publicVariable "UAMT_spotter_handgun_attachement1";
publicVariable "UAMT_spotter_handgun_attachement2";
publicVariable "UAMT_spotter_handgunAmmo_inv";
publicVariable "UAMT_spotter_UAMT_watch";
publicVariable "UAMT_spotter_UAMT_map";
publicVariable "UAMT_spotter_UAMT_compass";
publicVariable "UAMT_spotter_UAMT_binocs";
publicVariable "UAMT_spotter_terminal";
publicVariable "UAMT_spotter_UAMT_radio";
publicVariable "UAMT_spotter_inv_u";
publicVariable "UAMT_spotter_inv_v";
publicVariable "UAMT_spotter_inv_b";
publicVariable "UAMT_spotter_UAMT_equipment_ar";

publicVariable "UAMT_pilot_uniform";
publicVariable "UAMT_pilot_vest";
publicVariable "UAMT_pilot_UAMT_helmet";
publicVariable "UAMT_pilot_backpack";
publicVariable "UAMT_pilot_UAMT_facewear";
publicVariable "UAMT_pilot_rifle";
publicVariable "UAMT_pilot_scope";
publicVariable "UAMT_pilot_attachement1";
publicVariable "UAMT_pilot_attachement2";
publicVariable "UAMT_pilot_attachement3";
publicVariable "UAMT_pilot_ammo_inv";
publicVariable "UAMT_pilot_handgun";
publicVariable "UAMT_pilot_handgun_scope";
publicVariable "UAMT_pilot_handgun_attachement1";
publicVariable "UAMT_pilot_handgun_attachement2";
publicVariable "UAMT_pilot_handgunAmmo_inv";
publicVariable "UAMT_pilot_UAMT_watch";
publicVariable "UAMT_pilot_UAMT_map";
publicVariable "UAMT_pilot_UAMT_compass";
publicVariable "UAMT_pilot_UAMT_binocs";
publicVariable "UAMT_pilot_terminal";
publicVariable "UAMT_pilot_UAMT_radio";
publicVariable "UAMT_pilot_UAMT_nvg";
publicVariable "UAMT_pilot_inv_u";
publicVariable "UAMT_pilot_inv_v";
publicVariable "UAMT_pilot_inv_b";
publicVariable "UAMT_pilot_UAMT_equipment_ar";

publicVariable "UAMT_fpilot_uniform";
publicVariable "UAMT_fpilot_vest";
publicVariable "UAMT_fpilot_UAMT_helmet";
publicVariable "UAMT_fpilot_backpack";
publicVariable "UAMT_fpilot_UAMT_facewear";
publicVariable "UAMT_fpilot_rifle";
publicVariable "UAMT_fpilot_scope";
publicVariable "UAMT_fpilot_attachement1";
publicVariable "UAMT_fpilot_attachement2";
publicVariable "UAMT_fpilot_attachement3";
publicVariable "UAMT_fpilot_ammo_inv";
publicVariable "UAMT_fpilot_handgun";
publicVariable "UAMT_fpilot_handgun_scope";
publicVariable "UAMT_fpilot_handgun_attachement1";
publicVariable "UAMT_fpilot_handgun_attachement2";
publicVariable "UAMT_fpilot_handgunAmmo_inv";
publicVariable "UAMT_fpilot_UAMT_watch";
publicVariable "UAMT_fpilot_UAMT_map";
publicVariable "UAMT_fpilot_UAMT_compass";
publicVariable "UAMT_fpilot_UAMT_binocs";
publicVariable "UAMT_fpilot_terminal";
publicVariable "UAMT_fpilot_UAMT_radio";
publicVariable "UAMT_fpilot_UAMT_nvg";
publicVariable "UAMT_fpilot_inv_u";
publicVariable "UAMT_fpilot_inv_v";
publicVariable "UAMT_fpilot_inv_b";
publicVariable "UAMT_fpilot_UAMT_equipment_ar";

publicVariable "UAMT_crew_uniform";
publicVariable "UAMT_crew_vest";
publicVariable "UAMT_crew_UAMT_helmet";
publicVariable "UAMT_crew_backpack";
publicVariable "UAMT_crew_UAMT_facewear";
publicVariable "UAMT_crew_rifle";
publicVariable "UAMT_crew_scope";
publicVariable "UAMT_crew_attachement1";
publicVariable "UAMT_crew_attachement2";
publicVariable "UAMT_crew_attachement3";
publicVariable "UAMT_crew_ammo_inv";
publicVariable "UAMT_crew_handgun";
publicVariable "UAMT_crew_handgun_scope";
publicVariable "UAMT_crew_handgun_attachement1";
publicVariable "UAMT_crew_handgun_attachement2";
publicVariable "UAMT_crew_handgunAmmo_inv";
publicVariable "UAMT_crew_UAMT_watch";
publicVariable "UAMT_crew_UAMT_map";
publicVariable "UAMT_crew_UAMT_compass";
publicVariable "UAMT_crew_UAMT_binocs";
publicVariable "UAMT_crew_terminal";
publicVariable "UAMT_crew_UAMT_radio";
publicVariable "UAMT_crew_UAMT_nvg";
publicVariable "UAMT_crew_inv_u";
publicVariable "UAMT_crew_inv_v";
publicVariable "UAMT_crew_inv_b";
publicVariable "UAMT_crew_UAMT_equipment_ar";

publicVariable "UAMT_diver_uniform";
publicVariable "UAMT_diver_vest";
publicVariable "UAMT_diver_UAMT_helmet";
publicVariable "UAMT_diver_backpack";
publicVariable "UAMT_diver_UAMT_facewear";
publicVariable "UAMT_diver_rifle";
publicVariable "UAMT_diver_scope";
publicVariable "UAMT_diver_attachement1";
publicVariable "UAMT_diver_attachement2";
publicVariable "UAMT_diver_attachement3";
publicVariable "UAMT_diver_ammo_inv";
publicVariable "UAMT_diver_handgun";
publicVariable "UAMT_diver_handgun_scope";
publicVariable "UAMT_diver_handgun_attachement1";
publicVariable "UAMT_diver_handgun_attachement2";
publicVariable "UAMT_diver_handgunAmmo_inv";
publicVariable "UAMT_diver_UAMT_watch";
publicVariable "UAMT_diver_UAMT_map";
publicVariable "UAMT_diver_UAMT_compass";
publicVariable "UAMT_diver_UAMT_binocs";
publicVariable "UAMT_diver_terminal";
publicVariable "UAMT_diver_UAMT_radio";
publicVariable "UAMT_diver_UAMT_nvg";
publicVariable "UAMT_diver_inv_u";
publicVariable "UAMT_diver_inv_v";
publicVariable "UAMT_diver_inv_b";

publicVariable "diverUAMT_eod_inv_u";
publicVariable "diverUAMT_eod_inv_v";
publicVariable "diverUAMT_eod_inv_b";

publicVariable "diverUAMT_medic_inv_u";
publicVariable "diverUAMT_medic_inv_v";
publicVariable "diverUAMT_medic_inv_b";

publicVariable "UAMT_diver_UAMT_equipment_ar";


publicVariable "UAMT_rifleman_armory";
publicVariable "UAMT_grenadier_armory";
publicVariable "UAMT_mg_armory";
publicVariable "UAMT_mgAssis_armory";
publicVariable "UAMT_autorifle_armory";
publicVariable "UAMT_dm_armory";
publicVariable "UAMT_launcher_armory";
publicVariable "UAMT_launcherAssis_armory";
publicVariable "UAMT_medic_armory";
publicVariable "UAMT_eod_armory";
publicVariable "UAMT_engineer_armory";
publicVariable "UAMT_jtac_armory";
publicVariable "UAMT_sql_armory";
publicVariable "UAMT_gl_armory";
publicVariable "UAMT_sniper_armory";
publicVariable "UAMT_spotter_armory";
publicVariable "UAMT_pilot_armory";
publicVariable "UAMT_fpilot_armory";
publicVariable "UAMT_crew_armory";
publicVariable "UAMT_diver_armory";
publicVariable "diverUAMT_eod_armory";
publicVariable "diverUAMT_medic_armory";

publicVariable "ammoCrateArr";
publicVariable "heavyammoCrateArr";
publicVariable "grenadeCrateArr";
publicVariable "atMissileCrateArr";
publicVariable "aaMissileCrateArr";
publicVariable "atLightCrateArr";
publicVariable "medicCrateArr";
publicVariable "explosivesCrateArr";
publicVariable "minesCrateArr";
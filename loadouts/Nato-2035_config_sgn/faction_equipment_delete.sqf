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
uniforms = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
helmet = ["H_HelmetB","H_Cap_khaki_specops_UK","H_Cap_usblack"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
vests = ["V_PlateCarrier1_rgr"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]
facewear = ["G_Tactical_Clear","G_Lowprofile"]; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]

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
backpack_std = ["B_AssaultPack_mcamo"]; // For all roles without much to carry, like Rifleman, DM, Squadleaders | Variant Array ["ItemClassname 1","ItemClassName 2", etc]
backpack_med = ["B_Kitbag_mcamo"]; // For roles with need for larger carrying capacity: MG, Medic, Groupleader, EOD, Engineer | Variant Array ["ItemClassname 1","ItemClassName 2", etc]
backpack_big = ["B_Carryall_mcamo"]; // For Roles with heavy loads, like AT,AA, all Assistants | Variant Array ["ItemClassname 1","ItemClassName 2", etc]

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
watch = "ACE_Altimeter"; // String
map = "ItemMap"; // String
compass = "ItemCompass"; // String
binocs = "Binocular"; // String

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
terminal_t1 = "ItemGPS"; // Available for Everyone | String
terminal_t2 = "ItemGPS"; // Only Available for Groupleader | String
terminal_t3 = "ItemGPS"; // Only available for Squadleaders | String

if (isClass(configFile >> "cfgPatches" >> "cTab")) then {
	terminal_t1 = "ItemMicroDAGR"; // String
	terminal_t2 = "ItemAndroid"; // String
	terminal_t3 = "ItemcTab"; // String
};

// All Roles except Fighter Pilots
// All standard Infantery roles have the NVGs put in their Uniforms
// Roles with limited carrying capacity like Divers and Crew Roles
// have the NVG equipped.
nvg = "NVGoggles"; // String


//------------------------------------------------------------------
//							Radios 
//
// This is a Mission Maker Service, making the Missions playable
// no matter what Mod you use, so you can share it with other people.
//
//------------------------------------------------------------------

//Radios with Modcheck for TFAR or ACRE
radio = "ItemRadio"; // String
if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
	radio = "TFAR_anprc152"; // String
};

if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
	radio = "ACRE_PRC152"; // String
};

//------------------------------------------------------------------
//						Longrange Radios 
//------------------------------------------------------------------

// Longrange Radios you can set this variable to true.
lrAvailable = false; // Long Range Available
lrRoles = ["Groupleader","JTAC"]; 	// Roles that get Long Range Radio Equipment.
									// If TFAR or Vanilla LR, overwrites the default Backpack of the role

lrRadio = ""; 	// String | Use this for using Vanilla LR Radio Backpack. 
				// Will be overwritten when ACRE or TFAR is loaded

// LR Radio Equipment depending on loaded Mod
if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
	lrRadio = "TFAR_rt1523g_big"; // String
};

if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
	lrRadio = "ACRE_PRC117F"; // String
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

san_t0_u = [
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

san_t0_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

san_t0_b = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

//------------------------------------------------------------------
//			Tier 1 medical Equipment
//
// For all roles except Medics and Docs
//
//------------------------------------------------------------------
san_t1_u = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

san_t1_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

san_t1_b = [					
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
san_t2_u = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

san_t2_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

san_t2_b = [		
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
// All Roles except Crew and Diver have this in their Uniforms
//
//------------------------------------------------------------------
invStd_u = [
	["ACE_EarPlugs",1],
	["ACE_CableTie",2],
	["ACE_Flashlight_XL50",1],
	["ACE_MapTools",1],
	["ACE_IR_Strobe_Item",1]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

invStd_v = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

invStd_b = []; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Will be put into Vests, if full into Backpacks
throwablesStd = [
	["HandGrenade",2],
	["SmokeShell",2],
	["ACE_CTS9",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Will be put into Vests, if full into Backpacks
throwablesExt = [
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

std_rifle = "arifle_MX_F"; // String
std_scope = "optic_Aco"; // String
std_attachement1 = "ACE_DBAL_A3_Green"; // String
std_attachement2 = ""; // String
std_attachement3 = ""; // String

std_rifleAmmo_inv = [
	["30Rnd_65x39_caseless_mag",5],
	["30Rnd_65x39_caseless_mag_Tracer",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Available for all Roles except fpilot
std_handgun = "hgun_P07_F"; // String
std_handgun_scope = ""; // String
std_handgun_attachment1 = ""; // String
std_handgun_attachment2 = ""; // String

std_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Alternative Weapons for Roles with Standard Rifles in Armory. 
// Ammo, Scopes and Attachements go into Equipment Array, as they should be available for all Roles
std_weapons_alt = [
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
rifleman_uniform = uniforms;
rifleman_vest = vests;
rifleman_helmet = helmet;
rifleman_backpack = backpack_std;

// Weapons Loadout
rifleman_rifle = std_rifle; // String
rifleman_scope = std_scope; // String
rifleman_attachement1 = std_attachement1; // String
rifleman_attachement2 = std_attachement2; // String
rifleman_attachement3 = std_attachement3; // String

// Rifle Ammo in Inventory
rifleman_ammo_inv = std_rifleAmmo_inv; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Handgun Loadout
rifleman_handgun = std_handgun; // String
rifleman_handgun_scope = std_handgun_scope; // String
rifleman_handgun_attachement1 = std_handgun_attachment1; // String
rifleman_handgun_attachement2 = std_handgun_attachment2; // String

// Handgun Ammo in Inventory
rifleman_handgunAmmo_inv = std_handgunAmmo_inv; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

// Slotted Items
rifleman_watch = watch; // String
rifleman_map = map; // String
rifleman_compass = compass; // String
rifleman_binocs = binocs; // String
rifleman_terminal = terminal_t1; // String
rifleman_radio = radio; // String

// Inventory items
rifleman_inv_u = invStd_u + san_t1_u; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]
rifleman_inv_v = invStd_v + san_t1_v + throwablesStd; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]
rifleman_inv_b = invStd_b + san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]]; // Load Array [["ItemClassName 1", Number Amount],["ItemClassName 2", Number Amount],etc]

//Additional or alternative Items available for this specific Role in the Armory
rifleman_equipment_AR = []; // Variant Array ["ItemClassname 1","ItemClassName 2", etc]

//------------------------------------------------------------------
//	Grenadier Equipment
//------------------------------------------------------------------

// Outfit
grenadier_uniform = uniforms;
grenadier_vest = vests;
grenadier_helmet = helmet;
grenadier_backpack = backpack_std;

// Weapons Loadout
grenadier_rifle = "arifle_MX_GL_F";
grenadier_scope = std_scope;
grenadier_attachement1 = std_attachement1;
grenadier_attachement2 = std_attachement2;
grenadier_attachement3 = std_attachement3;

// Rifle Ammo in Inventory
grenadier_ammo_inv = std_rifleAmmo_inv;

// Handgun Loadout
grenadier_handgun = std_handgun;
grenadier_handgun_scope = std_handgun_scope;
grenadier_handgun_attachement1 = std_handgun_attachment1;
grenadier_handgun_attachement2 = std_handgun_attachment2;

grenadier_handgunAmmo_inv = std_handgunAmmo_inv;

grenadier_UGL_inv = [
	["1Rnd_HE_Grenade_shell",6],
	["1Rnd_Smoke_Grenade_shell",4],
	["ACE_40mm_Flare_ir",2]
];

// Grenadier UGL Pool
// Put everything in here that you want in the Armory and in the
// explosives Supply Crate. 
// If you want to Add Ammo to the armory but not the Supply crate, put it
// into the grenadier_equipment_ar
grenadier_UGL_Pool = [
	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"ACE_40mm_Flare_ir",
	"1Rnd_SmokeGreen_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell"	
];

// Slotted items
grenadier_watch = watch;
grenadier_map = map;
grenadier_compass = compass;
grenadier_binocs = binocs;
grenadier_terminal = terminal_t1;
grenadier_radio = radio;

// Inventory items
grenadier_inv_u = invStd_u + san_t1_u;
grenadier_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
grenadier_inv_b = invStd_b + san_t1_b;

//Additional or alternative Items available for this specific Role in the Armory
grenadier_equipment_ar = [
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
mg_uniform = uniforms;
mg_vest = vests;
mg_helmet = helmet;
mg_backpack = backpack_std;

// Weapons
mg_rifle = "MMG_02_sand_F";
mg_scope = "optic_Hamr";
mg_attachement1 = std_attachement1;
mg_attachement2 = "bipod_01_F_snd";
mg_attachement3 = std_attachement3;

mg_ammo_inv = [
	["130Rnd_338_Mag",4]
];

mg_handgun = std_handgun;
mg_handgun_scope = std_handgun_scope;
mg_handgun_attachement1 = std_handgun_attachment1;
mg_handgun_attachement2 = std_handgun_attachment2;

mg_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
mg_watch = watch;
mg_map = map;
mg_compass = compass;
mg_binocs = binocs;
mg_terminal = terminal_t1;
mg_radio = radio;

// Inventory items
mg_inv_u = invStd_u + san_t1_u;
mg_inv_v = invStd_v + san_t1_v + throwablesStd;
mg_inv_b = invStd_b + san_t1_b;

// Use this for items for MG that should also be available for Assis Roles,
// for example Ammo or spareparts
mg_assistant_share_ar = []; 

// Special alternative equipment for this specific Role in the Armory
mg_equipment_ar = [
	"MMG_02_camo_F",
	"MMG_02_black_F"
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
mgAssis_uniform = uniforms;
mgAssis_vest = vests;
mgAssis_helmet = helmet;
mgAssis_backpack = backpack_med;

// Weapons
mgAssis_rifle = std_rifle;
mgAssis_scope = std_scope;
mgAssis_attachement1 = std_attachement1;
mgAssis_attachement2 = std_attachement2;
mgAssis_attachement3 = std_attachement3;

mgAssis_ammo_inv = std_rifleAmmo_inv;

mgAssis_handgun = std_handgun;
mgAssis_handgun_scope = std_handgun_scope;
mgAssis_handgun_attachement1 = std_handgun_attachment1;
mgAssis_handgun_attachement2 = std_handgun_attachment2;

mgAssis_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
mgAssis_watch = watch;
mgAssis_map = map;
mgAssis_compass = compass;
mgAssis_binocs = binocs;
mgAssis_terminal = terminal_t1;
mgAssis_radio = radio;

// Inventory items
mgAssis_inv_u = invStd_u + san_t1_u;
mgAssis_inv_v = invStd_v + san_t1_v + throwablesStd;
mgAssis_inv_b = invStd_b + san_t1_b;

// Aditional Items the role should have in their loadout
mgAssis_additionalItems = [];

// Additonal Items for the Role in the Armory
mgAssis_equipment_ar = [];


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
autorifle_uniform = uniforms;
autorifle_vest = vests;
autorifle_helmet = helmet;
autorifle_backpack = backpack_std;

// Weapons
autorifle_rifle = "arifle_MX_SW_F";
autorifle_scope = std_scope;
autorifle_attachement1 = std_attachement1;
autorifle_attachement2 = "bipod_01_F_snd";
autorifle_attachement3 = std_attachement3;

autorifle_ammo_inv = [
	["100Rnd_65x39_caseless_mag",5],
	["100Rnd_65x39_caseless_mag_Tracer",2]
];

autorifle_handgun = std_handgun;
autorifle_handgun_scope = std_handgun_scope;
autorifle_handgun_attachement1 = std_handgun_attachment1;
autorifle_handgun_attachement2 = std_handgun_attachment2;

autorifle_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
autorifle_watch = watch;
autorifle_map = map;
autorifle_compass = compass;
autorifle_binocs = binocs;
autorifle_terminal = terminal_t1;
autorifle_radio = radio;

// Inventory items
autorifle_inv_u = invStd_u + san_t1_u;
autorifle_inv_v = invStd_v + san_t1_v + throwablesStd;
autorifle_inv_b = invStd_b + san_t1_b;

//Special alternative equipment for Autoriflemen in Armory
autorifle_equipment_ar = [
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
dm_uniform = uniforms;
dm_vest = vests;
dm_helmet = helmet;
dm_backpack = backpack_std;

// Weapons
dm_rifle = "arifle_MXM_F";
dm_scope = "optic_Hamr";
dm_attachement1 = std_attachement1;
dm_attachement2 = "bipod_01_F_snd";
dm_attachement3 = std_attachement3;

dm_ammo_inv = [
	["30Rnd_65x39_caseless_mag",7],
	["30Rnd_65x39_caseless_mag_Tracer",2]
];

dm_handgun = std_handgun;
dm_handgun_scope = std_handgun_scope;
dm_handgun_attachement1 = std_handgun_attachment1;
dm_handgun_attachement2 = std_handgun_attachment2;

dm_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
dm_watch = watch;
dm_map = map;
dm_compass = compass;
dm_binocs = binocs;
dm_terminal = terminal_t1;
dm_radio = radio;

// Inventory items
dm_inv_u = invStd_u + san_t1_u  + [["ACE_RangeCard",1]];
dm_inv_v = invStd_v + san_t1_v + throwablesStd;
dm_inv_b = invStd_b + san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]];

//Special alternative equipment for DM in Armory
dm_equipment_ar = [
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
launcher_uniform = uniforms;
launcher_vest = vests;
launcher_helmet = helmet;
launcher_backpack = backpack_med;

// Weapons
launcher_rifle = std_rifle;
launcher_scope = std_scope;
launcher_attachement1 = std_attachement1;
launcher_attachement2 = std_attachement2;
launcher_attachement3 = std_attachement3;

launcher_ammo_inv = std_rifleAmmo_inv;

launcher_handgun = std_handgun;
launcher_handgun_scope = std_handgun_scope;
launcher_handgun_attachement1 = std_handgun_attachment1;
launcher_handgun_attachement2 = std_handgun_attachment2;

launcher_handgunAmmo_inv = std_handgunAmmo_inv;

// Only available for AT and AA Roles
// Ammunition is available for AT-Assistant Role too
launcher_at = "launch_B_Titan_short_F";
launcher_at_attachement1 = "";
launcher_at_attachement2 = "";
launcher_at_attachement3 = "";
// Assistant Roles will load 1.5 ceiled amounts of ammunition
launcher_at_ammo = [
	["Titan_AT",1]
]; 
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
launcher_at_ammoPool = ["Titan_AP"];

launcher_aa = "launch_B_Titan_F";
launcher_aa_attachement1 = "";
launcher_aa_attachement2 = "";
launcher_aa_attachement3 = "";
// Assistant Roles will load 1.5 ceiled amounts of ammunition
launcher_aa_ammo = [
	["Titan_AA",1]
];
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
launcher_aa_ammoPool = [];

launcher_at_light = "";
launcher_at_light_attachement1 = "";
launcher_at_light_attachement2 = "";
launcher_at_light_attachement3 = "";


// Set this true if your AT Light Launcher is a one-shot/dispensible Launcher
// Needed for the Supply Crate
_lightATdispenseble = true;

// Even with a dispensible launcher, this is needed to fill the weapon. 
// Needs multidimensional  Array: [["Ammo_Type_1",1],["Ammo_Type_2",1]]
launcher_at_light_ammo = [];
// Additional Ammo for At that is available in Armory, Supply Crates and for Assistant Roles
// As this is not loaded in any Inventory, this is a Variant Array with Ammo-Class without amount
launcher_at_light_ammoPool = [];

// Slotted Items
launcher_watch = watch;
launcher_map = map;
launcher_compass = compass;
launcher_binocs = binocs;
launcher_terminal = terminal_t1;
launcher_radio = radio;

// Inventory items
launcher_inv_u = invStd_u + san_t1_u;
launcher_inv_v = invStd_v + san_t1_v + throwablesStd;
launcher_inv_b = invStd_b + san_t1_b;

// Inventory items for Assistant Roles
launcherAssis_inv_u = invStd_u + san_t1_u;
launcherAssis_inv_v = invStd_v + san_t1_v + throwablesStd;
launcherAssis_inv_b = invStd_b + san_t1_b;


//Special alternative equipment for AT in Armory
launcher_equipment_ar = [];

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
medic_uniform = uniforms;
medic_vest = vests;
medic_helmet = helmet;
medic_backpack = backpack_med;

// Weapons
medic_rifle = std_rifle;
medic_scope = std_scope;
medic_attachement1 = std_attachement1;
medic_attachement2 = std_attachement2;
medic_attachement3 = std_attachement3;

medic_ammo_inv = std_rifleAmmo_inv;

medic_handgun = std_handgun;
medic_handgun_scope = std_handgun_scope;
medic_handgun_attachement1 = std_handgun_attachment1;
medic_handgun_attachement2 = std_handgun_attachment2;

medic_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
medic_watch = watch;
medic_map = map;
medic_compass = compass;
medic_binocs = binocs;
medic_terminal = terminal_t1;
medic_radio = radio;

// Inventory items
medic_inv_u = invStd_u + san_t2_u;
medic_inv_v = invStd_v + san_t2_v + throwablesStd;
medic_inv_b = invStd_b + san_t2_b + throwablesExt;

// Additonal Items for the Role in the Armory
medic_equipment_ar = [];

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
eod_uniform = uniforms;
eod_vest = vests;
eod_helmet = helmet;
eod_backpack = backpack_med;

// Weapons
eod_rifle = std_rifle;
eod_scope = std_scope;
eod_attachement1 = std_attachement1;
eod_attachement2 = std_attachement2;
eod_attachement3 = std_attachement3;

eod_ammo_inv = std_rifleAmmo_inv;

eod_handgun = std_handgun;
eod_handgun_scope = std_handgun_scope;
eod_handgun_attachement1 = std_handgun_attachment1;
eod_handgun_attachement2 = std_handgun_attachment2;

eod_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
eod_watch = watch;
eod_map = map;
eod_compass = compass;
eod_binocs = binocs;
eod_terminal = terminal_t1;
eod_radio = radio;

// Inventory items
eod_inv_u = invStd_u + san_t1_u;
eod_inv_v = invStd_v + san_t1_v + throwablesStd  + throwablesExt;
eod_inv_b = invStd_b + san_t1_b + [
	["ACE_M26_Clacker",2],
	["DemoCharge_Remote_Mag",2],
	["ACE_VMM3",1]
];

// EOD Explosive Pool
// Put everything in here that you want in the Armory and in the
// explosives Supply Crate
eod_explosive_pool = [
	"ACE_M26_Clacker",
	"DemoCharge_Remote_Mag",
	"SatchelCharge_Remote_Mag",
	"ACE_VMM3"
];

// Mines Pool
// Put everything in here that you want in the Armory and in the
// explosives Supply Crate
eod_mines_pool = [
	"ClaymoreDirectionalMine_Remote_Mag",
	"ATMine_Range_Mag"
];

// Additional Equipment in the Armory
// Put everything here you want to be available for EODs in the armory
// BUT not in the Supply Crates
eod_equipment_ar = [
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
engineer_uniform = uniforms;
engineer_vest = vests;
engineer_helmet = helmet;
engineer_backpack = backpack_std;

// Weapons
engineer_rifle = std_rifle;
engineer_scope = std_scope;
engineer_attachement1 = std_attachement1;
engineer_attachement2 = std_attachement2;
engineer_attachement3 = std_attachement3;

engineer_ammo_inv = std_rifleAmmo_inv;

engineer_handgun = std_handgun;
engineer_handgun_scope = std_handgun_scope;
engineer_handgun_attachement1 = std_handgun_attachment1;
engineer_handgun_attachement2 = std_handgun_attachment2;

engineer_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
engineer_watch = watch;
engineer_map = map;
engineer_compass = compass;
engineer_binocs = binocs;
engineer_terminal = terminal_t1;
engineer_radio = radio;

// Inventory items
engineer_inv_u = invStd_u + san_t1_u;
engineer_inv_v = invStd_v + san_t1_v + throwablesStd;
engineer_inv_b = invStd_b + san_t1_b + [["ACE_Fortify",1], ["ToolKit",1]];

// Additonal Items for the Role in the Armory
engineer_equipment_ar = [
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
jtac_uniform = uniforms;
jtac_vest = vests;
jtac_helmet = helmet;
jtac_backpack = backpack_std;

// Weapons
jtac_rifle = std_rifle;
jtac_scope = std_scope;
jtac_attachement1 = std_attachement1;
jtac_attachement2 = std_attachement2;
jtac_attachement3 = std_attachement3;

jtac_ammo_inv = std_rifleAmmo_inv;

jtac_handgun = std_handgun;
jtac_handgun_scope = std_handgun_scope;
jtac_handgun_attachement1 = std_handgun_attachment1;
jtac_handgun_attachement2 = std_handgun_attachment2;

jtac_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
jtac_watch = watch;
jtac_map = map;
jtac_compass = compass;
jtac_binocs = "Laserdesignator";
jtac_terminal = terminal_t3;
jtac_radio = radio;

// Inventory items | Multidimensional Array [["ITEMNAME",AMOUNT],["ITEMNAME",AMOUNT]]
jtac_inv_u = invStd_u + san_t1_u + [["ACE_RangeTable_82mm",1], ["ACE_artilleryTable",1], ["ACE_PlottingBoard",1], ["Laserbatteries",1]];
jtac_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
jtac_inv_b = invStd_b + san_t1_b + [["ACE_HuntIR_monitor",1], ["B_UavTerminal",1]];

// Additonal Items for the Role in the Armory
jtac_equipment_ar = [];

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
sql_uniform = uniforms;
sql_vest = vests;
sql_helmet = helmet;
sql_backpack = backpack_std;

// Weapons
sql_rifle = std_rifle;
sql_scope = std_scope;
sql_attachement1 = std_attachement1;
sql_attachement2 = std_attachement2;
sql_attachement3 = std_attachement3;

sql_ammo_inv = std_rifleAmmo_inv;

sql_handgun = std_handgun;
sql_handgun_scope = std_handgun_scope;
sql_handgun_attachement1 = std_handgun_attachment1;
sql_handgun_attachement2 = std_handgun_attachment2;

sql_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
sql_watch = watch;
sql_map = map;
sql_compass = compass;
sql_binocs = "Rangefinder";
sql_terminal = terminal_t2;
sql_radio = radio;


// Inventory items
sql_inv_u = invStd_u + san_t1_u;
sql_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
sql_inv_b = invStd_b + san_t1_b + [["ACE_EntrenchingTool",1], ["ACE_wirecutter",1]];

// Additonal Items for the Role in the Armory
sql_equipment_ar = [];


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
gl_uniform = uniforms;
gl_vest = vests;
gl_helmet = helmet;
gl_backpack = backpack_std;

// Weapons
gl_rifle = std_rifle;
gl_scope = std_scope;
gl_attachement1 = std_attachement1;
gl_attachement2 = std_attachement2;
gl_attachement3 = std_attachement3;

gl_ammo_inv = std_rifleAmmo_inv;

gl_handgun = std_handgun;
gl_handgun_scope = std_handgun_scope;
gl_handgun_attachement1 = std_handgun_attachment1;
gl_handgun_attachement2 = std_handgun_attachment2;

gl_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
gl_watch = watch;
gl_map = map;
gl_compass = compass;
gl_binocs = "Laserdesignator";
gl_terminal = terminal_t3;
gl_radio = radio;

// Inventory items
gl_inv_u = invStd_u + san_t1_u + [["Laserbatteries",1]];
gl_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
gl_inv_b = invStd_b + san_t1_b;

//Throwables
gl_throwables = throwablesStd + throwablesExt;

// Aditional Items the role should have in their loadout
gl_additionalItems = [];

// Additonal Items for the Role in the Armory
gl_equipment_ar = [];


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
sniper_uniform = ["U_B_GhillieSuit"];
sniper_vest = ["V_Chestrig_rgr"];
sniper_helmet = ["H_Bandanna_mcamo"];
sniper_backpack = backpack_std;

// Role Specific Rifle
sniper_rifle = "srifle_LRR_camo_F";
sniper_scope = "optic_LRPS";
sniper_attachement1 = "";
sniper_attachement2 = "";
sniper_attachement3 = "";

sniper_ammo_inv = [
	["7Rnd_408_Mag",5]
];

sniper_handgun = std_handgun;
sniper_handgun_scope = std_handgun_scope;
sniper_handgun_attachement1 = std_handgun_attachment1;
sniper_handgun_attachement2 = std_handgun_attachment2;

sniper_handgunAmmo_inv = std_handgunAmmo_inv;

// Slotted Items
sniper_watch = watch;
sniper_map = map;
sniper_compass = compass;
sniper_binocs = binocs;
sniper_terminal = terminal_t2;
sniper_radio = radio;

//Throwables
sniper_throwables = throwablesStd + throwablesExt;

// Inventory items
sniper_inv_u = invStd_u + san_t1_u + [["ACE_RangeCard",1], ["ACE_Kestrel4500",1]];
sniper_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
sniper_inv_b = invStd_b + san_t1_b;

//Special alternative equipment for Snipers and Spotters in Armory
sniper_equipment_ar = [
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
spotter_uniform = ["U_B_GhillieSuit"];
spotter_vest = ["V_Chestrig_rgr"];
spotter_helmet = ["H_Bandanna_mcamo"];
spotter_backpack = backpack_std;

// Weapons
spotter_rifle = dm_rifle;
spotter_scope = dm_scope;
spotter_attachement1 = dm_attachement1;
spotter_attachement2 = dm_attachement2;
spotter_attachement3 = dm_attachement3;

spotter_ammo_inv = std_rifleAmmo_inv;

spotter_handgun = std_handgun;
spotter_handgun_scope = std_handgun_scope;
spotter_handgun_attachement1 = std_handgun_attachment1;
spotter_handgun_attachement2 = std_handgun_attachment2;

spotter_handgunAmmo_inv = dm_ammo_inv;

// Slotted Items
spotter_watch = watch;
spotter_map = map;
spotter_compass = compass;
spotter_binocs = "Rangefinder";
spotter_terminal = terminal_t2;
spotter_radio = radio;

// Inventory items
spotter_inv_u = invStd_u + san_t1_u + [["ACE_RangeCard",1]];
spotter_inv_v = invStd_v + san_t1_v + throwablesStd + throwablesExt;
spotter_inv_b = invStd_b + san_t1_b  + [["ACE_Kestrel4500",1], ["ACE_SpottingScope",1], ["ACE_wirecutter",1]];

//Special alternative equipment for Snipers and Spotters in Armory
spotter_equipment_ar = [];


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Crew Loadouts
//
// Crewloadouts are very different. They don't need a Primary gun.
// Also, they have now backpacks and therefor limited medical access
// They also have only SR Radios as LR should be available in vehicle
// 
// Crew Roles don't have any Access to the other shared Equipment besides
// Facewear.
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
pilot_uniform = ["U_B_HeliPilotCoveralls"];
pilot_helmet = ["H_PilotHelmetHeli_B"];
pilot_vest = ["V_TacVest_blk"];
pilot_backpack = [""];
pilot_facewear = ["G_Aviator"];

// Weapons
pilot_rifle = "SMG_01_F";
pilot_scope = "optic_Holosight_smg";
pilot_attachement1 = "";
pilot_attachement2 = "";
pilot_attachement3 = "";

pilot_ammo_inv = [
	["30Rnd_45ACP_Mag_SMG_01",2]
];

pilot_handgun = "hgun_P07_F";
pilot_handgun_scope = std_handgun_scope;
pilot_handgun_attachement1 = std_handgun_attachment1;
pilot_handgun_attachement2 = std_handgun_attachment2;

pilot_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
pilot_watch = watch;
pilot_map = map;
pilot_compass = compass;
pilot_binocs = binocs;
pilot_terminal = terminal_t2;
pilot_radio = radio;
pilot_nvg = "ACE_NVG_Wide";

// Inventory items
pilot_inv_u = invStd_u;
pilot_inv_v = san_t0_u + [
	["ACE_HandFlare_Green",2],
	["SmokeShellGreen",2]
];
pilot_inv_b = [];


//Special alternative equipment for Pilots in Armory
pilot_equipment_ar = [
	"ACE_NVG_Wide_WP"
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
fpilot_uniform = ["U_B_PilotCoveralls"];
fpilot_helmet = ["H_PilotHelmetFighter_B"];
fpilot_vest = [""];
fpilot_backpack = ["B_Parachute"];
fpilot_facewear = [""];

// Weapons
fpilot_rifle = "SMG_01_F";
fpilot_scope = "optic_Holosight_smg";
fpilot_attachement1 = "";
fpilot_attachement2 = "";
fpilot_attachement3 = "";

fpilot_ammo_inv = [
	["30Rnd_45ACP_Mag_SMG_01",2]
];

fpilot_handgun = "";
fpilot_handgun_scope = "";
fpilot_handgun_attachement1 = "";
fpilot_handgun_attachement2 = "";

fpilot_handgunAmmo_inv = [];

// Slotted Items
fpilot_watch = watch;
fpilot_map = map;
fpilot_compass = compass;
fpilot_binocs = binocs;
fpilot_terminal = terminal_t2;
fpilot_radio = radio;
fpilot_nvg = "ACE_NVG_Wide";

// Inventory items
fpilot_inv_u = invStd_u + san_t0_u + [
	["ACE_HandFlare_Green",1],
	["SmokeShellGreen",1]
];
fpilot_inv_v =  [];
fpilot_inv_b = [];


//Special alternative equipment for Pilots in Armory
fpilot_equipment_ar = [
	"ACE_NVG_Wide_WP"
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
crew_uniform = ["U_B_CombatUniform_mcam_vest"];
crew_vest = ["V_BandollierB_rgr"];
crew_helmet = ["H_HelmetCrew_B"];
crew_backpack = [""];
crew_facewear = ["G_Lowprofile"];

// Weapons
crew_rifle = "arifle_MXC_F";
crew_scope = "";
crew_attachement1 = "";
crew_attachement2 = "";
crew_attachement3 = "";

crew_ammo_inv = [
	["30Rnd_65x39_caseless_mag",2]
];

crew_handgun = "hgun_P07_F";
crew_handgun_scope = "";
crew_handgun_attachement1 = "";
crew_handgun_attachement2 = "";

crew_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
crew_watch = watch;
crew_map = map;
crew_compass = compass;
crew_binocs = binocs;
crew_terminal = terminal_t1;
crew_radio = radio;
crew_nvg = nvg;

// Inventory items
crew_inv_u = invStd_u + san_t0_u;
crew_inv_v = [
	["ACE_HandFlare_Green",2],
	["SmokeShellGreen",2]
];
crew_inv_b = [];

// Additonal Items for the Role in the Armory
crew_equipment_ar = [
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
diver_uniform = ["U_B_Wetsuit"];
diver_vest = ["V_RebreatherB"];
diver_helmet = ["H_HelmetB_light_black"];
diver_backpack = ["B_AssaultPack_blk"];
diver_facewear = ["G_B_Diving"];

// Weapons
diver_rifle = "arifle_SDAR_F";
diver_scope = "";
diver_attachement1 = "";
diver_attachement2 = "";
diver_attachement3 = "";

diver_ammo_inv = [
	["20Rnd_556x45_UW_mag",5]
];

diver_handgun = "hgun_P07_F";
diver_handgun_scope = "";
diver_handgun_attachement1 = "muzzle_snds_L";
diver_handgun_attachement2 = "";

diver_handgunAmmo_inv = [
	["16Rnd_9x21_Mag",2]
];

// Slotted Items
diver_watch = watch;
diver_map = map;
diver_compass = compass;
diver_binocs = binocs;
diver_terminal = terminal_t1;
diver_radio = radio;
diver_nvg = nvg;

// Inventory items
diver_inv_u = invStd_u + san_t1_u + san_t1_v + san_t1_b;
diver_inv_v = [];
diver_inv_b = throwablesStd + throwablesExt ;

// Inventory items
diverEOD_inv_u = invStd_u + san_t1_u + san_t1_v + san_t1_b;
diverEOD_inv_v = [];
diverEOD_inv_b = throwablesStd + throwablesExt + [
	["ACE_Clacker",2],
	["DemoCharge_Remote_Mag",2]
];

// Inventory items
diverMedic_inv_u = invStd_u;
diverMedic_inv_v = [];
diverMedic_inv_b = throwablesStd + throwablesExt + [
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
diver_equipment_AR = [];

//------------------------------------------------------------------
//	Content for Armory
//------------------------------------------------------------------


//------------------------------------------------------------------
//	Special Equipment used in Loadouts
//------------------------------------------------------------------


uav_Terminal = "B_UavTerminal";			//No attached Role, just needed for the Supply Point Crate
uav_backpack = "B_UAV_01_backpack_F";	//No attached Role, just needed for the Supply Point Crate
uav_battery = "ACE_UAVBattery";			//No attached Role, just needed for the Supply Point Crate

minedetector = "ACE_VMM3";				//Only available for EOD and Diver Team

explosivedevice = "ACE_Clacker";		//Only available for EOD and Diver Team
defusalkit = "ACE_DefusalKit";			//Only available for EOD and Diver Team

//Explosives for special occasions. Only available for EOD and Diver Roles or TOC Group
smallDemo = "DemoCharge_Remote_Mag";
bigDemo = "SatchelCharge_Remote_Mag";
apMine = "ClaymoreDirectionalMine_Remote_Mag";
atMine = "ATMine_Range_Mag";

//More Explosives in the Arsenal
explosives = [
	"SatchelCharge_Remote_Mag",
	"SLAMDirectionalMine_Wire_Mag",
	"ClaymoreDirectionalMine_Remote_Mag",
	"ACE_FlareTripMine_Mag"
];

explosives pushback smallDemo;
explosives pushback bigDemo;
explosives pushback apMine;
explosives pushback atMine;




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

equipment_ar = [
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
];

//------------------------------------------------------------------
//	Facewear Armory Extension
//
// Same as above, only for Facewear Items that are also available
// for Crew-Roles (sorry Divers, no special Facewear for you).
//------------------------------------------------------------------
facewear_Arm = [
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
std_equipment = [];
std_equipment append uniforms;
std_equipment append helmet;
std_equipment append vests;
std_equipment append facewear;
std_equipment append backpack_std;
std_equipment append backpack_med;
std_equipment append backpack_big;
std_equipment append [
	watch,
	map,
	compass,
	binocs,
	radio,
	std_scope,
	std_attachement1,
	std_attachement2,
	std_attachement3,
	std_handgun_scope,
	std_handgun_attachment1,
	std_handgun_attachment2
];

std_weapons = [];
std_weapons append [std_rifle,std_handgun];
std_weapons append std_weapons_alt;

{
	std_equipment pushback (_x select 0);
} forEach std_rifleAmmo_inv;

{
	std_equipment pushback (_x select 0);
} forEach std_handgunAmmo_inv;

{
	std_equipment pushback (_x select 0);
} forEach invStd_u;

{
	std_equipment pushback (_x select 0);
} forEach invStd_v;

{
	std_equipment pushback (_x select 0);
} forEach invStd_b;

//------------------------------------------------------------------
//	Rifleman Equipment Array
//------------------------------------------------------------------
rifleman_armory = [];
rifleman_armory append std_equipment;
rifleman_armory append std_weapons;
rifleman_armory append rifleman_uniform;
rifleman_armory append rifleman_vest;
rifleman_armory append rifleman_helmet;
rifleman_armory append rifleman_backpack;
rifleman_armory append [
	rifleman_rifle,
	rifleman_scope,
	rifleman_attachement1,
	rifleman_attachement2,
	rifleman_attachement3,
	rifleman_handgun,
	rifleman_handgun_scope,
	rifleman_handgun_attachement1,
	rifleman_handgun_attachement2,
	rifleman_watch,
	rifleman_map,
	rifleman_compass,
	rifleman_binocs,
	rifleman_terminal,
	rifleman_radio,
	nvg
];

rifleman_armory append rifleman_equipment_AR;
rifleman_armory append equipment_ar;
rifleman_armory append facewear_Arm;

{
	rifleman_armory pushback (_x select 0);
} forEach rifleman_ammo_inv;

{
	rifleman_armory pushback (_x select 0);
} forEach rifleman_handgunAmmo_inv;	

{
	rifleman_armory pushback (_x select 0);
} forEach rifleman_inv_u;

{
	rifleman_armory pushback (_x select 0);
} forEach rifleman_inv_v;

{
	rifleman_armory pushback (_x select 0);
} forEach rifleman_inv_b;

if ("Rifleman" in lrRoles) then {
	rifleman_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	Grenadier Equipment Array
//------------------------------------------------------------------	
grenadier_armory = [];
grenadier_armory append std_equipment;
grenadier_armory append grenadier_uniform;
grenadier_armory append grenadier_vest;
grenadier_armory append grenadier_helmet;
grenadier_armory append grenadier_backpack;
grenadier_armory append [
	grenadier_rifle,
	grenadier_scope,
	grenadier_attachement1,
	grenadier_attachement2,
	grenadier_attachement3,
	grenadier_handgun,
	grenadier_handgun_scope,
	grenadier_handgun_attachement1,
	grenadier_handgun_attachement2,
	grenadier_watch,
	grenadier_map,
	grenadier_compass,
	grenadier_binocs,
	grenadier_terminal,
	grenadier_radio,
	nvg
];

grenadier_armory append grenadier_equipment_AR;
grenadier_armory append equipment_ar;
grenadier_armory append facewear_Arm;
grenadier_armory append grenadier_UGL_Pool;

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_ammo_inv;

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_handgunAmmo_inv;	

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_inv_u;

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_UGL_inv;

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_inv_v;

{
	grenadier_armory pushback (_x select 0);
} forEach grenadier_inv_b;

if ("Grenadier" in lrRoles) then {
	grenadier_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	mg Equipment Array
//------------------------------------------------------------------	
mg_armory = [];
mg_armory append std_equipment;
mg_armory append mg_uniform;
mg_armory append mg_vest;
mg_armory append mg_helmet;
mg_armory append mg_backpack;
mg_armory append [
	mg_rifle,
	mg_scope,
	mg_attachement1,
	mg_attachement2,
	mg_attachement3,
	mg_handgun,
	mg_handgun_scope,
	mg_handgun_attachement1,
	mg_handgun_attachement2,
	mg_watch,
	mg_map,
	mg_compass,
	mg_binocs,
	mg_terminal,
	mg_radio,
	nvg
];

mg_armory append mg_equipment_ar;
mg_armory append equipment_ar;
mg_armory append facewear_Arm;
mg_armory append mg_assistant_share_ar;

{
	mg_armory pushback (_x select 0);
} forEach mg_ammo_inv;

{
	mg_armory pushback (_x select 0);
} forEach mg_handgunAmmo_inv;	

{
	mg_armory pushback (_x select 0);
} forEach mg_inv_u;

{
	mg_armory pushback (_x select 0);
} forEach mg_inv_v;

{
	mg_armory pushback (_x select 0);
} forEach mg_inv_b;

if ("MG" in lrRoles) then {
	mg_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	mgAssis Equipment Array
//------------------------------------------------------------------	
mgAssis_armory = [];
mgAssis_armory append std_equipment;
mgAssis_armory append std_weapons;
mgAssis_armory append mgAssis_uniform;
mgAssis_armory append mgAssis_vest;
mgAssis_armory append mgAssis_helmet;
mgAssis_armory append mgAssis_backpack;
mgAssis_armory append [
	mgAssis_rifle,
	mgAssis_scope,
	mgAssis_attachement1,
	mgAssis_attachement2,
	mgAssis_attachement3,
	mgAssis_handgun,
	mgAssis_handgun_scope,
	mgAssis_handgun_attachement1,
	mgAssis_handgun_attachement2,
	mgAssis_watch,
	mgAssis_map,
	mgAssis_compass,
	mgAssis_binocs,
	mgAssis_terminal,
	mgAssis_radio,
	nvg
];

mgAssis_armory append mgAssis_equipment_ar;
mgAssis_armory append equipment_ar;
mgAssis_armory append facewear_Arm;
mgAssis_armory append mg_assistant_share_ar;

{
	mgAssis_armory pushback (_x select 0);
} forEach mgAssis_ammo_inv;

{
	mgAssis_armory pushback (_x select 0);
} forEach mgAssis_handgunAmmo_inv;	

{
	mgAssis_armory pushback (_x select 0);
} forEach mgAssis_inv_u;

{
	mgAssis_armory pushback (_x select 0);
} forEach mgAssis_inv_v;

{
	mgAssis_armory pushback (_x select 0);
} forEach mgAssis_inv_b;

if ("MG-Assistant" in lrRoles) then {
	mgAssis_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	autorifle Equipment Array
//------------------------------------------------------------------	
autorifle_armory = [];
autorifle_armory append std_equipment;
autorifle_armory append autorifle_uniform;
autorifle_armory append autorifle_vest;
autorifle_armory append autorifle_helmet;
autorifle_armory append autorifle_backpack;
autorifle_armory append [
	autorifle_rifle,
	autorifle_scope,
	autorifle_attachement1,
	autorifle_attachement2,
	autorifle_attachement3,
	autorifle_handgun,
	autorifle_handgun_scope,
	autorifle_handgun_attachement1,
	autorifle_handgun_attachement2,
	autorifle_watch,
	autorifle_map,
	autorifle_compass,
	autorifle_binocs,
	autorifle_terminal,
	autorifle_radio,
	nvg
];

autorifle_armory append autorifle_equipment_ar;
autorifle_armory append equipment_ar;
autorifle_armory append facewear_Arm;

{
	autorifle_armory pushback (_x select 0);
} forEach autorifle_ammo_inv;

{
	autorifle_armory pushback (_x select 0);
} forEach autorifle_handgunAmmo_inv;	

{
	autorifle_armory pushback (_x select 0);
} forEach autorifle_inv_u;

{
	autorifle_armory pushback (_x select 0);
} forEach autorifle_inv_v;

{
	autorifle_armory pushback (_x select 0);
} forEach autorifle_inv_b;

if ("Autorifle" in lrRoles) then {
	autorifle_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	dm Equipment Array
//------------------------------------------------------------------	
dm_armory = [];
dm_armory append std_equipment;
dm_armory append dm_uniform;
dm_armory append dm_vest;
dm_armory append dm_helmet;
dm_armory append dm_backpack;
dm_armory append [
	dm_rifle,
	dm_scope,
	dm_attachement1,
	dm_attachement2,
	dm_attachement3,
	dm_handgun,
	dm_handgun_scope,
	dm_handgun_attachement1,
	dm_handgun_attachement2,
	dm_watch,
	dm_map,
	dm_compass,
	dm_binocs,
	dm_terminal,
	dm_radio,
	nvg
];

dm_armory append dm_equipment_ar;
dm_armory append equipment_ar;
dm_armory append facewear_Arm;

{
	dm_armory pushback (_x select 0);
} forEach dm_ammo_inv;

{
	dm_armory pushback (_x select 0);
} forEach dm_handgunAmmo_inv;	

{
	dm_armory pushback (_x select 0);
} forEach dm_inv_u;

{
	dm_armory pushback (_x select 0);
} forEach dm_inv_v;

{
	dm_armory pushback (_x select 0);
} forEach dm_inv_b;

if ("DM" in lrRoles) then {
	dm_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	launcher Equipment Array
//------------------------------------------------------------------	
launcher_armory = [];
launcher_armory append std_equipment;
launcher_armory append std_weapons;
launcher_armory append launcher_uniform;
launcher_armory append launcher_vest;
launcher_armory append launcher_helmet;
launcher_armory append launcher_backpack;
launcher_armory append [
	launcher_rifle,
	launcher_scope,
	launcher_attachement1,
	launcher_attachement2,
	launcher_attachement3,
	launcher_handgun,
	launcher_handgun_scope,
	launcher_handgun_attachement1,
	launcher_handgun_attachement2,
	launcher_at,
	launcher_at_attachement1,
	launcher_at_attachement2,
	launcher_at_attachement3,
	launcher_aa,
	launcher_aa_attachement1,
	launcher_aa_attachement2,
	launcher_aa_attachement3,
	launcher_at_light,
	launcher_at_light_attachement1,
	launcher_at_light_attachement2,
	launcher_at_light_attachement3,
	launcher_watch,
	launcher_map,
	launcher_compass,
	launcher_binocs,
	launcher_terminal,
	launcher_radio,
	nvg
];

launcher_armory append launcher_equipment_ar;
launcher_armory append launcher_at_ammoPool;
launcher_armory append launcher_aa_ammoPool;
launcher_armory append launcher_at_light_ammoPool;
launcher_armory append equipment_ar;
launcher_armory append facewear_Arm;

{
	launcher_armory pushback (_x select 0);
} forEach launcher_ammo_inv;

{
	launcher_armory pushback (_x select 0);
} forEach launcher_handgunAmmo_inv;	

{
	launcher_armory pushback (_x select 0);
} forEach launcher_at_ammo;	

{
	launcher_armory pushback (_x select 0);
} forEach launcher_aa_ammo;	

{
	launcher_armory pushback (_x select 0);
} forEach launcher_at_light_ammo;	

{
	launcher_armory pushback (_x select 0);
} forEach launcher_inv_u;

{
	launcher_armory pushback (_x select 0);
} forEach launcher_inv_v;

{
	launcher_armory pushback (_x select 0);
} forEach launcher_inv_b;

if ("AT" in lrRoles || "AA" in lrRoles || "AT-Light" in lrRoles) then {
	launcher_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	launcherAssis Equipment Array
//------------------------------------------------------------------
launcherAssis_armory = [];
launcherAssis_armory append std_equipment;
launcherAssis_armory append std_weapons;
launcherAssis_armory append launcher_uniform;
launcherAssis_armory append launcher_vest;
launcherAssis_armory append launcher_helmet;
launcherAssis_armory append launcher_backpack;
launcherAssis_armory append [
	launcher_rifle,
	launcher_scope,
	launcher_attachement1,
	launcher_attachement2,
	launcher_attachement3,
	launcher_handgun,
	launcher_handgun_scope,
	launcher_handgun_attachement1,
	launcher_handgun_attachement2,
	launcher_watch,
	launcher_map,
	launcher_compass,
	launcher_binocs,
	launcher_terminal,
	launcher_radio,
	nvg
];

launcherAssis_armory append launcher_at_ammoPool;
launcherAssis_armory append launcher_aa_ammoPool;
launcherAssis_armory append launcher_at_light_ammoPool;
launcherAssis_armory append equipment_ar;
launcherAssis_armory append facewear_Arm;

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcher_ammo_inv;

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcher_handgunAmmo_inv;	

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcher_at_ammo;	

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcher_aa_ammo;	

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcher_at_light_ammo;

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_u;

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_v;

{
	launcherAssis_armory pushback (_x select 0);
} forEach launcherAssis_inv_b;

if ("AT-Assistant" in lrRoles) then {
	launcherAssis_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	medic Equipment Array
//------------------------------------------------------------------
medic_armory = [];
medic_armory append std_equipment;
medic_armory append std_weapons;
medic_armory append medic_uniform;
medic_armory append medic_vest;
medic_armory append medic_helmet;
medic_armory append medic_backpack;
medic_armory append [
	medic_rifle,
	medic_scope,
	medic_attachement1,
	medic_attachement2,
	medic_attachement3,
	medic_handgun,
	medic_handgun_scope,
	medic_handgun_attachement1,
	medic_handgun_attachement2,
	medic_watch,
	medic_map,
	medic_compass,
	medic_binocs,
	medic_terminal,
	medic_radio,
	nvg
];

medic_armory append medic_equipment_AR;
medic_armory append equipment_ar;
medic_armory append facewear_Arm;

{
	medic_armory pushback (_x select 0);
} forEach medic_ammo_inv;

{
	medic_armory pushback (_x select 0);
} forEach medic_handgunAmmo_inv;	

{
	medic_armory pushback (_x select 0);
} forEach medic_inv_u;

{
	medic_armory pushback (_x select 0);
} forEach medic_inv_v;

{
	medic_armory pushback (_x select 0);
} forEach medic_inv_b;

if ("Medic" in lrRoles) then {
	medic_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	eod Equipment Array
//------------------------------------------------------------------
eod_armory = [];
eod_armory append std_equipment;
eod_armory append std_weapons;
eod_armory append eod_uniform;
eod_armory append eod_vest;
eod_armory append eod_helmet;
eod_armory append eod_backpack;
eod_armory append [
	eod_rifle,
	eod_scope,
	eod_attachement1,
	eod_attachement2,
	eod_attachement3,
	eod_handgun,
	eod_handgun_scope,
	eod_handgun_attachement1,
	eod_handgun_attachement2,
	eod_watch,
	eod_map,
	eod_compass,
	eod_binocs,
	eod_terminal,
	eod_radio,
	nvg
];

eod_armory append eod_explosive_pool;
eod_armory append eod_mines_pool;
eod_armory append eod_equipment_AR;
eod_armory append equipment_ar;
eod_armory append facewear_Arm;

{
	eod_armory pushback (_x select 0);
} forEach eod_ammo_inv;

{
	eod_armory pushback (_x select 0);
} forEach eod_handgunAmmo_inv;	

{
	eod_armory pushback (_x select 0);
} forEach eod_inv_u;

{
	eod_armory pushback (_x select 0);
} forEach eod_inv_v;

{
	eod_armory pushback (_x select 0);
} forEach eod_inv_b;

if ("EOD" in lrRoles) then {
	eod_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	engineer Equipment Array
//------------------------------------------------------------------
engineer_armory = [];
engineer_armory append std_equipment;
engineer_armory append std_weapons;
engineer_armory append engineer_uniform;
engineer_armory append engineer_vest;
engineer_armory append engineer_helmet;
engineer_armory append engineer_backpack;
engineer_armory append [
	engineer_rifle,
	engineer_scope,
	engineer_attachement1,
	engineer_attachement2,
	engineer_attachement3,
	engineer_handgun,
	engineer_handgun_scope,
	engineer_handgun_attachement1,
	engineer_handgun_attachement2,
	engineer_watch,
	engineer_map,
	engineer_compass,
	engineer_binocs,
	engineer_terminal,
	engineer_radio,
	nvg
];

engineer_armory append engineer_equipment_AR;
engineer_armory append equipment_ar;
engineer_armory append facewear_Arm;
	
{
	engineer_armory pushback (_x select 0);
} forEach engineer_ammo_inv;

{
	engineer_armory pushback (_x select 0);
} forEach engineer_handgunAmmo_inv;	

{
	engineer_armory pushback (_x select 0);
} forEach engineer_inv_u;

{
	engineer_armory pushback (_x select 0);
} forEach engineer_inv_v;

{
	engineer_armory pushback (_x select 0);
} forEach engineer_inv_b;

if ("Engineer" in lrRoles) then {
	engineer_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	jtac Equipment Array
//------------------------------------------------------------------
jtac_armory = [];
jtac_armory append std_equipment;
jtac_armory append std_weapons;
jtac_armory append jtac_uniform;
jtac_armory append jtac_vest;
jtac_armory append jtac_helmet;
jtac_armory append jtac_backpack;
jtac_armory append [
	jtac_rifle,
	jtac_scope,
	jtac_attachement1,
	jtac_attachement2,
	jtac_attachement3,
	jtac_handgun,
	jtac_handgun_scope,
	jtac_handgun_attachement1,
	jtac_handgun_attachement2,
	jtac_watch,
	jtac_map,
	jtac_compass,
	jtac_binocs,
	jtac_terminal,
	jtac_radio,
	nvg
];

jtac_armory append jtac_equipment_AR;
jtac_armory append equipment_ar;
jtac_armory append facewear_Arm;

{
	jtac_armory pushback (_x select 0);
} forEach jtac_ammo_inv;

{
	jtac_armory pushback (_x select 0);
} forEach jtac_handgunAmmo_inv;	

{
	jtac_armory pushback (_x select 0);
} forEach jtac_inv_u;

{
	jtac_armory pushback (_x select 0);
} forEach jtac_inv_v;

{
	jtac_armory pushback (_x select 0);
} forEach jtac_inv_b;

if ("JTAC" in lrRoles) then {
	jtac_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	sql Equipment Array
//------------------------------------------------------------------
sql_armory = [];
sql_armory append std_equipment;
sql_armory append std_weapons;
sql_armory append sql_uniform;
sql_armory append sql_vest;
sql_armory append sql_helmet;
sql_armory append sql_backpack;
sql_armory append [
	sql_rifle,
	sql_scope,
	sql_attachement1,
	sql_attachement2,
	sql_attachement3,
	sql_handgun,
	sql_handgun_scope,
	sql_handgun_attachement1,
	sql_handgun_attachement2,
	sql_watch,
	sql_map,
	sql_compass,
	sql_binocs,
	sql_terminal,
	sql_radio,
	nvg
];

sql_armory append sql_equipment_AR;
sql_armory append equipment_ar;
sql_armory append facewear_Arm;

{
	sql_armory pushback (_x select 0);
} forEach sql_ammo_inv;

{
	sql_armory pushback (_x select 0);
} forEach sql_handgunAmmo_inv;	

{
	sql_armory pushback (_x select 0);
} forEach sql_inv_u;

{
	sql_armory pushback (_x select 0);
} forEach sql_inv_v;

{
	sql_armory pushback (_x select 0);
} forEach sql_inv_b;

if ("Squadleader" in lrRoles) then {
	sql_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	gl Equipment Array
//------------------------------------------------------------------
gl_armory = [];
gl_armory append std_equipment;
gl_armory append std_weapons;
gl_armory append gl_uniform;
gl_armory append gl_vest;
gl_armory append gl_helmet;
gl_armory append gl_backpack;
gl_armory append [
	gl_rifle,
	gl_scope,
	gl_attachement1,
	gl_attachement2,
	gl_attachement3,
	gl_handgun,
	gl_handgun_scope,
	gl_handgun_attachement1,
	gl_handgun_attachement2,
	gl_watch,
	gl_map,
	gl_compass,
	gl_binocs,
	gl_terminal,
	gl_radio,
	nvg
];

gl_armory append gl_equipment_AR;
gl_armory append equipment_ar;
gl_armory append facewear_Arm;
	
{
	gl_armory pushback (_x select 0);
} forEach gl_ammo_inv;

{
	gl_armory pushback (_x select 0);
} forEach gl_handgunAmmo_inv;	

{
	gl_armory pushback (_x select 0);
} forEach gl_inv_u;

{
	gl_armory pushback (_x select 0);
} forEach gl_inv_v;

{
	gl_armory pushback (_x select 0);
} forEach gl_inv_b;

if ("Groupleader" in lrRoles) then {
	gl_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	sniper Equipment Array
//------------------------------------------------------------------
sniper_armory = [];
sniper_armory append std_equipment;
sniper_armory append std_weapons;
sniper_armory append sniper_uniform;
sniper_armory append sniper_vest;
sniper_armory append sniper_helmet;
sniper_armory append sniper_backpack;
sniper_armory append [
	sniper_rifle,
	sniper_scope,
	sniper_attachement1,
	sniper_attachement2,
	sniper_attachement3,
	sniper_handgun,
	sniper_handgun_scope,
	sniper_handgun_attachement1,
	sniper_handgun_attachement2,
	sniper_watch,
	sniper_map,
	sniper_compass,
	sniper_binocs,
	sniper_terminal,
	sniper_radio,
	nvg
];

sniper_armory append sniper_equipment_AR;
sniper_armory append facewear_Arm;

{
	sniper_armory pushback (_x select 0);
} forEach sniper_ammo_inv;

{
	sniper_armory pushback (_x select 0);
} forEach sniper_handgunAmmo_inv;	

{
	sniper_armory pushback (_x select 0);
} forEach sniper_inv_u;

{
	sniper_armory pushback (_x select 0);
} forEach sniper_inv_v;

{
	sniper_armory pushback (_x select 0);
} forEach sniper_inv_b;

if ("Sniper" in lrRoles) then {
	sniper_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	spotter Equipment Array
//------------------------------------------------------------------
spotter_armory = [];
spotter_armory append std_equipment;
spotter_armory append std_weapons;
spotter_armory append dm_armory;
spotter_armory append spotter_uniform;
spotter_armory append spotter_vest;
spotter_armory append spotter_helmet;
spotter_armory append spotter_backpack;
spotter_armory append [
	spotter_rifle,
	spotter_scope,
	spotter_attachement1,
	spotter_attachement2,
	spotter_attachement3,
	spotter_handgun,
	spotter_handgun_scope,
	spotter_handgun_attachement1,
	spotter_handgun_attachement2,
	spotter_watch,
	spotter_map,
	spotter_compass,
	spotter_binocs,
	spotter_terminal,
	spotter_radio,
	nvg
];

spotter_armory append spotter_equipment_AR;
spotter_armory append facewear_Arm;

{
	spotter_armory pushback (_x select 0);
} forEach spotter_ammo_inv;

{
	spotter_armory pushback (_x select 0);
} forEach spotter_handgunAmmo_inv;	

{
	spotter_armory pushback (_x select 0);
} forEach spotter_inv_u;

{
	spotter_armory pushback (_x select 0);
} forEach spotter_inv_v;

{
	spotter_armory pushback (_x select 0);
} forEach spotter_inv_b;

if ("Spotter" in lrRoles) then {
	spotter_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	pilot Equipment Array
//------------------------------------------------------------------
pilot_armory = [];
pilot_armory append pilot_uniform;
pilot_armory append pilot_vest;
pilot_armory append pilot_helmet;
pilot_armory append pilot_backpack;
pilot_armory append [
	pilot_facewear,
	pilot_rifle,
	pilot_scope,
	pilot_attachement1,
	pilot_attachement2,
	pilot_attachement3,
	pilot_handgun,
	pilot_handgun_scope,
	pilot_handgun_attachement1,
	pilot_handgun_attachement2,
	pilot_watch,
	pilot_map,
	pilot_compass,
	pilot_binocs,
	pilot_terminal,
	pilot_radio,
	pilot_nvg
];

pilot_armory append pilot_equipment_AR;
pilot_armory append facewear_Arm;

{
	pilot_armory pushback (_x select 0);
} forEach pilot_ammo_inv;

{
	pilot_armory pushback (_x select 0);
} forEach pilot_handgunAmmo_inv;	

{
	pilot_armory pushback (_x select 0);
} forEach pilot_inv_u;

{
	pilot_armory pushback (_x select 0);
} forEach pilot_inv_v;

{
	pilot_armory pushback (_x select 0);
} forEach pilot_inv_b;

if ("Pilot" in lrRoles) then {
	pilot_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	fpilot Equipment Array
//------------------------------------------------------------------
fpilot_armory = [];
fpilot_armory append fpilot_uniform;
fpilot_armory append fpilot_vest;
fpilot_armory append fpilot_helmet;
fpilot_armory append fpilot_backpack;
fpilot_armory append [
	fpilot_facewear,
	fpilot_rifle,
	fpilot_scope,
	fpilot_attachement1,
	fpilot_attachement2,
	fpilot_attachement3,
	fpilot_handgun,
	fpilot_handgun_scope,
	fpilot_handgun_attachement1,
	fpilot_handgun_attachement2,
	fpilot_watch,
	fpilot_map,
	fpilot_compass,
	fpilot_binocs,
	fpilot_terminal,
	fpilot_radio,
	fpilot_nvg,
	fpilot_equipment_AR,
	facewear_Arm
];

fpilot_armory append fpilot_equipment_AR;
fpilot_armory append facewear_Arm;

{
	fpilot_armory pushback (_x select 0);
} forEach fpilot_ammo_inv;

{
	fpilot_armory pushback (_x select 0);
} forEach fpilot_handgunAmmo_inv;	

{
	fpilot_armory pushback (_x select 0);
} forEach fpilot_inv_u;

{
	fpilot_armory pushback (_x select 0);
} forEach fpilot_inv_v;

{
	fpilot_armory pushback (_x select 0);
} forEach fpilot_inv_b;

if ("Fighter-Pilot" in lrRoles) then {
	fpilot_armory pushBack lrRadio;
};

//------------------------------------------------------------------
//	crew Equipment Array
//------------------------------------------------------------------
crew_armory = [];
crew_armory append crew_uniform;
crew_armory append crew_vest;
crew_armory append crew_helmet;
crew_armory append crew_backpack;
crew_armory append [
	crew_facewear,
	crew_rifle,
	crew_scope,
	crew_attachement1,
	crew_attachement2,
	crew_attachement3,
	crew_handgun,
	crew_handgun_scope,
	crew_handgun_attachement1,
	crew_handgun_attachement2,
	crew_watch,
	crew_map,
	crew_compass,
	crew_binocs,
	crew_terminal,
	crew_radio,
	crew_nvg
];

crew_armory append crew_equipment_AR;
crew_armory append facewear_Arm;

{
	crew_armory pushback (_x select 0);
} forEach crew_ammo_inv;

{
	crew_armory pushback (_x select 0);
} forEach crew_handgunAmmo_inv;	

{
	crew_armory pushback (_x select 0);
} forEach crew_inv_u;

{
	crew_armory pushback (_x select 0);
} forEach crew_inv_v;

{
	crew_armory pushback (_x select 0);
} forEach crew_inv_b;

if ("crew" in lrRoles) then {
	crew_armory pushBack lrRadio;
};


//------------------------------------------------------------------
//	diver Equipment Array
//------------------------------------------------------------------
diver_armory = [];
diver_armory append diver_uniform;
diver_armory append diver_vest;
diver_armory append diver_helmet;
diver_armory append diver_backpack;
diver_armory append diver_facewear;
diver_armory append [
	diver_rifle,
	diver_scope,
	diver_attachement1,
	diver_attachement2,
	diver_attachement3,
	diver_handgun,
	diver_handgun_scope,
	diver_handgun_attachement1,
	diver_handgun_attachement2,
	diver_watch,
	diver_map,
	diver_compass,
	diver_binocs,
	diver_terminal,
	diver_radio,
	diver_nvg,
	diver_equipment_AR
];
	
{
	diver_armory pushback (_x select 0);
} forEach diver_ammo_inv;

{
	diver_armory pushback (_x select 0);
} forEach diver_handgunAmmo_inv;	

{
	diver_armory pushback (_x select 0);
} forEach diver_inv_u;

{
	diver_armory pushback (_x select 0);
} forEach diver_inv_v;

{
	diver_armory pushback (_x select 0);
} forEach diver_inv_b;

if ("Diver-Rifleman" in lrRoles) then {
	diver_armory pushBack lrRadio;
};

if ("Diver-Groupleader" in lrRoles) then {
	diver_armory pushBack lrRadio;
};

diverEOD_armory = [];
diverEOD_armory append diver_armory;

{
	diverEOD_armory pushback (_x select 0);
} forEach diverEOD_inv_u;

{
	diverEOD_armory pushback (_x select 0);
} forEach diverEOD_inv_v;

{
	diverEOD_armory pushback (_x select 0);
} forEach diverEOD_inv_b;

if ("Diver-EOD" in lrRoles) then {
	diverEOD_armory pushBack lrRadio;
};

diverMedic_armory = [];
diverMedic_armory append diver_armory;

{
	diverMedic_armory pushback (_x select 0);
} forEach diverMedic_inv_u;

{
	diverMedic_armory pushback (_x select 0);
} forEach diverMedic_inv_v;

{
	diverMedic_armory pushback (_x select 0);
} forEach diverMedic_inv_b;

if ("Diver-Medic" in lrRoles) then {
	diverMedic_armory pushBack lrRadio;
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

//Primary Mag load - Alway takes the first Mag Type from the std_rifleAmmo_inv array
_mag = (std_rifleAmmo_inv select 0) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (500 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

_mag = (std_handgunAmmo_inv select 0) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (100 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

//------------------------------------------------------------------
// 	Heavy Ammo Crate
//------------------------------------------------------------------
heavyammoCrateArr = [];

_div = 0;

if (count mg_ammo_inv >= 1) then {
	_div = _div + 1;
};

if (count autorifle_ammo_inv >= 1) then {
	_div = _div + 1;
};

if (count dm_ammo_inv >= 1) then {
	_div = _div + 1;
};

_loadMass = _crateLimit / _div;

if (count mg_ammo_inv >= 1) then {
	_mag = (mg_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if (count autorifle_ammo_inv >= 1) then {
	_mag = (autorifle_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if (count dm_ammo_inv >= 1) then {
	_mag = (dm_ammo_inv select 0) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

//------------------------------------------------------------------
// 	Grenades Ammo Crate
//------------------------------------------------------------------

grenadeCrateArr = [];

_div = count throwablesStd + count throwablesExt;

_loadMass = floor (400 / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach throwablesStd;

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach throwablesExt;


_div = count grenadier_UGL_Pool;

_loadMass = floor (200 / _div);

{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach grenadier_UGL_Pool;

//------------------------------------------------------------------
// 	AT Missile Ammo Crate
//------------------------------------------------------------------
atMissileCrateArr = [];

_div = 	count launcher_at_ammo + count launcher_at_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_at_ammo;

{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_at_ammoPool;


//------------------------------------------------------------------
// 	AA Missile Ammo Crate
//------------------------------------------------------------------
aaMissileCrateArr = [];

_div = 	count launcher_aa_ammo + count launcher_aa_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_aa_ammo;


{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_aa_ammoPool;

//------------------------------------------------------------------
// 	AT-Light Missile Ammo Crate
//------------------------------------------------------------------
atLightCrateArr = [];

if (launcher_at_light != "") then {
	if (_lightATdispenseble) then {
		_magMass = getNumber (configFile >> "CfgWeapons" >> launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (600 / _magMass);
		
		atLightCrateArr append [[launcher_at_light,_loaditems]];
	}
	else
	{
		_magMass = getNumber (configFile >> "CfgWeapons" >> launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (300 / _magMass);
		
		atLightCrateArr append [[launcher_at_light,_loaditems]];
		
		_atLightAmmoArr = launcher_at_light_ammoPool;
		
		{
			_atLightAmmoArr pushback (_x select 0);
		} forEach launcher_at_light_ammo;

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

_sanCollected append san_t1_u;
_sanCollected append san_t1_v;
_sanCollected append san_t1_b;
_sanCollected append san_t2_u;
_sanCollected append san_t2_v;
_sanCollected append san_t2_b;

{
	medicCrateArr append [[_x select 0,(_x select 1) * 2]];
}forEach _sanCollected;

//------------------------------------------------------------------
// 	Explosives Supplies
//------------------------------------------------------------------
explosivesCrateArr = [];

_div = count eod_explosive_pool;
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
}forEach eod_explosive_pool;

//------------------------------------------------------------------
// 	Mines Supplies
//------------------------------------------------------------------
minesCrateArr = [];
_loadItems = 0;
_div = count eod_mines_pool;

_loadMass = floor (600 / _div);

{
	_itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
	_loadItems = floor (_loadMass / _itemMass);
	minesCrateArr append [[_x,_loadItems]];
}forEach eod_mines_pool;


//------------------------------------------------------------------
//
//	Push Public Variables
//
//------------------------------------------------------------------

publicVariable "uniforms";
publicVariable "helmet";
publicVariable "vests";
publicVariable "facewear";

publicVariable "backpack_std";
publicVariable "backpack_med";
publicVariable "backpack_big";

publicVariable "watch";
publicVariable "map";
publicVariable "compass";
publicVariable "binocs";

publicVariable "terminal_t1";
publicVariable "terminal_t2";
publicVariable "terminal_t3";

publicVariable "nvg";
publicVariable "radio";
publicVariable "lrAvailable";
publicVariable "lrRoles";
publicVariable "lrRadio";

publicVariable "san_t0_u";
publicVariable "san_t0_v";
publicVariable "san_t0_b";
publicVariable "san_t1_u";
publicVariable "san_t1_v";
publicVariable "san_t1_b";
publicVariable "san_t2_u";
publicVariable "san_t2_v";
publicVariable "san_t2_b";

publicVariable "invStd_u";
publicVariable "invStd_v";
publicVariable "invStd_b";

publicVariable "throwablesStd";
publicVariable "throwablesExt";

publicVariable "std_rifle";
publicVariable "std_scope";
publicVariable "std_attachement1";
publicVariable "std_attachement2";
publicVariable "std_attachement3";
publicVariable "std_rifleAmmo_inv";

publicVariable "std_handgun";
publicVariable "std_handgun_scope";
publicVariable "std_handgun_attachment1";
publicVariable "std_handgun_attachment2";
publicVariable "std_handgunAmmo_inv";

publicVariable "std_weapons_alt";

publicVariable "rifleman_uniform";
publicVariable "rifleman_vest";
publicVariable "rifleman_helmet";
publicVariable "rifleman_backpack";
publicVariable "rifleman_rifle";
publicVariable "rifleman_scope";
publicVariable "rifleman_attachement1";
publicVariable "rifleman_attachement2";
publicVariable "rifleman_attachement3";
publicVariable "rifleman_ammo_inv";
publicVariable "rifleman_handgun";
publicVariable "rifleman_handgun_scope";
publicVariable "rifleman_handgun_attachement1";
publicVariable "rifleman_handgun_attachement2";
publicVariable "rifleman_handgunAmmo_inv";
publicVariable "rifleman_watch";
publicVariable "rifleman_map";
publicVariable "rifleman_compass";
publicVariable "rifleman_binocs";
publicVariable "rifleman_terminal";
publicVariable "rifleman_radio";
publicVariable "rifleman_inv_u";
publicVariable "rifleman_inv_v";
publicVariable "rifleman_inv_b";
publicVariable "rifleman_equipment_AR";

publicVariable "grenadier_uniform";
publicVariable "grenadier_vest";
publicVariable "grenadier_helmet";
publicVariable "grenadier_backpack";
publicVariable "grenadier_rifle";
publicVariable "grenadier_scope";
publicVariable "grenadier_attachement1";
publicVariable "grenadier_attachement2";
publicVariable "grenadier_attachement3";
publicVariable "grenadier_ammo_inv";
publicVariable "grenadier_handgun";
publicVariable "grenadier_handgun_scope";
publicVariable "grenadier_handgun_attachement1";
publicVariable "grenadier_handgun_attachement2";
publicVariable "grenadier_handgunAmmo_inv";
publicVariable "grenadier_UGL_inv";
publicVariable "grenadier_watch";
publicVariable "grenadier_map";
publicVariable "grenadier_compass";
publicVariable "grenadier_binocs";
publicVariable "grenadier_terminal";
publicVariable "grenadier_radio";
publicVariable "grenadier_inv_u";
publicVariable "grenadier_inv_v";
publicVariable "grenadier_inv_b";
publicVariable "grenadier_equipment_ar";

publicVariable "mg_uniform";
publicVariable "mg_vest";
publicVariable "mg_helmet";
publicVariable "mg_backpack";
publicVariable "mg_rifle";
publicVariable "mg_scope";
publicVariable "mg_attachement1";
publicVariable "mg_attachement2";
publicVariable "mg_attachement3";
publicVariable "mg_ammo_inv";
publicVariable "mg_handgun";
publicVariable "mg_handgun_scope";
publicVariable "mg_handgun_attachement1";
publicVariable "mg_handgun_attachement2";
publicVariable "mg_handgunAmmo_inv";
publicVariable "mg_watch";
publicVariable "mg_map";
publicVariable "mg_compass";
publicVariable "mg_binocs";
publicVariable "mg_terminal";
publicVariable "mg_radio";
publicVariable "mg_inv_u";
publicVariable "mg_inv_v";
publicVariable "mg_inv_b";
publicVariable "mg_equipment_ar";

publicVariable "mgAssis_uniform";
publicVariable "mgAssis_vest";
publicVariable "mgAssis_helmet";
publicVariable "mgAssis_backpack";
publicVariable "mgAssis_rifle";
publicVariable "mgAssis_scope";
publicVariable "mgAssis_attachement1";
publicVariable "mgAssis_attachement2";
publicVariable "mgAssis_attachement3";
publicVariable "mgAssis_ammo_inv";
publicVariable "mgAssis_handgun";
publicVariable "mgAssis_handgun_scope";
publicVariable "mgAssis_handgun_attachement1";
publicVariable "mgAssis_handgun_attachement2";
publicVariable "mgAssis_handgunAmmo_inv";
publicVariable "mgAssis_watch";
publicVariable "mgAssis_map";
publicVariable "mgAssis_compass";
publicVariable "mgAssis_binocs";
publicVariable "mgAssis_terminal";
publicVariable "mgAssis_radio";
publicVariable "mgAssis_inv_u";
publicVariable "mgAssis_inv_v";
publicVariable "mgAssis_inv_b";
publicVariable "mgAssis_equipment_ar";

publicVariable "autorifle_uniform";
publicVariable "autorifle_vest";
publicVariable "autorifle_helmet";
publicVariable "autorifle_backpack";
publicVariable "autorifle_rifle";
publicVariable "autorifle_scope";
publicVariable "autorifle_attachement1";
publicVariable "autorifle_attachement2";
publicVariable "autorifle_attachement3";
publicVariable "autorifle_ammo_inv";
publicVariable "autorifle_handgun";
publicVariable "autorifle_handgun_scope";
publicVariable "autorifle_handgun_attachement1";
publicVariable "autorifle_handgun_attachement2";
publicVariable "autorifle_handgunAmmo_inv";
publicVariable "autorifle_watch";
publicVariable "autorifle_map";
publicVariable "autorifle_compass";
publicVariable "autorifle_binocs";
publicVariable "autorifle_terminal";
publicVariable "autorifle_radio";
publicVariable "autorifle_inv_u";
publicVariable "autorifle_inv_v";
publicVariable "autorifle_inv_b";
publicVariable "autorifle_equipment_ar";

publicVariable "dm_uniform";
publicVariable "dm_vest";
publicVariable "dm_helmet";
publicVariable "dm_backpack";
publicVariable "dm_rifle";
publicVariable "dm_scope";
publicVariable "dm_attachement1";
publicVariable "dm_attachement2";
publicVariable "dm_attachement3";
publicVariable "dm_ammo_inv";
publicVariable "dm_handgun";
publicVariable "dm_handgun_scope";
publicVariable "dm_handgun_attachement1";
publicVariable "dm_handgun_attachement2";
publicVariable "dm_handgunAmmo_inv";
publicVariable "dm_watch";
publicVariable "dm_map";
publicVariable "dm_compass";
publicVariable "dm_binocs";
publicVariable "dm_terminal";
publicVariable "dm_radio";
publicVariable "dm_inv_u";
publicVariable "dm_inv_v";
publicVariable "dm_inv_b";
publicVariable "dm_equipment_ar";

publicVariable "launcher_uniform";
publicVariable "launcher_vest";
publicVariable "launcher_helmet";
publicVariable "launcher_backpack";
publicVariable "launcher_rifle";
publicVariable "launcher_scope";
publicVariable "launcher_attachement1";
publicVariable "launcher_attachement2";
publicVariable "launcher_attachement3";
publicVariable "launcher_ammo_inv";
publicVariable "launcher_handgun";
publicVariable "launcher_handgun_scope";
publicVariable "launcher_handgun_attachement1";
publicVariable "launcher_handgun_attachement2";
publicVariable "launcher_handgunAmmo_inv";

publicVariable "launcher_at";
publicVariable "launcher_at_attachement1";
publicVariable "launcher_at_attachement2";
publicVariable "launcher_at_attachement3";
publicVariable "launcher_at_ammo";

publicVariable "launcher_aa";
publicVariable "launcher_aa_attachement1";
publicVariable "launcher_aa_attachement2";
publicVariable "launcher_aa_attachement3";
publicVariable "launcher_aa_ammo";

publicVariable "launcher_at_light";
publicVariable "launcher_at_light_attachement1";
publicVariable "launcher_at_light_attachement2";
publicVariable "launcher_at_light_attachement3";
publicVariable "launcher_at_light_ammo";

publicVariable "launcher_watch";
publicVariable "launcher_map";
publicVariable "launcher_compass";
publicVariable "launcher_binocs";
publicVariable "launcher_terminal";
publicVariable "launcher_radio";
publicVariable "launcher_inv_u";
publicVariable "launcher_inv_v";
publicVariable "launcher_inv_b";
publicVariable "launcher_equipment_ar";

publicVariable "launcher_ammo_pool";

publicVariable "eod_uniform";
publicVariable "eod_vest";
publicVariable "eod_helmet";
publicVariable "eod_backpack";
publicVariable "eod_rifle";
publicVariable "eod_scope";
publicVariable "eod_attachement1";
publicVariable "eod_attachement2";
publicVariable "eod_attachement3";
publicVariable "eod_ammo_inv";
publicVariable "eod_handgun";
publicVariable "eod_handgun_scope";
publicVariable "eod_handgun_attachement1";
publicVariable "eod_handgun_attachement2";
publicVariable "eod_handgunAmmo_inv";
publicVariable "eod_watch";
publicVariable "eod_map";
publicVariable "eod_compass";
publicVariable "eod_binocs";
publicVariable "eod_terminal";
publicVariable "eod_radio";
publicVariable "eod_inv_u";
publicVariable "eod_inv_v";
publicVariable "eod_inv_b";
publicVariable "eod_equipment_ar";

publicVariable "engineer_uniform";
publicVariable "engineer_vest";
publicVariable "engineer_helmet";
publicVariable "engineer_backpack";
publicVariable "engineer_rifle";
publicVariable "engineer_scope";
publicVariable "engineer_attachement1";
publicVariable "engineer_attachement2";
publicVariable "engineer_attachement3";
publicVariable "engineer_ammo_inv";
publicVariable "engineer_handgun";
publicVariable "engineer_handgun_scope";
publicVariable "engineer_handgun_attachement1";
publicVariable "engineer_handgun_attachement2";
publicVariable "engineer_handgunAmmo_inv";
publicVariable "engineer_watch";
publicVariable "engineer_map";
publicVariable "engineer_compass";
publicVariable "engineer_binocs";
publicVariable "engineer_terminal";
publicVariable "engineer_radio";
publicVariable "engineer_inv_u";
publicVariable "engineer_inv_v";
publicVariable "engineer_inv_b";
publicVariable "engineer_equipment_ar";

publicVariable "jtac_uniform";
publicVariable "jtac_vest";
publicVariable "jtac_helmet";
publicVariable "jtac_backpack";
publicVariable "jtac_rifle";
publicVariable "jtac_scope";
publicVariable "jtac_attachement1";
publicVariable "jtac_attachement2";
publicVariable "jtac_attachement3";
publicVariable "jtac_ammo_inv";
publicVariable "jtac_handgun";
publicVariable "jtac_handgun_scope";
publicVariable "jtac_handgun_attachement1";
publicVariable "jtac_handgun_attachement2";
publicVariable "jtac_handgunAmmo_inv";
publicVariable "jtac_watch";
publicVariable "jtac_map";
publicVariable "jtac_compass";
publicVariable "jtac_binocs";
publicVariable "jtac_terminal";
publicVariable "jtac_radio";
publicVariable "jtac_inv_u";
publicVariable "jtac_inv_v";
publicVariable "jtac_inv_b";
publicVariable "jtac_equipment_ar";

publicVariable "sql_uniform";
publicVariable "sql_vest";
publicVariable "sql_helmet";
publicVariable "sql_backpack";
publicVariable "sql_rifle";
publicVariable "sql_scope";
publicVariable "sql_attachement1";
publicVariable "sql_attachement2";
publicVariable "sql_attachement3";
publicVariable "sql_ammo_inv";
publicVariable "sql_handgun";
publicVariable "sql_handgun_scope";
publicVariable "sql_handgun_attachement1";
publicVariable "sql_handgun_attachement2";
publicVariable "sql_handgunAmmo_inv";
publicVariable "sql_watch";
publicVariable "sql_map";
publicVariable "sql_compass";
publicVariable "sql_binocs";
publicVariable "sql_terminal";
publicVariable "sql_radio";
publicVariable "sql_inv_u";
publicVariable "sql_inv_v";
publicVariable "sql_inv_b";
publicVariable "sql_equipment_ar";

publicVariable "gl_uniform";
publicVariable "gl_vest";
publicVariable "gl_helmet";
publicVariable "gl_backpack";
publicVariable "gl_rifle";
publicVariable "gl_scope";
publicVariable "gl_attachement1";
publicVariable "gl_attachement2";
publicVariable "gl_attachement3";
publicVariable "gl_ammo_inv";
publicVariable "gl_handgun";
publicVariable "gl_handgun_scope";
publicVariable "gl_handgun_attachement1";
publicVariable "gl_handgun_attachement2";
publicVariable "gl_handgunAmmo_inv";
publicVariable "gl_watch";
publicVariable "gl_map";
publicVariable "gl_compass";
publicVariable "gl_binocs";
publicVariable "gl_terminal";
publicVariable "gl_radio";
publicVariable "gl_inv_u";
publicVariable "gl_inv_v";
publicVariable "gl_inv_b";
publicVariable "gl_equipment_ar";

publicVariable "sniper_uniform";
publicVariable "sniper_vest";
publicVariable "sniper_helmet";
publicVariable "sniper_backpack";
publicVariable "sniper_rifle";
publicVariable "sniper_scope";
publicVariable "sniper_attachement1";
publicVariable "sniper_attachement2";
publicVariable "sniper_attachement3";
publicVariable "sniper_ammo_inv";
publicVariable "sniper_handgun";
publicVariable "sniper_handgun_scope";
publicVariable "sniper_handgun_attachement1";
publicVariable "sniper_handgun_attachement2";
publicVariable "sniper_handgunAmmo_inv";
publicVariable "sniper_Usniper_inv";
publicVariable "sniper_watch";
publicVariable "sniper_map";
publicVariable "sniper_compass";
publicVariable "sniper_binocs";
publicVariable "sniper_terminal";
publicVariable "sniper_radio";
publicVariable "sniper_inv_u";
publicVariable "sniper_inv_v";
publicVariable "sniper_inv_b";
publicVariable "sniper_equipment_ar";

publicVariable "spotter_uniform";
publicVariable "spotter_vest";
publicVariable "spotter_helmet";
publicVariable "spotter_backpack";
publicVariable "spotter_rifle";
publicVariable "spotter_scope";
publicVariable "spotter_attachement1";
publicVariable "spotter_attachement2";
publicVariable "spotter_attachement3";
publicVariable "spotter_ammo_inv";
publicVariable "spotter_handgun";
publicVariable "spotter_handgun_scope";
publicVariable "spotter_handgun_attachement1";
publicVariable "spotter_handgun_attachement2";
publicVariable "spotter_handgunAmmo_inv";
publicVariable "spotter_watch";
publicVariable "spotter_map";
publicVariable "spotter_compass";
publicVariable "spotter_binocs";
publicVariable "spotter_terminal";
publicVariable "spotter_radio";
publicVariable "spotter_inv_u";
publicVariable "spotter_inv_v";
publicVariable "spotter_inv_b";
publicVariable "spotter_equipment_ar";

publicVariable "pilot_uniform";
publicVariable "pilot_vest";
publicVariable "pilot_helmet";
publicVariable "pilot_backpack";
publicVariable "pilot_facewear";
publicVariable "pilot_rifle";
publicVariable "pilot_scope";
publicVariable "pilot_attachement1";
publicVariable "pilot_attachement2";
publicVariable "pilot_attachement3";
publicVariable "pilot_ammo_inv";
publicVariable "pilot_handgun";
publicVariable "pilot_handgun_scope";
publicVariable "pilot_handgun_attachement1";
publicVariable "pilot_handgun_attachement2";
publicVariable "pilot_handgunAmmo_inv";
publicVariable "pilot_watch";
publicVariable "pilot_map";
publicVariable "pilot_compass";
publicVariable "pilot_binocs";
publicVariable "pilot_terminal";
publicVariable "pilot_radio";
publicVariable "pilot_nvg";
publicVariable "pilot_inv_u";
publicVariable "pilot_inv_v";
publicVariable "pilot_inv_b";
publicVariable "pilot_equipment_ar";

publicVariable "fpilot_uniform";
publicVariable "fpilot_vest";
publicVariable "fpilot_helmet";
publicVariable "fpilot_backpack";
publicVariable "fpilot_facewear";
publicVariable "fpilot_rifle";
publicVariable "fpilot_scope";
publicVariable "fpilot_attachement1";
publicVariable "fpilot_attachement2";
publicVariable "fpilot_attachement3";
publicVariable "fpilot_ammo_inv";
publicVariable "fpilot_handgun";
publicVariable "fpilot_handgun_scope";
publicVariable "fpilot_handgun_attachement1";
publicVariable "fpilot_handgun_attachement2";
publicVariable "fpilot_handgunAmmo_inv";
publicVariable "fpilot_watch";
publicVariable "fpilot_map";
publicVariable "fpilot_compass";
publicVariable "fpilot_binocs";
publicVariable "fpilot_terminal";
publicVariable "fpilot_radio";
publicVariable "fpilot_nvg";
publicVariable "fpilot_inv_u";
publicVariable "fpilot_inv_v";
publicVariable "fpilot_inv_b";
publicVariable "fpilot_equipment_ar";

publicVariable "crew_uniform";
publicVariable "crew_vest";
publicVariable "crew_helmet";
publicVariable "crew_backpack";
publicVariable "crew_facewear";
publicVariable "crew_rifle";
publicVariable "crew_scope";
publicVariable "crew_attachement1";
publicVariable "crew_attachement2";
publicVariable "crew_attachement3";
publicVariable "crew_ammo_inv";
publicVariable "crew_handgun";
publicVariable "crew_handgun_scope";
publicVariable "crew_handgun_attachement1";
publicVariable "crew_handgun_attachement2";
publicVariable "crew_handgunAmmo_inv";
publicVariable "crew_watch";
publicVariable "crew_map";
publicVariable "crew_compass";
publicVariable "crew_binocs";
publicVariable "crew_terminal";
publicVariable "crew_radio";
publicVariable "crew_nvg";
publicVariable "crew_inv_u";
publicVariable "crew_inv_v";
publicVariable "crew_inv_b";
publicVariable "crew_equipment_ar";

publicVariable "diver_uniform";
publicVariable "diver_vest";
publicVariable "diver_helmet";
publicVariable "diver_backpack";
publicVariable "diver_facewear";
publicVariable "diver_rifle";
publicVariable "diver_scope";
publicVariable "diver_attachement1";
publicVariable "diver_attachement2";
publicVariable "diver_attachement3";
publicVariable "diver_ammo_inv";
publicVariable "diver_handgun";
publicVariable "diver_handgun_scope";
publicVariable "diver_handgun_attachement1";
publicVariable "diver_handgun_attachement2";
publicVariable "diver_handgunAmmo_inv";
publicVariable "diver_watch";
publicVariable "diver_map";
publicVariable "diver_compass";
publicVariable "diver_binocs";
publicVariable "diver_terminal";
publicVariable "diver_radio";
publicVariable "diver_nvg";
publicVariable "diver_inv_u";
publicVariable "diver_inv_v";
publicVariable "diver_inv_b";

publicVariable "diverEOD_inv_u";
publicVariable "diverEOD_inv_v";
publicVariable "diverEOD_inv_b";

publicVariable "diverMedic_inv_u";
publicVariable "diverMedic_inv_v";
publicVariable "diverMedic_inv_b";

publicVariable "diver_equipment_ar";


publicVariable "rifleman_armory";
publicVariable "grenadier_armory";
publicVariable "mg_armory";
publicVariable "mgAssis_armory";
publicVariable "autorifle_armory";
publicVariable "dm_armory";
publicVariable "launcher_armory";
publicVariable "launcherAssis_armory";
publicVariable "medic_armory";
publicVariable "eod_armory";
publicVariable "engineer_armory";
publicVariable "jtac_armory";
publicVariable "sql_armory";
publicVariable "gl_armory";
publicVariable "sniper_armory";
publicVariable "spotter_armory";
publicVariable "pilot_armory";
publicVariable "fpilot_armory";
publicVariable "crew_armory";
publicVariable "diver_armory";
publicVariable "diverEOD_armory";
publicVariable "diverMedic_armory";

publicVariable "ammoCrateArr";
publicVariable "heavyammoCrateArr";
publicVariable "grenadeCrateArr";
publicVariable "atMissileCrateArr";
publicVariable "aaMissileCrateArr";
publicVariable "atLightCrateArr";
publicVariable "medicCrateArr";
publicVariable "explosivesCrateArr";
publicVariable "minesCrateArr";
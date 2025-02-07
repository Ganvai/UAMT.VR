//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Mission Control Center
//
// Here you can manage all Mission Control Center features that
// are available for the groups or Players you defined in mccAccess
//
// Is useful for ZEUS controlled Missions to start or end a mission
//------------------------------------------------------------------
//------------------------------------------------------------------
mCC = true;							// Makes the Mission Control Center available for Players or Groups defined in mccAccess as well as Zeus.
									// Needed if you want these players to control the features listed below

mccAccess[] = {TOC,s0_1};				// Here you can give Groups or Player-Slots (identified by Variable Name set in 3DEN) access to the Mission Control Center 
									// in Self Interaction. Zeus Menu is not changed by that.

mccStart = true;					// Mission-Start available in MCC - doesn't change Zeus access for Debug

mccEnd = true;						// Mission-End available in MCC - doesn't change Zeus access for Debug

mccContinue = true;					// Mission Continue End available in MCC - doesn't change Zeus access for Debug

mccHeal = true;						// Players with Access can FUll HEAL another Player via ACE Self-Interact


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Gameplay Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------
									
missionstartedfeat	= true; 		// Sets if the "Mission Started"-Feature is available. When the Feature is "true", all Players have the Base Menu everywhere available 
									// until the Mission is started and missionStarted == true;
									// After the Mission was started, every JIP Player will be spawned on the Object "base" (Therefor its best if its a flat object, like invisible Helipads).
									// This is used for Missions that start "in field" where spawning would be normally dangerous or the Base Menu is not available. 
									// Needs the Variable "missionStarted". It is automatically set when you use the Mission Start function in the MCC as Zeus or when
									// you start an Intro sequence via: "scripts\UAMT-Scripts\MissionControlCenter\MCC_chapter_missionstart.sqf" remoteExec ["execVM",2];
									// Look into the script to learn more about functions how you can call it.
									// If you don't use it, you can set it manually in a Script via:
									// missionStarted = true;
									// publicVariable "missionStarted";

loadCargoFeature = true;			// Activate Load Cargo Feature. Adds a function to Supply Boxes and Containers to be loaded as Cargo on ViV Vehicles.
									// Although it is possible for nearly every object, right now it supports only objects you find in Een Editor under "Supplies"
									// Can be used in combination with the Supply Point to create resupply chains in the battlefield. 
									// Vehicle Ammo Boxes are also transportable with a HEMTT Flatbed ;-) .

endAllDead = false;					// When activated ends the Mission when every player is dead or uncontious. Can be nice to add extra punishment but think 
									// twice before using it in longer missions.


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Faction & Roles
//
// All Loadout related Features can be activated here
// 
//------------------------------------------------------------------
//------------------------------------------------------------------
// Faction
#include "loadouts\Nato-2035_config_sgn\CfgFactionEquipment.hpp" // Change path to the Faction you want to use in your mission

FortifyToolCamo		= "wood";			// Selects the Camo of the Items created with the Fortify Tool. Available are "wood" and "arid"

// Loadout Customisation
allowArmory			= true;			// Armory is available ingame.
allowLoadouts		= true;			// Players can switch their roles ingame.

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//		Weapon Proficiency
//
// Gives a bonus to the main weapon class defined in the loadouts
// and also a malus when handling a non proficient weapon
//
// By default, the standard rifle bonus only applies to 
// the Role Rifleman, for all other roles that use a standard rifle
// there will be the default values.
//
// Handguns recieve no bonus.
//------------------------------------------------------------------
//------------------------------------------------------------------
weaponProficiency 	= true;			// Enables the Weapon Proficiency System. This gives a Bonus for the Weapon Class attached to the role
wPSwayPro			= 0.6;			// Weapon Sway with proficient weapons. 1 is default.
wPRecoilPro			= 0.6;			// Recoil with proficient weapons. 1 is default.
wPSwayDef			= 0.9;			// Weapon Sway with all Weapon Classes that are not in wPNonProWeapons. Default Arma Value is 1.
wPRecoilDef			= 0.9;			// Recoil with with all Weapon Classes that are not in wPNonProWeapons. Default Arma Value is 1.

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Difficulty Setup
//
// Here you can setup special traits for the Players to make
// missions easier (or harder).
// 
//------------------------------------------------------------------
//------------------------------------------------------------------
unitLevel = "default";	//Choose from some Presets we made for you. If you want to configure it by yourself, choose "custom".

// default: All the Arma default settings.
// improved: A higher camouflage and load setting that seems a bit more realistic.
// special: Camouflage, load and Damage threshhold are increased to a setting where a properly trained soldier would be.
// operator: Resembles more the performance of a Tier One Operator with a good camouflage and high stamina.
// custom: Lets you define the values by yourself.

camouflageCnfg = 1;	// Makes it easier for enemies to spot you. 0 means you are easy to spot, 1 is Game default.
audibCnfg = 1; 		// Defines how good the enemy AI can hear you. 1 is Default
loadCnfg = 1; 		// Defines how much weight affects your stamina. 1 is Default
acePerfCnfg = 1; 	// Performance Factor for ACE Advanced Fatigue
aceDmgCnfg = 1; 	// Unit Damage Threshhold for ACE Medical


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Support Features
//
// Configuration of Support Features
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
//					UAMT Message Config
//
// All Support features in the UAMT have custom messages as text and
// with audio messages in english.
//------------------------------------------------------------------
supportMessages = true;			// Activate/Deactivate audio messages for all UAMT support functions. Not recommended as important informations for players will be lost.
supportControlName = "TOC";		//The Name that is shown in Radio Messages from all Support Functions from UAMT. Something like TOC, Oberkommando, CO or whatever you come up with.
supportCustomAudio = false;		//Plays Custom Audio messages. If you don't like them, set it to false. It will still send Status Reports,
									//but just with generic radio chatter sound. And no, there will be no translations to other languages. English was hard enough XD.

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Insertion Feature
//
// Gives the Players Options on how they want to Insert for this
// Mission.
// HALO, Helicopter and Vehicle Inerstion available.
// Needs several Predefined Elements in the Mission.
// See Showcase Insertion in the Original UAMT Mission
//
// Every insertion method spawns a task for the players with
// description and position of the insertion vehicle.
//
// Mission will only continue of EVERY Player is in the vehicles.
//
// All Vehicles configured here will be locked and Fuel set to
// zero so no abuse is possible. Keep in mind that some vehicles
// cannot be locked (like Little Birds for example). These will
// still have Zero fuel.
//------------------------------------------------------------------
//------------------------------------------------------------------
insFeature = true; //Activates the Insertion Feature
insEnableHALO = true; // Enables HALO option in insertion menu
insEnableHeli = true; // Enables Helo option in insertion menu
insEnableGroundV = true; // Enables Wheeled option in insertion menu
insIntro = true; // Plays a short Intro with text given further down in the Intro Generator and Camera Positions from the Template. If these Markers are deleted, this will throw an error.
insPrepareTasks = true; // Generates tasks for Preparation that give more detailed information about the Insertion System and its Options. Tasks can be found in initServer.sqf
insCustomAudio = true; // Activates custom Audio Voicelines for all Insertion methods
insTimeFeat = true; // Gives the Players the option to choose time of operation
insTimeObj = "insTimeLaptop"; // Variable Name of the Object the Time Feature is attached to
insMethodObj = "insFlightControl"; // Variable Name of the Object the Time Feature is attached to
				
//Insertion HALO
insHALOVeh = "halo_1"; // Name of the Halo Vehicle.
insHALODoors[] = {"Door_rear_source"}; // Array of Doors to animate for start and Halo. Ignores 'wrong' values
												// Vanilla Chinook Ramp: "Door_rear_source"
												// Vanilla Ghost Hawk / Mi-48: "door_L","door_R"
												// Vanilla Merlin : "door_back_R","door_back_L","CargoRamp_Open"
												// Vanilla Blackfish: "Door_1_source"
												// CUP CH-53, C-130, Osprey: "ramp_bottom","ramp_top"
												// CUP Chinook HC-6: "Ani_Hatch1","Ani_Hatch2"
												// CUP Merlin: "dvere_l","dvere_p","rampa"
												// CUP UH-60: "doors"
											// To find doors look up the Vehicle in Config Viewer, Scroll down to User Actions and look for actions to close or open the doors. 
											
												
//------------------------------------------------------------------
// 			HALO Parachute Crate
//
// Crate that will spawn when choosing HALO Insertion. Makes
// the HALO insertion compatible with/without BackpackOnChest Mod
// If no BackpackOnChest is loaded, players will be able to store
// Their Backpacks in the crate and recieve a parachute in exchange.
// The Crate will be moved close to the drop position where players can
// then retrieve their backpacks.
//
// If BackpackOnChest is loaded, this crate will simply hold the given 
// parachutes.
//------------------------------------------------------------------
parachuteCrate = "insHaloCrate"; 	// Variable name of the crate you placed for the parachutes.
insHALOParachutes = "B_Parachute"; // Parachute that will be put in the Box or given out via the no BackpackOnChest function
insHALOParachutesCount = 30;		// Number of parachutes put in the crate when BackpackOnChest is loaded

//Insertion Helo
insHeloVeh[] = {"insHelo_1","insHelo_2","insHelo_3","insHelo_4"}; // Array of Helicopters for Insertion Feature.
insHeloDoors[] = {"door_L","door_R"}; // See doors for HALO for help

//Insertion Cars
insCarVeh[] = {"insCar_1","insCar_2","insCar_3","insCar_4"}; // Array of Cars for Insertion Feature


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Casualty Feature
//
// Marks positions of killed Civilians (or friendlies if enabled)
// including the shooters name.
// Also gives audio and text messages with shooter name
// 
// Will use Support Audio Configs for messages.
//------------------------------------------------------------------
//------------------------------------------------------------------
cFcivil = true; // Enables/Disables the Killed Civilian Feature
cFfriendlies = true; // Enables messages when killing friendlys
cFFriendlySides[] = {"west","independent"};	// Side which are considered friendlies. 
											// Available sides: "west","east","indipendent"


//------------------------------------------------------------------
//------------------------------------------------------------------
//
// 						Supply Point Feature
//
// Activates the Supply Point Feature. Makes it possible to spawn
// boxes with Ammo, Grenades and so on at a specific Object (can be
// a container or even a Vehicle).
//
// Boxes are automatically filled with Equipment from 
// "faction_equipment.sqf" in your loadout folder.
//
// What boxes are spawnable is configured while creating a new loadout
// in:
//		"loadouts/Faction-Name/supplySystem/supplyPointInit.sqf"
//
// and should be already predefined with the Faction
//
// Will use Support Audio Configs for messages.
//------------------------------------------------------------------
//------------------------------------------------------------------
supplyPointFeature	= true;					//Sets if a Supply Point Feature is available.
supplyPoints[]		= {						//Defines Objects that offer Supply Crate Spawn. Is a multidimensional Array!
						{supplypointstatic,		//Objectvariable defined in Eden Editor from the Object that has the ACE Options to spawn the crates. Has to exist, otherwise throws an Error!
						3,						//Distance to Object in Meters
						90},	  				//Direction relative to the Object. For example, if you want to spawn the crate at the back of a Truck, this should be 180
						{supplypointMobile,7,180}
					};



//------------------------------------------------------------------
//------------------------------------------------------------------
//
// 						Supply Drop
//
// Makes it possible for Players to call in a Supply Drop by 
// Helicopter.
// Helicopter can be called to current Position or you can choose
// a Position on the Map.
// The Supply Drop Crate has the same spawning mechanisms as a 
// Supply Point.
//------------------------------------------------------------------
//------------------------------------------------------------------
supplyDropFeature		= true;			//Enables the Supply Drop Function. Needs the Supply Crates Configured in Loadout. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later.

supplyDropRoles[] 		= {TOC,s0_1, Groupleader, JTAC};	//Defines who has access to call in a Supply Drop. Can be a GroupID, a PlayerVariable or a role. 
										// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
										// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
										// When using GroupID, every Player in the specific group can call it in.

supplyDropCargo			= 1;			// How the Cargo Crate is filled. 1: With contents for all Players | 2: Cargo only for the Group that is calling the Supply Drop
supplyDropStatus 		= 0;			// The supplyStatus manages the accessebility of the function.
										// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
										// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
										// 1 : Call -> Another player is calling the function and it is therefor not available for any other Player (deprecated)
										// 2 : Progress  -> The Supply Drop was called and is now being executed and it is therefor not available for any other player
										// 3 : Cooldown -> The supply drop  was executed and is now in Cooldown before it is avialable again
										// 4 : Not available -> The supply drop is not available until the Missionmaker sets the Status manually to 0
										//						-> The function will not be shown in the players ace selfinteract menu until its under 4
										//					supplyDropStatus = 0;
										//					publicVariable "supplyDropStatus";
										//		IF YOU DON'T WANT ANY SUPPLY DROP use supplyDropFeature instead!
										
supplyDropMax			= 99;			// Limits the Supply Drops. As the Supply Drop is pretty powerful, you need to be careful how to balance the amount of available Drops for your Mission.
										// Even if you want supplies to be scarce, it's best practice to never use only one Drop. because Arma being Arma and the crate can get lost on Buildings or trees.

supplyDropVehicle		= "B_Heli_Transport_03_unarmed_F"; 	// Vehicle Class of Supply Drop Helicopter. Only Helicopters are working. Theoretically you can use a plane, but they are to fast and the Supply Drop is likely to getting lost.

supplyDropPilot			= "B_Helipilot_F";	// Class of the Pilot sitting in the Helo... leave it as it is, nobody will see this guy anyway.

supplyDropDist 			= 1000;			// Gives the Minimum Distance from the delivery Position to where the Vehicle will spawn. 
										// Adapt this depending in how large your Mission area is and how many people will be spread over the map. 
										// 2000 to 5000m should be fine normally.
										
supplyDropDamage 		= false;		// Configure if the Supply Drop Helicopter can be damaged.

supplyDropDelay 		= 1;			// Defines the delay until a new Supply Drop is available again. Balancing and "realism".

supplyDropDelayPenalty 	= 10;			// Defines how much time is added as penalty when the Supply Drop Helicopter was destroyed on its mission. Balancing and "realism".


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				Helicopter Transport
//
//
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
chtFeature = true;				// Activates the Heli Fire Support Feature. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later.

chtStatus = 0;			// The Status manages the accessebility of the function.
							// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
							// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
							// 1 : Call -> Another player is calling this Support and it is therefor not available for any other Player
							// 2 : Progress  -> The Support was called and is now being executed and it is therefor not available for any other player
							// 3 : Cooldown -> The Support was executed and is now in Cooldown before it is avialable again
							// 4 : Not available -> The support is not available until the Missionmaker sets the Status manually to 0
							//						-> The function will not be shown in the players ace selfinteract menu until its under 4
							//					artiStatus = 0;
							//					publicVariable "artiStatus";
							//		IF YOU DON'T WANT ANY Artillery use artiFeature instead!
							
chtHelis[] = {"B_Heli_Light_01_F","B_Heli_Light_01_F","B_Heli_Transport_01_F"};	// Helicopter Classes available for Transport. If you want several Helicopters of one class, just give another one in this array (see example Heli_Light).
chtRoles[] = {JTAC,Groupleader};	// Roles that can call in Heli Transport
chtSpawn = "chtSpawnMrk";		// Location the Helicopter will spawn. Place an empty marker and input its name here.
chtDespawn = "chtDespawnMrk";	// Location the Helicopter will despawn. Place an empty marker and input its name here.
chtCivil = false;				// If true, Helicopters are on civil side, won't be attacked or react to hostile forces.
chtDamage = false;				// If false, Helicopter is invulnerable. Recommended as the AI Pilots sometimes do weird shit even without enemy in contact XD
chtRespawn = 0;					// If larger then 0, helicopters respawn when they were destroyed after the given time (in seconds).
chtCooldown  = 120;				// Time in seconds until a Helicopter is ready to fly again.


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Artillery Support Feature
//
// Makes Artillery Support available for specific roles
// You can Limit the Artillery by a Cooldown and a Max Count
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

artiFeature = true; //Activates the Artillery Support Feature. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later.

artiRoles[] = {TOC, Groupleader, JTAC, s1}; // Defines the Roles that have Access to the Artillery Menu. 
											// Can be a Group Variable (set in Init of the Playerslot, not the Group Variable), a Role or a Player Variable
											// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
											// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
											// When using GroupID, every Player in the specific group can call it in.

artiStatus 	= 0;			// The Status manages the accessebility of the function.
							// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
							// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
							// 1 : Call -> Another player is calling this Support and it is therefor not available for any other Player (deprecated)
							// 2 : Progress  -> The Support was called and is now being executed and it is therefor not available for any other player
							// 3 : Cooldown -> The Support was executed and is now in Cooldown before it is avialable again
							// 4 : Not available -> The support is not available until the Missionmaker sets the Status manually to 0
							//						-> The function will not be shown in the players ace selfinteract menu until its under 4
							//					artiStatus = 0;
							//					publicVariable "artiStatus";
							//		IF YOU DON'T WANT ANY Artillery use artiFeature instead!

//------------------------------------------------------------------
// Here you define which Artillery Supports are available
// Kepp in Mind you have to Place the Units on the Map, name them
// accordingly and find out the Right Ammo Type
//------------------------------------------------------------------
artillery[] = {
				{
					"3x Searas",	//Name that is shown in the Menu
					{sea_1,sea_2,sea_3},	//Variables of the Artillery (Must be on the Object, for example the Mortar itself, not the Unit controlling it. Same for Vehicles.)
					{
						{					//Ammo Type Array
								"12Rnd_230mm_rockets",		// Ammo Type Classname
								"230mm Rockets",			// Ammy Type Display Name
								300,							// Available Rounds of Ammo
								true						// No Fire Zone (true means can not fire in no fire zone)
						} 
					},
					true									//Makes Artillery Unit Available in GUI - WIP
				},
				
				{
					"3x Sholef",
					{sho_1,sho_2,sho_3},
					{
						{"32Rnd_155mm_Mo_shells","155mm Shells",100,true},
						{"2Rnd_155mm_Mo_Cluster","155mm Cluster",50,true},
						{"6Rnd_155mm_Mo_smoke","155mm Smoke",100,false},
						{"2Rnd_155mm_Mo_LG","155mm Laser Guided",100,true}
					},
					true
				},
				
				{
					"3x Mortars",
					{mort_1,mort_2,mort_3},
					{
						{"8Rnd_82mm_Mo_shells","82mm Shells",800,true},
						{"8Rnd_82mm_Mo_Flare_white","82mm Flare",800,false},
						{"8Rnd_82mm_Mo_Smoke_white","82mm Smoke",800,false}
					},
					true
				}
};

artiCooldown = 10; 	// Cooldown for Artillery after strike. Balancing gameplay element. 
					// I would recommend 120 to 300 at least so they don't just bomb a place to the ground

artiNoFireZones[] = {noFireZone_1,noFire_2}; 	// No Fire Zones. Artillery can not be fired in these Areas. 
											// Place an Elipse or Rectangle Area on the map and give its Variable Name here.
											// Doesn't make a difference if the Area is Visible or not.


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				VLS Fire-Support
//
// Lets the defined roles order a strike with VLS Missiles. 
//
// Roles in vlsRoles can call the Strike via Equipment defined in vls 
// equipment (Laserdesignator prefered). This limits their calls to
// only what they can see.
//
// Roles in vlsRolesCMDR have access to a terminal where they can 
// choose a position on a map to strike. Very powerful with unlimited
// range. 
// 
// vlsAiDisabled should be true, if you want the VLS Turret only react
// on strikes ordered via this function.
// This will deactivate any AI capabilities for the VLS to automatically
// fire. 
// This will also disable the Turret in all UAV Terminals in the 
// Mission, see the players cannot take control of it. 
// This is the recommended setting, as the Turrets AI has sometimes
// unforseen behaviour.
//
// vlsDelay is meant to be used if you want to simulate the vls platform to
// not be 'on the map'. If you have a specified compound/ship for the vls
// launchplatform on the map, this can be 0.
//
// Has two options to be called. All players in vlsRoles can call a Strike
// when looking through a Laserdesignator (or other equipment you defined).
// This means, they need to have a view onto the target.
//
// All players in vlsRolesCMDR can order a strike via graphic interface
// and call it on any position on the map.
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

vlsFeature = true;				// Activates the vls Function. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later.
vlsName = "vls_1";				// Variable name of the vls turret you placed on the map.

vlsStatus = 0;					// The Status manages the accessebility of the function.
								// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
								// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
								// 1 : Call -> Another player is calling this Support and it is therefor not available for any other Player
								// 2 : Progress  -> The Support was called and is now being executed and it is therefor not available for any other player
								// 3 : Cooldown -> The Support was executed and is now in Cooldown before it is avialable again
								// 4 : Not available -> The support is not available until the Missionmaker sets the Status manually to 0
								//						-> The function will not be shown in the players ace selfinteract menu until its under 4
								//					missionNameSpace setVariable ["vlsStatus",4,true];
								//		IF YOU DON'T WANT ANY VLS set vlsFeature to false instead!

vlsHERounds = 100;				// Count of Cruise Missiles that can be fired.
vlsClusterRounds = 100;			// Count of Cluster Missiles that can be fired.
vlsDelay = 10;					// Delay of rocketlaunch after strike is ordered in seconds.
vlsCooldown = 10;				// Cooldown time in seconds until another vls Strike is available again.
vlsRoles[] = {JTAC,Groupleader};	// Roles that can call a vls strike via Equipment on sight.
vlsRolesCMDR[] = {TOC,JTAC};		// Roles that can call in a VLS strike via Interface
vlsEquipment[] = {laserDesignator};  // Equipment with which role defined players can call a vls strike.
vlsNeedsLaser = true;			// Target can only be marked if Equipment has a laser. If you want that players can call the strike with binocs or rangefinder, set to false.
vlsAllowDrones = false;			// Target can be marked and called when in drones. Drones need to have laser.
vlsNoFireZones[] = {noFireZone_1}; // Areas where no vls Strike is allowed. Place an area on the map and give it a variable name. Enter the variable name here. It doesn't matter if area is visible or not

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				CAS Strike
//
// Call in a fixed Wing CAS Strike on a Position marked with a Laserdesignator
// 
// Has two options to be called. All players in casRoles can call a Strike
// when looking through a Laserdesignator (or other equipment you defined).
// This means, they need to have a view onto the target.
//
// All players in casRolesCMDR can order a strike via graphic interface
// and call it on any position on the map.
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
casFeature = true;				// Activates the CAS Feature. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later. 

casStatus = 0;					// The Status manages the accessebility of the function.
								// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
								// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
								// 1 : Call -> Another player is calling this Support and it is therefor not available for any other Player (deprecated)
								// 2 : Progress  -> The Support was called and is now being executed and it is therefor not available for any other player
								// 3 : Cooldown -> The Support was executed and is now in Cooldown before it is avialable again
								// 4 : Not available -> The support is not available until the Missionmaker sets the Status manually to 0
								//						-> The function will not be shown in the players ace selfinteract menu until its under 4
								//					vlsStatus = 0;
								//					publicVariable "vlsStatus";
								//		IF YOU DON'T WANT ANY CAS use casFeature instead!
								
casClass = "B_Plane_CAS_01_dynamicLoadout_F";	// Plane that flies the CAS (musst be one of the vanilla CAS vehicle Types
casMGruns = 100;					// How Many MG runs the CAS can do
casMisRuns = 100;					// How many missile runs the CAS can do
casBombRuns = 100;				// How many bomb runs the CAS can do
casDelay = 10;					// How much time goes by between call and the spawn of the CAS plane
casCooldown = 30;				// Cooldown time until CAS is available again
casPenalty = 30;					// How long it takes until CAS is available again after the plane was shot down. If 0 the CAS won't be available once it was lost!
casRoles[] = {JTAC,Groupleader};	// Roles that can call in a CAS strike in the field via Laser Designator (defined in casEquipment).
casRolesCMDR[] = {TOC,JTAC};			// Roles that can call in a CAS strike from and to everywhere via Interface and map marker. Very powerful, meant for high ranking officers not at the front lines.
casEquipment[] = {laserdesignator};	// Equipment with which you can call in a CAS strike.
casNeedsLaser = true;			// Target can only be marked if Equipment has a laser. If you want that players can call the strike with binocs or rangefinder, set to false.
casAllowDrones = true;			// Target can be marked and called when in drones. Drones need to have laser.
casNoFireZones[] = {noFireZone_1}; // Areas where CAS strikes are prohibited. Place an area on the map and give it a variable name. Enter the variable name here. It doesn't matter if area is visible or not

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				Helicopter Fire Support
//
// Calls in rotary fire support for an allowed time
// 
// Has two options to be called. All players in hfsRoles can call the
// Helicopters to their position.
//
// All players in casRolesCMDR can order send the helis via graphic interface
// everywhere on the map.
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
hfsFeature = true;				// Activates the Heli Fire Support Feature. This permanently deactivates this feature for the mission and it won't be accessible even if you set it to true later.

hfsStatus = 0;					// The Status manages the accessebility of the function.
								// While 0 to 3 are Ingame Status, 4 is to manage by the Missionmaker
								// 0 : Available -> Use this if you want it to be accessibel from the very beginning of the Mission
								// 1 : Call -> Another player is calling this Support and it is therefor not available for any other Player
								// 2 : Progress  -> The Support was called and is now being executed and it is therefor not available for any other player
								// 3 : Cooldown -> The Support was executed and is now in Cooldown before it is avialable again
								// 4 : Not available -> The support is not available until the Missionmaker sets the Status manually to 0
								//						-> The function will not be shown in the players ace selfinteract menu until its under 4
								//					vlsStatus = 0;
								//					publicVariable "vlsStatus";
								//		IF YOU DON'T WANT ANY HFS use hfsFeature instead!
								
hfsArray[] = {{"B_Heli_Light_01_dynamicLoadout_F",2,3},{"B_Heli_Attack_01_dynamicLoadout_F",1,5}};	// Array of Helicopters. Multidimensional Array {{"Heli Class",Number spawned Helis,Number Support can be called},{more Elements}}
hfsDuration = 60;				// How long the helicopters will stay on Target
hfsDistance = 2000;				// How far away the Helicopters are spawned
hfsDelay = 10;					// Delay until helicopters are spawned
hfsCooldown = 30;				// How long until Heli Fire Support is available again
hfsPenalty = 30;				// Penalty if one or more helis get shot.
hfsRespawn = false;				// Enable respawn for lost helicopters. If false, the fire support is not available anymore for this element.
hfsRoles[] = {JTAC,Groupleader};	// Roles that can call in Heli Fire Support
hfsRolesCMDR[] = {TOC,JTAC};			// Roles that can call in a Heli Fire Support from and to everywhere via Interface and map marker. Very powerful, meant for high ranking officers not at the front lines.
hfsNoFireZones[] = {noFireZone_1};	// Areas where Heli Fire Support is prohibited. Place an area on the map and give it a variable name. Enter the variable name here. It doesn't matter if area is visible or not.


//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				Random Vehicle IED Feature
//
// Searches for Vehicles of the given Faction and randomly props them
// with IEDs. 
//
// The IEDs explode when players (only players) want to access the inventory
// or enter the vehicle.
//
// Before exploding, a beeping sound is played for 4 seconds.
//
// EODs can check all vehicles from the faction for IEDs and defuse them
// if they find one.
//
// We have a function you can use in the vehicles init if you want only 
// specific cars or other objects rigged. See more in:
// "scripts\UAMTScripts\functions\fn_vehicleIED.sqf"
//
// If you have cars that need to be NOT with IED put this into the cars init:
// this setVariable ["IEDFree",true,true];
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
rVifFeature = true;				// Activates the Random IED Feature
rVifFactions[] = {"OPF_F","CIV_F"}; // Side of which vehicles shall be propped with IEDs. Available: "BLU_F","OPF_F","CIV_F","IND_F"
rVifChance = 0.5;				// Chance a vehicle has an IED in %. 1 means every vehicle, 0 means never. Recommended 0.1.
rVifBombType = 0;				// Bomb Type: 0 means normal Vehicle detonation. 1 is a medium sized explosion, 2 a very large one. Recommended 0.

//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//
//				Random IED Feature
//
// Searches units of the given Faction and randomly props them
// with IEDs.
//
// We have a function you can use in the units init if you want to have trap
// specific units with IEDs. See more in:
// "scripts\UAMTScripts\functions\fn_iedUnit.sqf"
//
// If you have units that need to be NOT with IED put this into the units init:
// this setVariable ["IEDFree",true,true];
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
rifFeature = true;				// Activates the Random IED Feature
rifFactions[] = {"OPF_F","IND_F"}; // Side of which vehicles shall be propped with IEDs. Available: "BLU_F","OPF_F","CIV_F","IND_F"
rifChance = 0.5;				// Chance a vehicle has an IED in %. 1 means every vehicle, 0 means never. Recommended 0.2.


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Welcome  Message
//
// Shows a GUI Welcome MEssage that gives an Overview over the 
// Custom UAMT Features available in this Mission as well as a
// referal to the UAMT Manual on the Map for further features
//------------------------------------------------------------------
//------------------------------------------------------------------
welcomeMessage = true;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Radio Code Feature
//
// Here you can configure the Radio Code Feature.
// With enhanced mode on true, everyone can send radio codes.
// Enhanced mode off means only Group and Squadleaders can send them
// You edit the Radio codes to your liking as well
//------------------------------------------------------------------
//------------------------------------------------------------------
radioCodeFeature	= true;			// Enables an ACE Self Interact Option for Players to send Radio Codes (meant for Groupleaders communicating with TOC)

recipientConfig[]	= {Groupleader,Squadleader,TOC,Fox,Hotel,Sierra};	// Sets who recieves sended radio codes. You can enter Loadout roles and GroupIDs in here. 
																		// Seperater must be a comma: ","
																		// If you create new Groups that are not Having a Groupleader or are Special Tactics Groups where everybody 
																		// should be able to use Radio Codes, they must be added here manually.

EverybodyCanListen 	= true;			// Enables the Option to Leave and Join the Radio Code Channel for everyone. If not, only the Roles and Groups in recipientconfig 
									// will see the Radiocode Options. Should be true by default as this only can help players understand whats up in a bigger scenario.

EverybodyCanSend	= false;		// Enables the Option for everybody to send Radio Code Messages.
									// Also, this is in fact how it works in reality, we know that this depends highly on the discipline of the Playerbase, 
									// so feel free to set it on false if it is not working ingame

// Here you can edit the Radio Codes. Right now it is limited to 10. You cannot add more Codes. If you want fewer Codes, just empty the string (example: radio10M = "";)
radio1M 			= "Code 1 - TOC Come In";
radio2M 			= "Code 2 - Arrival on Scene";
radio3M 			= "Code 3 - Assignment Complete";
radio4M 			= "Code 4 - Waiting for Orders";
radio5M 			= "Code 5 - Tango spotted";
radio6M 			= "Code 6 - Recieving Fire";
radio7M 			= "Code 7 - In Firefight";
radio8M 			= "Code 8 - Personal Wounded";
radio9M 			= "Code 9 - Clear";
radio10M			= "Code 10 - Groupleader Down";

// Sadly by now, you cannot add or remove Radio Codes :-(

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Ambience Features
//
// You can activate certain ambience features here.
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

//------------------------------------------------------------------
// Ambient Fly By
//
// The Ambient Fly By Script spawns an airborne Vehicle on a random Position, flying over a random Players position.
// The Vehicles are setCaptive, so wont be engaged or engage anyone.
// You can choose between Planes or Helos or use both
// Consider which side they are on or if use at all when making AA Part of your Mission (for immerion reasons)
// The AFB will always be close to at least one Player. Consider this when setting the spawn time so it doesn't happen to often
//------------------------------------------------------------------
AFBActivated = true;	// Activate AFB for Planes
AFBPHeight = 300;			// Height for Planes. Needed for some of the larger planes like C-130, which are likely to crash at heights under 300.
AFBmaxTime = 1800;			// Max Time between AFB, std. 30 min = 1800
AFBmidTime = 1200;			// Mid Time between AFB, std. 20 min = 1200
AFBminTime = 600;			// Min Time between AFB, std. 10 min = 600
AFBdistance = 5000;			// Distance to the Player in which the Vehicle is spawned. Consider Mission Area, Player Count and spread of them on the Map during the Mission.
AFBVehicles[] = {B_Plane_Fighter_01_F,B_Plane_CAS_01_dynamicLoadout_F,B_Heli_Light_01_dynamicLoadout_F,B_Heli_Transport_03_F,B_Heli_Transport_01_F}; //Planes are randomly choosen from this list. Just seperate by coma ","
AFBAmount = 3;				// Maximum of random amount of Vehicles spawned at the same time

//------------------------------------------------------------------
// Ambience Enhancement Features
//------------------------------------------------------------------
groundfog			= false;		// Activates Groundfog script, creating clouds of fog close to the ground in the vicinity of the Player.
									// Great for atmosphere, but can makes playing a lot harder, depending on the strenght you set as AI isn't affected by the fog
groundfogstrength	= 3;			//Sets how strong the Ground Fog is
									// 1 = weak - Just a little bit of fog, best for bright daylight in Jungle
									// 2 = light - Some fog, good for morning hours in Jungle
									// 3 = mid - You can see the fog clearly. In morning hours it gives great atmosphere but in bright daylight, 
									//     makes it a bit more challenging to see.
									// 4 = strong - Definetly a challenge and in bright daylight it is challenging to spot enemies
									// 5 = extreme - The original Ground Fog script setting. Makes it very difficult to spot AI or other players
									// I recommend trying the lower values first and checking them out at the daytime your Mission will be,
									// as lightning can have a huge impact on how challenging it becomes. If you want it just for some atmosphere,
									// stick with 1 or 2.
									
foggybreath			= false;		// Activates the foggy breath script, creating little clouds in the face of the player simulating cold air.

sandstorm			= false;		// Activates litle Dust Clouds moving in the vicinity of the Player. Great for Desert environments

colorgrading		= "";			// You can activate Color Grading to enhance your setting
									// Available Color Gradings are:
									// "" - No color grading added, just pure vanilla gloss
									// "Night" - For enhanced visibility in Night Missions without NVGs
									// "Desert/Winter" - Enhanced brightness, little bit of grain, perfect for Desert or Winter Settings
									// "Winter Day" - Enhanced Blue Values, brightness and grain, adding to a freezing atmosphere
									// "African" - Brownish, bright african settings, perfect for enhancing hot environments
									// "Jungle Rainy" - enhanced green values, a bit of grain added, perfect for rainy jungle environments
									// "Jungle" - enhanced green values and brightness, for dense jungle

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Instant Intro / Outro Maker
//
// Instant Intro Maker is an option to show a special Intro when the
// Mission is started by TOC / Zeus. You can choose between several
// music tracks that are played and give a short overview about
// what your Mission is about
//
// Starting the Intro is possible by Zeus, Players that have access
// to the Mission Control Center (see begining of this file) or via
// script:
// [[true],"scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionstart.sqf"]remoteExec ["execVM",2];
// 
// For more customisation options see:
// "scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionstart.sqf"
//------------------------------------------------------------------
//------------------------------------------------------------------
intro 				= 4;			// Choose the Intro Music that is played. All Tracks are available in ARMA without any restrictions (even the DLC ones)!
									// Every Track is cut so the intro is something around 55 seconds long.
									// 1 This is War a - The original This is War
									// 2 Fighter Jets - Theme from the Jets DLC. A bit more orchestral and with military feel
									// 3 This is War Heli Remix - From the Heli DLC. Very epic variation of This is War
									// 4 Tac Ops DLC Opening 3 - This is War Variation from Tac Ops DLC. More orchestral and calm but epic
									// 5 Conquistador - Nice track with guitar and a more folk like feeling
									// 6 This is War Tanks - From Tanks DLC. Orchestral, heavy and epic
									
									// Please keep in mind that, if you are using the Insertion  Feature, for the Insertion System Intros, only a shortened Version of the Tanks track is playing,
									// as the timing is more critical.
									
									
// Text shown in the Intro. Is used also for the Insertion Intro sequence!
// To change the logo on the last screen, replace the clan-logo.paa in the folder "images"
introM = "Introducing sentence in starting sequence";
backgroundM = "Background about the Operation";
missionM = "Mission: <br/>1. Target<br/>2. Target<br/>3. Target";
titleHeader = "O P E R A T I O N   S I T E - DD.MM.YYYY - U N I T";
title = "Missionname";

// After the Intro sequence, a Ticker is shown:
tickerCountry = "Land, Region";
tickerLocation = "Map-Location";

//------------------------------------------------------------------
// 					Outro
//
// Starting the Outro is possible by Zeus, Players that have access
// to the Mission Control Center (see begining of this file) or via
// script:
// [[_success,_scripted,_customSeq,_customSleep],"scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionend.sqf"]remoteExec ["execVM",2];
// 
// For more customisation options see:
// "scripts\UAMTScripts\MissionControlCenter\MCC_chapter_missionend.sqf"
//------------------------------------------------------------------

outroS 				= 7; //Choose an Outro Track for Mission Success Ending from the list below
outroC 				= 6; //Choose an Outro Track for Mission To Be Continued Ending from the list below

/*
1 : This is War Tank DLC Remix
2 : Welcome to Tanoa Pt 4
3 : Contact Outro 2
4 : This is War (6th Anniversary Remix)
5 : Track_O_03 
6 : Track_O_12
7 : Track_P_04
*/
						
successM = "M I S S I O N   A C C O M P L I S H E D"; //Message on the first Screen of the Outro
secondSuccessM = "Mission Fulfilled: HVT Elimnated, Convoy Destroyed"; //Message on the Second Screen of the Outro
tySuccessM = "Put the safety on and report for AAR"; //Third message, that will be written under a personal 'Thank You' to the Player

continueM = "T O   B E   C O N T I N U E D"; //Message on the first Screen of the Outro
secondContinueM = "Not every Mission Objective could be done today. But this is far from over!"; //Message on the Second Screen of the Outro
tyContinueM = "Prepare bivouac and get your MREs out"; //Third message, that will be written under a personal 'Thank You' to the Player

//------------------------------------------------------------------
// 					Intro Jingle
//
// Plays when Players load into the Mission. Should be a short one.
// You can give a start parameter and a fade in time.
//
// You can also give custom music tracks that you define in cfgMusic
//------------------------------------------------------------------

// Use this Line when you don't want an intro jingle.
// Don't forget to comment out the other Intro Jingle!!!
// iJName = ""; iJStart = 0; iJFade = 0;

// Recommended Opening Tracks in Vanilla:

// Tanks DLC: Good Neighbors
// Calm, with military feeling  Length: 21 seconds.
// iJName = "LeadTrack04_F_Tank"; iJStart = 9; iJFade = 1;

// This is War (VR Remix - loop)
// Short, electronic variation of This is War  Length: 14 seconds.
// iJName = "LeadTrack01b_F_Bootcamp"; iJStart = 18; iJFade = 2;

// Stage C: Event Track 02 (Broken Barricade - Alternative 1)
// Arma Theme with heavy electronics and rhythm. Length: 23 seconds.
// iJName = "EventTrack02b_F_EPC"; iJStart = 7; iJFade = 0.5;

// Stage B: Event Track 01 (Resist - Alternative)
// Ethnic Flute with Arabic feeling and light drums. Length: 16 seconds.
// iJName = "EventTrack01a_F_EPB"; iJStart = 12; iJFade = 1;

// Stage A: Event Track 01 (Fragmented - Alternative)
// Electronic with Drums. Length: 28 seconds.
// iJName = "EventTrack01_F_EPA"; iJStart = 0; iJFade = 0;

// Stage A: Event Track 01 (Fragmented - Alternative)
// Electronic without Drums.  Length: 28 seconds.
// iJName = "EventTrack01a_F_EPA"; iJStart = 0; iJFade = 0;

// Stage B: Event Track 03 (Recon)
// Actionintro with Arma 3 drums and ethnic feeling.  Length: 30 seconds.
// iJName = "EventTrack03_F_EPB"; iJStart = 0; iJFade = 0;

// Stage B: Event Track 03 (Recon - Alternative)
// Same as before with less drums.  Length: 30 seconds.
// iJName = "EventTrack03a_F_EPB"; iJStart = 0; iJFade = 0;

// Welcome To Tanoa - Part 1
// Very calm, atmospheric, guitar  Length: 33 seconds.
// iJName = "AmbientTrack02a_F_EXP"; iJStart = 0; iJFade = 0;

// Stave B: Event Track 02 (Ambush)
// Ethnic guitar and drums with military snares  Length: 22 seconds.
// iJName = "EventTrack02_F_EPB"; iJStart = 0; iJFade = 0;

// Stave B: Event Track 02 (Ambush - Alternative)
// Only ethnic drums  Length: 22 seconds.
 iJName = "EventTrack02a_F_EPB"; iJStart = 0; iJFade = 0;

// Stave A: Event Track 02 (Horizon Scan)
// Guitar, Synthies and Drums  Length: 36 seconds.
// iJName = "EventTrack02_F_EPA"; iJStart = 0; iJFade = 0;

// Stave A: Event Track 02 (Horizon Scan - Alternative)
// Same as before without drums. Very calm  Length: 36 seconds.
// iJName = "EventTrack02a_F_EPA"; iJStart = 0; iJFade = 0;

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						ModCheck
//
// Applying a Whitelist to the mods loaded by the Players.
// If Players are using Mod that are not whitelisted, they get a blackscreen
// with a message that they are using non whitelisted mods and a list of the
// mods that are not whitelisted and in their preset.
// They are also teleported to blacklistcage.
// 
// You can change the whitelist and also get some deeper information
// about the modcheck by looking into the file "scripts\UAMT-Scripts\modcheck.sqf"
//------------------------------------------------------------------
//------------------------------------------------------------------
modcheck			= true;	// Enables the Modcheck. Mod Whitelist is configured under "scripts\modcheck.sqf". Needs Blacklistcage in Mission available

modCheckOnlyLogging = true;	// Makes it that the modcheck is running only in the background, logging Players and their mods that are not on the Whitelist, 
							// without teleporting the Players away and forcing them to reload.
							// We found this very helpful at the beginning to get an overview over what was happening on our server.
							// Search your server log for "ModCheck" to find the logging entries.

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
mCC = true;							// Makes the Mission Control Center available for Players or Groups defined in mccAccess. Needed if you want these players to control the features listed below

mccAccess[] = {TOC,s0_1};				// Here you can give Groups or Player-Slots (identified by Variable Name set in 3DEN) access to the Mission Control Center 
									// in Self Interaction. Zeus Menu is not changed by that.

mccStart = true;					// Mission-Start available in MCC - doesn't change Zeus access for Debug

mccEnd = true;						// Mission-End available in MCC - doesn't change Zeus access for Debug

mccContinue = true;					// Mission Continue End available in MCC - doesn't change Zeus access for Debug

mccHeal = true;						// Access to Full Heal function in MCC


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Gameplay Features
//
//------------------------------------------------------------------
//------------------------------------------------------------------

baseRadius = 100;					// Radius around the object "base" where the base menu is available after missionStarted was set to true.
									
missionstartedfeat	= true; 		// Sets if the "Mission Started"-Feature is available. When the Feature is "true", all Players have the Base Menu everywhere available 
									// until the Mission is started and missionStarted == true;
									// After the Mission was started, every JIP Player will be spawned in the Base, defined in initPlayerLocal.sqf. 
									// This is used for Missions that start in field where spawning would be normally dangerous or the Base Menu is not available. 
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
//				Faction & Loadout Features
//
// All Loadout related Features can be activated here
// 
//------------------------------------------------------------------
//------------------------------------------------------------------
// Faction
faction 			= "Nato-2035_v2"; 	// Sets the Faction for the Mission start. You can find available Factions under Missionfolder\loadouts
FortifyToolCamo		= "wood";			// Selects the Camo of the Items created with the Fortify Tool. Available are "wood" and "arid"

// Loadout Customisation
allowArmory			= true;			// Armory is available ingame.
allowLoadouts		= true;			// Players can switch their roles ingame.


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
insEnableGroundV = false; // Enables Wheeled option in insertion menu
insIntro = true; // Plays a short Intro with text given further down in the Intro Generator and Camera Positions from the Template. If these Markers are deleted, this will throw an error.
insPrepareTasks = true; // Generates tasks for Preparation that give more detailed information about the Insertion System and its Options. Tasks can be found in initServer.sqf
insCustomAudio = true; // Activates custom Audio Voicelines for all Insertion methods
insTimeFeat = true; // Gives the Players the option to choose time of operation
insTimeObj = "insTimeLaptop"; // Variable Name of the Object the Time Feature is attached to
insMethodObj = "insFlightControl"; // Variable Name of the Object the Time Feature is attached to
				
//Insertion HAlo
insHALOVeh = "halo_1"; // Name of the Halo Vehicle.
insHALODoors[] = {"Door_rear_source"}; // Array of Doors to animate for start and Halo. Ignores 'wrong' values
												// Vanilla Chinook Ramp: "Door_rear_source"
												// Vanilla Ghost Hawk / Mi-48: "door_L","door_R"
												// Vanilla Merlin : "door_back_R","door_back_L","CargoRamp_Open"
												// CUP CH-53, C-130, Osprey: "ramp_bottom","ramp_top"
												// CUP Chinook HC-6: "Ani_Hatch1","Ani_Hatch2"
												// CUP Merlin: "dvere_l","dvere_p","rampa"
												// CUP UH-60: "doors"
											// To find doors look up the Vehicle in Config Viewer, Scroll down to User Actions and look for actions to close or open the doors. 
											
												

insNoBoC = true; 	// Extra function for HALO when you are Playing without the Backpack on Chest Mod. 
					// Spawns a Crate where Players have a Hold Action to store their Backpack and get a Parachute.
					// No extra Parachute in Arsenal or Vehicle needed!
					// It needs a Helipad called insNoBoCPos (see Template Mission for reference).
					// When the Halo Aircraft starts, it will move the Crate to the Drop Zone 
					// where Players can retrieve their gear.

//Insertion Helo
insHeloVeh[] = {"insHelo_1","insHelo_2","insHelo_3","insHelo_4"}; // Array of Helicopters for Insertion Feature.
insHeloDoors[] = {"door_L","door_R"}; // Look at Doors for HALO for extended Description

//Insertion Cars
insCarVeh[] = {"insCar_1","insCar_2","insCar_3","insCar_4"}; // Array of Cars for Insertion Feature


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Killed Civilian Feature
//
// Marks positions of killed Civilians with Shooter Name.
// Also gives voice messages and text messages with shooter name
// Has two escalation stages where the messages from TOC get more angry
// Also has an option to abort the Mission when to many civs are killed.
// 
//------------------------------------------------------------------
//------------------------------------------------------------------
civKillFeature = true; //Enables/Disables the Killed Civilian Feature
civEscalation1 = 5; // Gives a special warning when this number of Civ Kills is reached.
civEscalation2 = 10; // Gives a special warning when this number of Civ Kills is reached.
civAbortMission = false; // Ends the Mission with a special Message when number of Civ Kills is reached.
civAbortKillCount = 50; // Number of Civilian kills to abort mission.
civMessageSender = "TOC"; // Name of the Source who sends the Kill Messages


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
//					Overall Config
//------------------------------------------------------------------
supportControlName = "TOC";			//The Name that is shown in Radio Messages from all Support Functions from UAMT. Something like TOC, Oberkommando, CO or whatever you come up with.
supportCustomAudioMsg = true;		//Plays Custom Audio messages. If you don't like them, set it to false. It will still send Status Reports,
									//but just with generic radio chatter sound. And no, there will be no translations to other languages. English was hard enough XD.


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
supplyDropFeature		= true;			//Enables the Supply Drop Function. Needs the Supply Feature enabled. Needs Mission Control Center enabled.

supplyDropRoles[] 		= {TOC,s0_1, Groupleader, JTAC};	//Defines who has access to call in a Supply Drop. Can be a GroupID, a PlayerVariable or a role. 
										// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
										// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
										// When using GroupID, every Player in the specific group can call it in.

supplyDropOnStart 		= true;			// Gives the Player the possibility to call a Supply Drop right from the Start.
										// This Option can also be used to activate the Supply Drop later in the mission, for example when a Mission objective was fulfilled.
										// For this use: 
										// supplyDropAvailable = true;
										// publicVariable "supplyDropAvailable";

supplyDropMax			= 99;			// Limits the Supply Drops. As the Supply Drop is pretty powerful, you need to be careful how to balance the amount of available Drops for your Mission.
										// Even if you want supplies to be scarce, it's best practice to never use only one Drop. because Arma being Arma and the crate can get lost on Buildings or trees.

supplyDropVehicle		= "B_Heli_Transport_03_unarmed_F"; 	// Vehicle Class of Supply Drop Helicopter. Only Helicopters are working. Theoretically you can use a plane, but they are to fast and the Supply Drop is likely to getting lost.

supplyDropPilot			= "B_Helipilot_F";	// Class of the Pilot sitting in the Helo... leave it as it is, nobody will see this guy anyway.

SupplyDropMinDistSpawn 	= 2000;			// Gives the Minimum Distance from the delivery Position to where the Vehicle will spawn. 
										// Adapt this depending in how large your Mission area is and how many people will be spread over the map. 
										// 2000 to 5000m should be fine normally.

supplyDropDelay 		= 10;			// Defines the delay until a new Supply Drop is available again. Balancing and "realism".

supplyDropDelayPenalty 	= 10;			// Defines how much time is added as penalty when the Supply Drop Helicopter was destroyed on its mission. Balancing and "realism".


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Transport Feature
//
// Makes a Transport via Helicopter available 
// Only one Transport ist available at all times, so make
// the helicopter large enough for all Players.
//
// To activate this mid Mission see "trpOnStart" comment!
// 
// 
//------------------------------------------------------------------
//------------------------------------------------------------------
trpFeature 			= true;				// Enables the Transport Feature.

trpRoles[] 			= {TOC,Groupleader,JTAC,s0_1};		// Defines who has access to call in a Transport. Can be a GroupID, a PlayerVariable or a role.
										// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
										// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
										// When using GroupID, every Player in the specific group can call it in.

trpOnStart			= true;		// Sets if the Transport Call is always available from the get go. If you want to enable the Transport by yourself use:
								//  transportAvailable = true;
								//  publicVariable "transportAvailable";
								// in a Trigger or a script to enable the transport call in the MCC
								
trpVehicleClass 	= "B_Heli_Transport_03_unarmed_F"; // Vehicle Class Name of Transport Helicopter

trpSpawnPos[] 		= {5322.66,6460.94,0}; //Spawn location, where the Helo will spawn and also despawn. 

trpAllowDamage		= false;	// With true, you can make the Transport Helicopter vulnerable. Even though there is a function in the background
								//  that searches a safe area for the Transporter to land, things in Arma can happen. Also AA can take out all Players easily
								//  Be careful with that. To avoid Player frustration, I would recommend letting this on false even though its less reAliSTiC.

trpDelay			= 10;		// Delay in seconds until the Transport Call is available again after the Helicopter despawned. Balancing and "realism".

trpDelayPenalty		= 10;		// Time in seconds that is added onto the trpDelay when Transporter gets destroyed on its Mission. Balancing and "realism".


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

artiFeature = true; //Activates the Artillery Support Feature

artiRoles[] = {TOC, Groupleader, JTAC, s1}; // Defines the Roles that have Access to the Artillery Menu. 
											// Can be a Group Variable (set in Init of the Playerslot, not the Group Variable), a Role or a Player Variable
											// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
											// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
											// When using GroupID, every Player in the specific group can call it in.

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
								80,							// Available Rounds of Ammo
								true						// No Fire Zone (true means can not fire in no fire zone)
						} 
					},
					true									//Makes Artillery Unit Available in GUI - WIP
				},
				
				{
					"3x Sholef",
					{sho_1,sho_2,sho_3},
					{
						{"32Rnd_155mm_Mo_shells","155mm Shells",10,true},
						{"2Rnd_155mm_Mo_Cluster","155mm Cluster",5,true},
						{"6Rnd_155mm_Mo_smoke","155mm Smoke",10,false},
						{"2Rnd_155mm_Mo_LG","155mm Laser Guided",10,true}
					},
					true
				},
				
				{
					"3x Mortars",
					{mort_1,mort_2,mort_3},
					{
						{"8Rnd_82mm_Mo_shells","82mm Shells",80,true},
						{"8Rnd_82mm_Mo_Flare_white","82mm Flare",80,false},
						{"8Rnd_82mm_Mo_Smoke_white","82mm Smoke",80,false}
					},
					true
				}
};

artiCooldown = 10; 	// Cooldown for when the Artillery is available again. Balancing gameplay element. 
					// I would recommend 120 to 300 at least so they don't just bomb a place to the ground

artiNoFireZones[] = {noFire_1,noFire_2}; 	// No Fire Zones. Artillery can not be fired in these Areas. 
											// Place an Elipse or Rectangle Area on the map and give its Variable Name here.
											// Doesn't make a difference if the Area is Visible or not.


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					CAS Feature
//
// Has a Helicopter and a Plane version.
// Plane strikes one time with a chosen weapon on a location marked
// by user on the map.
// Helicopter sends chosen Helicopters to a location marked by user
// on the map and lets them stay there for the configured time
// 
//------------------------------------------------------------------
//------------------------------------------------------------------

casPlaneFeature = true; // Activates the CAS Plane Feature

casPlaneClass = "B_Plane_Fighter_01_Stealth_F";	// Class of the Plane you want to give Airsupport. Currently only one Plane configurable

casPlaneWeapons[] = {0,1,2,3}; 	// Array to select which Weapontypes for the strike are available. 
								// 0 : Machinegun
								// 1 : Missile
								// 2 : Machinegun and Missile
								// 3 : Bomb
								// You can choose different kind of Bombs by giving a different Vehicle Class

casPlaneRoles[] = {TOC,JTAC,s0_1};	// Roles that can call a CAS Plane Strike
									// Can be a Group Variable (set in Init of the Playerslot, not the Group Variable), a Role or a Player Variable
									// When using roles, keep in mind that when "Loadouts" are available, this role can change. 
									// If this feature is mission critical, it is always best practice to also give the player variable of, for example the Groupleader
									// When using GroupID, every Player in the specific group can call it in.

casPlaneAvailableFromStart = true; 	// Makes the Option available from the Start. 
									// Set this to false if you want to activate the feature later in the Mission, for example when a Mission objective was fulfilled.
									// For this use: 
									// casPlaneAvailable = true;
									// publicVariable "casPlaneAvailable";

casPlaneCooldown = 10; // Cooldown time before the next Airstrike is available

casPlaneCooldownPenalty = 10; // Penalty that gets added to cooldown if the Plane was destroyed on its Mission

casPlaneMaxCount = 10; 	// Max Amount of available Strikes
						// Can be changed later in the Mission with:
						// casPlaneMaxCount = 5;
						// publicVariable "casPlaneMaxCount";

casPlaneDelay = 10; // Delay between calling the Airstrik and actually spawning the Vehicle

casPlaneNoCASZones[] = {marker_1}; 	// No Fire Zones are Areas on the Map where no CAS is allowed.
									// Usea "Areas" in Eden Editor and enter their variable Name here.
									// Works with Circular and Rectangular Area. Doesn't matter of the Area is visible or not

//------------------------------------------------------------------
//			Helicopter CAS
//------------------------------------------------------------------

casHeloFeature = true; // Activates the CAS Helicopter Feature

casHeloArr[] = {{"B_Heli_Attack_01_dynamicLoadout_F",1},{"B_Heli_Light_01_dynamicLoadout_F",2},{"B_Heli_Light_01_dynamicLoadout_F",4}}; // Multidimensional Array. Gives Helicopter Class and Amount of Helicopter spawned

casHeloRoles[] = {TOC,JTAC,s1}; // Roles that can call the Helicopter CAS

casHeloAvailableFromStart = true; // Makes the Feature available from the Start

casHeloDuration = 60; // Duration how long the Helicopters wills tay on target before they retunr

casHeloCooldown = 10; // Cooldown after Helicopter left the ARea

casHeloCooldownPenalty = 10; // Cooldown Penalty when all Helicopters are destroyed

casHeloMaxCount = 10; // Max Amount of available Striks

casHeloDelay = 10; // Delay between calling the Helicopters and actually spawning the Vehicles

casHeloNoCASZones[] = {marker_1}; 	// No Fire Zones are Areas on the Map where no CAS is allowed. 
									// Usea "Areas" in Eden Editor and enter their variable Name here.
									// Works with Circular and Rectangular Area. Doesn't matter of the Area is visible or not


//------------------------------------------------------------------
//------------------------------------------------------------------
//
//					Welcome  Message
//
// The Welcome Message is displayed on the start for every Player.
// You can give the Player a short overview about your mission settings
// and special Options.
//
// If you don't want to show the Messages, just give an empty String "".
//------------------------------------------------------------------
//------------------------------------------------------------------
WelcomeMessage = "<t color='#ffffff' size='1.7' font='RobotoCondensed' shadow = '1' >This Mission is powered by the UAMT. Use ACE Selfinteract (STRG+WIN), go to Base Menu for Arsenal, Loadouts and Teleport to a Group.<br/>You can read more about all Functions in the Manual on the Map Screen.</t>";
MissionControlCenterMessage = "<t color='#ffffff' size='1.7' font='RobotoCondensed' shadow = '1' >Your Slot has access to the Mission Control Center. Depending on the Mission, you can start or end the Mission and have Access to debugging functions.<br/> Read more about that in the Manual on the Map Screen.</t>";

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
AFBPHeight = 300;			// Height for Planes. This is for some of the larger planes like C-130, which are likely to crash at heights under 300.
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

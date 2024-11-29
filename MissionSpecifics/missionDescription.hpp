//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
//
//						Mission HPP
//
// Extension of description.ext for mission specific entries.
//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------
//Mission Head ==================================================
author			= "Missionmaker";
loadScreen 		= "a3\data_f_exp_a\Data\FM_LEARN_Nexus1_ca.paa";

OnLoadName 		= "Missiontitle on Loadingscreen";
OnLoadMission   = "Punchline For Mission.";
OnLoadIntro 	= "";

overviewText 		= "Mission-Description in Server Mission Screen.<br/><br/>Addons: CBA, CUP, ACE<br/>Loadouts need TFAR!";
overviewTextLocked 	= "";
overviewPicture 	= "a3\data_f_exp_a\Data\FM_LEARN_Nexus1_ca.paa";

//  ===  Punktvergabe  ==========================================
minScore		= 0;
avgScore		= 800;
maxScore		= 1600;

//   ===   Missionszubehoer   ===================================
ShowGPS 			= 1;
ShowCompass 		= 1;
ShowRadio 			= 0;
ShowMap 			= 1;
ShowNotePad 		= 1;
ShowWatch 			= 1;
ShowDebriefing 		= 1;
showUAVFeed 		= 0;

forceRotorLibSimulation = 0;
allowFunctionsRecompile = 1;

//CBA Settings in Mission => If you want to use Server config, set this to 0.
cba_settings_hasSettingsFile = 1;

enableItemsDropping = 0;  	//Disable dropping items while swimming. 0 = Disable 1 = Enable
//joinUnassigned 	= 0;	//auto assigned a free playable slot in the mission lobby 0:disable 1:enable
allowFunctionsLog 	= 0;	//log to the RPT file 0:disable 1:enable
enableDebugConsole 	= 1;	//access to the Debug Console
showSquadRadar      = 0;  	//Defines if the Squad Radar is visible.
showGroupIndicator 	= 0;   	//When set to 1, changes default GPS mini map into a radar like display that indicates group members relative position to the player
disabledAI 			= 1;  	//When 1, removes all playable units which do not have a human player. When 0, a logging out player will have AI take control of his character

// Respawn ============================================================
respawn 			= 3; 
respawnDelay 		= 10;
//respawnVehicleDelay 	= 0;
//respawnDialog 	= 0;
//respawnButton 	= 0;
//respawnOnStart 	= -1;

//reviveDelay 		= 40; 	//The time it takes to revive an incapacitated unit. Medikit will halve this time. Must have "Revive" Respawn template enabled.
//reviveForceRespawnDelay  = 3;	//The time it takes for an incapacitated unit to force their respawn
//reviveBleedOutDelay 	= 600;	//The time it takes for a unit to bleed out

corpseManagerMode 	= 1;		//Type of removed bodies: 0 - none, 1 - all, 2 - only respawnable, 3 - only non-respawnable
corpseLimit 		= 20;		//Max number of bodies which can be available at the same time. When exceeded, start deleting immediately.
corpseRemovalMinTime = 1200;	//Minimal time in seconds a body stays in the scene (can't be removed sooner).
corpseRemovalMaxTime = 2400;	//Maximal time in seconds after which a dead body is removed (can't stay longer)

wreckManagerMode	= 1; 	//Type of removed wrecks: 0 - none, 1 - all, 2 - only respawnable, 3 - only non-respawnable
wreckLimit 			= 10; 	//Max number of wrecks which can be available at the same time. When exceeded, start deleting immediately.
wreckRemovalMinTime = 1200; 	//Minimal time in seconds a wreck stays in the scene (can't be removed sooner).
wreckRemovalMaxTime = 2400; 	//Maximal time in seconds after which a wreck is removed (can't stay longer)
zeusCompositionScriptLevel = 2; // 0: all scripts are forbidden - 1: only attributes are allowed (including custom attributes added by mods) - 2: all scripts are allowed including init scripts

// Kopf =========================================================
class Header
{
	gameType	= COOP;
	minPlayers	= 1;
	maxPlayers	= 91;
};

class CfgTaskEnhancements
{
	enable		= 1;		//0: disable new task features (default), 1: enable new task features & add new task markers and task widgets into the map
	3d			= 0;		//0: do not use new 3D markers (default), 1: replace task waypoints with new 3D markers
	3dDrawDist	= 600;		//3d marker draw distance (default: 2000)
	share		= 1;		//0: do not count assigned players (default), 1: count how many players have the task assigned
	propagate	= 1;		//0: do not propagate (default), 1: propagate shared tasks to subordinates
};
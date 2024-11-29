//------------------------------------------------------------------
//------------------------------------------------------------------
//
//				Mission Control Center
//
// The Modcheck feature is meant for larger clans that might have some
// Problems with Players using Mods giving them unfair advantages over others
// like NoStamina, NoWeaponSway, ACEArsenal everywhere or Mods that 
// can break game or server performance (from which there are pleanty).
// 
// This is annyoing no matter if you are a PVE or PVP clan.
//
// The ModCheck works as a Whitelist, meaning you are giving all Mods 
// that are allowed. If a Player loads other mods, he will be teleported
// into a secluded Area called blacklistcage and only see a black screen
// with a list of the mods he loaded you didn't "whitelist".
//
// The Player will be forced to restart the game and remove these mods.
//
// We had a very good experience with this in our clan in weekly missions with
// between 50 and 70 players and were able to improve server performance
// and stability by a huge amount.
//
// The Whitelist will of course need a lot of attention and communication
// to your players, but if you are struggeling with some 'special' people
// who just load every dogshit they found on the steam workshop, this
// might be a good solution.
//
// It can be activated in the config.cpp file and there also be set to 
// only Logging mode, which logs the Playername and the mods he is using 
// in the server log but doesn't force players to reload.
//
// This proofed useful for getting an overview before activating the
// ModCheck with "ban" mode
// Search your server log for "ModCheck" to find the logging entries.
//
// Why is this a Whitelist?
// Even though a whitelist might seem very restrictive, a blacklist would be 
// impossible to manage with all the mods on the Steam Workshop.
// Also, Players could just rename their mods and then still be able to use them.
//
// This feature needs a lot of good communication between the Missionmakers,
// Server Admins and your Players / Clan. But if you are struggeling with poor
// performance on your server or Players just ruining the fun for everyone,
// this is a gamechanger and really worth the work.
//------------------------------------------------------------------
//------------------------------------------------------------------


_modCheckResult = false;

// This is the whitelist as a onedimendional Array.
// The Numbers behind the Mod Name are the Steam IDs. These are needed for 
// Players who don't save the mod in in the standard workshop folder.
// You find the Steam ID by browsing the steam workshop in your browser and
// taking the Number at the end of the URL of the mod. 
// Here the Example from CBA:
// https://steamcommunity.com/workshop/filedetails/?id=450814997

_whitelistedMods = 	[
						"@CBA_A3", "450814997",
						"@ace", "463939057",
						"@ACE 3 Extension (Placeables)", "866772689",
						//"@KAT - Advanced Medical", "2020940806",
						
						//AI Mods - Only ever use one AI Mod / Mod-Set. The AIs don't work together
						"@ASR AI3", "642457233",
						//"@LAMBS_Danger.fsm", "1858075458",
						//"@LAMBS_Suppression", "1808238502",
						//"@LAMBS_Turrets", "1862208264",
						//"@LAMBS_RPG", "1858070328",
						//"@LAMBS_RPG_CUP", "2521194984",
						//"@LAMBS_RPG_RHS", "2521192995",
						//"@Vcom AI V3.4.0", "721359761",
						//"@DCO Soldier FSM", "2825929474",
						//"@DCO Vehicle.FSM - Vehicle AI Enhancement (No longer updated)", "2760263165", //No longer Supported, but V 2.0 is not out yet
						//"@DCO UnitScanner", "2811378998", //Needed if DCO Vehicle is used
						
						// Missionmaker Mods
						"@3den Enhanced", "623475643",
						"@ZEC - Zeus and Eden Templates - Building Compositions", "642912021",
						"@ZEI - Zeus and Eden Interiors", "1251859358",
						"@ZECCUP - Zeus and Eden Templates for CUP Terrains", "750186990",
						"@Advanced Developer Tools", "2369477168",
						
						// CUP
						"@CUP Terrains - Core", "583496184",
						"@CUP Terrains - CWA", "853743366",
						"@CUP Terrains - Maps", "583544987",
						"@CUP Terrains - Maps 2.0", "1981964169",
						"@CUP Units", "497661914",
						"@CUP Vehicles", "541888371",		
						"@CUP Weapons", "497660133",
						//"@Community Factions Project (CFP)", "1369691841",
						"@Interiors for CUP", "1883956552",
						
						//RHS and around
						//"@RHSUSAF", "843577117",
						//"@RHSAFRF", "843425103",
						//"@RHSGREF", "843593391",
						//"@RHSSAF", "843632231",
						//"@3CB Factions", "1673456286",
						
						//NIArms
						//"@NIArms Core", "667454606",
						//"@NIArms All in One", "1208517358",
						//"@NIArms All in One - CUP Compatibility", "1400569717",
						//"@NIArms Core - RHS Compatibility", "1541041923",
						
						//Bundeswehr Mod
						//"@BWMod", "1200127537",
						
						//VSM All in One because who does load the single files???
						//"@VSM All-In-One Collection", "823636749",
						

						//TFAR
						"@Task Force Arrowhead Radio (BETA!!!)", "894678801",
						"@Radio Animations for Task Force Radio", "1480333388",
						
						//ACRE 2
						//"@ACRE2", "751965892",
						
						//MilSim Extras
						//"@NATO Markers+", "1340701737",
						//"@cTab", "871504836",
						"@Enhanced Movement", "333310405",
						"@Enhanced Movement Rework", "2034363662",

						//----------------------------------
						//
						//	Maps
						//
						//----------------------------------
						
						//Maps by Tempaa (absolute Map God)
						"@Anizay", "1537973181",
						"@Hellanmaa", "1291778160",
						"@Lang Dan", "2843029228",	//Needs S.O.G. Prarie Fire DLC
						"@Cham", "1789554117",	// Needs Global MObilization DLC
						"@Vinjesvingen", "1757672655",
						"@Kujari", "1726494027",
						"@Suursaari", "1680294609",
						"@Northern Fronts Terrains", "1630816076",
						"@Summa", "1598087521",
						"@Ihantala Winter", "1494127420",
						"@Ihantala", "1494115712",
						"@Pulau", "1423583812",
						"@Ruha", "1368857262",
						
						//Maps by GOS_Makhno (Map God as well)
						"@G.O.S Dariyah", "701535490",
						"@G.O.S N'Djenahoud", "937515516",
						"@G.O.S Song Bin Tanh 2.0 (APEX)", "878119643",
						"@G.O.S Leskovets", "855464203",
						"@G.O.S N'ziwasogo", "694603075",
						"@G.O.S Gunkizli", "693153082",
						"@G.O.S Al Rayak", "648172507",
						"@G.O.S Kalu Khan", "643744158",				
						
						//Maps by Jujurat (Gotta check these out)
						"@Niakala", "2801060088",
						"@Sa'hatra", "3019928771",

						//Misc Entries totally worth Checking out
						"@Bala Murghab, Afghanistan", "2781043850", //Performance Heavy in MP but so detailed
						"@Rosche, Germany", "1527410521",
						"@UMB Colombia", "2266710560", //Tanoa with little water and some AWESOME Compounds
						
						"@Chernarus Redux", "1128256978",
						"@Libertad - AIO", "2734575927", //Tanoa Light, especially regarding Performance
						
						"@Kunduz River", "3078351739",						
						
						"@Fallujah 2.0", "2926828901",
						
						"@Angola Maps v1.3", "1446500688",

						//Maps needing JBad
						"@LYTHIUM", "909547724",
						"@Jbad", "520618345",


						//----------------------------------
						//
						//	Additional Client Side Mods
						//
						//----------------------------------
						
						//Gameplay
						"@Suppress", "825174634",
						"@Immerse", "825172265",
						"@CH View Distance", "837729515",
						"@Better Inventory", "2791403093",
						"@Window Breaker", "1578884800",
						"@Brush Clearing", "1889104923",
						"@Arsenal Search", "2060770170",
						"@ACE 3 Extension (Animations and Actions)", "766491311",
						"@Dismount Where You Look", "1841553455",
						"@Ride Where You Look", "2153127400",
						"@Project Infinite - Inspect weapons", "812441729",
						"@9Liners & Notepad", "1210050323",
						"@ACE Compat CUP Facewear", "2614664632",
						"@Head Range Plus - TrackIR Mod", "630737877",
						"@cb_blood", "2362277256",
						"@Enhanced Map Ace Version", "2467590475",
						"@DUI - Squad Radar", "1638341685",
						"@FHQ_GroupInfo", "1460411342",
						"@VileHUD", "1538673636",
						"@Death and Hit reactions", "2993442344",
						
						
						//Visual
						"@Blastcore Edited (standalone version)", "767380317",
						"@Vanilla smoke (for Blastcore Edited)", "853303947",	
						"@Blastcore Murr Edition Smoke Alternative", "2478519591",
						"@Blastcore Murr Edition", "2257686620",
						"@Dynamic Lights Extended", "2429580300",
						"@Real Lighting and Weather", "2809399991",
						"@Cinematic Lens Flare", "878502647",
						"@Splendid Lighting Modification", "2070681304",
						"@Fixed Splendid Lighting Modification", "2979710855",
						"@Cinematic Lens Flare x Splendid Lighting Compatibility", "2715797525",
						"@Bullets_Hit", "2190826124",
						"@ArmaFXP - Smoke Edit", "2147472177",
						"@Lushify", "2638049909",
						"@ReColor", "649832908",
						"@Fawks' Enhanced NVGs", "2513044572",
						"@BettIR (Legacy v0.2.1)", "2260572637",
						
						//Reduced Haze Mods
						"@Reduced Haze Mod v3.1", "1397683809",
						"@Lythium - Reduced Haze Mod ANZACSAS", "2904665257",
						"@Niakala - Reduced Haze Mod ANZACSAS", "2905489750",
						"@Sumava - Reduced Haze Mod ANZACSAS", "2997224666",
						"@Kujari Reduced Haze Mod - ANZACSAS", "2904319753",
						"@Anizay - Reduced Haze Mod ANZACSAS", "2905491647",
						
						//Sound
						"@DynaSound 2", "825181638",
						"@Enhanced Soundscape", "825179978",
						"@Enhanced Soundscape Plus", "2938312887",
						"@LAxemann's Environment Ducking", "2812569803",
						"@JSRS SOUNDMOD", "861133494",
						"@JSRS SOUNDMOD - CUP WEAPONS MOD SOUND SUPPORT", "1624803912",
						"@JSRS SOUNDMOD - CUP VEHICLES MOD SOUND SUPPORT", "1624804924",
						"@JSRS SOUNDMOD - Reloading Sounds", "1429098683",
						
						//Zeus Mods
						"@Zeus Enhanced", "1779063631",
						"@Zeus Enhanced - ACE3 Compatibility", "2018593688",
						"@Crows Zeus Additions", "2447965207",
						
						//Arma 3 Expansions
						"expansion",
						"kart",
						"heli",
						"mark",
						"jets",
						"argo",
						"orange",
						"tacops",
						"tank",
						"enoch",
						"aow",
						"curator"
					];


private _playermods = [];

_loadedMods = configSourceModList (configFile >> "CfgPatches");

{
	_result = false;
	_result = _x in _whitelistedMods;
	if (_result == false )then {
		_playermods pushBack _x;
	};		
} forEach _loadedMods;

if(count _playermods > 0) then {
	(format ["ModCheck: %1 is using Blacklisted Mods: %2",profileName, _playermods]) remoteExec ["diag_log", 2];
	
	if (getMissionConfigValue "modCheckOnlyLogging" != "true") then {
		_playermessage = format ["<t color='#ff0000' size='3'>You are using non whitelisted Mods.</t><br/><t color='#ffffff' size='1.5'> Please restart the game and remove the following mods from your preset: %1 </t>", _playermods];
		titleText [_playermessage, "BLACK FADED", 100, true, true];

		//Teleport to Cage of Shame:
		player setPos getPos blacklistcage;
		
		_modCheckResult = false;
	}
	else {
		_modCheckResult = true;
	};
}
else {
	_modCheckResult = true;
};

_modcheckResult;
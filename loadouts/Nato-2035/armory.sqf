/*
	Waffenkammer
	
	In der Waffenkammer können die Spieler ihr eigenes Loadout zusammenstellen.
	
	Im ersten Schritt wird in mehreren Arrays das gesamte Material abgebildet. 
	
	Im zweiten Schritt wird das Material entsprechend den Rollen der Spieler gesammelt.
	
	Zuletzt wird das Arsenal erstellt.
	
	Nachdem das Arsenal geschlossen wurde, wird es gelöscht. Dies ist nötig, damit bei einem
	Rollenwechsel die Items weiterhin korrekt dargestellt werden und nicht Items der vorigen
	Rolle angezeigt werden.
*/

// Get Player Role
_playerGrp = groupID group player;
_loadout = player getVariable "loadout";
//Needed for waitUntil after Arsenal is closed, combined with Event Handler on Arsenal
player setVariable ["arsenalClosed", false];

_equipment = [];

//------------------------------------------------------------------
//------------------------------------------------------------------
//
//			Rollenspezifisches Equipment erstellen
//
//------------------------------------------------------------------
//------------------------------------------------------------------	

//------------------------------------------------------------------
//						Rifleman
//------------------------------------------------------------------	

if (_loadout == "Rifleman") then {
	_equipment append rifleman_armory;
};

//------------------------------------------------------------------
//						Grenadier
//------------------------------------------------------------------	

if (_loadout == "Grenadier") then {
	_equipment append grenadier_armory;
};


//------------------------------------------------------------------
//						DM
//------------------------------------------------------------------	
	
if (_loadout == "DM") then {
	_equipment append dm_armory;
};


//------------------------------------------------------------------
//						MG
//------------------------------------------------------------------	
	
if (_loadout == "MG") then {
	_equipment append mg_armory;
};

//------------------------------------------------------------------
//					MG-Assistant
//------------------------------------------------------------------	
	
if (_loadout == "MG-Assistant") then {
	_equipment append mgAssis_armory;
};

//------------------------------------------------------------------
//						Autorifle
//------------------------------------------------------------------	
	
if (_loadout == "Autorifle") then {
	_equipment append autorifle_armory;
};

//------------------------------------------------------------------
//						Launcher
//------------------------------------------------------------------	
	
if (_loadout == "AT" || _loadout == "AA" || _loadout == "AT-Light") then {
	_equipment append launcher_armory;
};

//------------------------------------------------------------------
//					Launcher Assistant
//------------------------------------------------------------------	
	
if (_loadout == "AT-Assistant") then {
	_equipment append launcherAssis_armory;
};

//------------------------------------------------------------------
//						Medic
//------------------------------------------------------------------	
	
if (_loadout == "Medic") then {					
	_equipment append medic_armory;
};

//------------------------------------------------------------------
//							EOD
//------------------------------------------------------------------	
	
if (_loadout == "EOD") then {					
	_equipment append eod_armory;
};

//------------------------------------------------------------------
//						Engineer
//------------------------------------------------------------------	
	
if (_loadout == "Engineer") then {					
	_equipment append engineer_armory;
};

//------------------------------------------------------------------
//							JTAC
//------------------------------------------------------------------	
	
if (_loadout == "JTAC") then {					
	_equipment append jtac_armory;
};

//------------------------------------------------------------------
//						Squadleader
//------------------------------------------------------------------	
	
if (_loadout == "Squadleader") then {					
	_equipment append sql_armory;
};

//------------------------------------------------------------------
//						Groupleader
//------------------------------------------------------------------	
	
if (_loadout == "Groupleader") then {					
	_equipment append gl_armory;
};

//------------------------------------------------------------------
//						Sniper
//------------------------------------------------------------------	
	
if (_loadout == "Sniper") then {					
	_equipment append sniper_armory;
};

//------------------------------------------------------------------
//						Spotter
//------------------------------------------------------------------	
	
if (_loadout == "Spotter") then {					
	_equipment append spotter_armory;
};

//------------------------------------------------------------------
//						Pilot
//------------------------------------------------------------------	
	
if (_loadout == "Pilot") then {					
	_equipment append pilot_armory;
};

//------------------------------------------------------------------
//					Fighter-Pilot
//------------------------------------------------------------------	
	
if (_loadout == "Fighter-Pilot") then {					
	_equipment append fpilot_armory;
};

//------------------------------------------------------------------
//						Crew
//------------------------------------------------------------------	
	
if (_loadout == "Crew") then {					
	_equipment append crew_armory;
};

//------------------------------------------------------------------
//					Diver-Groupleader
//------------------------------------------------------------------	
	
if (_loadout == "Diver-Groupleader") then {					
	_equipment append diver_armory;
	_equipment append diverEOD_armory;
};

//------------------------------------------------------------------
//					Diver-Rifleman
//------------------------------------------------------------------	
	
if (_loadout == "Diver-Rifleman") then {					
	_equipment append diver_armory;
};

//------------------------------------------------------------------
//					Diver-EOD
//------------------------------------------------------------------	
	
if (_loadout == "Diver-EOD") then {					
	_equipment append diverEOD_armory;
};

//------------------------------------------------------------------
//					Diver-Medic
//------------------------------------------------------------------	
	
if (_loadout == "Diver-Medic") then {					
	_equipment append diverMedic_armory;
};

//------------------------------------------------------------------
//						TOC
//------------------------------------------------------------------	
if (_playerGrp == "TOC") then {					
	_equipment append rifleman_armory;
	_equipment append grenadier_armory;
	_equipment append mg_armory;
	_equipment append mgAssis_armory;
	_equipment append autorifle_armory;
	_equipment append dm_armory;
	_equipment append launcher_armory;
	_equipment append launcherAssis_armory;
	_equipment append medic_armory;
	_equipment append eod_armory;
	_equipment append engineer_armory;
	_equipment append jtac_armory;
	_equipment append sql_armory;
	_equipment append gl_armory;
	_equipment append sniper_armory;
	_equipment append spotter_armory;
	_equipment append pilot_armory;
	_equipment append fpilot_armory;
	_equipment append crew_armory;
	_equipment append diver_armory;
	_equipment append diverEOD_armory;
	_equipment append diverMedic_armory;
};
//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Arsenal Erstellen
//
//------------------------------------------------------------------
//------------------------------------------------------------------	


// Fill ACE Arsenal
[player, _equipment, false] call ace_arsenal_fnc_addVirtualItems;

// Open ACE Arsenal
_waffenkammer = [player, player, false] call ace_arsenal_fnc_openBox;

// Message for Player which options are available
titleText ["<t color='#ffffff' size='2'>This is an ACE Arsenal. Don't forget to pack Ammo after changing a weapon!</t>", "PLAIN", 1, true, true];

// Add Event Handler for closing the Arsenal
_arsenalEventHandler = ["ace_arsenal_displayClosed", { player setVariable ["arsenalClosed", true]; } ] call CBA_fnc_addEventHandler;

UAMT_ARSENAL_DISPLAY_ID = ["ace_arsenal_displayClosed", { 
	[player, true, false] call ace_arsenal_fnc_removeVirtualItems;
	["ace_arsenal_displayClosed", UAMT_ARSENAL_DISPLAY_ID] call CBA_fnc_removeEventHandler; } ] call CBA_fnc_addEventHandler;



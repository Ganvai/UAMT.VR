/*
	Waffenkammer
	
	In der Waffenkammer können die Spieler ihr eigenes Loadout zusammenstellen.	
	
	Nachdem das Arsenal geschlossen wurde, wird es gelöscht. Dies ist nötig, damit bei einem
	Rollenwechsel die Items weiterhin korrekt dargestellt werden und nicht Items der vorigen
	Rolle angezeigt werden.
*/

// Im Fahrzeug lässt sich das Arsenal nicht öffen -> exit
if (!(isNull objectParent player)) exitWith {
	titleText ["<t color='#e5991a' size='1.8'>Arsenal not available.<br/></t><t color='#ffffff' size='1.4'>Exit vehicle and try again.</t>", "PLAIN DOWN", 1, true, true];	
};

// Get Player Role
_unitLoadOut = player getVariable ["loadout", "DefaultLoadout"];

// create array from current loadout
_playerItems = flatten (getUnitLoadout player);
_playerItems = (_playerItems arrayIntersect _playerItems) select {_x isEqualType "" && {_x != ""}};

// get role-specific arsenal-items from config
_arsenalItems = [_unitLoadOut,"arsenal",""] call UAMT_fnc_loadoutGetValue;

// combine them to one array
{ _playerItems pushBackUnique _x; } forEach _arsenalItems;


//------------------------------------------------------------------
//						TOC
//------------------------------------------------------------------
// 	TOC has accsess to all equipment
// generate All Roles from CfgLoadouts ?
// or use all entrys from Roles-Array?
// 
_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
_allRoles = flatten _allRoles;
//systemchat str _allRoles;


_playerGrp = groupID group player;
if (_playerGrp == "TOC") then {	
	/*			
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
	*/
};
//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Create Arsenal
//
//------------------------------------------------------------------
//------------------------------------------------------------------	


// Fill ACE Arsenal
[player, _arsenalItems, false] call ace_arsenal_fnc_addVirtualItems;

// Open ACE Arsenal
[player, player, false] call ace_arsenal_fnc_openBox;

// Message for Player which options are available
titleText ["<t color='#ffffff' size='2'>This is an ACE Arsenal. Don't forget to pack Ammo after changing a weapon!</t>", "PLAIN", 1, true, true];

UAMT_ARSENAL_DISPLAY_ID = ["ace_arsenal_displayClosed", { 
	[player, true, false] call ace_arsenal_fnc_removeVirtualItems;
	_profWeaponsArr = [];
	_profWeaponsArr pushback (primaryWeapon player);
	_profWeaponsArr pushback (secondaryWeapon player);
	_profWeaponsArr pushback (handgunWeapon player);
	player setVariable ["profWeapons",_profWeaponsArr,true];
	["ace_arsenal_displayClosed", UAMT_ARSENAL_DISPLAY_ID] call CBA_fnc_removeEventHandler; } ] call CBA_fnc_addEventHandler;
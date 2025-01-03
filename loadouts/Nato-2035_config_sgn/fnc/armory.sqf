/*
	Waffenkammer
	
	In der Waffenkammer können die Spieler ihr eigenes Loadout zusammenstellen.	
	
	Nachdem das Arsenal geschlossen wurde, wird es gelöscht. Dies ist nötig, damit bei einem
	Rollenwechsel die Items weiterhin korrekt dargestellt werden und nicht Items der vorigen
	Rolle angezeigt werden.
*/

// Im Fahrzeug lässt sich das Arsenal nicht öffen -> exit
if (!(isNull objectParent player)) exitWith {
	titleText ["<t color='#e5991a' size='1.8'>Arsenal nicht verfügbar.<br/></t><t color='#ffffff' size='1.4'>Bitte aussteigen und erneut versuchen.</t>", "PLAIN DOWN", 1, true, true];	
};

// Get Player Role
//_unitLoadOut = player getVariable ["UAMT_unitLoadout", "DefaultLoadout"];
_unitLoadOut = player getVariable ["loadout", "DefaultLoadout"];

// var-name of arsenal array for this role
_arsenalVar = format ["UAMT_%1ArsenalArray",_unitLoadOut]; 

// get arsenal array from missionNamespace
_arsenalArray = missionNamespace getVariable [_arsenalVar, ""]; 

// no arsenal array found ->  create arsenal array for this role
if (_arsenalArray isEqualto "") then {
	// create array from current loadout
	_currentItems = flatten (getUnitLoadout player);
	_currentItems = (_currentItems arrayIntersect _currentItems) select {_x isEqualType "" && {_x != ""}};
	
	// get arsenal items defined in CfgLoadouts
	_arsenalItems = [_unitLoadOut,"arsenal",""] call UAMT_fnc_getCfgValue;
	
	// add items to personal arsenal
	{ _currentItems pushBackUnique _x; } forEach _arsenalItems;
	
	// save loadout-array
	missionNamespace setVariable [_arsenalVar, _currentItems];
	
	_arsenalArray = _currentItems;
}; 

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
//						Arsenal Erstellen
//
//------------------------------------------------------------------
//------------------------------------------------------------------	


// Fill ACE Arsenal
[player, _arsenalArray, false] call ace_arsenal_fnc_addVirtualItems;

// Open ACE Arsenal
_waffenkammer = [player, player, false] call ace_arsenal_fnc_openBox;

// Message for Player which options are available
titleText ["<t color='#ffffff' size='2'>This is an ACE Arsenal. Don't forget to pack Ammo after changing a weapon!</t>", "PLAIN", 1, true, true];

UAMT_ARSENAL_DISPLAY_ID = ["ace_arsenal_displayClosed", { 
	[player, true, false] call ace_arsenal_fnc_removeVirtualItems;
	["ace_arsenal_displayClosed", UAMT_ARSENAL_DISPLAY_ID] call CBA_fnc_removeEventHandler; } ] call CBA_fnc_addEventHandler;
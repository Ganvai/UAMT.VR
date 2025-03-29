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

_roleItems = [];
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "helmet",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "facewear",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "uniforms",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "vests",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "backpack",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "primary",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "handgun",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "secondary",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "map",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "terminal",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "radio",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "compass",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "watch",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "nvgs",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "binocs",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "itemsUniform",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "itemsVest",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "itemsBackPack",""] call BIS_fnc_returnConfigEntry );
_roleItems pushback ( [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut >> "arsenal",""] call BIS_fnc_returnConfigEntry );

_roleItems = flatten _roleItems;
_roleItems = _roleItems - [""];

_arsenalItems = [];
{
	// entry is string -> check CfgFactionEquipment for items
	if (_x isEqualType "") then {
		private _cfgFaction = ([missionConfigFile >> "CfgFactionEquipment", _x, ""] call BIS_fnc_returnConfigEntry);		
		if (_cfgFaction isEqualType []) then {
			_arsenalItems append _cfgFaction;
		} else {
			if (_x != "") then {
				_arsenalItems pushBack _x;
			};
		};				
	};		
}forEach _roleItems;

_arsenalItems = flatten _arsenalItems;

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
	_profWeaponsArr pushback ((primaryWeaponMagazine player) select 0);
	_profWeaponsArr pushback (secondaryWeapon player);
	_profWeaponsArr pushback (secondaryWeaponMagazine player);
	_profWeaponsArr pushback (handgunWeapon player);
	_profWeaponsArr pushback (handgunMagazine player);
	player setVariable ["profWeapons",_profWeaponsArr,true];
	["ace_arsenal_displayClosed", UAMT_ARSENAL_DISPLAY_ID] call CBA_fnc_removeEventHandler; } ] call CBA_fnc_addEventHandler;
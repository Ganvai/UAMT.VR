/*	
	by SmartGun
		
 	Description:	
	apply Loadout to Unit
	set Insignia
	set ACE Unit Traits
	put primary weapon on save 
	
 	Paramameters:	
		_this select 0: unit 	(OBJECT)
		_this select 1: loadout (ARRAY) -> unitLoadoutArray -> https://community.bistudio.com/wiki/Unit_Loadout_Array
		
	Return values:
	-none
*/
params ["_unit","_loadoutArray"];

// apply unitLoadout
_unit setUnitLoadout _loadoutArray;

private _unitLoadOut = _unit getVariable ["loadout", "DefaultLoadout"];

// Check for cTab NSWDG Edition because their Items get into inventory and not into the Slot.
if ( isClass(configFile >> "cfgPatches" >> "cTab") ) then {

	// Get the GPS Item from the config
	private _gps = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "terminal", ""] call BIS_fnc_returnConfigEntry;
	
	
	if (_gps != "") then {
	
		// Check if the assigned GPS Item should infact be replaced by a cTab alternative
		if (_gps in ["terminal_t1","terminal_t2","terminal_t3"]) then {	
			
			_gps = format ["ctab_%1",_gps];
			_gps = ([missionConfigFile >> "CfgFactionEquipment" >> _gps] call BIS_fnc_returnConfigEntry);
			
			if !(_gps in (assignedItems _unit)) then {
				_unit addItem _gps;
			};			
		};
	};
	
};

// apply insignia
private _insignia = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "insignia", [""]] call BIS_fnc_returnConfigEntry;
if ((count _insignia) > 0) then {
	player setVariable ["BIS_fnc_setUnitInsignia_class", nil];	
	[player, selectRandom _insignia] call BIS_fnc_setUnitInsignia;
};

// apply ACE traits
private _ace_isMedic 	= [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isMedic", 0] call BIS_fnc_returnConfigEntry;
private _ace_isEngineer = [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isEngineer", 0] call BIS_fnc_returnConfigEntry;
private _ace_isEOD 		= [missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, "ace_isEOD", false] call BIS_fnc_returnConfigEntry;
player setVariable ["ACE_medical_medicClass",_ace_isMedic,true];
player setVariable ["ACE_isEngineer",_ace_isEngineer,true];
if (_ace_isEOD == "true") then {
	player setVariable ["ACE_isEOD",true,true];
}
else {
	player setVariable ["ACE_isEOD",false,true];
};

// put weapon on safe && in lowered position
if (isplayer _unit) then {		
	if (isClass (configFile >> "CfgPatches" >> "ace_main")) then {			
		[ACE_player, currentWeapon ACE_player, true] call ace_safemode_fnc_setWeaponSafety;
	};		
	[] spawn { sleep 0.6; player action ["WeaponOnBack", player]; };
};

// Check all Weapons in for Weapon Proficiency

_profWeaponsArr = [];
_profWeaponsArr pushback (primaryWeapon player);
_profWeaponsArr pushback ((primaryWeaponMagazine player) select 0);
_profWeaponsArr pushback (secondaryWeapon player);
_profWeaponsArr pushback (secondaryWeaponMagazine player);
_profWeaponsArr pushback (handgunWeapon player);
_profWeaponsArr pushback (handgunMagazine player);
player setVariable ["profWeapons",_profWeaponsArr,true];
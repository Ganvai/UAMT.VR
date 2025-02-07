/*	
	by SmartGun
		
 	Description:	
	get items from CfgLoadouts and / or CfgFactionEquipment
	convert Items, Magazines and Weapons into correct format for use in unitLoadoutArray 
	
 	Paramameters:	
		_this select 0: unitLoadout	(STRING) 	-> Name of Loadout; -> "loadout" variable in player init = Loadout Class in CfgLoadouts
		_this select 1: entry		(STRING) 	-> Name of Entry in CfgLoadouts / CfgFactionEquipment
		_this select 2: defaultRet	(ANY) 		-> Default Return Value; -> function will return this if no valid Cfg-entry was found 
			
	Return values:
	array of Items / Magazines / Weapons
*/
params ["_unitLoadOut","_value","_default"];

private _ret = []; // return array

// get cfg from loadout
private _cfgEntry = ([missionConfigFile >> "CfgLoadouts" >> _unitLoadOut, _value, _default] call BIS_fnc_returnConfigEntry);	

{
	// entry is string -> check CfgFactionEquipment for items
	if (_x isEqualType "") then {
		private _cfgFaction = ([missionConfigFile >> "CfgFactionEquipment", _x, _default] call BIS_fnc_returnConfigEntry);		
		if (_cfgFaction isEqualType []) then {
			_ret append _cfgFaction;
		} else {
			if (_x != "") then {
				_ret pushBack _x;
			};
		};				
	};		
	
	// entry is array -> add it
	if (_x isEqualType []) then {			
		_ret pushBack _x;
	};
} forEach _cfgEntry;

// check for magazine & Explosives
{
	private _type = (_x call BIS_fnc_itemType)#0;
	
	// check for Magazine & Explosives
	if ( (_type in ["Magazine","Mine"]) && ((count _x) < 3) ) then {
		// convert to Magazine-Array format by adding 3rd element	
		_x pushBack 1; // 	
	};
	
	// check for Weapon
	if ( (_type in ["Weapon"]) && ((count _x) < 3) ) then {	
		// convert to Weapon-Array format
		_ret set [_forEachIndex, [[_x#0,"","","",[],[],""],_x#1]];		
	};
	
} forEach _ret;		

_ret;
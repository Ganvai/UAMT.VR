/*	
	by SmartGun
		
 	Description:	
	will return items from CfgLoadouts and / or CfgFactionEquipment
	
 	Paramameters:	
	-none		
			
	Return values:
	-none		
*/

//_getCfgValue = {	
	params ["_loadout","_value","_default"];
	private _ret = []; // return array
	
	// get cfg from loadout
	private _cfgEntry = ([missionConfigFile >> "CfgLoadouts" >> _loadout, _value, _default] call BIS_fnc_returnConfigEntry);	
	
	// check all entrys from CfgLoadouts
	{
		// entry is string -> check CfgFactionEquipment for items
		if (_x isEqualType "") then {
			private _cfgFaction = ([missionConfigFile >> "CfgFactionEquipment", _x, _default] call BIS_fnc_returnConfigEntry);
			//systemchat str _cfgFaction;
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
	
	// check for magazine
	{
		private _type = (_x call BIS_fnc_itemType)#0;
		if ( (_type isEqualTo "Magazine") && ((count _x) < 3) ) then {
			_x pushBack 1; // add 3rd element for use with setUnitloadout			
		};
	} forEach _ret;		
	_ret	
//};
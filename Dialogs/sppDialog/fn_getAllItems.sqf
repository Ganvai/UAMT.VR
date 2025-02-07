disableSerialization;
// Gathers all Items available in Loadouts and saves them in a special Array

//["_itemClass","_itemName","_itemImage","_itemSpecificType","_itemRolesArray"];

_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
_tempItemArr = [];
_itemHM = createHashMap;
{
	_role = _x select 1;
	
	_tempItemArr = ( [_role,"helmet",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"facewear",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"uniforms",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"vests",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"backpack",[]] call UAMT_fnc_loadoutGetValue);

	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "primary", []] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "handgun", []] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "secondary", []] call BIS_fnc_returnConfigEntry);

	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "map", ""] call BIS_fnc_returnConfigEntry);
	
	_terminal = ([missionConfigFile >> "CfgLoadouts" >> _role, "terminal", ""] call BIS_fnc_returnConfigEntry);
	if (_terminal in ["terminal_t1","terminal_t2","terminal_t3"]) then {	
		if (isClass(configFile >> "cfgPatches" >> "cTab")) then {
			_terminal = format ["ctab_%1",_terminal];		
		};
		_terminal = ([missionConfigFile >> "CfgFactionEquipment" >> _terminal] call BIS_fnc_returnConfigEntry);
	};
	_tempItemArr pushback _terminal;
	
	_radio = ([missionConfigFile >> "CfgLoadouts" >> _role, "radio", ""] call BIS_fnc_returnConfigEntry);
	if (_radio != "") then {
		if (isClass(configFile >> "cfgPatches" >> "task_force_radio")) then {
			_radio = ([missionConfigFile >> "CfgFactionEquipment" >> "tfar_radio"] call BIS_fnc_returnConfigEntry);
		};
		if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
			_radio = ([missionConfigFile >> "CfgFactionEquipment" >> "acre_radio"] call BIS_fnc_returnConfigEntry);
		};
	};

	_tempItemArr pushback _radio;
	
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "compass", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "watch", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "nvgs", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "binocs", ""] call BIS_fnc_returnConfigEntry);
	
	{_tempItemArr pushBackUnique _x} forEach ( [_role,"itemsUniform",[]] call UAMT_fnc_loadoutGetValue);
	{_tempItemArr pushBackUnique _x} forEach ( [_role,"itemsVest",[]] call UAMT_fnc_loadoutGetValue);
	{_tempItemArr pushBackUnique _x} forEach ( [_role,"itemsBackPack",[]] call UAMT_fnc_loadoutGetValue);
	{_tempItemArr pushBackUnique _x} forEach ( [_role,"arsenal",""] call UAMT_fnc_loadoutGetValue);
	
	_tempItemArr = flatten _tempItemArr;
	_tempItemArr = _tempItemArr select {_x isEqualType "" && {_x != ""}};
	
	{
		if (_x in _itemHM) then {
			_tempArray = _itemHM get _x;
			_roletempArray = _tempArray select 4;
			_roleTempArray pushback _role;
			_tempArray set [4,_roleTempArray];
			_itemHM set [_x,_tempArray];
		}
		else {
			(_x call BIS_fnc_itemType) params ["_category", "_specificType"];
			
			_configMain = switch (true) do {
				case (isclass (configfile >> "cfgweapons" >> _x)): {"CfGWeapons"};
				case (isclass (configfile >> "CfgMagazines" >> _x)): {"CfgMagazines"};
				case (isclass (configfile >> "CfgVehicles" >> _x)): {"CfgVehicles"};
				case (isclass (configfile >> "CfgGlasses" >> _x)): {"CfgGlasses"};
			};
			
			_name 		= [configFile >> _configMain >> _x >> "displayName"] call BIS_fnc_returnConfigEntry;
			_image		= [configFile >> _configMain >> _x >> "picture"] call BIS_fnc_returnConfigEntry;
			_description = ([configFile >> _configMain >> _x >> "descriptionShort"] call BIS_fnc_returnConfigEntry) regexReplace ["<br[\W ]*\/>", "\n"];
			
			if (_specificType in ["Throw", "SmokeShell", "Flare"]) then {_specificType = "Grenade"};
			
			if (_specificType == "AccessoryBipod" && {_x isKindOf ["CBA_MiscItem", configFile >> "CfgWeapons"]}) then {_specificType = "Item"};
			
			if ([configFile >> _configMain >> _x, "ACE_isMedicalItem",0] call BIS_fnc_returnConfigEntry == 1) then {
				_specificType = "Medikit";
			};
			
			if ([configFile >> _configMain >> _x, "ACE_isTool",0] call BIS_fnc_returnConfigEntry == 1) then {
				_specificType = "Item";
			};

			if ([configFile >> _configMain >> _x, "ace_explosives_placeable",0] call BIS_fnc_returnConfigEntry == 1) then {
				_specificType = "Mine";
			};
			
			_itemArray = [_x,_name,_image,_specificType,[_role],_description];
			_itemHM set [_x,_itemArray];
		};	
	}forEach _tempItemArr;	
}forEach _allRoles;

uiNamespace setVariable ["itemHM",_itemHM];

_itemHM;


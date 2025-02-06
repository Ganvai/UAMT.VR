// Gathers all Items available in Loadouts and saves them in a special Array

//["_itemClass","_itemName","_itemImage","_itemSpecificType","_itemRolesArray"];

_allRoles = [missionConfigFile >> "CfgRoles" >> "roles"] call BIS_fnc_returnConfigEntry;
_tempItemArr = [];
_itemHM = createHashMap;
{
	_role = _x select 1;
	
	_tempItemArr = [missionConfigFile >> "CfgLoadouts" >> _role, "helmet", [""]] call BIS_fnc_returnConfigEntry;
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "facewear", [""]] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "uniforms", [""]] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "vests", [""]] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "backpack", [""]] call BIS_fnc_returnConfigEntry);

	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "primary", []] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "handgun", []] call BIS_fnc_returnConfigEntry);
	_tempItemArr append ([missionConfigFile >> "CfgLoadouts" >> _role, "secondary", []] call BIS_fnc_returnConfigEntry);

	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "map", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "terminal", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "radio", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "compass", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "watch", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "nvgs", ""] call BIS_fnc_returnConfigEntry);
	_tempItemArr pushback ([missionConfigFile >> "CfgLoadouts" >> _role, "binocs", ""] call BIS_fnc_returnConfigEntry);
	
	_tempItemArr append ( [_role,"itemsUniform",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"itemsVest",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"itemsBackPack",[]] call UAMT_fnc_loadoutGetValue);
	_tempItemArr append ( [_role,"arsenal",[]] call UAMT_fnc_loadoutGetValue);
	
	_tempItemArr = flatten _tempItemArr;
	_tempItemArr = _tempItemArr select {_x isEqualType "" && {_x != ""}};
	
	{
		if (_x in _itemHM) then {
			_tempArray = _itemHM get _x;
			_tempArray set [4,((_tempArray select 4) pushback _role)];
			_itemHM set [_x,_tempArray];
		}
		else {
			_configMain = "CfGWeapons";
			
			if (isClass (configFile >> "CfgMagazines" >> _x)) then {
				_configMain = "CfgMagazines";
			}
			else {
				if (isClass (configFile >> "CfgVehicles" >> _x)) then {
					_configMain = "CfgVehicles";
				};
			};
			
			_name 		= [configFile >> _configMain >> _x >> "displayName"] call BIS_fnc_returnConfigEntry;
			_image		= [configFile >> _configMain >> _x >> "picture"] call BIS_fnc_returnConfigEntry;	
			(_x call BIS_fnc_itemType) params ["_category", "_specificType"];
			
			_itemArray = [_x,_name,_image,_specificType,[_role]];
			_itemHM set [_x,_itemArray];
		};	
	}forEach _tempItemArr;	
}forEach _allRoles;

uiNamespace setVariable ["itemHM",_itemHM];

_itemHM;


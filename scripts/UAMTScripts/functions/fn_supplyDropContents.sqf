params ["_method","_group"];

// Set Up Variables
_cargo = [];

// Get Players depending on Method
if (_method == 1) then {
	_players = allplayers - entities "HeadlessClient_F";
}
else {
	_players = units _group;
};

// Gather all Roles and Weapons
{
	// Setup all Temp Variables
	_magCargo = [];
	_weaponTempMagWell = [];

	_role = _x getVariable "loadout";
	_profWeapons = _x getVariable ["profWeapons",[]];
	
	_allRoleItems = [missionConfigFile >> "CfgLoadouts" >> _role, "itemsUniform", []] call BIS_fnc_returnConfigEntry;
	_allRoleItems append ([missionConfigFile >> "CfgLoadouts" >> _role, "itemsVest", []] call BIS_fnc_returnConfigEntry);
	_allRoleItems append ([missionConfigFile >> "CfgLoadouts" >> _role, "itemsBackPack", []] call BIS_fnc_returnConfigEntry);
	
	_allArsenalItems = [_role,"arsenal",""] call UAMT_fnc_loadoutGetValue;
	
	// Add Magazines for Primary Weapon
	if (_profWeapons select 0 != "") then {
		_weaponTemp = (_profWeapons select 0);
		
		_weaponTempMuzzles = [configFile >> "CfGWeapons" >> _weaponTemp, "muzzles",["this"]] call BIS_fnc_returnConfigEntry;
		
		_weaponTempMagWell = compatibleMagazines _weaponTemp;
		
		{
			if (_x in _allRoleItems) exitWith {
				_cargo pushback [_x,3];
				_allRoleItems = _allRoleItems - _x;
			};

			if (_x in _allArsenalItems) exitWith {
					_cargo pushback [_x,3];
			};

			_stdMags = [configFile >> "CfGWeapons" >> _weaponTemp, "magazines"] call BIS_fnc_returnConfigEntry;
			{
				_cargo pushback [_x,3];
			}forEach _stdMags;

		}forEach _weaponTempMagWell;
	};

	// Add Magazines for Secondary Weapon
	if (_profWeapons select 1 != "") then {
		_weaponTemp = (_profWeapons select 1);
		
		_weaponTempMuzzles = [configFile >> "CfGWeapons" >> _weaponTemp, "muzzles",["this"]] call BIS_fnc_returnConfigEntry;
		
		_weaponTempMagWell = compatibleMagazines _weaponTemp;
		
		{
			if (_x in _allRoleItems) exitWith {
				_cargo pushback [_x,3];
				_allRoleItems = _allRoleItems - _x;
			};

			if (_x in _allArsenalItems) exitWith {
					_cargo pushback [_x,3];
			};

			_stdMags = [configFile >> "CfGWeapons" >> _weaponTemp, "magazines"] call BIS_fnc_returnConfigEntry;
			{
				_cargo pushback [_x,3];
			}forEach _stdMags;

		}forEach _weaponTempMagWell;
	};

	// Add Magazines for Handgun
	if (_profWeapons select 2 != "") then {
		_weaponTemp = (_profWeapons select 2);
		
		_weaponTempMuzzles = [configFile >> "CfGWeapons" >> _weaponTemp, "muzzles",["this"]] call BIS_fnc_returnConfigEntry;
		
		_weaponTempMagWell = compatibleMagazines _weaponTemp;
		
		{
			if (_x in _allRoleItems) exitWith {
				_cargo pushback [_x,3];
				_allRoleItems = _allRoleItems - _x;
			};

			if (_x in _allArsenalItems) exitWith {
					_cargo pushback [_x,3];
			};

			_stdMags = [configFile >> "CfGWeapons" >> _weaponTemp, "magazines"] call BIS_fnc_returnConfigEntry;
			{
				_cargo pushback [_x,3];
			}forEach _stdMags;

		}forEach _weaponTempMagWell;
	};

	// Fill all other Items into the crate
	{
		_item = _x select 0;
		_count = _x select 1;
		_cargo pushback [_item,(ceil (_count / 2))];
	}forEach _allRoleItems;
	
}forEach _players;

// Add Throwables to Cargo
_throwables = [missionConfigFile >> "CfgFactionEquipment", "throwablesStd", []] call BIS_fnc_returnConfigEntry;
_throwables append ([missionConfigFile >> "CfgFactionEquipment", "throwablesExt", []] call BIS_fnc_returnConfigEntry);

{
	_cargo pushback [(_x select 0),(ceil (((_x select 1) * (count _players)) / 2))];
}forEach _throwables;

// Add Medic Items to Cargo
_medicItems = [missionConfigFile >> "CfgFactionEquipment", "san_t3_u", []] call BIS_fnc_returnConfigEntry;
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t3_v", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t3_b", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t2_u", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t2_v", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t2_b", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t1_u", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t1_v", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t1_b", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t0_u", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t0_v", []] call BIS_fnc_returnConfigEntry);
_medicItems append ([missionConfigFile >> "CfgFactionEquipment", "san_t0_b", []] call BIS_fnc_returnConfigEntry);

{
	_cargo pushback [(_x select 0),(ceil (((_x select 1) * (count _players)) / 2))];
}forEach _medicItems;

_cargo;


/*
// Gather all Roles with amount
{
	_role = _x;
	_index = -1;
		
	for "_i" from 0 to count _roles do {
		if (_role == ((_roles select _i) select 0)) exitWith {
			_index = _i;
		};
	};
	
	if (_index == -1) then {
		_roles pushback [_x,1];
	}
	else {
		_roles set [_index,[((_roles select _index) select 0),(((_roles select _index) select 1) + 1)]];
	};
}forEach _rolesAll;

// Gather all Primary Weapons with amount
{
	_weapon = _x;
	_index = -1;
		
	for "_i" from 0 to count _weapons do {
		if (_weapon == ((_weaponTempWeapons select _i) select 0)) exitWith {
			_index = _i;
		};
	};
	
	if (_index == -1) then {
		_weaponTempWeapons pushback [_x,1];
	}
	else {
		_weaponTempWeapons set [_index,[((_weaponTempWeapons select _index) select 0),(((_weaponTempWeapons select _index) select 1) + 1)]];
	};
}forEach _weaponTempWeaponsAll;

// Gather all Primary Weapons with amount
{
	_weapon = _x;
	_index = -1;
		
	for "_i" from 0 to count _weapons do {
		if (_weapon == ((_secondaryWeapons select _i) select 0)) exitWith {
			_index = _i;
		};
	};
	
	if (_index == -1) then {
		_secondaryWeapons pushback [_x,1];
	}
	else {
		_secondaryWeapons set [_index,[((_secondaryWeapons select _index) select 0),(((_secondaryWeapons select _index) select 1) + 1)]];
	};
}forEach _secondaryWeaponsAll;


_weaponMuzzles =  _playerweapon Config entry muzzles;

{
	_magazines = compatibleMagazines [_playerWeapon,_x];
}forEach _weaponMuzzles;

{
	if (_x in alleItemsInPlayerLoadout) then {
		_x pushback _cargo;
	};
}forEach _magazines;
*/
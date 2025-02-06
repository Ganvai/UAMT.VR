params [["_method",1],"_group"];

// Set Up Variables
_cargo = [];
_players = [];

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
	_player = _x;

	_role = _player getVariable "loadout";
	_profWeapons = _player getVariable ["profWeapons",[]];
	_primaryArr = [missionConfigFile >> "CfgLoadouts" >> _role, "primary", []] call BIS_fnc_returnConfigEntry;
	
	_allRoleItems = [missionConfigFile >> "CfgLoadouts" >> _role, "itemsUniform", []] call BIS_fnc_returnConfigEntry;
	_allRoleItems append ([missionConfigFile >> "CfgLoadouts" >> _role, "itemsVest", []] call BIS_fnc_returnConfigEntry);
	_allRoleItems append ([missionConfigFile >> "CfgLoadouts" >> _role, "itemsBackPack", []] call BIS_fnc_returnConfigEntry);
	
	_allRoleItems = _allRoleItems select {_x isEqualType []};
	
	if (primaryWeapon _player in _profWeapons) then {
		_cargo pushback [(_profWeapons select 1),3];
		
		_magWell = compatibleMagazines (_primaryArr select 0);
		_magType = [configFile >> "CfgMagazines" >> ((_primaryArr select 4) select 0), "ammo",0] call BIS_fnc_returnConfigEntry;
		{
			if ((_x select 0) in _magWell && ([configFile >> "CfgMagazines" >> (_x select 0), "ammo"] call BIS_fnc_returnConfigEntry) == _magType) then {
				_allRoleItems = _allRoleItems - [_x];
			};
		}forEach _allRoleItems;
	};

	// Fill all other Items into the crate
	{
		_cargo pushback [_x select 0,ceil ((_x select 1) / 2)];
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
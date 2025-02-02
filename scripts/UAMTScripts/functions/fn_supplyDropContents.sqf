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
	_role = _x getVariable "loadout";
	
	private _loadoutArray = [_role] call UAMT_fnc_loadoutCreate;
	private _allRoleItems = flatten _loadoutArray;
	_allRoleItems = (_allRoleItems arrayIntersect _allRoleItems) select {_x isEqualType "" && {_x != ""}};
	
	_allArsenalItems = [""]; //TODO  Function for getting all Role Config Items from CfGEquipment
	_primaryMags = [];
	
	// Add 
	if (_profWeapons select 0 != "")
		_primary = (_profWeapons select 0);
		_primaryMuzzles = [configFile >> "CfGWeapons" >> _primary, "muzzles",["this"]] call BIS_fnc_returnConfigEntry;
		{
			_primaryMagWell = compatibleMagazines [_primary,_x];
		}forEach _primaryMuzzles;
		
		{
			if (_x in _allRoleItems || _x in _allArsenalItems) then {
				
			};
		}forEach _primaryMagWell;
		
	
		
	};

	if (_profWeapons select 1 != "")
		_secondary = (_profWeapons select 1);
	};

	if (_profWeapons select 2 != "")
		_handgun = _profWeapons select 2 ;
	};


}forEach _players;


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
		if (_weapon == ((_primaryWeapons select _i) select 0)) exitWith {
			_index = _i;
		};
	};
	
	if (_index == -1) then {
		_primaryWeapons pushback [_x,1];
	}
	else {
		_primaryWeapons set [_index,[((_primaryWeapons select _index) select 0),(((_primaryWeapons select _index) select 1) + 1)]];
	};
}forEach _primaryWeaponsAll;

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
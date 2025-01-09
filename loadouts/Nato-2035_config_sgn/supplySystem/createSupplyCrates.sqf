//------------------------------------------------------------------
//
//	Supply Crates
//
//------------------------------------------------------------------

// The maximum Weight for the Crate. In Ace, crates with a weight of 600
// can still be carried, crates with weight under 700 can still be dragged.
// Crates heavier than 700 can not be moved at all. 
// Recommended limit is 600.
_crateLimit = 600;


//------------------------------------------------------------------
//	Ammo Crate
//------------------------------------------------------------------
ammoCrateArr = [];

_additionalItems = [missionConfigFile >> "CfgFactionEquipment", "ammo_SupplyCrate", []] call BIS_fnc_returnConfigEntry;

_loadMax = 600;
if (count _additionalItems > 0 ) then {
	_loadMax = 450;
};

//Primary Mag load - Alway takes the first Mag Type from the std_rifleAmmo_inv array
_mag = (([missionConfigFile >> "CfgLoadouts" >> "DefaultLoadout", "primary", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor ((_loadMax - 100) / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

_mag = (([missionConfigFile >> "CfgLoadouts" >> "DefaultLoadout", "handgun", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (100 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

_cargoSpace  = 150 / count _additionalItems;

{
	_mass = [_x] call  UAMT_fnc_getItemMass;
	if (_mass > 0 ) then {
		_loaditems = floor (_cargoSpace / ([configFile >> "CfgMagazines" >> _x,"mass"] call BIS_fnc_returnConfigEntry));
		ammoCrateArr append [[_x,_loaditems]];
	};
} forEach _additionalItems;

missionNameSpace setVariable ["SupplyPoint_AmmoCrate",ammoCrateArr,true];


//------------------------------------------------------------------
// 	Heavy Ammo Crate
//------------------------------------------------------------------
heavyammoCrateArr = [];

_additionalItems = [missionConfigFile >> "CfgFactionEquipment", "heavyAmmo_SupplyCrate", []] call BIS_fnc_returnConfigEntry;

_div = 0;

_roles = [missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry;


if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "MG"}) >= 0) then {
	_div = _div + 1;
};

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "Autorifle"}) >= 0) then {
	_div = _div + 1;
};

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "DM"}) >= 0) then {
	_div = _div + 1;
};

if (count _additionalItems > 0) then {
	_div = _div + 1;
};

_loadMass = _crateLimit / _div;

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "MG"}) >= 0) then {
	_mag = (([missionConfigFile >> "CfgLoadouts" >> "MG", "primary", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "Autorifle"}) >= 0) then {
	_mag = (([missionConfigFile >> "CfgLoadouts" >> "Autorifle", "primary", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "DM"}) >= 0) then {
	_mag = (([missionConfigFile >> "CfgLoadouts" >> "DM", "primary", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

	_loadItems = floor (_loadMass / _magMass);

	heavyammoCrateArr append [[_mag,_loaditems]];
};

{
	_mass = [_x] call  UAMT_fnc_getItemMass;
	if (_mass > 0 ) then {
		_loaditems = floor (_loadMass / ([configFile >> "CfgMagazines" >> _x,"mass"] call BIS_fnc_returnConfigEntry));
		heavyammoCrateArr append [[_x,_loaditems]];
	};
} forEach _additionalItems;

missionNameSpace setVariable ["SupplyPoint_HeavyAmmoCrate",heavyammoCrateArr,true];


//------------------------------------------------------------------
// 	Grenades Ammo Crate
//------------------------------------------------------------------

grenadeCrateArr = [];

_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "throwablesStd", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "throwablesExt", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "grenades_SupplyCrate", []] call BIS_fnc_returnConfigEntry;

_div = count _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		grenadeCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_GrenadeCrate",grenadeCrateArr,true];


//------------------------------------------------------------------
// 	AT Missile Ammo Crate
//------------------------------------------------------------------
atMissileCrateArr = [];

_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "itemsATSupplyCrate", []] call BIS_fnc_returnConfigEntry);

_div = count _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		atMissileCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_ATCrate",atMissileCrateArr,true];


//------------------------------------------------------------------
// 	AA Missile Ammo Crate
//------------------------------------------------------------------
aaMissileCrateArr = [];

_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "itemsAASupplyCrate", []] call BIS_fnc_returnConfigEntry);

_div = count _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		aaMissileCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_AACrate",aaMissileCrateArr,true];


//------------------------------------------------------------------
// 	AT-Light Missile Ammo Crate
//------------------------------------------------------------------
atLightCrateArr = [];

_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "itemsATLightSupplyCrate", []] call BIS_fnc_returnConfigEntry);

_div = count _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		atLightCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_ATLightCrate",atLightCrateArr,true];


//------------------------------------------------------------------
// 	Medic Supplies
//------------------------------------------------------------------
medicCrateArr = [];
_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t1_u", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t1_v", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t1_b", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t2_u", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t2_v", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t2_b", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t3_u", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t3_v", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "san_t3_b", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "medicAddSupplyCrate", []] call BIS_fnc_returnConfigEntry;

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "docAddSupplyCrate", []] call BIS_fnc_returnConfigEntry;

_div = _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating Medic Supply Crate. Item has no Mass :%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		medicCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_MedicCrate",medicCrateArr,true];


//------------------------------------------------------------------
// 	Explosives Supplies
//------------------------------------------------------------------
explosivesCrateArr = [];
_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "explosives_SupplyCrate", []] call BIS_fnc_returnConfigEntry);

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "eodItemsExplosiveSupplyCrate", []] call BIS_fnc_returnConfigEntry);

_div = _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		explosivesCrateArr append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_ExplosivesCrate",explosivesCrateArr,true];


//------------------------------------------------------------------
// 	UAV Supplies
//------------------------------------------------------------------
uavSupplyCrate = [];

_fillarray = [];

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "uav_SupplyCrate", []] call BIS_fnc_returnConfigEntry);

{
	_fillarray pushBackUnique _x;
}forEach [missionConfigFile >> "CfgFactionEquipment", "jtacSupplyCrate", []] call BIS_fnc_returnConfigEntry);

_div = _fillarray;

_loadMass = floor (_crateLimit / _div);

{
	_item = _x select 0;
	_mass = _mass = [_x] call  UAMT_fnc_getItemMass;
	
	if (_mass == -1) then {
		diag_log text format["Error when creating AT Supply Crate with Item:%1", _item];
	}
	else {
		_loadItems = floor (_loadMass / _mass);
		uavSupplyCrate append [[_mag,_loaditems]];
	};
}forEach _fillarray;

missionNameSpace setVariable ["SupplyPoint_UAVCrate",uavSupplyCrate,true];



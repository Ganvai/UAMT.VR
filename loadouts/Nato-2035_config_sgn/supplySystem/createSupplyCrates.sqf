//------------------------------------------------------------------
//
//	Supply Crates
//
//------------------------------------------------------------------
_crateLimit = 600;
//------------------------------------------------------------------
//	Ammo Crate
//------------------------------------------------------------------
ammoCrateArr = [];

//Primary Mag load - Alway takes the first Mag Type from the std_rifleAmmo_inv array
_mag = (([missionConfigFile >> "CfgLoadouts" >> "DefaultLoadout", "primary", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (500 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];

_mag = (([missionConfigFile >> "CfgLoadouts" >> "DefaultLoadout", "handgun", []] call BIS_fnc_returnConfigEntry) select 4 ) select 0;
_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;

_loadItems = floor (100 / _magMass);

ammoCrateArr append [[_mag,_loaditems]];


//------------------------------------------------------------------
// 	Heavy Ammo Crate
//------------------------------------------------------------------
heavyammoCrateArr = [];

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

//------------------------------------------------------------------
// 	Grenades Ammo Crate
//------------------------------------------------------------------

grenadeCrateArr = [];

_throwablesStd = [missionConfigFile >> "CfgFactionEquipment", "throwablesStd", []] call BIS_fnc_returnConfigEntry;
_throwablesExt = [missionConfigFile >> "CfgFactionEquipment", "throwablesExt", []] call BIS_fnc_returnConfigEntry;

_div = count _throwablesStd + count _throwablesExt;

_loadLimiter = 600;

if ((([missionConfigFile >> "CfgRoles", "roles", []] call BIS_fnc_returnConfigEntry) findIf {_x select 0 == "DM"}) >= 0) then {
	_loadLimiter = 400;
};

_loadMass = floor (_loadLimiter / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach throwablesStd;

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	grenadeCrateArr append [[_mag,_loaditems]];
}forEach throwablesExt;

if (_loadLimiter < 600) then {
	_uglPool = [missionConfigFile >> "CfgFactionEquipment", "grenadier_UGL_Pool", []] call BIS_fnc_returnConfigEntry;
	_div = count _uglPool;

	_loadMass = floor (200 / _div);

	{
		_mag = _x;
		_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
		
		_loadItems = floor (_loadMass / _magMass);
		
		grenadeCrateArr append [[_mag,_loaditems]];
	}forEach _uglPool;
};

//------------------------------------------------------------------
// 	AT Missile Ammo Crate
//------------------------------------------------------------------
atMissileCrateArr = [];

_div = 	count launcher_at_ammo + count launcher_at_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_at_ammo;

{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	atMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_at_ammoPool;


//------------------------------------------------------------------
// 	AA Missile Ammo Crate
//------------------------------------------------------------------
aaMissileCrateArr = [];

_div = 	count launcher_aa_ammo + count launcher_aa_ammoPool;

_loadMass = floor (_crateLimit / _div);

{
	_mag = _x select 0;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_aa_ammo;


{
	_mag = _x;
	_magMass = [configfile >> "CfgMagazines" >> _mag, "mass"] call BIS_fnc_returnConfigEntry;
	
	_loadItems = floor (_loadMass / _magMass);
	
	aaMissileCrateArr append [[_mag,_loaditems]];
}forEach launcher_aa_ammoPool;

//------------------------------------------------------------------
// 	AT-Light Missile Ammo Crate
//------------------------------------------------------------------
atLightCrateArr = [];

if (launcher_at_light != "") then {
	if (_lightATdispenseble) then {
		_magMass = getNumber (configFile >> "CfgWeapons" >> launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (600 / _magMass);
		
		atLightCrateArr append [[launcher_at_light,_loaditems]];
	}
	else
	{
		_magMass = getNumber (configFile >> "CfgWeapons" >> launcher_at_light >> "WeaponSlotsInfo" >> "mass");
		
		_loadItems = floor (300 / _magMass);
		
		atLightCrateArr append [[launcher_at_light,_loaditems]];
		
		_atLightAmmoArr = launcher_at_light_ammoPool;
		
		{
			_atLightAmmoArr pushback (_x select 0);
		} forEach launcher_at_light_ammo;

		_div = 	count _atLightAmmoArr;

		_loadMass = floor (_crateLimit / _div);
		
		{
			atLightCrateArr append [[_x,_loaditems]];
		} forEach _atLightAmmoArr;
	};
};


//------------------------------------------------------------------
// 	Medic Supplies
//------------------------------------------------------------------
medicCrateArr = [];
_sanCollected = [];

_sanCollected append san_t1_u;
_sanCollected append san_t1_v;
_sanCollected append san_t1_b;
_sanCollected append san_t2_u;
_sanCollected append san_t2_v;
_sanCollected append san_t2_b;

{
	medicCrateArr append [[_x select 0,(_x select 1) * 2]];
}forEach _sanCollected;

//------------------------------------------------------------------
// 	Explosives Supplies
//------------------------------------------------------------------
explosivesCrateArr = [];

_div = count eod_explosive_pool;
_itemMass = 0;
_loadItems = 0;
_loadMass = floor (600 / _div);

{
	if (isClass (configFile >> "CfgVehicles" >> _x)) then {
		if (getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass") != 0) then {
			_itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "mass");
			
			_loadItems = floor (_loadMass / _itemMass);
		}
		else {
			if (getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass") != 0) then {
				_itemMass = getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass");
				
				_loadItems = floor (_loadMass / _itemMass);
			};
		};
	}
	else {
		if (isClass (configFile >> "CfgMagazines" >> _x)) then {
			_itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
			_loadItems = floor (_loadMass / _itemMass);
		};
	};
	
	explosivesCrateArr append [[_x,_loadItems]];
}forEach eod_explosive_pool;

//------------------------------------------------------------------
// 	Mines Supplies
//------------------------------------------------------------------
minesCrateArr = [];
_loadItems = 0;
_div = count eod_mines_pool;

_loadMass = floor (600 / _div);

{
	_itemMass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass");
	_loadItems = floor (_loadMass / _itemMass);
	minesCrateArr append [[_x,_loadItems]];
}forEach eod_mines_pool;


//------------------------------------------------------------------
//
//	Push Public Variables
//
//------------------------------------------------------------------

publicVariable "ammoCrateArr";
publicVariable "heavyammoCrateArr";
publicVariable "grenadeCrateArr";
publicVariable "atMissileCrateArr";
publicVariable "aaMissileCrateArr";
publicVariable "atLightCrateArr";
publicVariable "medicCrateArr";
publicVariable "explosivesCrateArr";
publicVariable "minesCrateArr";
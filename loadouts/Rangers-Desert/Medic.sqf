//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Medic
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","Medic"];
_notloadeditems = [];

//------------------------------------------------------------------
//	Init
//------------------------------------------------------------------	
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

//------------------------------------------------------------------
//	Outfit
//------------------------------------------------------------------
player forceAddUniform medic_uniform;
player addHeadgear medic_helmet;
player addVest medic_vest;
player addGoggles facewear;
player addBackpack medic_backpack;

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon medic_rifle;
player addPrimaryWeaponItem medic_scope;
player addPrimaryWeaponItem medic_attachement1;
player addPrimaryWeaponItem medic_attachement2;
player addPrimaryWeaponItem medic_attachement3;
player addPrimaryWeaponItem ((medic_ammo_inv select 0) select 0);

player addWeapon medic_handgun;
player addHandgunItem medic_handgun_scope;
player addHandgunItem medic_handgun_attachement1;
player addHandgunItem medic_handgun_attachement2;
player addHandgunItem ((medic_handgunAmmo_inv select 0) select 0);

//------------------------------------------------------------------
//	
// Items to Inventory
//
//------------------------------------------------------------------
{
	for "_i" from 1 to (_x select 1) do {
		if (player canAddItemToUniform (_x select 0)) then {
			player addItemToUniform (_x select 0);
		} 
		else{
			if (player canAddItemToVest (_x select 0)) then {
				player addItemToVest (_x select 0);
			} 
			else{
				if (player canAddItemToBackpack (_x select 0)) then {
					player addItemToBackpack (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};			
			};
		};
	};
} forEach medic_inv_u;

{
	for "_i" from 1 to (_x select 1) do {
		if (player canAddItemToVest (_x select 0)) then {
			player addItemToVest (_x select 0);
		} 
		else{
			if (player canAddItemToBackpack (_x select 0)) then {
				player addItemToBackpack (_x select 0);
			} 
			else{
				if (player canAddItemToUniform (_x select 0)) then {
					player addItemToUniform (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};			
			};
		};
	};
} forEach medic_inv_v;

{
	for "_i" from 1 to (_x select 1) do {
		if (player canAddItemToBackpack (_x select 0)) then {
			player addItemToBackpack (_x select 0);
		} 
		else{
			if (player canAddItemToVest (_x select 0)) then {
				player addItemToVest (_x select 0);
			} 
			else{
				if (player canAddItemToUniform (_x select 0)) then {
					player addItemToUniform (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};			
			};
		};
	};
} forEach medic_inv_b;

//------------------------------------------------------------------
//
//	Ammo
//
//------------------------------------------------------------------

//------------------------------------------------------------------
//	Primary Mags
//------------------------------------------------------------------
{
	for "_i" from 1 to (_x select 1) do {
		if (player canAddItemToVest (_x select 0)) then {
			player addItemToVest (_x select 0);
		} 
		else{
			if (player canAddItemToBackpack (_x select 0)) then {
				player addItemToBackpack (_x select 0);
			} 
			else{
				if (player canAddItemToUniform (_x select 0)) then {
					player addItemToUniform (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};			
			};
		};
	};
} forEach medic_ammo_inv;

{
	for "_i" from 1 to (_x select 1) do {
		if (player canAddItemToVest (_x select 0)) then {
			player addItemToVest (_x select 0);
		} 
		else{
			if (player canAddItemToBackpack (_x select 0)) then {
				player addItemToBackpack (_x select 0);
			} 
			else{
				if (player canAddItemToUniform (_x select 0)) then {
					player addItemToUniform (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};			
			};
		};
	};
} forEach medic_handgunAmmo_inv;


//------------------------------------------------------------------
//	Item Slots
//------------------------------------------------------------------
if (medic_watch != "") then {
	player linkItem medic_watch;
};

if (medic_map != "") then {
	player linkItem medic_map;
};

if (medic_compass != "") then {
	player linkItem medic_compass;
};

if (medic_binocs != "") then {
	player linkItem medic_binocs;
};

if (medic_terminal != "") then {
	player linkItem medic_terminal;
};

if (medic_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		if (player canAddItemToUniform medic_radio) then {
			player addItemToUniform medic_radio;
		}
		else {
			if (player canAdd medic_radio) then {
				player addItem medic_radio;
			}
			else {
				_notloadeditems pushback medic_radio;
			};
		};
	}
	else {
		player linkItem medic_radio;
	};
};

if (nvg != "") then {
	if (player canAddItemToUniform nvg) then {
		player addItemToUniform nvg;
	}
	else {
		if (player canAdd nvg) then {
			player addItem nvg;
		}
		else {
			player linkItem nvg;
		};
	};
};


//------------------------------------------------------------------
//	ACE Optiones for Role
//------------------------------------------------------------------	
//Medic: 
player setVariable ["ACE_medical_medicClass", 2, true];

//Combat Engineer:
player setVariable ["ACE_isEngineer", 0, true];

//Explosive Specialist:
player setVariable ["ACE_isEOD", false, true];

[ACE_player, currentWeapon ACE_player, true] call ace_safemode_fnc_setWeaponSafety;

//------------------------------------------------------------------
//	Loadout Overload Hint
//------------------------------------------------------------------	
if ((count _notloadeditems) > 0) then {
	_errorString = format ["Not enough space in Inventory for: %1",_notloadeditems];
	hint _errorString;
}

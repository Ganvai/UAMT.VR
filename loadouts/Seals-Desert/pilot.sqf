//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Pilot
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","Pilot"];
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
player forceAddUniform pilot_uniform;
player addHeadgear pilot_helmet;
player addVest pilot_vest;
player addGoggles pilot_facewear;

if (lrAvailable && ((player getVariable "loadout") in lrRoles) && (lrRadio != "")) then {

	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		
		player addBackpack pilot_backpack;
		
		if (player canAddItemToBackpack lrRadio) then {
			player addItemToBackpack lrRadio;
		}
		else {
			if (player canAdd lrRadio) then {
				player addItem lrRadio;
			}
			else {
				_notloadeditems pushback lrRadio;
			};
		};
	}
	else {
		player addBackpack lrRadio;
	}
}
else {
	player addBackpack pilot_backpack;
};

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon pilot_rifle;
player addPrimaryWeaponItem pilot_scope;
player addPrimaryWeaponItem pilot_attachement1;
player addPrimaryWeaponItem pilot_attachement2;
player addPrimaryWeaponItem pilot_attachement3;
player addPrimaryWeaponItem ((pilot_ammo_inv select 0) select 0);

player addWeapon pilot_handgun;
player addHandgunItem pilot_handgun_scope;
player addHandgunItem pilot_handgun_attachement1;
player addHandgunItem pilot_handgun_attachement2;
player addHandgunItem ((pilot_handgunAmmo_inv select 0) select 0);

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
			if (player canAddItemToBackpack (_x select 0)) then {
				player addItemToBackpack (_x select 0);
			} 
			else{
				if (player canAddItemToVest (_x select 0)) then {
					player addItemToVest (_x select 0);
				} 
				else{
					 _notloadeditems pushback (_x select 0);
				};
			};
		};
	}
} forEach pilot_inv_u;

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
	}
} forEach pilot_inv_v;

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
	}
} forEach pilot_inv_b;

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
	}
} forEach pilot_ammo_inv;

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
	}
} forEach pilot_handgunAmmo_inv;



//------------------------------------------------------------------
//	Item Slots
//------------------------------------------------------------------
player linkItem pilot_watch;
player linkItem pilot_map;
player linkItem pilot_compass;
player linkItem pilot_binocs;
player linkItem pilot_terminal;

if (pilot_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		if (player canAddItemToUniform pilot_radio) then {
			player addItemToUniform pilot_radio;
		}
		else {
			if (player canAdd pilot_radio) then {
				player addItem pilot_radio;
			}
			else {
				_notloadeditems pushback pilot_radio;
			};
		};
	}
	else {
		player linkItem pilot_radio;
	};
};

player linkItem pilot_nvg;


//------------------------------------------------------------------
//	ACE Optiones for Role
//------------------------------------------------------------------	
//Medic: 
player setVariable ["ACE_medical_medicClass", 0, true];

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

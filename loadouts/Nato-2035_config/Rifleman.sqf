//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Rifleman
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","Rifleman"];
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
player forceAddUniform selectRandom rifleman_uniform;
player addHeadgear selectRandom rifleman_helmet;
player addVest selectRandom rifleman_vest;
player addGoggles selectRandom facewear;

if (lrAvailable && ((player getVariable "loadout") in lrRoles) && (lrRadio != "")) then {

	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		
		player addBackpack selectRandom rifleman_backpack;
		
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
	player addBackpack selectRandom rifleman_backpack;
};

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon rifleman_rifle;
player addPrimaryWeaponItem rifleman_scope;
player addPrimaryWeaponItem rifleman_attachement1;
player addPrimaryWeaponItem rifleman_attachement2;
player addPrimaryWeaponItem rifleman_attachement3;
player addPrimaryWeaponItem ((rifleman_ammo_inv select 0) select 0);

player addWeapon rifleman_handgun;
player addHandgunItem rifleman_handgun_scope;
player addHandgunItem rifleman_handgun_attachement1;
player addHandgunItem rifleman_handgun_attachement2;
player addHandgunItem ((rifleman_handgunAmmo_inv select 0) select 0);

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
} forEach rifleman_inv_u;

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
} forEach rifleman_inv_v;

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
} forEach rifleman_inv_b;

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
} forEach rifleman_ammo_inv;

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
} forEach rifleman_handgunAmmo_inv;


//------------------------------------------------------------------
//	Item Slots
//------------------------------------------------------------------
if (rifleman_watch != "") then {
	player linkItem rifleman_watch;
};

if (rifleman_map != "") then {
	player linkItem rifleman_map;
};

if (rifleman_compass != "") then {
	player linkItem rifleman_compass;
};

if (rifleman_binocs != "") then {
	player addWeapon rifleman_binocs;
};

if (rifleman_terminal != "") then {
	player linkItem rifleman_terminal;
};

if (rifleman_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		if (player canAddItemToUniform rifleman_radio) then {
			player addItemToUniform rifleman_radio;
		}
		else {
			if (player canAdd rifleman_radio) then {
				player addItem rifleman_radio;
			}
			else {
				_notloadeditems pushback rifleman_radio;
			};
		};
	}
	else {
		player linkItem rifleman_radio;
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

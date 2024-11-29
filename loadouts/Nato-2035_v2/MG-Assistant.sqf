//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						MG-Assistant
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","MG-Assistant"];
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
player forceAddUniform selectRandom mgAssis_uniform;
player addHeadgear selectRandom mgAssis_helmet;
player addVest selectRandom mgAssis_vest;
player addGoggles selectRandom facewear;

if (lrAvailable && ((player getVariable "loadout") in lrRoles) && (lrRadio != "")) then {

	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		
		player addBackpack selectRandom mgAssis_backpack;
		
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
	player addBackpack selectRandom mgAssis_backpack;
};

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon mgAssis_rifle;
player addPrimaryWeaponItem mgAssis_scope;
player addPrimaryWeaponItem mgAssis_attachement1;
player addPrimaryWeaponItem mgAssis_attachement2;
player addPrimaryWeaponItem mgAssis_attachement3;
player addPrimaryWeaponItem ((mgAssis_ammo_inv select 0) select 0);

player addWeapon mgAssis_handgun;
player addHandgunItem mgAssis_handgun_scope;
player addHandgunItem mgAssis_handgun_attachement1;
player addHandgunItem mgAssis_handgun_attachement2;
player addHandgunItem ((mgAssis_handgunAmmo_inv select 0) select 0);

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
} forEach mgAssis_inv_u;

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
} forEach mgAssis_inv_v;

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
} forEach mgAssis_inv_b;

//------------------------------------------------------------
//						Assistant Ammo
//------------------------------------------------------------
{
	for "_i" from 1 to (round ((_x select 1) * 0.75)) do {
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
} forEach mg_ammo_inv;

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
} forEach mgAssis_ammo_inv;

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
} forEach mgAssis_handgunAmmo_inv;



//------------------------------------------------------------------
//	Item Slots
//------------------------------------------------------------------
player linkItem mgAssis_watch;
player linkItem mgAssis_map;
player linkItem mgAssis_compass;
player linkItem mgAssis_binocs;
player linkItem mgAssis_terminal;

if (mgAssis_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		if (player canAddItemToUniform mgAssis_radio) then {
			player addItemToUniform mgAssis_radio;
		}
		else {
			if (player canAdd mgAssis_radio) then {
				player addItem mgAssis_radio;
			}
			else {
				_notloadeditems pushback mgAssis_radio;
			};
		};
	}
	else {
		player linkItem mgAssis_radio;
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

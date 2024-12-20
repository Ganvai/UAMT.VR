//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Squadleader
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","Squadleader"];
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
player forceAddUniform selectRandom sql_uniform;
player addHeadgear selectRandom sql_helmet;
player addVest selectRandom sql_vest;
player addGoggles selectRandom facewear;

if (lrAvailable && ((player getVariable "loadout") in lrRoles) && (lrRadio != "")) then {

	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		
		player addBackpack selectRandom sql_backpack;
		
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
	player addBackpack selectRandom sql_backpack;
};

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon sql_rifle;
player addPrimaryWeaponItem sql_scope;
player addPrimaryWeaponItem sql_attachement1;
player addPrimaryWeaponItem sql_attachement2;
player addPrimaryWeaponItem sql_attachement3;
player addPrimaryWeaponItem ((sql_ammo_inv select 0) select 0);

player addWeapon sql_handgun;
player addHandgunItem sql_handgun_scope;
player addHandgunItem sql_handgun_attachement1;
player addHandgunItem sql_handgun_attachement2;
player addHandgunItem ((sql_handgunAmmo_inv select 0) select 0);

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
} forEach sql_inv_u;

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
} forEach sql_inv_v;

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
} forEach sql_inv_b;

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
} forEach sql_ammo_inv;

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
} forEach sql_handgunAmmo_inv;



//------------------------------------------------------------------
//	Item Slots
//------------------------------------------------------------------
player linkItem sql_watch;
player linkItem sql_map;
player linkItem sql_compass;
player addWeapon sql_binocs;
player linkItem sql_terminal;

if (sql_radio != "") then {
	if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
		if (player canAddItemToUniform sql_radio) then {
			player addItemToUniform sql_radio;
		}
		else {
			if (player canAdd sql_radio) then {
				player addItem sql_radio;
			}
			else {
				_notloadeditems pushback sql_radio;
			};
		};
	}
	else {
		player linkItem sql_radio;
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

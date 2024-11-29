//------------------------------------------------------------------
//------------------------------------------------------------------
//
//						Groupleader
//
//------------------------------------------------------------------
//------------------------------------------------------------------
if (!local player) exitWith {};

player setVariable ["loadout","Groupleader"];
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
player forceAddUniform uniforms;
player addHeadgear helmet;
player addVest vests;
player addGoggles facewear;
player addBackpack backpack_small;
player addBackpack backpack_big;
player addBackpack backpack_grouplead;

//------------------------------------------------------------------
//	Weapons
//------------------------------------------------------------------
player addWeapon primary;
player addPrimaryWeaponItem primary_scope;
player addPrimaryWeaponItem primary_attachement1;
player addPrimaryWeaponItem primary_attachement2;
player addPrimaryWeaponItem primary_silencer;
player addPrimaryWeaponItem primary_mag;

player addWeapon launcher_at;
player addSecondaryWeaponItem launcher_at_ammo1;
if (launcher_at_scope != "") then {
	player addSecondaryWeaponItem launcher_at_scope;
};

player addWeapon handgun;
player addHandgunItem handgun_scope;
player addHandgunItem handgun_attachment1;
player addHandgunItem handgun_attachment2;
player addHandgunItem handgun_mag;


//------------------------------------------------------------------
//
//	Ammo
//
//------------------------------------------------------------------

//------------------------------------------------------------------
//	Primary Mags
//------------------------------------------------------------------
for "_i" from 1 to primary_mag_count do {
	_fits = player canAddItemToVest primary_mag;
	if (_fits) then {
		player addItemToVest primary_mag;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack primary_mag;
		if (_fits) then {
			player addItemToBackpack primary_mag;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform primary_mag;
			if (_fits) then {
				player addItemToUniform primary_mag;
			}
			else {
				_notloadeditems pushback primary_mag;
			};
		};
	};
};

for "_i" from 1 to primary_mag_tracer_count do {
	_fits = player canAddItemToVest primary_tracer;
	if (_fits) then {
		player addItemToVest primary_tracer;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack primary_tracer;
		if (_fits) then {
			player addItemToBackpack primary_tracer;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform primary_tracer;
			if (_fits) then {
				player addItemToUniform primary_tracer;
			}
			else {
				_notloadeditems pushback primary_tracer;
			};
		};
	};
};

//------------------------------------------------------------------
//	Handgun Mags
//------------------------------------------------------------------
for "_i" from 1 to handgun_mag_count do {
	_fits = player canAddItemToVest handgun_mag;
	if (_fits) then {
		player addItemToVest handgun_mag;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack handgun_mag;
		if (_fits) then {
			player addItemToBackpack handgun_mag;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform handgun_mag;
			if (_fits) then {
				player addItemToUniform handgun_mag;
			}
			else {
				_notloadeditems pushback handgun_mag;
			};
		};
	};
};		

//------------------------------------------------------------------
//	Launcher Ammo
//------------------------------------------------------------------
for "_i" from 1 to 1 do {
	_fits = player canAddItemToBackpack launcher_at_ammo1;
	if (_fits) then {
		player addItemToBackpack launcher_at_ammo1;
	}
	else {
		_fits = false;
		_fits = player canAdd launcher_at_ammo1;
		if (_fits) then {
			player addItem launcher_at_ammo1;
		}
		else {
			_notloadeditems pushback launcher_at_ammo1;
		};
	};
};

for "_i" from 1 to 1 do {
	_fits = player canAddItemToBackpack launcher_at_ammo2;
	if (_fits) then {
		player addItemToBackpack launcher_at_ammo2;
	}
	else {
		_fits = false;
		_fits = player canAdd launcher_at_ammo2;
		if (_fits) then {
			player addItem launcher_at_ammo2;
		}
		else {
			_notloadeditems pushback launcher_at_ammo2;
		};
	};
};

for "_i" from 1 to launcher_at_spotting_count do {
	_fits = player canAddItemToBackpack launcher_at_spotting;
	if (_fits) then {
		player addItemToBackpack launcher_at_spotting;
	}
	else {
		_fits = false;
		_fits = player canAdd launcher_at_spotting;
		if (_fits) then {
			player addItem launcher_at_spotting;
		}
		else {
			_notloadeditems pushback launcher_at_spotting;
		};
	};
};


//------------------------------------------------------------------
//	
// Throwables
//
//------------------------------------------------------------------

//------------------------------------------------------------------
//	Grenades
//------------------------------------------------------------------
for "_i" from 1 to grenades_count do {
	_fits = player canAddItemToVest grenades;
	if (_fits) then {
		player addItemToVest grenades;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack grenades;
		if (_fits) then {
			player addItemToBackpack grenades;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform grenades;
			if (_fits) then {
				player addItemToUniform grenades;
			}
			else {
				_notloadeditems pushback grenades;
			};
		};
	};
};

//------------------------------------------------------------------
//	Smokes White
//------------------------------------------------------------------
for "_i" from 1 to smoke_white_count do {
	_fits = player canAddItemToVest smoke_white;
	if (_fits) then {
		player addItemToVest smoke_white;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack smoke_white;
		if (_fits) then {
			player addItemToBackpack smoke_white;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform smoke_white;
			if (_fits) then {
				player addItemToUniform smoke_white;
			}
			else {
				_notloadeditems pushback smoke_white;
			};
		};
	};
};

//------------------------------------------------------------------
//	Smokes Green
//------------------------------------------------------------------
for "_i" from 1 to smoke_green_count do {
	_fits = player canAddItemToVest smoke_green;
	if (_fits) then {
		player addItemToVest smoke_green;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack smoke_green;
		if (_fits) then {
			player addItemToBackpack smoke_green;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform smoke_green;
			if (_fits) then {
				player addItemToUniform smoke_green;
			}
			else {
				_notloadeditems pushback smoke_green;
			};
		};
	};
};

//------------------------------------------------------------------
//	Smokes Red
//------------------------------------------------------------------
for "_i" from 1 to smoke_red_count do {
	_fits = player canAddItemToVest smoke_red;
	if (_fits) then {
		player addItemToVest smoke_red;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack smoke_red;
		if (_fits) then {
			player addItemToBackpack smoke_red;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform smoke_red;
			if (_fits) then {
				player addItemToUniform smoke_red;
			}
			else {
				_notloadeditems pushback smoke_red;
			};
		};
	};
};

//------------------------------------------------------------------
//	Flashbangs
//------------------------------------------------------------------
for "_i" from 1 to flashbang_count do {
	_fits = player canAddItemToVest flashbang;
	if (_fits) then {
		player addItemToVest flashbang;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack flashbang;
		if (_fits) then {
			player addItemToBackpack flashbang;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform flashbang;
			if (_fits) then {
				player addItemToUniform flashbang;
			}
			else {
				_notloadeditems pushback flashbang;
			};
		};
	};
};

//------------------------------------------------------------------
//	IR Grenades
//------------------------------------------------------------------
for "_i" from 1 to ir_grenade_count do {
	_fits = player canAddItemToVest ir_grenade;
	if (_fits) then {
		player addItemToVest ir_grenade;
	}
	else {
		_fits = false;
		_fits = player canAddItemToBackpack ir_grenade;
		if (_fits) then {
			player addItemToBackpack ir_grenade;
		}
		else {
			_fits = false;
			_fits = player canAddItemToUniform ir_grenade;
			if (_fits) then {
				player addItemToUniform ir_grenade;
			}
			else {
				_notloadeditems pushback ir_grenade;
			};
		};
	};
};

//------------------------------------------------------------------
//	Standard Equipment
//------------------------------------------------------------------
if (comms != "") then {
	player linkItem comms;
};
if (watch != "") then {
	player linkItem watch;
};
if (map != "") then {
	player linkItem map;
};
if (compass != "") then {
	player linkItem compass;
};

if (nvg != "") then {
	_fits = player canAddItemToUniform nvg;
	if (_fits) then {
		player addItemToUniform nvg;
	}
	else {
		_fits = false;
		_fits = player canAdd nvg;
		if (_fits) then {
			player addItem nvg;
		}
		else {
			_notloadeditems pushback nvg;
		};
	};
};

if (IRStrobe != "") then {
	_fits = player canAddItemToUniform IRStrobe;
	if (_fits) then {
		player addItemToUniform IRStrobe;
	}
	else {
		_fits = false;
		_fits = player canAdd IRStrobe;
		if (_fits) then {
			player addItem IRStrobe;
		}
		else {
			_notloadeditems pushback IRStrobe;
		};
	};
};

if (earplugs != "") then {
	_fits = player canAddItemToUniform earplugs;
	if (_fits) then {
		player addItemToUniform earplugs;
	}
	else {
		_fits = false;
		_fits = player canAdd earplugs;
		if (_fits) then {
			player addItem earplugs;
		}
		else {
			_notloadeditems pushback earplugs;
		};
	};
};

if (handcuffs != "") then {
	_fits = player canAddItemToUniform handcuffs;
	if (_fits) then {
		player addItemToUniform handcuffs;
	}
	else {
		_fits = false;
		_fits = player canAdd handcuffs;
		if (_fits) then {
			player addItem handcuffs;
		}
		else {
			_notloadeditems pushback handcuffs;
		};
	};
};

if (flashlight != "") then {
	_fits = player canAddItemToUniform flashlight;
	if (_fits) then {
		player addItemToUniform flashlight;
	}
	else {
		_fits = false;
		_fits = player canAdd flashlight;
		if (_fits) then {
			player addItem flashlight;
		}
		else {
			_notloadeditems pushback flashlight;
		};
	};
};

if (maptools != "") then {
	_fits = player canAddItemToUniform maptools;
	if (_fits) then {
		player addItemToUniform maptools;
	}
	else {
		_fits = false;
		_fits = player canAdd maptools;
		if (_fits) then {
			player addItem maptools;
		}
		else {
			_notloadeditems pushback maptools;
		};
	};
};


//------------------------------------------------------------------
//	Special Role Equipment
//------------------------------------------------------------------	
if (terminal_troops != "") then {
	player linkItem terminal_grouplead;
};
if (terminal_squadlead != "") then {
	player linkItem terminal_grouplead;
};
if (terminal_grouplead != "") then {
	player linkItem terminal_grouplead;
};
if (binocs_tier1 != "") then {
	player addWeapon binocs_tier1;
};
if (binocs_tier2 != "") then {
	player addWeapon binocs_tier2;
};
if (laserdesignator != "") then {
	player addWeapon laserdesignator;
};
if (laserdesignator_bats != "") then {
	player addItem laserdesignator_bats;
};

if (isClass(configFile >> "cfgPatches" >> "acre_main")) then {
	_fits = player canAddItemToBackpack acre_lr;
	if (_fits) then {
		player addItemToUniform acre_lr;
	}
	else {
		_fits = false;
		_fits = player canAdd acre_lr;
		if (_fits) then {
			player addItem acre_lr;
		}
		else {
			_notloadeditems pushback acre_lr;
		};
	};
};

if (isClass(configFile >> "cfgPatches" >> "cTab")) then {
	_fits = player canAddItemToUniform cTabcam;
	if (_fits) then {
		player addItemToUniform cTabcam;
	}
	else {
		_fits = false;
		_fits = player canAdd cTabcam;
		if (_fits) then {
			player addItem cTabcam;
		}
		else {
			_notloadeditems pushback cTabcam;
		};
	};
};

if (entrenching != "") then {
	_fits = player canAddItemToUniform entrenching;
	if (_fits) then {
		player addItemToUniform entrenching;
	}
	else {
		_fits = false;
		_fits = player canAdd entrenching;
		if (_fits) then {
			player addItem entrenching;
		}
		else {
			_notloadeditems pushback entrenching;
		};
	};
};

if (cutter != "") then {
	_fits = player canAddItemToUniform cutter;
	if (_fits) then {
		player addItemToUniform cutter;
	}
	else {
		_fits = false;
		_fits = player canAdd cutter;
		if (_fits) then {
			player addItem cutter;
		}
		else {
			_notloadeditems pushback cutter;
		};
	};
};

if (tools != "") then {
	_fits = player canAddItemToUniform tools;
	if (_fits) then {
		player addItemToUniform tools;
	}
	else {
		_fits = false;
		_fits = player canAdd tools;
		if (_fits) then {
			player addItem tools;
		}
		else {
			_notloadeditems pushback tools;
		};
	};
};
if (B_UavTerminal != "") then {
	_fits = player canAddItemToUniform B_UavTerminal;
	if (_fits) then {
		player addItemToUniform B_UavTerminal;
	}
	else {
		_fits = false;
		_fits = player canAdd B_UavTerminal;
		if (_fits) then {
			player addItem B_UavTerminal;
		}
		else {
			_notloadeditems pushback B_UavTerminal;
		};
	};
};

if (ACE_UAVBattery != "") then {
	_fits = player canAddItemToUniform ACE_UAVBattery;
	if (_fits) then {
		player addItemToUniform ACE_UAVBattery;
	}
	else {
		_fits = false;
		_fits = player canAdd ACE_UAVBattery;
		if (_fits) then {
			player addItem ACE_UAVBattery;
		}
		else {
			_notloadeditems pushback ACE_UAVBattery;
		};
	};
};

if (ACE_VMM3 != "") then {
	_fits = player canAddItemToUniform ACE_VMM3;
	if (_fits) then {
		player addItemToUniform ACE_VMM3;
	}
	else {
		_fits = false;
		_fits = player canAdd ACE_VMM3;
		if (_fits) then {
			player addItem ACE_VMM3;
		}
		else {
			_notloadeditems pushback ACE_VMM3;
		};
	};
};

if (explosivedevice != "") then {
	_fits = player canAddItemToUniform explosivedevice;
	if (_fits) then {
		player addItemToUniform explosivedevice;
	}
	else {
		_fits = false;
		_fits = player canAdd explosivedevice;
		if (_fits) then {
			player addItem explosivedevice;
		}
		else {
			_notloadeditems pushback explosivedevice;
		};
	};
};

if (defusalkit != "") then {
	_fits = player canAddItemToUniform defusalkit;
	if (_fits) then {
		player addItemToUniform defusalkit;
	}
	else {
		_fits = false;
		_fits = player canAdd defusalkit;
		if (_fits) then {
			player addItem defusalkit;
		}
		else {
			_notloadeditems pushback defusalkit;
		};
	};
};

if (rangecard != "") then {
	_fits = player canAddItemToUniform rangecard;
	if (_fits) then {
		player addItemToUniform rangecard;
	}
	else {
		_fits = false;
		_fits = player canAdd rangecard;
		if (_fits) then {
			player addItem rangecard;
		}
		else {
			_notloadeditems pushback rangecard;
		};
	};
};

if (windgauge != "") then {
	_fits = player canAddItemToUniform windgauge;
	if (_fits) then {
		player addItemToUniform windgauge;
	}
	else {
		_fits = false;
		_fits = player canAdd windgauge;
		if (_fits) then {
			player addItem windgauge;
		}
		else {
			_notloadeditems pushback windgauge;
		};
	};
};
//------------------------------------------------------------------
//	Medic
//------------------------------------------------------------------	
execVM "loadouts\medic_load_std.sqf";

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

//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//
//				Welcome Message
//
// Creates a Welcome Message with every important Information for the players
// at the beginning of the mission.
// Gathers all available Features and explains what they can do
//
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------

_messageheadline = format ["<t size='1.2'>Welcome to the Mission: %1</t><br/><br/>",(getMissionConfigValue "OnLoadName")];

_availableFeatures = [];

if (getMissionConfigValue "allowArmory" == "true") then {
	_availableFeatures pushback "Armory - ACE Arsenal to customise your Equipment. The equipment is limited to your role";
};

if (getMissionConfigValue "allowLoadouts" == "true") then {
	_availableFeatures pushback "Loadouts - Here you can change your role. Be aware that some roles have special features.";
};

_message = "<t size'1.1' underline='1'>Base-Menu:</t><br/>";

if (getMissionConfigValue "missionstartedfeat" == "true") then {
	if (!missionStarted) then {
		_message = _message + "The Mission has not yet started. As long as it has not started, you have access to the Base Menu via ACE Selfinteraction (STRG+WIN) everywhere.<br/>As soon as the Mission has started, you can only access the Base Menu when you are in the Base, near your Spawn Point.<br/>";
	}
	else {
		_message = _message + "The Mission has already started. You have access to the Base Menu via ACE Selfinteraction (STRG+WIN) in the area around your spawn point.<br/>";
	};
}
else {
	_message = _message + "You have access to the Base Menu via ACE Selfinteraction (STRG+WIN) in the area around your spawn point.<br/>";
};

_message = _message + "<br/> <t size'1.1' underline='1'>Base-Menu-Functions:</t><br/>1. Teleport - Here you can teleport to any Playergroup on the Battlefield<br/>2. Reset Loadout - If you changed anything in your loadout you can reset it here.<br/>";

_count = 3;

{
	_message = _message + str _count + "." + _x + "<br/>";
	_count = _count + 1;
}forEach _availableFeatures;

if (getMissionConfigValue "weaponProficiency" == "true") then {
	_playerLoadout = player getVariable "loadout";
	_profWeapons = [missionConfigFile >> "CfgLoadouts" >> _playerLoadout, "proficientWeapons",[]] call BIS_fnc_returnConfigEntry;
	
	if (count _profWeapons > 0 ) then {
		_message = _message + "<br/><t size'1.1' underline='1'>Weapon Proficiency:</t><br/>This Mission features Weapon Proficiency. This means your role has better stats when using the weapon class your role is trained for.<br/><br/>Your Class is Proficient with:<br/>";
		
		{
			switch _x do {
				case "arifle" : {_message = _message + "- Assault Rifles<br/>"};
				case "mg" : {_message = _message + "- Assault Rifles<br/>"};
				case "missile" : {_message = _message + "- Missile Launchers<br/>"};
				case "rocket" : {_message = _message + "- Rocket Launchers<br/>"};
				case "srifle" : {_message = _message + "- Sniper and DM Rifles<br/>"};
				case "smg" : {_message = _message + "- Submachine Guns<br/>"};
				case "sgun" : {_message = _message + "- Shot Guns<br/>"};
			};
		}forEach _profWeapons;
		
		_message = _message + "<br/>";
	};
};

_message = _message + "To learn more about all Custom-Features in this Mission, open the Map and go to UAMT Manual.";

[_messageheadline + _Message] spawn BIS_fnc_guiMessage;

_result = true;

if (player getVariable ["savedBackpack",""] != "") then {
	_result = ["There is already a backpack from you stored in the container. Do you want to replace it with your current backpack?", "Backpack already stored",true,true] call BIS_fnc_guiMessage;
};

if (!_result) exitWith  {closeDialog 0;};

if (backpack player != "") then {
	if (backpack player != (getMissionConfigValue "insHALOParachutes")) then {
		player setVariable ["savedItems",backpackItems player];
		player setVariable ["savedBackpack",backpack player];
		removeBackpack player;
		player addBackpack (getMissionConfigValue "insHALOParachutes");
		["Your backpack and all items in it are now stored in the cargo crate. You recieved a parachute.", "Backpack stored"] call BIS_fnc_guiMessage;
	}
	else {
		["You allready have a parachute. Nothing was stored", "Error"] call BIS_fnc_guiMessage;
	};
}
else {
	player addBackpack (getMissionConfigValue "insHALOParachutes");
	_result = ["You don't have a Backpack to store. Parachute recieved", "Hint"] call BIS_fnc_guiMessage;
};

closeDialog 0;
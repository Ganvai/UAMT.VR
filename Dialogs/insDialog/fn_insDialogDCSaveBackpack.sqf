if (player getVariable ["savedBackpack",""] != "") then {

	_result = false;
	_result = ["There is already a backpack from you stored in the container. Do you want to delete this?", "Error",true,true] call BIS_fnc_guiMessage;
	
	if (!_result) exitWith  {};
};

if (backpack player != "") then {
	if (backpack player != "B_Parachute" && backpack player != "ACE_NonSteerableParachute") then {
		player setVariable ["savedItems",backpackItems player];
		player setVariable ["savedBackpack",backpack player];
		removeBackpack player;
		player addBackpack "B_Parachute";
		["Your backpack and all Items in it are now stored in the Cargo Crate. You recieved a parachute.", "Backpack stored"] call BIS_fnc_guiMessage;
	}
	else {
		["You allready have a parachute. Nothing was stored", "Error"] call BIS_fnc_guiMessage;
	};
}
else {
	player addBackpack "B_Parachute";
	_result = ["You don't have a Backpack to store. Parachute recieved", "Hint"] call BIS_fnc_guiMessage;
};
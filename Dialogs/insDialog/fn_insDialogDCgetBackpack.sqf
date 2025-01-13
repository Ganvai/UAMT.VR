_backpack = player getVariable ["savedBackpack",""];

if (_backpack == "") exitWith {
	["No Backpack stored.", "Error"] call BIS_fnc_guiMessage;
	closeDialog 0;
};
	
if (backpack player != _backpack) then {
	removeBackpack player;
	_items =  player getVariable "savedItems";
	player addBackpack _backpack;
	{player addItemToBackpack _x;}forEach _items;
	["Backpack retrieved from cargo", "Backpack retrieved"] call BIS_fnc_guiMessage;
	
	player setVariable ["savedItems",[""]];
	player setVariable ["savedBackpack",""];
};

closeDialog 0;